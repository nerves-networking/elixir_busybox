defmodule Busybox.MixProject do
  use Mix.Project

  @version "0.1.5"

  def project do
    [
      app: :busybox,
      version: @version,
      elixir: "~> 1.6",
      compilers: [:elixir_make | Mix.compilers()],
      make_targets: ["all"],
      make_clean: ["clean"],
      make_error_message: "",
      start_permanent: Mix.env() == :prod,
      build_embedded: true,
      deps: deps(),
      docs: docs(),
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
      {:ex_doc, "~> 0.19", only: :docs, runtime: false},
      {:dialyxir, "~> 1.0.0", only: [:dev, :test], runtime: false}
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
        "CHANGELOG.md",
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

  defp docs do
    [
      extras: ["README.md"],
      main: "readme",
      source_ref: "v#{@version}",
      source_url: "https://github.com/nerves-networking/elixir_busybox"
    ]
  end
end
