# Temp repository with tools to reproduce mise problem

Reproduces a random problem where `mise upgrade` fails to create a shim for `uv` and `uvx`.

## Workflow to reproduce

1. Build container with `./build-container.sh`
1. Export MISE_GITHUB_TOKEN environment variable
1. Run the reproduction script with `./run-repro.sh`
