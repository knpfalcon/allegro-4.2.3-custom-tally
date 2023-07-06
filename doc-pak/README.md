# Allegro 4.2.3 - Custom Build for Tally Trauma

This is a modified version of Allegro 4.2.3 for my `DOS` game `Tally Trauma`. There were a few things I didn't need, wanted to work differently, or would cause DJGPP to crash. I make changes as I run across something I need to work differently for my game.

## FOR USE WITH DJGPP CROSS-COMPILER

### Linux
Get it from this repo: https://github.com/andrewwutw/build-djgpp

Pre-built binaries are available if you don't want to compile DJGPP from source. I'm using `GCC 5.1.0` for this build. But the link above has releases for up to `GCC 12.2.0`

### Windows

The above repo has `MinGW` versions for `Windows`.

`recompile.sh` will probably work with the DJGPP cross-compiler for windows, but I haven't completely tested it. You would have to use `GitBash`. Or, I think `Powershell` supports bash now too. 

#### Another option:

https://www.mrdictionary.net/allegro/ (Scroll to the bottom.)

If you downloaded `DJGPP` and `Allegro` from `mrdictionary.net`, follow those instructions. You could change out that `allegro` directory with this one. The package from `mrdictionary.net` uses an older version of `GCC`, so If you replace that `allegro` directory with this one, remove all occurrences of `-fgnu89-inline` from `makefile.dj`. 

### OSX

No idea, honestly. I don't use it. But I assume it wouldn't be that much different from Linux. Just download the appropriate release from: https://github.com/andrewwutw/build-djgpp

## Changes from Original
- **Don't check automatically for FPU if CPUID instruction isn't present.** When `install_allegro()` or `allegro_init()` is called, it checks if the `CPUID` instruction is available. If it *is* available, it uses that information to check for a `FPU`/`Floating Point Unit` coprocessor. If `CPUID` *is not* available, it checks for the `FPU` differently which causes a crash with `SIGNOFP` if the `CPU` doesn't have an `FPU`.  This was a problem with my `486sx` which was made before 1992-1993. I created a `check_fpu` variable which is by default set to `0`. It will not automatically check for an `FPU` now if `CPUID` isn't present. If you so wish to check for an `FPU` when `CPUID` isn't present, set `check_fpu` to anything above `0` before calling `install_allegro()` or `allegro_init()`.
- **recompile.sh** for easy recompling. It cleans everything, generates the dependencies, then recompiles. It may need to be modified based on your setup.
- **DAT tool** no longer appends file extentions to the end of object names. For example, `IMAGE.PCX` will be in your datafile and generated header as simply `IMAGE`. The old behavior caused the object to be named `IMAGE_PCX`. I didn't like that. `build_dat.sh` is in the tools directory for easy building. `recompile.sh` calls this script automatically and rebuilds `DAT` as `ZDAT`. It does not use `DJGPP` to build, so I can use it on a modern OS. So you'd have to install a native version of Allegro 4 for that. If you're on Linux and have `apt`, it's a simple `sudo apt install liballegro4.2-dev`. And make sure, of course, to have `GCC` installed.
 
## Instructions

- Edit recompile.sh to your needs. Change these lines to the directories where `DJGPP` and `Allegro` are. Or put `DJGPP` and `Allegro` in your home folder. 

```
# Paths to DJGPP. Set these to where you have DJGPP
export PATH=$HOME/djgpp/i586-pc-msdosdjgpp/bin/:$PATH
export GCC_EXEC_PREFIX=$HOME/djgpp/lib/gcc/

# For automatic copying after build, set these to your DJPP and ALLEGRO parent directories
export DJGPP_DIR=$HOME/djgpp
export ALLEGRO_DIR=$HOME/allegro
```

- Navigate to Allegro's root folder

```
cd /YOUR_PATH_TO/allegro/
```

- Run recompile.sh to build the `RELEASE` version and automatically copy it to your `DJGPP` directory.
```
./recompile.sh
```

- If you want the `PROFILE` and `DEBUG` builds also, run:
```
./recompile.sh -all
```
It will compile all versions.

## Final Notes
- This `custom version` of `Allegro 4.2.3` is intended for compiling games and apps for `DOS`. It may work on other platforms, but at that point you're better off using `Allegro 5`, which is much better for modern platforms. https://github.com/liballeg/allegro5

- This doesn't build the examples and tools other than `DAT`. I'm sure it wouldn't be too difficult to make the necessary modifications if you want them. You could compile them individually too. I don't need them, so I didn't bother with the extra effort.

- Forgive any mess due to formatters and my laziness. :)
