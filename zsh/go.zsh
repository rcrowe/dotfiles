export GOPATH=$HOME/go

# Ignore work modules from hitting proxy
export GOPRIVATE=go.buf.build,github.com/thirdfort/*

# Add go built binaries to path
export PATH=$GOPATH/bin:$PATH
