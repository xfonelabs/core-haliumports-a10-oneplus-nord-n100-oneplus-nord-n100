#!/bin/bash
set -xe

[ -d build ] || git clone https://gitlab.com/rubencarneiro/halium-generic-adaptation-build-tools -b sageteaedge build
./build/build.sh "$@"