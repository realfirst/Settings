# *************************************************************************
# DOT CSHRC BY YEN-LIANG LIU
# *************************************************************************

# *******************************************************************
# BASIC SETTINGS.
# *******************************************************************
setenv PATH "/usr/local/bin:/usr/X11R6/bin:/usr/bin:/bin:/usr/sbin"
setenv LD_LIBRARY_PATH "/usr/local/lib:/usr/X11R6/lib64:/usr/lib64:/usr/lib:/lib64:/lib"
setenv MANPATH "/usr/X11R6/man:/usr/man:/usr/share/man"
setenv EXINIT   `set ai|set shiftwidth=3|set ic`
setenv LS_COLORS "di=1;36:ln=1;34:ex=1;35:mi=1;31:or=5;41:*.gz=01;31:*.bz2=01;31:*.d=31:*.c=32:*.h=32:*.inl=32:*.cpp=32:*.hpp=32:*.o=1;30"
set autolist = ambiguous
set notify
set fignore = (.o \~)
set savehist = 2000
set history = 2000

# *******************************************************************
# SETUP ENVIRONMENT VARIABLES
# *******************************************************************
if ( ! $?USER ) then
    setenv USER `whoami`
endif
if ( ! $?HOST ) then
    setenv HOST `hostname`
endif
if ( ! $?UNAME ) then
    setenv UNAME  `uname`
endif
if ( ! $?UNAME_R ) then
    setenv UNAME_R `uname -r`
endif

if ( $TERM =~ *xterm* ) then
    bindkey "\e[1~" beginning-of-line
    bindkey "\e[4~" end-of-line
#     bindkey "\e[3~" delete-char-or-list-or-eof
    bindkey "\e[7~" beginning-of-line
    bindkey "\e[8~" end-of-line
	#    setenv TERM xterm-16color
else if ( $TERM =~ *rxvt* ) then
    bindkey "\e[7~" beginning-of-line
    bindkey "\e[8~" end-of-line
    bindkey "\e[3~" delete-char-or-list-or-eof
    setenv TERM rxvt
endif

# ********************************************************************
# DEVELOPMENT SETTINGS
# ********************************************************************
# setenv EMACS_HOME ~/emacs
setenv MANPATH "~/local/man:${MANPATH}"
setenv LD_LIBRARY_PATH "~/local/lib:${LD_LIBRARY_PATH}"
setenv EDITOR "emacsclient -c -a """
setenv VISUAL "emacsclient -c -a """

set path = ( ~/local/bin $path )

#
source ~/00env/cshrc.dev
source ~/00env/cshrc.qt
source ~/00env/cshrc.boost

alias use_aspirin_rb10 'source ~/00env/cshrc.aspirin RB-1.0'
# source ~/00env/cshrc.aspirin

source ~/00env/cshrc.oa
# source ~/00env/cshrc.xarch

source ~/00env/cshrc.local_tools

# Cadence SOC Encounter
alias use_cadence 'source /space/eda/00env/cshrc.ic611'
alias use_opus 'source /space/eda/00env/cshrc.opus'

# Astro & IC Compiler
alias use_astro 'source /space/eda/00env/cshrc.ast_200606SP2'
alias use_icc 'source ~/00env/cshrc.icc'

# Magma
alias use_magma 'source /space/eda/00env/cshrc.magma_060506'

# PrimeTime
alias use_pt 'source /space/eda/00env/cshrc.pt_0706-SP3;setenv MANPATH /space/eda/synopsys/PT/Z-2006.12-SP1/doc/pt/man:$MANPATH'

###########################################
# Change the window title of X terminals
###########################################
set backslash_quote
if( $?DISPLAY && $?TERM ) then
    if( $?MRXVT_TABTITLE ) then
    # Set the tab title for mrxvt
        if ( ! $?EMACS ) then
            alias jobcmd 'echo -n \\\\033]61\;\!#:q  \($cwd\) \\\\007 > /dev/stderr'
            alias cwdcmd 'echo -n \\\\033]61\;\!#:q  \($cwd\) \\\\007 > /dev/stderr'
        endif
    else
    # Set the window title for xterm
        if ( ! $?EMACS ) then
        alias jobcmd 'echo -n \\\\033]0\;\!#:q  \($cwd\) \\\\007 > /dev/stderr'
        alias cwdcmd 'echo -n \\\\033]0\;\!#:q  \($cwd\) \\\\007 > /dev/stderr'
        endif
    endif
endif
unset backslash_quote

# -------------------------------------------------------------------
# ALIASES
# -------------------------------------------------------------------
if ( $UNAME == Linux ) then
     alias ls      '/bin/ls --color=auto -F'
endif
alias ll          'ls -l'
alias la          'ls -la'
alias rm          'rm -i'

alias ec          'emacsclient -nc -a ""'
alias et          'emacsclient -t -a ""'
alias startvnc    'vncserver :90 -geometry 1280x768 -depth 24'
alias gr          'grep -n'
alias cls         'clear'
alias date        'date +"%Y/%m/%d %H:%M:%S"'
# alias rdp         'rdesktop -a 16 -g 1024x768 -u $USER -r disk:local=/josh -r disk:rd=/d100/home/josh -r clipboard:PRIMARYCLIPBOARD 10.1.14.25'
alias rdp         'rdesktop -a 16 -g 1270x950 -u $USER -r disk:local=/josh -r disk:rd=/d100/home/josh -r clipboard:PRIMARYCLIPBOARD 10.1.14.25'
alias emulator    'emulator -avd avd-1.5 -sdcard ~/sd256m.img'
# alias valgrind 'valgrind --xml=yes --log-file=valgrind.log.xml --tool=memcheck -v --leak-check=full'
alias valgrind 'valgrind --log-file=valgrind.log.xml --tool=memcheck -v --leak-check=full --child-silent-after-fork=yes --xml=yes --show-below-main=yes'
alias bld '../../etc/script/bld'
# Aliases for connection to pc10?
foreach n ( 03 04 06 07 09 10 11)
   alias pc1$n 'ssh -X 10.1.12.1'$n
end
alias oakland 'ssh 10.1.12.98'
set MY_CODE_ROOT="~/projects/"
alias src 'cd $MY_CODE_ROOT/aspirin/trunk/src/'
alias rb1 'cd $MY_CODE_ROOT/aspirin/RB-1.0/src/'
alias rn6242 'cd $MY_CODE_ROOT/aspirin/RN6242/src/'
alias rb1.2 'cd $MY_CODE_ROOT/aspirin/RB-1.2/src/'
alias rel1 'cd $MY_CODE_ROOT/aspirin/REL-1.0/src/'
alias bug77 'cd $MY_CODE_ROOT/aspirin/BUG-77/src/'
alias bug80 'cd $MY_CODE_ROOT/aspirin/BUG-80/src/'

# #########################################################################
# Test for S60
# #########################################################################
# setenv GNUPOC_ROOT $HOME/gnupoc
# setenv TOOLCHAIN_DIR $GNUPOC_ROOT/csl_gcc
# setenv S60_SDK_DIR $GNUPOC_ROOT/symbian-sdks/3.1
# setenv QT_S60_DIR $GNUPOC_ROOT/qt_s60
# setenv WRAPPER_DIR $GNUPOC_ROOT/bin
# setenv SRC_DIR $HOME/downloads

# for freemind
setenv JAVA_HOME ~/tools/jdk/current/jre

# ------------------------------------------------------------------------
# MISC SETTINGS.
# ------------------------------------------------------------------------
set cdpath = ( $HOME )
set prompt = "[%n@%m]:%~ > "
# set prompt = "%{[0;35m%}%S%m%s%{[0m%}:%~%{[0m%} > "
# set prompt = "%{^[[1;37;44m%}%n@%{^[[1;32;43m%}%m:%{^[[1;33;41m%}%~%{^[[0m%} > "
# set prompt = "%{^[[0;37;44m%}%n@%{^[[0;32;43m%}%m:%{^[[0;33;41m%}%~ %{^[[0m%}> "

if ( $?EMACS ) then
    unsetenv LS_COLORS
    unalias ls
    alias ls '/bin/ls -F'
    unset    prompt
    set      prompt = "[%m]:%~ > "
endif

#
setenv SHELL tcsh
set    symlinks=ignore
set    rmstar

umask 027 # remove w from group permission and rwx from others permission.

# setenv TERM xterm-256color

#cd .
