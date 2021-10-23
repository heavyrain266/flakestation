self: super:

{

  kakoune-unwrapped = super.kakoune-unwrapped.overrideAttrs (oldAttrs: rec {
    version = "master";

    src = super.fetchFromGitHub {
      owner = "mawww";
      repo = "kakoune";
      rev = "689553c2e9b953a9d3822528d4ad858af95fb6a2";
      sha256 = "18ai2ln7mj0a4fsqhanv2zbnxa4signd2j2smv4q7qgn097ygprg";
      fetchSubmodules = true;
    };
  });

}
