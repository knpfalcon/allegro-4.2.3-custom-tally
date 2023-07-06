#!/bin/sh
export ALLEGRO_DIR=$HOME/allegro

echo "\nCompiling makedoc"
echo "-------------"
gcc -I"$ALLEGRO_DIR"/docs/src/makedoc/ makedoc.c makechm.c makedevh.c makehtml.c makeman.c makemisc.c makertf.c makesci.c maketexi.c maketxt.c -o $ALLEGRO_DIR/docs/makedoc
