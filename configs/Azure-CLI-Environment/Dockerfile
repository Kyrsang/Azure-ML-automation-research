FROM mcr.microsoft.com/azureml/openmpi4.1.0-ubuntu20.04:20231002.v1

# Install Azure CLI
RUN apt-get update && \
    apt-get install -y curl && \
    curl -sL https://aka.ms/InstallAzureCLIDeb | bash && \
    apt-get clean

# Set the working directory
WORKDIR /app

# Copy your datasets into the container
COPY ./datasets/ /app/datasets/

# Install Azure ML CLI extension
RUN az extension add -n ml

# Verify installation
RUN az --version
