self: super:

{
    river = super.river.overrideAttrs (oldAttrs: rec {
        src = super.fetchFromGitHub {
            owner = "ifreund";
            repo = "river";
            rev = "4b94b9c0839eb75e5a8d3eeaf26e85e516a89015";
            sha256 = "0b1dxjv6f99f1msmg40jgfkvv56as5ngs6wg0cg2yiqjlz9c35vc";
            fetchSubmodules = true;
        };
    });
}
