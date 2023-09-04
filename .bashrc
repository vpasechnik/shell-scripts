which minikube >/dev/null 2>&1 &&
    . <(minikube completion bash) && 
    complete -o default -F __start_minikube minikube.exe

which kubectl >/dev/null 2>&1 && 
    . <(kubectl completion bash) &&
    alias k=kubectl &&
    complete -o default -F __start_kubectl k &&
    complete -o default -F __start_kubectl kubectl.exe

alias update.bashrc="curl https://raw.githubusercontent.com/vpasechnik/shell-scripts/main/.bashrc -o ~/.bashrc 2>/dev/null"
alias install.glab.cli="go install gitlab.com/gitlab-org/cli/cmd/glab@main && export PATH=\$PATH:\$GOPATH/bin"

function __set_my_prompt
{
    local NOCOLOR="\[\033[0m\]"
    local RED="\[\033[0;31m\]"
    local GREEN="\[\033[0;32m\]"
    local YELLOW="\[\033[0;33m\]"
    local BLACK="\[\033[0;30m\]"

    local ps_git=""
    local git_branch=$(git branch --show-current 2>/dev/null)
    if [ "$git_branch" != "" ]; then
        local git_modified_color="${GREEN}"
        local git_status=$(git status 2>/dev/null | grep "Your branch is ahead" 2>/dev/null)
        if [ "$git_status" != "" ]; then
           git_modified_color="${YELLOW}"
        fi
        local git_status=$(git status --porcelain 2>/dev/null)
        if [ "$git_status" != "" ]; then
            git_modified_color="${RED}"
        fi
        ps_git=" ($git_modified_color$git_branch${NOCOLOR})"
    fi

    PS1="${GREEN}\u@\h:${YELLOW}\w$ps_git${NOCOLOR}\$ "
}

PROMPT_COMMAND='__set_my_prompt'

