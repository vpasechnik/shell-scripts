# install glab cli
which go >/dev/null 2>&1 && go install gitlab.com/gitlab-org/cli/cmd/glab@main && export PATH=$PATH:$GOPATH/bin

which minikube >/dev/null 2>&1 &&
    . <(minikube completion bash) && 
    complete -o default -F __start_minikube minikube.exe
which kubectl >/dev/null 2>&1 && 
    . <(kubectl completion bash) &&
    alias k=kubectl &&
    complete -o default -F __start_kubectl k &&
    complete -o default -F __start_kubectl kubectl.exe

