# Allegro 4.2.3 - Custom Build for Tally Trauma

This is a modified version of Allegro 4.2.3 for my DOS game Tally Trauma.

### Changes from Original
- Don't check automatically for FPU if CPUID instruction isn't present. This used to cause a SIGNOFP crash with DJGPP on CPUs without an FPU. Now the user has the option to set `check_fpu`, before initializing Allegro, to true to check for FPU if CPUID isn't present.
- DAT tool now doesn't append file extentions to the end of object names. For example, IMAGE.PCX will be in your datafile as simply IMAGE.
- I also added recompile.sh for easy recompling. It cleans everything, generates the dependencies, then recompiles. It may need to be modified based on your setup.

You'll have to forgive any mess due to formatters and my laziness. :)
