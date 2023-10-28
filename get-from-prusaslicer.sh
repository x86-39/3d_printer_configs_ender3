#!/bin/bash

PRINTER_FIND="*Ender 3*"

rm ./PrusaSlicer/{filament,print,printer}/*

IFS=$'\n'
for d in {filament,print,printer}; do
    mkdir -p ./PrusaSlicer/$d || true
    for f in $( find ~/.config/PrusaSlicer/$d -type f -name $PRINTER_FIND -printf '%P\n' ); do
        cp ~/.config/PrusaSlicer/$d/$f ./PrusaSlicer/$d/$f
    done
done