
# source global definitions
[ -e /etc/bashrc ] &&
    . /etc/bashrc
[ -e /etc/bashrc.cloudshell ] &&
    . /etc/bashrc.cloudshell

# add go utils to path if go is available
which go >/dev/null 2>&1 &&
    echo $PATH | grep -v $(go env GOPATH)/bin >/dev/null &&
    PATH=$PATH:$(go env GOPATH)/bin

which minikube >/dev/null 2>&1 &&
    . <(minikube completion bash) && 
    complete -o default -F __start_minikube minikube.exe

which kubectl >/dev/null 2>&1 && 
    . <(kubectl completion bash) &&
    alias k=kubectl &&
    complete -o default -F __start_kubectl k &&
    complete -o default -F __start_kubectl kubectl.exe

which kind >/dev/null 2>&1 &&
    . <(kind completion bash)

[ -e ~/lib/git-completion.bash ] &&
    . ~/lib/git-completion.bash
[ -e ~/lib/oci_autocomplete.sh ] &&
    . ~/lib/oci_autocomplete.sh

alias update.bashrc="curl https://raw.githubusercontent.com/vpasechnik/shell-scripts/main/.bashrc -o ~/.bashrc 2>/dev/null"
alias install.glab.cli="go install gitlab.com/gitlab-org/cli/cmd/glab@main && export PATH=\$PATH:\$GOPATH/bin"
alias install.git.completion="mkdir -p ~/lib && curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/lib/git-completion.bash && . ~/lib/git-completion.bash"

function __set_my_prompt
{
    local NOCOLOR="\[\033[0m\]"
    local RED="\[\033[0;31m\]"
    local GREEN="\[\033[0;32m\]"
    local YELLOW="\[\033[0;33m\]"
    local BLACK="\[\033[0;30m\]"

    local ps_git=""
    local git_branch="$(git branch --show-current 2>/dev/null)"
    if [ "$git_branch" != "" ]; then
        local git_modified_color="${GREEN}"
        local git_status="$(git status 2>/dev/null | grep "Your branch is ahead" 2>/dev/null)"
        if [ "$git_status" != "" ]; then
           git_modified_color="${YELLOW}"
        fi
        local git_status="$(git status --porcelain 2>/dev/null)"
        if [ "$git_status" != "" ]; then
            git_modified_color="${RED}"
        fi
        ps_git=" ${NOCOLOR}($git_modified_color$git_branch${NOCOLOR})${NOCOLOR}"
    fi

    local ps_kubectl=""
    if which kubectl > /dev/null 2>&1 ; then
        local kubectl_context="$(kubectl config current-context 2>/dev/null)"
        local kubectl_ns="$(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)"
        [ "${kubectl_context}" != "" ] &&
            ps_kubectl="${NOCOLOR}(k8s|${GREEN}${kubectl_context}${NOCOLOR}:${RED}${kubectl_ns}${NOCOLOR}) "
    fi
    PS1="${ps_kubectl}${GREEN}\u@\h:${YELLOW}\w${NOCOLOR}${ps_git}\n\$ "
}

PROMPT_COMMAND='__set_my_prompt'

