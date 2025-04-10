  fhs = pkgs.buildFHSUserEnv {
    name = "android-env";
    targetPkgs = pkgs:
      with pkgs; [
        android-tools
        libxcrypt-legacy # libcrypt.so.1
        freetype # libfreetype.so.6
        fontconfig # java NPE: "sun.awt.FontConfiguration.head" is null
        yaml-cpp # necessary for some kernels according to a comment on the gist

        # Some of the packages here are probably unecessary but I don't wanna figure out which
        bc
        binutils
        bison
        ccache
        curl
        flex
        gcc
        git
        git-repo
        git-lfs
        gnumake
        gnupg
        gperf
        imagemagick
        jdk11
        elfutils
        libxml2
        libxslt
        lz4
        lzop
        m4
        nettools
        openssl.dev
        perl
        pngcrush
        procps
        python3
        rsync
        schedtool
        SDL
        squashfsTools
        unzip
        util-linux
        xml2
        zip

        # only necessary if you wanna use `runScript = "zsh";` below
        zsh
      ];
    multiPkgs = pkgs:
      with pkgs; [
        zlib
        ncurses5
        libcxx
        readline

        libgcc # crtbeginS.o
        iconv # ??? - i put this here and by the time i went back to remove unecessary packages i forgot why
        iconv.dev # sys/types.h
      ];
    runScript = "zsh"; # personal preference, you could set this to bash instead if you want
    profile = ''
      export ALLOW_NINJA_ENV=true
      export USE_CCACHE=1
      export CCACHE_EXEC=/usr/bin/ccache
      export ANDROID_JAVA_HOME=${pkgs.jdk11.home}
      # Building involves a phase of unzipping large files into a temporary directory
      export TMPDIR=/tmp
      export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${pkgs.ncurses5}/lib
    '';
  };
in
  pkgs.stdenv.mkDerivation {
    name = "android-env-shell";
    nativeBuildInputs = [fhs];
    shellHook = "exec android-env";
  }
