#!/bin/bash
set -e

ENV_NAME=fmrec

echo "================================="
echo "1. 初始化 Conda"
echo "================================="

source "$(conda info --base)/etc/profile.d/conda.sh"


echo "================================="
echo "2. 创建 Python 3.10 环境"
echo "================================="

if conda env list | grep -q "^${ENV_NAME} "; then
    echo "环境 ${ENV_NAME} 已存在，跳过创建"
else
    conda create -n ${ENV_NAME} python=3.10 -y
fi


echo "================================="
echo "3. 激活环境"
echo "================================="

conda activate ${ENV_NAME}


echo "================================="
echo "4. 更新 pip"
echo "================================="

python -m pip install --upgrade pip


echo "================================="
echo "5. 安装 PyTorch CUDA 11.8"
echo "================================="

pip install \
    torch==2.1.2 \
    torchvision==0.16.2 \
    torchaudio==2.1.2 \
    --index-url https://download.pytorch.org/whl/cu118


echo "================================="
echo "6. 安装 FMRec 依赖"
echo "================================="

pip install \
    numpy \
    scipy \
    timm \
    matplotlib


echo "================================="
echo "7. 检查 GPU"
echo "================================="

python -c "
import torch
print('PyTorch:', torch.__version__)
print('CUDA:', torch.version.cuda)
print('CUDA Available:', torch.cuda.is_available())
if torch.cuda.is_available():
    print('GPU:', torch.cuda.get_device_name(0))
"


echo "================================="
echo "FMRec 环境安装完成"
echo "以后运行：conda activate fmrec"
echo "================================="