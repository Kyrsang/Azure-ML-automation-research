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


### 2. Deploy the Azure Machine Learning extension on AKS or Arc Kubernetes cluster
