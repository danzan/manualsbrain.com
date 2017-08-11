defmodule TelegramBot.Mixfile do
  use Mix.Project

  def project do
    [app: :telegram_bot,
     version: append_revision("0.1.0"),
     build_path: "../../_build",
     config_path: "../../config/config.exs",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     compilers: [:gettext] ++ Mix.compilers,
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
    [extra_applications: [:logger, :sentry],
     mod: {TelegramBot.Application, []}]
  end

  defp aliases do
    [run: "run --no-halt"]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # To depend on another app inside the umbrella:
  #
  #   {:my_app, in_umbrella: true}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:nadia, "~> 0.4.2"},
     {:cowboy, "~> 1.0.4"},
     {:plug, "~> 1.3"},
     {:exconstructor, "~> 1.1"},
     {:redix, ">= 0.0.0"},
     {:gettext, "~> 0.13"},
     {:cortex, "~> 0.1", only: [:dev, :test]},
     {:sentry, "~> 5.0.1"},
     {:httpoison, "~> 0.12"},
     {:manul_search, "~> 0.0.1", in_umbrella: true}]
  end
end
