#!/bin/bash

set -euo pipefail

args=("$@")

function loadStFile() {
    GToolkitCLI="./GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit-cli"
    CUSTOMIZATION_FILE="$1"
    echo "Loading custom configuration: ${CUSTOMIZATION_FILE}"
    "$GToolkitCLI" *.image st "$CUSTOMIZATION_FILE" --interactive --no-quit
}

DIR="gt-`date +%Y-%m-%d-%H-%M`"
mkdir $DIR
cd $DIR

case "$(uname -s)" in
	Darwin)
		curl https://dl.feenk.com/scripts/mac.sh | bash
		;;
	Linux)
		curl https://dl.feenk.com/scripts/linux.sh | bash
		;;
	MINGW*|MSYS*|CYGWIN*)
		wget https://dl.feenk.com/scripts/windows.ps1 -OutFile windows.ps1; ./windows.ps1
		;;
	*)
		echo "Unknown system."
		exit 1
		;;
esac

cd glamoroustoolkit

for f in ../../scripts/*; do
	loadStFile $f
done

if [[ ${args[0]-none} == '--withgs' ]]; then
	echo "Setting up gt4gemstone"

	# this seems unsafe? it probably is! but gemstone requires it somehow,
	# i don’t make the rules
	sudo sysctl -w kern.sysv.shmall=1572864
	sudo sysctl -w kern.sysv.shmmax=6442450944

	source ./pharo-local/iceberg/feenkcom/gt4gemstone/scripts/dev_preconfigure_gemstone.sh --rowan2
	./gt4gemstone/scripts/setup-remote-gemstone.sh
	cp ../../gt4gemstone.properties ./pharo-local/lepiter

	startnetldi -g
	startstone gs64stone
fi

echo "We are ready!"

./GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit

stopgs() {
	if [[ ${args[0]-default} == 'withgs' ]]; then
		stopnetldi
		stopstone -i gs64stone DataCurator swordfish
	fi
}

trap 'stopgs' SIGINT
