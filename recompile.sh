#!/bin/sh

#
# For easier comiling with the DJPP cross-compiler on Linux
#   Use ./recompile -all to build RELEASE, DEBUG and PROFILE versions of Allegro

# Paths to DJGPP set these to where ever you have your DJGPP Cross-compiler
export PATH=$HOME/djgpp/i586-pc-msdosdjgpp/bin/:$PATH
export GCC_EXEC_PREFIX=$HOME/djgpp/lib/gcc/

# For automatic copying after build, set these to your DJPP and ALLEGRO parent directories
export DJGPP_DIR=$HOME/djgpp
export ALLEGRO_DIR=$HOME/allegro

# Clean, Rebuild Dependencies, Build Lib
echo "\nCleaning Allegro"
echo "----------------"
make veryclean TARGET_ARCH_EXCL=i386 UNIX_TOOLS=1 CROSSCOMPILE=1
make veryclean TARGET_ARCH_EXCL=i386 UNIX_TOOLS=1 CROSSCOMPILE=1 DEBUGMODE=1
make veryclean TARGET_ARCH_EXCL=i386 UNIX_TOOLS=1 CROSSCOMPILE=1 PROFILEMODE=1
echo "\nRebuilding Allegro Dependencies"
echo "-------------------------------"
make depend TARGET_ARCH_EXCL=i386 UNIX_TOOLS=1 CROSSCOMPILE=1
if [ "$1" = "-all" ]; then
    make depend TARGET_ARCH_EXCL=i386 UNIX_TOOLS=1 CROSSCOMPILE=1 DEBUGMODE=1
    make depend TARGET_ARCH_EXCL=i386 UNIX_TOOLS=1 CROSSCOMPILE=1 PROFILEMODE=1
fi
echo "\nRebuilding Allegro Libs"
echo "-----------------------"
make lib TARGET_ARCH_EXCL=i386 UNIX_TOOLS=1 CROSSCOMPILE=1
if [ "$1" = "-all" ]; then
    make lib TARGET_ARCH_EXCL=i386 UNIX_TOOLS=1 CROSSCOMPILE=1 DEBUGMODE=1
    make lib TARGET_ARCH_EXCL=i386 UNIX_TOOLS=1 CROSSCOMPILE=1 PROFILEMODE=1
fi

# Clear prefix so the modified version of DAT will compile with modern GCC
# We don't want to use a DOS version
export GCC_EXEC_PREFIX=
$ALLEGRO_DIR/tools/build_dat.sh

echo "\nCopying Allegro Libs..."
cp -R -T $ALLEGRO_DIR/lib/djgpp $DJGPP_DIR/lib/
echo "\nCopying Allegro Headers..."
cp -r $ALLEGRO_DIR/include/ $DJGPP_DIR
