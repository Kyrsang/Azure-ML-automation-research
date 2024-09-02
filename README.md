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
            
            Component(compute, "Compute Cluster")
            
            Component(pipeline, "Pipeline")
            
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
    UpdateRelStyle(acr, pipeline, $textColor="grey", $offsetX="-150", $offsetY="-80")

    Rel(scheduler, pipeline, "Triggers on cron event")
    UpdateRelStyle(scheduler, pipeline, $textColor="grey", $offsetX="-100", $offsetY="30")

    Rel(compute, pipeline, "Provides compute resource")
    UpdateRelStyle(compute, pipeline, $textColor="grey", $offsetX="-70", $offsetY="10")
```

### Tasks of `pipelineJob` in details    
<img width="600" alt="image" src="https://github.com/user-attachments/assets/81d27d08-f8c4-400e-b461-c146d843c17a">

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
