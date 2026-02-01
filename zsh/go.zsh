export GOPATH=$HOME/go

# Ignore work modules from hitting proxy
export GOPRIVATE=buf.build,go.buf.build,github.com/namespacelabs/*,namespacelabs.dev/internal/*

# Add go built binaries to path
export PATH=$GOPATH/bin:$PATH
