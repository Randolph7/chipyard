#!/usr/bin/env bash

# exit script if any command fails
set -e
set -o pipefail

# exit script if not in Chipyard conda env
if [[ `basename $CONDA_PREFIX` != .conda-env ]]; then
    echo 'ERROR: Chipyard conda env not activated. Please source env.sh and run this script again.'
    exit
fi

# Explicitly install mentor plugins for Calibre if you have access
if [[ $1 == "calibre" ]]; then
    git clone git@github.com:ucb-bar/hammer-mentor-plugins.git vlsi/hammer-mentor-plugins
    pip install -e vlsi/hammer-mentor-plugins
fi

# Initialize HAMMER tech plugin
# And add tech plugin to conda dependencies
if [[ $1 != *asap7* ]] && [[ $1 != *sky130* ]]; then
    git submodule update --init --recursive vlsi/hammer-$1-plugin
    pip install -e vlsi/hammer-$1-plugin
fi
