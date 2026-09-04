{ config, ...}:

{
  environment.variables = {
    AMD_VULKAN_ICD="RADV";
    MESA_SHADER_CACHE_MAX_SIZE="12G";
    VDPAU_DRIVER="radeonsi";
    LIBVA_DRIVER_NAME="radeonsi";
    MESA_GLTHREAD="true"; 
  };
}
