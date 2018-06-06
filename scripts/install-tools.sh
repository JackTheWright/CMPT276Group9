#!/bin/bash

WD=$(pwd)
echo "[ INFO ]: Adding $WD to ~/.bashrc"
echo "export PATH=\"$WD/scripts:\$PATH\"" >> ~/.bashrc
echo "[  OK  ]: Done"
echo "[ INFO ]: Defining TRACKIT_ROOT"
echo "export TRACKIT_ROOT=\"$WD\"" >> ~/.bashrc
echo "[  OK  ]: Done"
export PATH="$WD/scripts:$PATH"
export TRACKIT_ROOT="$WD"
echo "[ GOOD ]: Install complete"

