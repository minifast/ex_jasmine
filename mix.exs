defmodule Jasmine.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ex_jasmine,
      version: "0.1.0",
      elixir: "~> 1.5",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:cowboy, :plug]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:cowboy, "~> 1.0"},
      {:plug, "~> 1.0"},
    ]
  end

  defp package do
    [
      maintainers: ["Ministry of Velocity LLC"],
      licenses: ["MIT"],
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      links: %{"GitHub" => "https://github.com/minifast/ex_jasmine"}
    ]
  end
end
