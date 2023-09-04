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

