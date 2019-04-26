# BusyBox for Elixir programs

[![CircleCI](https://circleci.com/gh/fhunleth/elixir_busybox.svg?style=svg)](https://circleci.com/gh/fhunleth/elixir_busybox)

[BusyBox](https://www.busybox.net/) is a C program that provides implementations
of many Unix utilities in one small package. It is frequently used in embedded
systems.

This Elixir module makes it available to Elixir programs on platforms that
BusyBox supports.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `elixir_busybox` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:elixir_busybox, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/elixir_busybox](https://hexdocs.pm/elixir_busybox).

