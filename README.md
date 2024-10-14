# Azure-ML-automation-research

## 1. Deploy AutoML best model to an online endpoint

<details>
  <summary> <code>pipelineJob</code> details</summary>
  <img width="600" alt="image" src="https://github.com/user-attachments/assets/81d27d08-f8c4-400e-b461-c146d843c17a">
</details>

<details>
  <summary>Result view of <code>prepare_dataset</code> step</summary>
  <img src="https://github.com/user-attachments/assets/e4399385-8bf4-4255-b986-e2ae36f61fe5"></img>
</details>

<details>
  <summary>Result view of <code>setup_automl</code> step</summary>
  <img src="https://github.com/user-attachments/assets/9de1490d-43e9-4dd4-b71d-2ff8b68629d8"></img>
</details>

<details>
  <summary>Result view of <code>monitor_automl</code> step</summary>
  <img src="https://github.com/user-attachments/assets/885619ff-483d-4e84-9ec7-71b3c2340ea3"></img>
</details>

## 2. Deploy AutoML best model to AKS (a public Kubernetes cluster scenario)

### Overview 
  1. [Prepare an Azure Kubernetes Service cluster](#prepare-an-azure-kubernetes-service-cluster)
  2. Deploy the Azure Machine Learning cluster extension.
  3. Attach the Kubernetes cluster to your Azure Machine Learning workspace.
  4. Use the Kubernetes compute target from the CLI v2, SDK v2, or the Azure Machine Learning studio UI.

### 1. Prepare an Azure Kubernetes Service cluster

Create a public AKS cluster by running a [workflow](https://github.com/Kyrsang/Azure-ML-automation-research/blob/main/.github/workflows/k8s-1-create-public-AKS-cluster.yml) that creates a cluster and upload a `kubeconfig` file. 

Then download the `kubeconfig` file that is uploaded as an artifact from the result page of the workflow's run:
```
PS C:\Users> ls
...
-a----      2024-10-14  오후 12:51           9809 kubeconfig
```
> Ensure that the directory path containing the `kubeconfig` file does not include any characters that are not supported by the 'cp949' codec, such as Korean characters.

To configure kubectl to refer to the cluster in AKS, set the KUBECONFIG environment variable as follows:
```
PS C:\Users> $env:KUBECONFIG = "C:\Users\kubeconfig"
```

You will see that you are successfully connected to the cluster in AKS:

```
PS C:\Users> kubectl config get-contexts
CURRENT   NAME                  CLUSTER               AUTHINFO                                                    NAMESPACE
*         eunsang-aks-cluster   eunsang-aks-cluster   clusterUser_inbrein-azure-ml-research_eunsang-aks-cluster
```

<details>
  <summary>
    <code><br>PS C:\Users> kubectl get all -A<br></code>
  </summary>
  <br>
  
  ```shell
  NAMESPACE     NAME                                      READY   STATUS    RESTARTS   AGE
  kube-system   pod/azure-ip-masq-agent-gfnvs             1/1     Running   0          17m
  kube-system   pod/cloud-node-manager-4wxrb              1/1     Running   0          17m
  kube-system   pod/coredns-597bb9d4db-42gmw              1/1     Running   0          16m
  kube-system   pod/coredns-597bb9d4db-4jmpg              1/1     Running   0          17m
  kube-system   pod/coredns-autoscaler-689db4649c-2f9d2   1/1     Running   0          17m
  kube-system   pod/csi-azuredisk-node-jjdpp              3/3     Running   0          17m
  kube-system   pod/csi-azurefile-node-9wwht              3/3     Running   0          17m
  kube-system   pod/konnectivity-agent-85d8d6f866-9pcqh   1/1     Running   0          17m
  kube-system   pod/konnectivity-agent-85d8d6f866-tdxc5   1/1     Running   0          17m
  kube-system   pod/kube-proxy-pnhs2                      1/1     Running   0          17m
  kube-system   pod/metrics-server-7b685846d6-2wjqc       2/2     Running   0          16m
  kube-system   pod/metrics-server-7b685846d6-zcrvh       2/2     Running   0          16m
  
  NAMESPACE     NAME                     TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)         AGE
  default       service/kubernetes       ClusterIP   10.0.0.1     <none>        443/TCP         18m
  kube-system   service/kube-dns         ClusterIP   10.0.0.10    <none>        53/UDP,53/TCP   17m
  kube-system   service/metrics-server   ClusterIP   10.0.9.56    <none>        443/TCP         17m
  
  NAMESPACE     NAME                                        DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
  kube-system   daemonset.apps/azure-ip-masq-agent          1         1         1       1            1           <none>          17m
  kube-system   daemonset.apps/cloud-node-manager           1         1         1       1            1           <none>          17m
  kube-system   daemonset.apps/cloud-node-manager-windows   0         0         0       0            0           <none>          17m
  kube-system   daemonset.apps/csi-azuredisk-node           1         1         1       1            1           <none>          17m
  kube-system   daemonset.apps/csi-azuredisk-node-win       0         0         0       0            0           <none>          17m
  kube-system   daemonset.apps/csi-azurefile-node           1         1         1       1            1           <none>          17m
  kube-system   daemonset.apps/csi-azurefile-node-win       0         0         0       0            0           <none>          17m
  kube-system   daemonset.apps/kube-proxy                   1         1         1       1            1           <none>          17m
  
  NAMESPACE     NAME                                 READY   UP-TO-DATE   AVAILABLE   AGE
  kube-system   deployment.apps/coredns              2/2     2            2           17m
  kube-system   deployment.apps/coredns-autoscaler   1/1     1            1           17m
  kube-system   deployment.apps/konnectivity-agent   2/2     2            2           17m
  kube-system   deployment.apps/metrics-server       2/2     2            2           17m
  
  NAMESPACE     NAME                                            DESIRED   CURRENT   READY   AGE
  kube-system   replicaset.apps/coredns-597bb9d4db              2         2         2       17m
  kube-system   replicaset.apps/coredns-autoscaler-689db4649c   1         1         1       17m
  kube-system   replicaset.apps/konnectivity-agent-85d8d6f866   2         2         2       17m
  kube-system   replicaset.apps/metrics-server-7b445dd694       0         0         0       17m
  kube-system   replicaset.apps/metrics-server-7b685846d6       2         2         2       16m
  ```
  > [1] In the command, the `-j` option directs any access to the rule `KUBE-SEP-IT2ZTR26TO4XFPTO` to jump to the `KUBE-MARK-MASQ` rule.

</details>

### 2. Deploy the Azure Machine Learning extension on AKS or Arc Kubernetes cluster

Install Azure Machine Learning extension on the cluster by running: 
```powershell 
az k8s-extension create `
	--name eunsang-aks-cluster-ml-extension `
	--extension-type Microsoft.AzureML.Kubernetes `
	--config enableTraining=True enableInference=True inferenceRouterServiceType=LoadBalancer allowInsecureConnections=True InferenceRouterHA=False `
	--cluster-type managedClusters `
	--cluster-name eunsang-aks-cluster `
	--resource-group inbrein-azure-ml-research`
	--scope cluster
```
> The parameters are set for a quick proof of concept to run various ML workloads. For more detailed deployment requirements, refer [here](https://learn.microsoft.com/en-us/azure/machine-learning/how-to-deploy-kubernetes-extension?view=azureml-api-2&tabs=deploy-extension-with-cli#azure-machine-learning-extension-deployment---cli-examples-and-azure-portal). 
