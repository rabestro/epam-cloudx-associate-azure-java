# Module 3: App Services

# Step 2: Build and Push Docker Images

ACR_NAME=module3acr
SERVICES=("petstoreapp" "petstorepetservice" "petstoreorderservice" "petstoreproductservice")

die() {
    echo "$*" >&2
    exit 1
}

# Check if petstore directory exists
if [ ! -d "./petstore" ]; then
    die "Directory ./petstore does not exist"
fi

build_and_push_images() {
    echo "Logging in to ACR: $ACR_NAME"
    az acr login --name $ACR_NAME || die "Failed to log in to ACR: $ACR_NAME"
    cd ./petstore || die "Failed to navigate to ./petstore directory"

    for service in "${SERVICES[@]}"
    do
        az acr build \
            --image $service:v1 \
            --registry $ACR_NAME \
            --file $service/Dockerfile ./$service
    done
}

build_and_push_images
