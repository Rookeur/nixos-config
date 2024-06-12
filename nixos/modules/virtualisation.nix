{ self, ... }:

{
  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
    # vmware.host.enable = true;
    virtualbox = {
      guest.enable = true;
      host = {
        enable = true;
        enableExtensionPack = true;
      };
    };
  };
}
