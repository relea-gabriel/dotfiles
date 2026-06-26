# ~/.bashrc: executed by bash(1) for non-login shells.

# --- Standard Bash Configs ---
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s checkwinsize

# --- DevOps Aliases & Paths ---
alias k=kubectl
alias awsp="source _awsp"

# Python / Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PIPENV_PYTHON=$PYENV_ROOT/shims/python
export PATH="$HOME/.pyenv/bin:$PATH"
if command -v pyenv >/dev/null; then
    eval "$(pyenv init -)"
fi

# Pulumi & Local Binaries
export PATH="$PATH:$HOME/.pulumi/bin"
export PATH="$PATH:$HOME/.local/bin"

# Kubeswitch
if command -v switcher >/dev/null; then
    source <(switcher init bash)
    source <(alias sw=switch)
    source <(switch completion bash)
    alias sw=switch
fi

# --- Quality of Life Upgrades ---

# Bind Up and Down arrows to history search
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Initialize Starship Prompt
if command -v starship >/dev/null; then
    eval "$(starship init bash)"
fi

# Instantly setup or activate the Python environment
init-project() {
    if [ ! -d "venv" ]; then
        echo "Creating venv and installing requirements..."
        python -m venv venv
        source venv/bin/activate
        pip install -r requirements.txt
    else
        echo "Activating existing venv..."
        source venv/bin/activate
    fi
}

# One-command ECR login (Run this AFTER aws sso login)
alias ecr-login="aws ecr get-login-password --region eu-west-1 | docker login -u AWS --password-stdin 733996454592.dkr.ecr.eu-west-1.amazonaws.com"