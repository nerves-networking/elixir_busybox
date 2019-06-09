defmodule BusyboxTest do
  use ExUnit.Case
  doctest Busybox

  test "runs busybox" do
    {text, status} = Busybox.cmd("busybox", [])

    assert status == 0
    assert text =~ "multi-call binary."
  end

  test "paths are under the priv dir" do
    paths = Busybox.path()

    priv_dir = Application.app_dir(:busybox, "priv")

    Enum.each(paths, fn path ->
      assert String.starts_with?(path, priv_dir)
    end)
  end

  test "find_executable works" do
    assert Busybox.find_executable("does_not_exist") == nil
    assert File.exists?(Busybox.find_executable("busybox"))
  end
end
