eval `/usr/bin/dircolors $HOME/.colorsdb`
export X11HOME=/usr/X11R6
export JDK_HOME=/usr/local/j2sdk1.4.0
export CVSROOT=/usr/local/cvs
export CVS_RSH=ssh
export GS_OPTIONS="-sPAPERSIZE=a4"
export TEXINPUTS=/usr/share/texmf/tex/latex/prosper:/home/jax/latex:$TEXINPUTS
export XERCESCROOT=/usr/local/src/xerces-c
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$XERCESCROOT/lib
export EDITOR=/usr/bin/vim
export CVSCLINIC=":ext:jscherpe@turing.cs.hmc.edu:/clinic/2003/ray03/"
export MAYA_SHADER_LIBRARY_PATH="/usr/aw/shaderLibrary"

# OpenGL issues
export __GL_SYNC_DISPLAY_DEVICE=DFP-0
export __GL_SYNC_TO_VBLANK=1

export LANGUAGE=en
export LINGUAS=en
export LC_ALL=en_US.UTF8 # General language settings as English
export LC_CTYPE=ja_JP    # May break certain things like window maker; untested
export LC_TIME=C         # Format time as English
export LC_NUMERIC=C      # Format numbers as English
export LC_MESSAGES=C     # Output messages in English
export LC_COLLATE=ja_JP  # Do sorting and collating of characters as Japanese
export LANG=ja_JP.UTF8        # Use Japanese for all others

path=(/usr/bin /usr/local/bin /bin /usr/games)
path=($path $X11HOME/bin)
path=($path $HOME/bin /usr/sbin /sbin)
path=($path $JDK_HOME/bin)
path=($path /usr/aw/maya5.0/bin)
