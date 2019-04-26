defmodule ElixirBusyboxTest do
  use ExUnit.Case
  doctest ElixirBusybox

  test "runs busybox" do
    {text, status} = ElixirBusybox.cmd("busybox", [])

    assert status == 0
    assert text =~ "multi-call binary."
  end

  test "paths are under the priv dir" do
    paths = ElixirBusybox.path()

    priv_dir = Application.app_dir(:elixir_busybox, "priv")

    Enum.each(paths, fn path ->
      assert String.starts_with?(path, priv_dir)
    end)
  end

  test "find_executable works" do
    assert ElixirBusybox.find_executable("does_not_exist") == nil
    assert File.exists?(ElixirBusybox.find_executable("busybox"))
  end
end
