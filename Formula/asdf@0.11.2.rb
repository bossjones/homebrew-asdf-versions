# typed: false
# frozen_string_literal: true

class AsdfAT0112 < Formula
  desc "Extendable version manager with support for Ruby, Node.js, Elixir, Erlang & more"
  homepage "https://asdf-vm.com/"
  version "0.11.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/asdf-vm/asdf/archive/v0.11.2.tar.gz"
      sha256 "8fb63f069d4c5b12778b2749652a7c059030dab5e231f0a2a03270037a3705fd"

      def install
        bash_completion.install "completions/asdf.bash"
        fish_completion.install "completions/asdf.fish"
        zsh_completion.install "completions/_asdf"
        libexec.install Dir["*"]
        touch libexec/"asdf_updates_disabled"

        bin.write_exec_script libexec/"bin/asdf"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/asdf-vm/asdf/archive/v0.11.2.tar.gz"
      sha256 "8fb63f069d4c5b12778b2749652a7c059030dab5e231f0a2a03270037a3705fd"

      def install
        bash_completion.install "completions/asdf.bash"
        fish_completion.install "completions/asdf.fish"
        zsh_completion.install "completions/_asdf"
        libexec.install Dir["*"]
        touch libexec/"asdf_updates_disabled"

        bin.write_exec_script libexec/"bin/asdf"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/asdf-vm/asdf/archive/v0.11.2.tar.gz"
      sha256 "8fb63f069d4c5b12778b2749652a7c059030dab5e231f0a2a03270037a3705fd"

      def install
        bash_completion.install "completions/asdf.bash"
        fish_completion.install "completions/asdf.fish"
        zsh_completion.install "completions/_asdf"
        libexec.install Dir["*"]
        touch libexec/"asdf_updates_disabled"

        bin.write_exec_script libexec/"bin/asdf"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/asdf-vm/asdf/archive/v0.11.2.tar.gz"
      sha256 "8fb63f069d4c5b12778b2749652a7c059030dab5e231f0a2a03270037a3705fd"

      def install
        bash_completion.install "completions/asdf.bash"
        fish_completion.install "completions/asdf.fish"
        zsh_completion.install "completions/_asdf"
        libexec.install Dir["*"]
        touch libexec/"asdf_updates_disabled"

        bin.write_exec_script libexec/"bin/asdf"
      end
    end
  end

  depends_on "autoconf"
  depends_on "automake"
  depends_on "coreutils"
  depends_on "libtool"
  depends_on "libyaml"
  depends_on "openssl@3"
  depends_on "readline"
  depends_on "unixodbc"

  def caveats
    s = "To use asdf, add the following line to your #{shell_profile}:\n"

    s += if preferred == :fish
      "  source #{opt_libexec}/asdf.fish\n\n"
    else
      "  . #{opt_libexec}/asdf.sh\n\n"
    end

    s += "Restart your terminal for the settings to take effect."

    s
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/asdf version")
    output = shell_output("#{bin}/asdf plugin-list 2>&1", 1)
    assert_match "No plugins installed", output
    assert_match "Update command disabled.", shell_output("#{bin}/asdf update", 42)
  end
end
