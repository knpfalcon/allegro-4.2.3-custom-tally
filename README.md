# Allegro 4.2.3 - Custom Build for Tally Trauma

This is a modified version of Allegro 4.2.3 for my DOS game Tally Trauma. So far, I've removed Allegro's check for FPU. DJGPP would throw an SIGNOFP when I was intentionally avoiding floats. I also modified the dat tool to stop appending file extentions onto datafile object names. For example, formerly when using dat, a file like FILE.PCX would be name FILE_PCX inside the datafile. Now there's no _PCX tacked on.

This version is meant to be used with the DJGPP cross-compiler. There's no guarantee if it will work for you. I'm putting this repo up for two reasons:

1. To back-up my changes.
2. Keep my modifcations open-source for anyone to look at.

I also added recompile.sh for easy recompling. It cleans everything, generates the dependencies, then recompiles. It may need to be modified based on your setup.

You'll have to forgive any mess due to formatters and my laziness. :)
