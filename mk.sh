#!/bin/bash

set -e

args=("$@")

function loadStFile() {
    GToolkitCLI="./GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit-cli"
    CUSTOMIZATION_FILE="$1"
    echo "Loading custom configuration: ${CUSTOMIZATION_FILE}"
    "$GToolkitCLI" *.image st "$CUSTOMIZATION_FILE" --interactive --no-quit
}

DIR=`date +%Y-%m-%d-%H-%M`
mkdir $DIR
cd $DIR
curl https://dl.feenk.com/scripts/mac.sh | bash

cd glamoroustoolkit

for f in ../../scripts/*; do
	loadStFile $f
done

if [[ $1 == '--withgs' ]]; then
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
	if [[ ${script_args[0]} == 'withgs' ]]; then
		stopnetldi
		stopstone -i gs64stone DataCurator swordfish
	done
}

trap 'stopgs' SIGINT
