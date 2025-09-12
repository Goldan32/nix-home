trustssh() {
    ssh-keygen -f "${HOME}/.ssh/known_hosts" -R "$(echo $1 | cut -d '@' -f 2)" && \
    ssh "$1"
}

export LSP_SOURCE="corpo"
