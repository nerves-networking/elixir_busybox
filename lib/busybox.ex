defmodule Busybox do
  @moduledoc """
  BusyBox for Elixir programs

  [BusyBox](https://www.busybox.net/) is a C program that provides
  implementations of many Unix utilities in one small package. It is frequently
  used in embedded systems.

  This Elixir module makes it available to Elixir programs on platforms that
  BusyBox supports.
  """

  @doc """
  Execute a BusyBox command like System.cmd/3

  The BusyBox commands are in this application's priv directory and this
  version of `cmd/3` only looks there for the binaries.
  """
  @spec cmd(binary(), [binary()], keyword()) ::
          {Collectable.t(), exit_status :: non_neg_integer()}
  def cmd(command, args, opts \\ []) do
    case find_executable(command) do
      nil ->
        # System.cmd does this
        raise ErlangError, original: :enoent

      path ->
        System.cmd(path, args, opts)
    end
  end

  @doc """
  Find the path to a BusyBox command
  """
  @spec find_executable(binary()) :: Path.t() | nil
  def find_executable(program) do
    path()
    |> Enum.map(&Path.join(&1, program))
    |> Enum.find(&File.exists?/1)
  end

  @doc """
  Return a list of installation paths for BusyBox binaries
  """
  @spec path :: [Path.t()]
  def path() do
    priv_path = Application.app_dir(:busybox, "priv")
    install_dirs = ["bin", "usr/bin", "sbin", "usr/sbin"]
    Enum.map(install_dirs, &Path.join(priv_path, &1))
  end
end
