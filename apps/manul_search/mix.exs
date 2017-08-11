defmodule ManulSearch.Mixfile do
  use Mix.Project

  def project do
    [app: :manul_search,
     version: append_revision("0.0.1"),
     build_path: "../../_build",
     config_path: "../../config/config.exs",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def append_revision(version) do
    "#{version}+#{revision()}"
  end

  defp revision() do
    System.cmd("git", ["rev-parse", "--short", "HEAD"])
    |> elem(0)
    |> String.rstrip
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger],
     mod: {ManulSearch.Application, []}]
  end

  defp deps do
    [{:cortex, "~> 0.1", only: [:dev, :test]},
    {:elastix, "~> 0.4.0"}]
  end
end
