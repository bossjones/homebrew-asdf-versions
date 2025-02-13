class AsdfAT0112 < Formula
  desc "Extendable version manager with support for Ruby, Node.js, Elixir, Erlang & more"
  homepage "https://asdf-vm.com/"
  url "https://github.com/asdf-vm/asdf/archive/v0.11.2.tar.gz"
  sha256 "8fb63f069d4c5b12778b2749652a7c059030dab5e231f0a2a03270037a3705fd"
  license "MIT"

  def install
    libexec.install "bin", "lib", "LICENSE", "README.md"
    libexec.install "completions"
    libexec.install "defaults" => "etc"

    bin.install_symlink libexec/"bin/asdf"

    bash_completion.install_symlink libexec/"completions/asdf.bash" => "asdf"
    fish_completion.install_symlink libexec/"completions/asdf.fish"
    zsh_completion.install_symlink libexec/"completions/_asdf"
  end

  def caveats
    <<~EOS
      To use asdf, add the following line to your ~/.bash_profile or ~/.zshrc:
        . "#{opt_libexec}/asdf.sh"
    EOS
  end

  test do
    assert_match "version", shell_output("#{bin}/asdf --version")
    system "#{bin}/asdf", "plugin", "list"
    assert_match "Oohes!",
      shell_output("#{bin}/asdf plugin-add bogus https://github.com/asdf-vm/asdf-bogus.git")
    assert_match "Updated bogus to revision",
      shell_output("#{bin}/asdf plugin-update bogus")
    system "#{bin}/asdf", "plugin", "remove", "bogus"
  end
end
