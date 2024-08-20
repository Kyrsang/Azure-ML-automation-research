FROM mcr.microsoft.com/azureml/openmpi4.1.0-ubuntu20.04:20231002.v1

# Install Azure CLI
RUN apt-get update && \
    apt-get install -y curl && \
    curl -sL https://aka.ms/InstallAzureCLIDeb | bash && \
    apt-get clean

# Install Azure ML CLI extension
RUN az extension add -n ml

# Verify installation
RUN az --version

# Define build arguments
ARG AZURE_CLIENT_ID
ARG AZURE_CLIENT_SECRET
ARG AZURE_TENANT_ID

# Set environment variables from build arguments
ENV AZURE_CLIENT_ID=${AZURE_CLIENT_ID}
ENV AZURE_CLIENT_SECRET=${AZURE_CLIENT_SECRET}
ENV AZURE_TENANT_ID=${AZURE_TENANT_ID}

# Create an entrypoint script to authenticate with Azure
RUN echo '#!/bin/bash\n\
az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET --tenant $AZURE_TENANT_ID\n\
exec "$@"' > /entrypoint.sh && chmod +x /entrypoint.sh

# Set the entrypoint to the script
ENTRYPOINT ["/entrypoint.sh"]
