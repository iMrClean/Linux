PODMAN_REGISTRY_CONF="$HOME/.config/containers/registries.conf"
mkdir -p $HOME/.config/containers
cat > $PODMAN_REGISTRY_CONF <<EOF
[registries.search]
registries = ['registry.access.redhat.com', 'registry.redhat.io', 'docker.io']

[registries.insecure]
registries = []

[registries.block]
registries = []
EOF
