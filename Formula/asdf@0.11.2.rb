class AsdfAT01112 < Formula
  desc "Extendable version manager with support for Ruby, Node.js, Elixir, Erlang & more"
  homepage "https://asdf-vm.com/"
  url "https://github.com/asdf-vm/asdf/archive/v0.11.2.tar.gz"
  # sha256 "77b24369c9d8f2b3d2b5f0097a25d5f9ee1b0c1dbf4c4148a8c2c7c8f766b57e"
  sha256 "8fb63f069d4c5b12778b2749652a7c059030dab5e231f0a2a03270037a3705fd"
  license "MIT"

  def install
    bash_completion.install "completions/asdf.bash"
    fish_completion.install "completions/asdf.fish"
    zsh_completion.install "completions/_asdf"
    libexec.install "bin", "lib"
    prefix.install "LICENSE", "README.md"
    (prefix/"etc").install "defaults"

    (bin/"asdf").write_env_script libexec/"bin/asdf", :ASDF_DIR => libexec
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
