FROM ubuntu:24.04

# System packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    curl \
    git \
    git-lfs \
    gnupg \
    locales \
    sudo \
    unzip \
    vim \
    xz-utils \
    zsh \
    && rm -rf /var/lib/apt/lists/*

# Locale
RUN locale-gen en_GB.UTF-8

# Create devbox user with passwordless sudo
RUN groupadd --gid 1001 devbox \
    && useradd --uid 1001 --gid 1001 --create-home --shell /usr/bin/zsh devbox \
    && echo "devbox ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/devbox \
    && chmod 0440 /etc/sudoers.d/devbox

# Install Nix (as root, no init system in containers)
RUN curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix  | sh -s -- install linux \
    --extra-conf "sandbox = false" \
    --init none \
    --no-confirm

# Install nix-direnv via Nix
# Use a tarball URL to avoid GitHub API rate limiting during local builds.
# To update: change the commit hash (any recent nixpkgs-unstable commit works).
ARG NIXPKGS_COMMIT=fef542e7a88eec2b698389e6279464fd479926b6
RUN . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh \
    && nix profile install "github:NixOS/nixpkgs/${NIXPKGS_COMMIT}#nix-direnv"

# Switch to devbox user
USER devbox
WORKDIR /home/devbox

# Copy dotfiles
COPY --chown=devbox:devbox . /home/devbox/.dotfiles

# Run install
RUN /home/devbox/.dotfiles/install.sh

# Verify shell starts cleanly
RUN zsh -lc 'echo "shell-ok"'

CMD ["zsh", "-l"]
