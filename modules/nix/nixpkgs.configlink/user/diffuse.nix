{ stdenv, fetchurl, python27Packages, makeWrapper }:

let
  inherit (python27Packages) pygtk python;
in stdenv.mkDerivation rec {
  version = "0.4.8";
  pname = "diffuse";

  src = fetchurl {
    url = "mirror://sourceforge/project/diffuse/diffuse/${version}/${pname}-${version}.tar.bz2";
    sha256 = "0ayz8bywmk1z3zicb0a7hbxliqpc7xym60s0mawzqllkpadvgly1";
  };

  buildInputs = [ python pygtk makeWrapper ];

  buildPhase = ''
    python ./install.py --prefix="$out" --sysconfdir="$out/etc" --pythonbin="${python}/bin/python"
    wrapProgram "$out/bin/diffuse" --prefix PYTHONPATH : $PYTHONPATH:${pygtk}/lib/${python.libPrefix}/site-packages/gtk-2.0
  '';

  # no-op, everything is done in buildPhase
  installPhase = "true";

}
