FROM mcr.microsoft.com/azureml/openmpi4.1.0-ubuntu20.04:20231002.v1

# Install Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Install Azure ML CLI extension
RUN az extension add -n ml

# Verify installation
RUN az --version
