# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="$HOME/Documents/shell/scripts:$PATH"

# Path to your oh-my-zsh installation.
# ~~~~ UNCOMMENT this out to bring back .oh-my-zsh ~~~~
#export ZSH="/Users/sconnie2/.oh-my-zsh"
# ~~~~ UNCOMMENT ~~~~

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"
#ZSH_THEME="clean"
#ZSH_THEME="powerlevel9k/powerlevel9k"

# Setting up colors....



#export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
#export PS1=$'\e[0;31m%n@%m$ \e[0m'

#Works but no line wrap...
#export PS1=$'\e[0;90m%n%F{red}-%d% $ \e[0m'

#With the shortened directory:
#PROMPT='%(?.%F{green}√.%F{red}?%?)%f %B%F{91}%1~%f%b %# '
# With the full directory:
PROMPT='%(?.%F{green}√.%F{red}?%?)%f %B%F{91}%3~%f%b %# '

# GIT shit
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{240}(%b)%f'
zstyle ':vcs_info:*' enable git

# GIT Autocompletion
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)

autoload -Uz compinit && compinit

# zsh uses the same shell variables PS1 for prompt,
# however the variable names PROMPT and prompt are synonyms for PS1

# zsh variables:
# %m shows the first element of the hostname

# 31=Red; 35=Magenta; 90=Bright Black; 32=Darker Green
#original PS1= %n@%m %1 %#
# color is in \e[0;31m
# turn off color character attributes: \e[0m 
#export CLICOLOR=1

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# ~~~ UNCOMMENT OUT to bring back oh-my-zsh
#source $ZSH/oh-my-zsh.sh
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# pwdf: echoes path of front-most window of Finder
pwdf ()
{ 
   currFolderPath=$( /usr/bin/osascript <<"   EOT"
       tell application "Finder"
           try
               set currFolder to (folder of the front window as alias)
           on error
               set currFolder to (path to desktop folder as alias)
           end try
           POSIX path of currFolder
       end tell
   EOT
   )
   echo "$currFolderPath"
}

# ~~~~~ JJ ADDED ~~~~~
##### Aliases #####
# CD and LS...
alias edq='cd ~/Documents/ThinkEmpire/code/ingestion/phone-verifier-node'
alias think='cd ~/Documents/ThinkEmpire'
alias ingestion='cd ~/Documents/ThinkEmpire/code/ingestion'
alias writers='cd ~/Documents/ThinkEmpire/code/ingestion/writers'
alias pollers='cd ~/Documents/ThinkEmpire/code/ingestion/pollers'
alias sodapollers='cd ~/Documents/ThinkEmpire/code/ingestion/pollers/nyc-dob-now-build-poller'
alias main='cd ~/Documents/ThinkEmpire/code/appterminal'
alias cdf='cd "`pwdf`"'
alias ls='ls -GwF'
alias lsa='ls -a'
alias ll='ls -alh'
# Network
alias ip='curl ifconfig.me'
alias ipplus='curl ipinfo.io'
# Launchers...
alias maincode='cd ~/Documents/ThinkEmpire/code/appterminal && code .'
alias sodapollercode='cd ~/Documents/ThinkEmpire/code/ingestion/pollers/nyc-dob-now-build-poller && code .'
alias edqcode='cd ~/Documents/ThinkEmpire/code/ingestion/phone-verifier-node && code .'
# Kubectl... 
alias kgpni='kubectl get pods --namespace=ingestion'
alias kgdni='kubectl get deployments --namespace=ingestion'
alias kgcjni='kubectl get cronjobs --namespace=ingestion'
alias kgjni='kubectl get jobs --namespace=ingestion'
alias printacrispods='kubectl get pods --namespace=ingestion | awk '\''/nyc-acris-scraper-[^docids]/{print $1}'\'' | head -1'
# Scale Deployments...
alias acrisdown='kubectl scale deployment nyc-acris-scraper --replicas=0 --namespace=ingestion' 
alias acrisup='kubectl scale deployment nyc-acris-scraper --replicas=1 --namespace=ingestion'
alias ecbpollerup='kubectl scale deployment nyc-dob-ecb-violations-poller --replicas=1 --namespace=ingestion'
alias ecbpollerdown='kubectl scale deployment nyc-dob-ecb-violations-poller --replicas=1 --namespace=ingestion'
alias ecbwriterup='kubectl scale deployment nyc-dob-ecb-violations-writer --replicas=1 --namespace=ingestion'
alias ecbwriterdown='kubectl scale deployment nyc-dob-ecb-violations-writer --replicas=0 --namespace=ingestion'
alias complaintswriterup='kubectl scale deployment nyc-dob-complaints-writer --replicas=1 --namespace=ingestion'
alias complaintswriterdown='kubectl scale deployment nyc-dob-complaints-writer --replicas=0 --namespace=ingestion'
alias violatiosnwriterup='kubectl scale deployment nyc-dob-violations-writer --replicas=1 --namespace=ingestion'
alias violationswriterdown='kubectl scale deployment nyc-dob-violations-writer --replicas=0 --namespace=ingestion'
# Shells...
alias acrisshell='kubectl get pods --namespace=ingestion | awk '\''/nyc-acris-scraper-[^docids]/{print $1}'\'' | head -1 | xargs -to -I {pod} kubectl exec -it {pod} -c nyc-acris-scraper --namespace=ingestion sh'
alias ogacrisshell='kubectl exec -it nyc-acris-scraper-ff66588c8-rddbg -c nyc-acris-scraper --namespace=ingestion sh'
alias ecbpollershell='kubectl get pods --namespace=ingestion | awk '\''/nyc-dob-ecb-violations-poller/{print $1}'\'' | head -1 | xargs -to -I {pod} kubectl exec -it {pod} -c nyc-dob-ecb-violations-poller --namespace=ingestion sh'
# Logs...
alias acrispollerlog='kubectl get pods --namespace=ingestion | awk '\''/acris-poller/{print $1}'\'' | xargs kubectl logs -f --namespace=ingestion'
alias acriswriterlog='kubectl get pods --namespace=ingestion | awk '\''/acris-writer/{print $1}'\'' | xargs kubectl logs -f --namespace=ingestion'
alias ecbpollerlog='kubectl get pods --namespace=ingestion | awk '\''/ecb-poller-manual/{print $1}'\'' | xargs kubectl logs -f --namespace=ingestion'
alias ecbwriterlog='kubectl get pods --namespace=ingestion | awk '\''/nyc-dob-ecb-violations-writer/{print $1}'\'' | xargs kubectl logs -f --namespace=ingestion'
alias complaintswriterlog='kubectl get pods --namespace=ingestion | awk '\''/nyc-dob-complaints-writer/{print $1}'\'' | xargs kubectl logs -f --namespace=ingestion'
alias violationswriterlog='kubectl get pods --namespace=ingestion | awk '\''/nyc-dob-violations-writer/{print $1}'\'' | xargs kubectl logs -f --namespace=ingestion'
alias acrislog='kubectl get pods --namespace=ingestion | awk '\''/nyc-acris-scraper-[^docids]/{print $1}'\'' | xargs kubectl logs -f --namespace=ingestion'
alias productionlog='kubectl get pods --namespace=production | awk '\''/appterminal-[^redis]/{print $1}'\'' | xargs kubectl logs -f --namespace=production'
# Jobs...
alias createecbpollerjob='kubectl create job --from=cronjob/nyc-dob-ecb-violations-poller-update-recent ecb-poller-manual --namespace=ingestion'
alias deleteecbpollerjob='kubectl delete job --namespace=ingestion ecb-poller-manual'

# Remove All
alias deleteallecbpods="kubectl get pods --namespace=ingestion --no-headers=true | awk '/nyc-dob-ecb/{print $1}' | xargs kubectl delete --namespace=ingestion pod"
alias deleteallcomplaintspods="kubectl get pods --namespace=ingestion --no-headers=true | awk '/nyc-dob-complaints/{print $1}' | xargs kubectl delete pod --namespace=ingestion"


#####################################
# Attempt at adding color to MAN page
#export LESS_TERMCAP_mb=$'\e[1;32m'
#export LESS_TERMCAP_md=$'\e[1;32m'
#export LESS_TERMCAP_me=$'\e[0m'
#export LESS_TERMCAP_se=$'\e[0m'
#export LESS_TERMCAP_so=$'\e[01;33m'
#export LESS_TERMCAP_ue=$'\e[0m'
#export LESS_TERMCAP_us=$'\e[1;4;31m'

export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;35m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
export GROFF_NO_SGR=1                  # for konsole and gnome-terminal
# ~~~ Above Works

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
if [ /usr/local/bin/kubectl ]; then source <(kubectl completion zsh); fi
