#!/bin/bash
cd figs/backup; \
for name in *.pdf; do
    convert -density 300 -quality 100 -resize 1600x1600 $name ../$name
done
