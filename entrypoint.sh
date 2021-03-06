#!/bin/bash

set -e
echo "${INPUT_GOOGLE_APPLICATION_CREDENTIALS}" | base64 -d > "${HOME}/gcloud.json"
gcloud auth activate-service-account --key-file="${HOME}/gcloud.json" --project "${INPUT_GCP_PROJECT}"

echo $INPUT_IMAGE_TAG
echo $INPUT_IMAGE_TAG
echo $INPUT_DOCKERIMAGE_PATH
echo $INPUT_DOCKERIMAGE_PATH
# Build image
gcloud builds submit --tag "$INPUT_IMAGE_TAG" "$INPUT_DOCKERIMAGE_PATH"

# Build the Flex Template.
gcloud beta dataflow flex-template build $INPUT_TEMPLATE_PATH \
  --image "$INPUT_IMAGE_TAG" \
  --sdk-language "PYTHON" \
  #--metadata-file "$INPUT_METADATA_PATH"
