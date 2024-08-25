# Azure-ML-automation-research

### `pipelineJob` Definition  
```mermaid
C4Context
    title  
    
    Deployment_Node(github, "GitHub") {
        Component(githubaction, "GitHub Action", "azure-ml-setup.yml", "")
    }

    Enterprise_Boundary(azure, "Azure") {
        
        Container(acr, "Acure Container Registry")

        Deployment_Node(azml, "Azure Machine Learning") {
            Component(pipeline, "Pipeline")

            Component(compute, "Compute Cluster")
            
            Component(scheduler, "Scheduler")

            
        }
    }

    Rel(githubaction, acr, "Linux env. with configs and data")
    UpdateRelStyle(githubaction, acr, $textColor="grey", $offsetX="-80", $offsetY="10")

    Rel(githubaction, compute, "Create compute cluster")
    UpdateRelStyle(githubaction, compute, $textColor="grey", $offsetX="-80", $offsetY="10")

    Rel(githubaction, scheduler, "Set up schedule")
    UpdateRelStyle(githubaction, scheduler, $textColor="grey", $offsetX="-80", $offsetY="10")

    Rel(acr, pipeline, "Provdes containerized Linux environment")
    UpdateRelStyle(acr, pipeline, $textColor="grey", $offsetX="-10", $offsetY="-80")

    Rel(scheduler, pipeline, "Triggers on cron event")
    UpdateRelStyle(scheduler, pipeline, $textColor="grey", $offsetX="10", $offsetY="100")

    Rel(compute, pipeline, "Provides compute resource")
    UpdateRelStyle(compute, pipeline, $textColor="grey", $offsetX="10", $offsetY="30")
```

### Tasks of `pipelineJob` in details    
```mermaid
flowchart TD
    subgraph pipelineJob
        A[prepare_dataset]
        B[setup_automl]
        C[monitor_automl]
        D[register_automl] 
        E[publish_endpoint]
    end 

    F(datastore/iris mltable)
    G(model training... for about 12 mins.) 
    
    A --> B 
    C --> D 
    D --> E 
    A --> F 
    B --> G     
    G <--Completed---> C
    F --> G
```

<details>
  <summary>Result view of `prepare_dataset` step</summary>
  <img src="https://github.com/user-attachments/assets/e4399385-8bf4-4255-b986-e2ae36f61fe5"></img>
</details>

<details>
  <summary>Result view of `setup_automl` step</summary>
  <img src="https://github.com/user-attachments/assets/9de1490d-43e9-4dd4-b71d-2ff8b68629d8"></img>
</details>

<details>
  <summary>Result view of `monitor_automl` step</summary>
  <img src="https://github.com/user-attachments/assets/885619ff-483d-4e84-9ec7-71b3c2340ea3"></img>
</details>

<details>
  <summary>Result view of `register_automl` step</summary>
  <img src="https://github.com/user-attachments/assets/efb2e662-e6c2-458c-bace-5404826518df"></img>
</details>
