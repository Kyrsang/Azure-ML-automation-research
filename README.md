# Azure-ML-automation-research

### `pipelineJob` Definition  
```mermaid
flowchart TD
    subgraph Azure
        
        subgraph Azure ACR
            B(DockerEnv)
        end

        subgraph Azure ML
                C(Compute)
                subgraph Scheduling_Job
                    A(pipelineJob) 
                end 
        end 

    end 

    subgraph GitHub Action
        D(azure-ml-setup.yml)
    end 
    
    D --> |1|B 
    D --> |3|Scheduling_Job
    D --> |2|C
    C --> A
    B --> A
    A --> |every month|A
 
    
    linkStyle 0,1,2,3,4,5 stroke-width:.3px;
```

### Tasks of `pipelineJob` in details    
```mermaid
flowchart TD
    subgraph pipelineJob
        A[Prepare Data]
        B[Create AutoML training Job]
        C[Monitor train result]
        D[Register best model]
        E[Publish endpoint]
    end 

    F(datastore/iris mltable)
    G(model training...) 
    
    A --> B 
    C --> D 
    D --> E 
    A --> F 
    B --> G  
    G --> |takes about 12 mins.|G 
    
    G --Completed---> C
```

<details>
  <summary>Result view of `az ml data create`</summary>
  <img src="https://github.com/user-attachments/assets/e4399385-8bf4-4255-b986-e2ae36f61fe5"></img>
</details>

<details>
  <summary>Result view of `az ml job create`</summary>
  <img src="https://github.com/user-attachments/assets/9de1490d-43e9-4dd4-b71d-2ff8b68629d8"></img>
</details>

