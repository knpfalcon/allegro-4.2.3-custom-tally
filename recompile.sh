#!/bin/sh

#
# For easier comiling with the DJPP cross-compiler on Linux
#   Use ./recompile.sh -all to build and install RELEASE, DEBUG and PROFILE versions of Allegro
#   Use ./recompile.sh without arguments to build and install only the RELEASE versions

# Set this to the location of your DJGPP binaries
DJGPPGBIN=$HOME/djgpp/i586-pc-msdosdjgpp/bin

DOCDEST=$HOME/AllegroManual

# Set these to your DJGPP and Allegro parent directories
export DJGPP_DIR=$HOME/djgpp
export ALLEGRO_DIR=$HOME/allegro

# This is where the makedoc binary will be when it is compiled
export MAKEDOC=$ALLEGRO_DIR/docs/makedoc

# This exports the paths for DJGPP's bin and changes the GCC_EXEC_PREFIX to DJGPP
# The functions that compile DAT and makedoc shouldn't use this because I want to
# use a modern compiler for those for use in my workflow
exportpaths()
{
    export PATH=$DJGPPGBIN/:$PATH
    export GCC_EXEC_PREFIX=$HOME/djgpp/lib/gcc/
}

# Cleans everything out of Allegro that was built. You must rebuild dependencies
# before trying to recompile. This script does that for you, of course.
clean()
{
    echo "\nDeep Cleaning Allegro"
    echo "----------------"
    make veryclean TARGET_ARCH_EXCL=i386 UNIX_TOOLS=1 CROSSCOMPILE=1
    make veryclean TARGET_ARCH_EXCL=i386 UNIX_TOOLS=1 CROSSCOMPILE=1 DEBUGMODE=1
    make veryclean TARGET_ARCH_EXCL=i386 UNIX_TOOLS=1 CROSSCOMPILE=1 PROFILEMODE=1
}

# Rebuilds the dependencies Allegro needs for compiling. DAT needs the plugins.h
# which is done by cat command.
depend()
{
    echo "\nBuilding Allegro Dependencies"
    echo "-------------------------------"
    cat $ALLEGRO_DIR/tools/plugins/*.inc > $ALLEGRO_DIR/obj/djgpp/plugins.h
    make depend TARGET_ARCH_EXCL=i386 UNIX_TOOLS=1 CROSSCOMPILE=1
}

# Build only RELEASE version of Allegro, without debug symbols
release()
{
    echo "\nBuilding Allegro Release Lib"
    echo "-----------------------"
    make lib TARGET_ARCH_EXCL=i386 UNIX_TOOLS=1 CROSSCOMPILE=1
}

# Build only DEBUG version of Allegro
debug()
{
    echo "\nBuilding Allegro Debug Lib"
    echo "-----------------------"
    make lib TARGET_ARCH_EXCL=i386 UNIX_TOOLS=1 CROSSCOMPILE=1 DEBUGMODE=1
}

# Build only PROFILE version of Allegro
profile()
{
    echo "\nBuilding Allegro Profile Lib"
    echo "-----------------------"
    make lib TARGET_ARCH_EXCL=i386 UNIX_TOOLS=1 CROSSCOMPILE=1 PROFILEMODE=1
}

# Haven't implemented these yet. I usually just compile them manually as I need them.
examples()
{
    echo "Building examples from this script isn't yet implemented."
}

# Makes an HTML version of the documenation and puts it in the folder specified by
# the DOCDEST variable at the top. You must build makedoc first for this to work.
docs()
{
    ( cd docs/src/; for file in *._tx; do $MAKEDOC -html $DOCDEST/$(basename $file ._tx).html $file; done )
    ( cd docs/src/build; for file in *._tx; do $MAKEDOC -html $DOCDEST/build/$(basename $file ._tx).html $file; done )
}

# Builds makedoc for use on modern Linux.
makedoc()
{
    ( cd $ALLEGRO_DIR/docs/src/makedoc/; ./makedoc.sh )
}

# Builds the dat tool for use on modern Linux.
dat()
{
    ( cd $ALLEGRO_DIR/tools; ./build_dat.sh )
}

# Copies Allegro libs and headers to proper place in the directory DJGPP_DIR
# is set with.
copy()
{
    echo "\nCopying Allegro Libs..."
    cp -R -T $ALLEGRO_DIR/lib/djgpp $DJGPP_DIR/lib/
    echo "\nCopying Allegro Headers..."
    cp -r $ALLEGRO_DIR/include/ $DJGPP_DIR
}

# Runs make with all option... Doesn't work quite right, hence the reason for this script.
# Put here as a test.
makeall()
{
    clean
    depend
    make all TARGET_ARCH_EXCL=i386 UNIX_TOOLS=1 CROSSCOMPILE=1 DEBUGMODE=1
}

# ./recompile.sh -all
if [ "$1" = "-all" ]; then
    exportpaths
    clean
    depend
    release
    debug
    profile
    copy
fi

# ./recompile.sh -clean
if [ "$1" = "-clean" ]; then
    exportpaths
    clean
fi

# ./recompile.sh -release
if [ "$1" = "-release" ]; then
    exportpaths
    clean
    depend
    release
fi

# ./recompile.sh -debug
if [ "$1" = "-debug" ]; then
    exportpaths
    clean
    depend
    debug
fi

# ./recompile.sh -profile
if [ "$1" = "-profile" ]; then
    exportpaths
    clean
    depend
    profile
fi

# ./recompile.sh -depend
if [ "$1" = "-depend" ]; then
    exportpaths
    depend
fi

# ./recompile.sh
if [ $# -eq 0 ]; then
    exportpaths
    clean
    depend
    release
    copy
fi

# ./recompile.sh -dat
# Compile DAT
if [ "$1" = "-dat" ]; then
    dat
fi

# ./recompile.sh -makedoc
# Compile MAKEDOC
if [ "$1" = "-makedoc" ]; then
    makedoc
fi

# ./recompile.sh -docs
# Compile Documentation in HTML Format
if [ "$1" = "-docs" ]; then
    mkdir -p $DOCDEST
    mkdir -p $DOCDEST/build
    docs
fi

# ./recompile.sh -tools
# Compile both DAT and MAKEDOC
if [ "$1" = "-tools" ]; then
    dat
    makedoc
fi

# ./recompile.sh -examples
# Compile both EXAMPLES (Not working implemented yet).
if [ "$1" = "-examples" ]; then
    examples
fi