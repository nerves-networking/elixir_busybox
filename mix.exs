defmodule ElixirBusybox.MixProject do
  use Mix.Project

  def project do
    [
      app: :elixir_busybox,
      version: "0.1.0",
      elixir: "~> 1.6",
      compilers: [:elixir_make | Mix.compilers()],
      make_targets: ["all"],
      make_clean: ["clean"],
      start_permanent: Mix.env() == :prod,
      build_embedded: true,
      deps: deps(),
      docs: [extras: ["README.md"], main: "readme"],
      description: description(),
      package: package()
    ]
  end

  def application do
    [mod: {ElixirBusybox.Application, []}]
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
      licenses: ["GPL-2.0", "MIT"],
      links: %{"GitHub" => "https://github.com/fhunleth/elixir_busybox"}
    ]
  end
end
