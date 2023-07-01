#!/bin/sh

#
# Compile Allegro's DAT utility
#   Environment Variable ALLEGRO_DIR should be set first if not
#   using ./recompile.
#   
#export ALLEGRO_DIR=$HOME/allegro
#

echo "\nCompiling DAT"
echo "-------------"
echo gcc -I"$ALLEGRO_DIR"/obj/djgpp/ -o zdat dat.c datedit.c plugins/datitype.c plugins/datfli.c plugins/datalpha.c plugins/datfname.c plugins/datfont.c plugins/datgrab.c plugins/datgrid.c plugins/datimage.c plugins/datmidi.c plugins/datpal.c plugins/datsamp.c plugins/datworms.c -lalleg
