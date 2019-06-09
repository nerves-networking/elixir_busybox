defmodule Busybox.MixProject do
  use Mix.Project

  def project do
    [
      app: :busybox,
      version: "0.1.0",
      elixir: "~> 1.6",
      compilers: [:elixir_make | Mix.compilers()],
      make_targets: ["all"],
      make_clean: ["clean"],
      make_args: make_args(),
      start_permanent: Mix.env() == :prod,
      build_embedded: true,
      deps: deps(),
      docs: [extras: ["README.md"], main: "readme"],
      description: description(),
      package: package()
    ]
  end

  def application do
    [mod: {Busybox.Application, []}]
  end

  defp deps do
    [
      {:elixir_make, "~> 0.5", runtime: false},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
      {:dialyxir, "~> 1.0.0-rc.6", only: [:dev, :test], runtime: false}
    ]
  end

  defp description do
    "Busybox packaged up as a mix project"
  end

  defp package do
    [
      files: [
        "busybox.config",
        "busybox.hash",
        "lib",
        "patches",
        "mix.exs",
        "README.md",
        "LICENSE",
        "Makefile"
      ],
      licenses: ["GPL-2.0", "MIT"],
      links: %{"GitHub" => "https://github.com/nerves-networking/elixir_busybox"}
    ]
  end

  defp make_args do
    # Tell make to use all cores when building
    ["-j", to_string(:erlang.system_info(:schedulers))]
  end
end
