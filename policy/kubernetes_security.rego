package kubernetes.security

# Disallow use of privileged containers
deny[msg] {
    input.kind == "Pod"
    container := input.spec.containers[_]
    container.securityContext.privileged == true
    msg := "Privileged containers are not allowed"
}

# Ensure that 'readOnlyRootFilesystem' is set to true
deny[msg] {
    input.kind == "Pod"
    container := input.spec.containers[_]
    container.securityContext.readOnlyRootFilesystem != true
    msg := "readOnlyRootFilesystem should be set to true"
}

# Ensure that 'runAsNonRoot' is set to true
deny[msg] {
    input.kind == "Pod"
    container := input.spec.containers[_]
    container.securityContext.runAsNonRoot != true
    msg := "Containers should run as non-root users"
}
