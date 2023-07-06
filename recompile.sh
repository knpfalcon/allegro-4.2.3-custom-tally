#!/bin/sh

#
# For easier comiling with the DJPP cross-compiler on Linux
#   Use ./recompile -all to build RELEASE, DEBUG and PROFILE versions of Allegro

# Paths to DJGPP. Set these to where you have DJGPP
DJGPPGBIN=$HOME/djgpp/i586-pc-msdosdjgpp/bin

# For automatic copying after build, set these to your DJPP and ALLEGRO parent directories
export DJGPP_DIR=$HOME/djgpp
export ALLEGRO_DIR=$HOME/allegro

export MAKEDOC=$ALLEGRO_DIR/docs/makedoc


exportpaths()
{
    export PATH=$DJGPPGBIN/:$PATH
    export GCC_EXEC_PREFIX=$HOME/djgpp/lib/gcc/
}
# Clean, Rebuild Dependencies, Build Lib
clean()
{
    echo "\nDeep Cleaning Allegro"
    echo "----------------"
    make veryclean TARGET_ARCH_EXCL=i386 UNIX_TOOLS=1 CROSSCOMPILE=1
    make veryclean TARGET_ARCH_EXCL=i386 UNIX_TOOLS=1 CROSSCOMPILE=1 DEBUGMODE=1
    make veryclean TARGET_ARCH_EXCL=i386 UNIX_TOOLS=1 CROSSCOMPILE=1 PROFILEMODE=1
}

# Rebuild Dependencies
depend()
{
    echo "\nBuilding Allegro Dependencies"
    echo "-------------------------------"
    cat $ALLEGRO_DIR/tools/plugins/*.inc > $ALLEGRO_DIR/obj/djgpp/plugins.h
    make depend TARGET_ARCH_EXCL=i386 UNIX_TOOLS=1 CROSSCOMPILE=1
}

release()
{
    echo "\nBuilding Allegro Release Lib"
    echo "-----------------------"
    make lib TARGET_ARCH_EXCL=i386 UNIX_TOOLS=1 CROSSCOMPILE=1
}

debug()
{
    echo "\nBuilding Allegro Debug Lib"
    echo "-----------------------"
    make depend TARGET_ARCH_EXCL=i386 UNIX_TOOLS=1 CROSSCOMPILE=1 DEBUGMODE=1
}

profile()
{
    echo "\nBuilding Allegro Profile Lib"
    echo "-----------------------"
    make depend TARGET_ARCH_EXCL=i386 UNIX_TOOLS=1 CROSSCOMPILE=1 PROFILEMODE=1
}

examples()
{
    make examples TARGET_ARCH_EXCL=i386 UNIX_TOOLS=1 CROSSCOMPILE=1
}

docs()
{
    ( cd docs/src/; for file in *._tx; do $MAKEDOC -html $HOME/alleg423manual/$(basename $file ._tx).html $file; done )
    ( cd docs/src/build; for file in *._tx; do $MAKEDOC -html $HOME/alleg423manual/build/$(basename $file ._tx).html $file; done )
}


makedoc()
{
    ( cd $ALLEGRO_DIR/docs/src/makedoc/; ./makedoc.sh )
}

dat()
{
    ( cd $ALLEGRO_DIR/tools; ./build_dat.sh )
}

copy()
{
    echo "\nCopying Allegro Libs..."
    cp -R -T $ALLEGRO_DIR/lib/djgpp $DJGPP_DIR/lib/
    echo "\nCopying Allegro Headers..."
    cp -r $ALLEGRO_DIR/include/ $DJGPP_DIR
}

makeall()
{
    clean
    depend
    make all TARGET_ARCH_EXCL=i386 UNIX_TOOLS=1 CROSSCOMPILE=1 DEBUGMODE=1
}

if [ "$1" = "-all" ]; then
    exportpaths
    clean
    depend
    release
    debug
    profile
    dat
fi


if [ "$1" = "-clean" ]; then
    exportpaths
    clean
fi

if [ "$1" = "-release" ]; then
    exportpaths
    clean
    depend
    release
fi

if [ "$1" = "-debug" ]; then
    exportpaths
    clean
    depend
    debug
fi

if [ "$1" = "-profile" ]; then
    exportpaths
    clean
    depend
    profile
fi

if [ "$1" = "-depend" ]; then
    exportpaths
    depend
fi


if [ $# -eq 0 ]; then
    exportpaths
    clean
    depend
    release
    copy
fi

if [ "$1" = "-dat" ]; then
    dat
fi


if [ "$1" = "-docs" ]; then
    docs
fi

if [ "$1" = "-makedoc" ]; then
    makedoc
fi

if [ "$1" = "-tools" ]; then
    dat
    makedoc
fi

