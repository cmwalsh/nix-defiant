{ pkgs ? import <nixpkgs> {} }:

with pkgs;

stdenv.mkDerivation rec {

  pname = "FreeShow";
  version = "1.3.3";

  src = fetchurl {
    url = "https://github.com/ChurchApps/FreeShow/releases/download/v1.3.3/FreeShow-1.3.3-x86_64.AppImage";
    sha256 = "sha256-/cqHdiL7E+NMuW6Hxp4IgHu9v8Ex57b9pzkbs4Tav7g=";
  };

  nativeBuildInputs = [ makeWrapper ];

  buildInputs = [ 
    p7zip 
    imagemagick
  ];

  sourceRoot = ".";

  # Don't extract the AppImage
  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin $out/share/applications $out/share/appimages $out/share/icons/hicolor/256x256/apps
    
    # Copy the AppImage to share directory
    cp $src $out/share/appimages/${pname}.AppImage
    chmod +x $out/share/appimages/${pname}.AppImage

    # Extract the icon from the AppImage
    cd $out/share/appimages
    ${p7zip}/bin/7z x ${pname}.AppImage *.png || true
    
    # Find and copy the icon (adjust the find pattern based on extracted files)
    ICON_PATH=$(find . -name "*.png" -print -quit)
    if [ ! -z "$ICON_PATH" ]; then
      cp "$ICON_PATH" $out/share/icons/hicolor/256x256/apps/${pname}.png
    fi

    # Create wrapper script
    makeWrapper ${appimage-run}/bin/appimage-run $out/bin/${pname} \
      --add-flags "$out/share/appimages/${pname}.AppImage"

    # Create desktop entry
    cat > $out/share/applications/${pname}.desktop << EOF
    [Desktop Entry]
    Name=FreeShow
    Exec=${pname}
    Icon=${pname}
    Type=Application
    Categories=Office;
    EOF
  '';

  meta = with lib; {
    description = "A dynamic, user-friendly, and open-source presenter built for all of your presentations.";
    homepage = "https://freeshow.app/";
    license = licenses.gpl3; # Adjust according to the application's license
    platforms = [ "x86_64-linux" ];
    maintainers = with maintainers; [ ];
  };
}
