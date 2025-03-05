#!/bin/bash
# diskrot: Quick ComyfyUI setup script


# Navigate to workspace
cd /workspace

# Clone the repository if it doesn't exist
if [ ! -d "ComfyUI" ]; then
    git clone https://github.com/comfyanonymous/ComfyUI.git
fi

# Navigate to ComfyUI directory
cd ComfyUI

# Define model paths and URLs
declare -A models=(
    ["models/diffusion_models/wan2.1_i2v_480p_14B_fp8_e4m3fn.safetensors"]="https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/diffusion_models/wan2.1_i2v_480p_14B_fp8_e4m3fn.safetensors"
    ["models/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors"]="https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors"
    ["models/clip_vision/clip_vision_h.safetensors"]="https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/clip_vision/clip_vision_h.safetensors"
    ["models/vae/wan_2.1_vae.safetensors"]="https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors"
)

# Download missing models
for file in "${!models[@]}"; do
    if [ ! -f "$file" ]; then
        mkdir -p "$(dirname "$file")"
        wget -O "$file" "${models[$file]}"
    fi
done

# Install dependencies
pip install -r requirements.txt

# Start the application
python main.py --listen 0.0.0.0
