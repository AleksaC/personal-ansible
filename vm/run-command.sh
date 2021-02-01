#!/usr/bin/env bash

set -eou pipefail

cd "$(dirname "$0")"

case "${2:-}" in
  "--recreate")
    vagrant halt
    vagrant destroy --force
    ;;
esac

vagrant up

vagrant ssh -- -t "$1"
