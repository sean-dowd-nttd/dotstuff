# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export GOPATH=$HOME/go
# For Rancher Desktop:
#export PATH=$HOME/bin:/opt/homebrew/bin:$HOME/.rd/bin:/usr/local/bin:$PATH:$GOPATH/bin
# For Docker Desktop (/usr/local/bin)
export PATH=$HOME/bin:/opt/homebrew/bin:/usr/local/bin:$PATH:$GOPATH/bin

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi
if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi
if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/ohmyzsh-full-autoupdate ]; then
    git clone https://github.com/Pilaton/OhMyZsh-full-autoupdate.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/ohmyzsh-full-autoupdate
fi
if [ ! -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi
if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/terragrunt ]; then
    git clone https://github.com/hanjunlee/terragrunt-oh-my-zsh-plugin ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/terragrunt
fi

. "$HOME/.asdf/asdf.sh"

# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    asdf
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
    brew
    macos
    httpie
    gnu-utils
    wd
    gh
    terraform
    terragrunt
    fzf
    kubectl
    docker
    ohmyzsh-full-autoupdate
    aws
    repo
    #mvn
)

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
source $ZSH/oh-my-zsh.sh

alias rebrew="brew update && brew outdated && brew upgrade; brew upgrade --cask; brew cleanup; (echo 'brew list:'; brew list --formulae; echo; echo 'brew list --cask'; brew list --cask) > ~/BrewInstalledList.$(uname -n); omz update"


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$(direnv hook zsh)"

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

alias ll='exa -l'
alias lltr='exa -l -sold'
alias tree='exa --tree'
alias lf='exa -F'
alias dig=dog
alias mroe=bat
alias more=bat
alias dv='dirs -v'
alias tf=terraform
alias tg=terragrunt
alias dcp='docker compose'

# Get azure-cli completion (it's bash-only):
autoload -U +X bashcompinit && bashcompinit
source /opt/homebrew/etc/bash_completion.d/az


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

. <(flux completion zsh)

# set this for GUI tools/global env.  asdf for shell
export JAVA_HOME=/Library/Java/JavaVirtualMachines/temurin-11.jre/Contents/Home
eval "$(/opt/homebrew/bin/brew shellenv)"
test -e "$HOME/.venv-dso/bin/activate" && source $HOME/.venv-dso/bin/activate

