#!/bin/bash

make publish;

echo "Building HTML is complete!"

cp -r ./output/* ../chickenandsnake.github.io;
echo "Coppying files complete"




