#!/bin/bash


if [ ! -d deps ]; then
  mix local.hex --force
  mix local.rebar --force
  mix deps.get --force
fi

sed -i 's|db_host: "localhost",|db_host: "${DBHOST}",|g' config/config.exs

MIX_ENV=prod mix compile.protocols --force
MIX_ENV=prod exec elixir --detached -pa _build/prod/consolidated -S mix phoenix.server
