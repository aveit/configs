alias cfg='cd ~/.config/'
alias dev='cd $HOME/dev/'
alias app='cd $HOME/dev/app/'
alias lcfg='cd ~/.config/lvim/'
alias ecfg='lvim ~/.config/lvim/config.lua'

alias vi='lvim'
alias vim='lvim'
alias nvim='lvim'

# FLUTTER
alias clget='flutter clean &&  flutter pub get'
alias bldrun='flutter pub run build_runner build --delete-conflicting-outputs'

alias ls='exa -al --color=always --group-directories-first' # my preferred listing
alias la='exa -a --color=always --group-directories-first'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first'  # long format
alias lt='exa -aT --color=always --group-directories-first' # tree listing
alias l.='exa -a --group-directories-first | egrep "^\."'

### GIT
alias gs="git status"
alias gl="git log --graph --decorate"
alias gpl='git pull'
alias grb='git pull --rebase'
alias gps='git push'
alias gc='git checkout'
alias gd='git diff'
alias gup='git remote update'
alias gwt='git worktree'

### Colorize grep
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# adding flags
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB

alias oc='gio open .' # open current directory
alias ssn="sudo shutdown now"
alias wdil='history | grep' #when i did last?
alias pf="ps -e | grep $1"  # Find the processID of an app that you want to kill.  pf firefox pf chrome
