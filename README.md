# BusyBox for Elixir programs

[![CircleCI](https://circleci.com/gh/nerves-networking/elixir_busybox.svg?style=svg)](https://circleci.com/gh/nerves-networking/elixir_busybox)
[![Hex version](https://img.shields.io/hexpm/v/elixir_busybox.svg "Hex version")](https://hex.pm/packages/elixir_busybox)

[BusyBox](https://www.busybox.net/) is a C program that provides implementations
of many Unix utilities in one small package. It is frequently used in embedded
systems.

This Elixir module makes it available to Elixir programs on platforms that
BusyBox supports. This lets you enable more Busybox utilities than provided by
the official Nerves systems.

All BusyBox programs are installed under the `elixir_busybox` OTP applications
`priv` directory. See the module documentation for helpers for adding the
appropriate directories to the `PATH` variable, running commands or finding
executables.

The BusyBox command list is not configurable, yet. If you would like to modify
the enabled commands, look for the `make_menuconfig` helper script after you
build once. It runs BusyBox's configuration utility using the correct paths and
copies back changes. Work is needed to let you specify your own configuration in
your `config.exs`. Please consider helping add this if you need it.

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

## Licenses

BusyBox is covered by the [GNU General Public License version
2](https://opensource.org/licenses/GPL-2.0). Please see the [BusyBox source and
website](https://www.busybox.net) for details.

All Elixir code and infrastructure in this repository that's not BusyBox is
covered by the [MIT license](https://opensource.org/licenses/MIT).
