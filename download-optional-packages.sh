#!/bin/bash
downloadPackages() {
	curl -LO# https://github.com/KreitinnSoftware/MiceWine-RootFS-Generator/releases/download/$(curl -s https://api.github.com/repos/KreitinnSoftware/MiceWine-RootFS-Generator/releases | grep tag_name -m 1 | cut -d ":" -f 2 | sed "s/\"//g" | sed "s/,//g" | sed "s/ //g")/MiceWine-Packages.zip
	unzip MiceWine-Packages.zip -d built-pkgs
}

filterDownloadablePackages() {
	cd built-pkgs

	local FILTERED_PACKAGES=""

	for i in $(ls *.isDownloadable); do 
		FILTERED_PACKAGES="$FILTERED_PACKAGES $(echo $i | sed "s/.isDownloadable/.rat/g")"
	done

	mv $FILTERED_PACKAGES $INIT_DIR/components/Packages

	cd ..

	rm -rf built-pkgs
}

export INIT_DIR=$PWD

mkdir -p components/Packages

downloadPackages
filterDownloadablePackages