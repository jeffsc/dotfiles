#
# Example .zshrc file for zsh 4.0
#
# .zshrc is sourced in interactive shells.  It
# should contain commands to set up aliases, functions,
# options, key bindings, etc.
#

# THIS FILE IS NOT INTENDED TO BE USED AS /etc/zshrc, NOR WITHOUT EDITING

# Search path for the cd command
cdpath=()

# Use hard limits, except for a smaller stack and no core dumps
unlimit
limit stack 8192
limit core 0
limit -s

umask 022

# Set up aliases
alias mv='nocorrect mv'       # no spelling correction on mv
alias cp='nocorrect cp'       # no spelling correction on cp
alias mkdir='nocorrect mkdir' # no spelling correction on mkdir
alias j=jobs
alias pu=pushd
alias po=popd
alias d='dirs -v'
alias h=history
alias grep=egrep
alias ls='ls --color=auto -F'
alias ll='ls -l'
alias la='ls -a'
alias less='less -m'
alias c='noglob perl -le "print eval qq(@ARGV)"'
alias man='~/bin/manlocale'

# List only directories and symbolic
# links that point to directories
alias lsd='ls -d *(-/DN)'
alias llsd='ls -ld *(-/DN)'

# List only file beginning with "."
alias l.='ls -d .*'
alias lsa='ls -ld .*'

alias u='cd ..'
alias uu='cd ../..'
alias uuu='cd ../../..'
alias uuuu='cd ../../../..'

# CVS for turing
alias cvs-clinic='cvs -d $CVSCLINIC'

# Shell functions
setenv() { typeset -x "${1}${1:+=}${(@)argv[2,$#]}" }  # csh compatibility
freload() { while (( $# )); do; unfunction $1; autoload -U $1; shift; done }
#chpwd() { print -Pn "\e]0;%n@%m: %~\a"}

# Where to look for autoloaded function definitions
fpath=($fpath ~/.zfunc)

# Autoload all shell functions from all directories in $fpath (following
# symlinks) that have the executable bit on (the executable bit is not
# necessary, but gives you an easy way to stop the autoloading of a
# particular shell function). $fpath should not be empty for this to work.
for func in $^fpath/*(N-.x:t); autoload $func

# automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath

# Global aliases -- These do not have to be
# at the beginning of the command line.
alias -g M='|more'
alias -g H='|head'
alias -g T='|tail'
alias -g L='|less'
alias -g I='|ispell -a'

#manpath=($X11HOME/man /usr/man /usr/lang/man /usr/local/man)
#export MANPATH

# Hosts to use for completion (see later zstyle)
#hosts=(`hostname` ftp.math.gatech.edu prep.ai.mit.edu wuarchive.wustl.edu)
hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts <$HOME/.ssh/known_hosts2)"}:#[0-9]*}%%\ *}%%,*} www.google.com www.slashdot.org)
users=(jax jscherpelz jscherpe jeff)

my_accounts=(
	jax@{soren,nysori,soren.st.hmc.edu,nysori.st.hmc.edu,baku,baku.st.hmc.edu}
	jscherpelz@{odin,odin.ac.hmc.edu,mail2,mail2.ac.hmc.edu,improv,improv.ac.hmc.edu,munin.claremont.edu}
	jscherpe@{turing,turing.cs.hmc.edu,hobgoblin.cs.hmc.edu}
	jeff@elves-and-buttercups.st.hmc.edu
)

# Set prompts
#PROMPT='%m%# '    # default prompt
#RPROMPT=' %~'     # prompt for right side of screen

# Some environment variables
export MAIL=/var/spool/mail/$USERNAME
export LESS=-cex3M
export HELPDIR=/usr/local/lib/zsh/help  # directory for run-help function to find docs

MAILCHECK=300
HISTSIZE=200
DIRSTACKSIZE=20

# Watch for my friends
#watch=( $(<~/.friends) )       # watch for people in .friends file
watch=(notme)                   # watch for everybody but me
LOGCHECK=300                    # check every 5 min for login/logout activity
WATCHFMT='%n %a %l from %m at %t.'

# Set/unset  shell options
setopt   notify globdots correct pushdtohome cdablevars autolist
setopt   correctall autocd longlistjobs
setopt   autoresume histignoredups pushdsilent noclobber
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
setopt   autoparamslash
setopt	ignoreeof
unsetopt bgnice
setopt	nobeep

# Autoload zsh modules when they are referenced
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -ap zsh/mapfile mapfile

# Some nice key bindings
bindkey '^X^Z' universal-argument ' ' magic-space
bindkey '^X^A' vi-find-prev-char-skip
bindkey '^Xa' _expand_alias
bindkey '^Z' accept-and-hold
bindkey -s '\M-/' \\\\
bindkey -s '\M-=' \|

#bindkey -v               # vi key bindings

#bindkey -e                 # emacs key bindings
bindkey ' ' magic-space    # also do history expansion on space
bindkey '^I' complete-word # complete on tab, leave expansion to _expand
bindkey '^X^H' run-help
bindkey '^X^Q' push-line
#bindkey '^X^A' accept-and-hold

# Setup new style completion system. To see examples of the old style (compctl
# based) programmable completion, check Misc/compctl-examples in the zsh
# distribution.
autoload -U compinit
compinit

# Completion Styles

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
    
# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host completion
#zstyle ':completion:*:processes' command 'ps -o pid,s,nice,stime,args'
#zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
zstyle '*' hosts $hosts

# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
    '*?.old' '*?.pro'
# the same for old style completion
#fignore=(.o .c~ .old .pro)

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'

zstyle ':completion:*:hosts' hosts $hosts
zstyle ':completion:*:users' user $users
zstyle ':completion:*:my-accounts' users-hosts $my_accounts

###############
#  git stuff  #
###############

typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

setopt prompt_subst

export __CURRENT_GIT_BRANCH=
export __CURRENT_GIT_VARS_INVALID=1

zsh_git_invalidate_vars() {
    export __CURRENT_GIT_VARS_INVALID=1
}
zsh_git_compute_vars() {
    export __CURRENT_GIT_BRANCH="$(parse_git_branch)"
    export __CURRENT_GIT_VARS_INVALID=
}

parse_git_branch() {
    git branch --no-color 2> /dev/null \
    | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

chpwd_functions+='zsh_git_chpwd_update_vars'
zsh_git_chpwd_update_vars() {
    zsh_git_invalidate_vars
}

preexec_functions+='zsh_git_preexec_update_vars'
zsh_git_preexec_update_vars() {
    case "$(history $HISTCMD)" in 
        *git*) zsh_git_invalidate_vars ;;
    esac
}

get_git_prompt_info() {
    test -n "$__CURRENT_GIT_VARS_INVALID" && zsh_git_compute_vars
    echo $__CURRENT_GIT_BRANCH
}

alias git='noglob git'

#autoload -U promptinit
#promptinit
#prompt jax
source ~/.zsh-func/prompt_jax
prompt_jax

www=/usr/local/www/content
anime=/media/new/anime
newanime=/media/new/anime-new
smp3=/home/jax/programming/servermp3

source ~/.zcompctl

# Get rid of Ubuntu menu warnings
UBUNTU_MENUPROXY=

set_console_title () { print -Pn "\e]0;Eterm console\a" }
