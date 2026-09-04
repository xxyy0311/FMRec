#!/bin/bash

set -e

echo "======================================"
echo "FMRec environment setup"
echo "======================================"

ENV_NAME="fmrec"

if ! command -v conda >/dev/null 2>&1; then
    echo "Error: conda not found."
    exit 1
fi

if conda env list | grep -q "^${ENV_NAME} "; then
    echo "Conda environment '${ENV_NAME}' already exists."
else
    echo "Creating conda environment '${ENV_NAME}'..."
    conda env create -f environment.yml
fi

echo ""
echo "Environment setup finished."
echo "Please run:"
echo "conda activate ${ENV_NAME}"
