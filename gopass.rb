# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Gopass < Formula
  desc "The slightly more awesome Standard Unix Password Manager for Teams."
  homepage "https://www.gopass.pw/"
  version "1.12.2"
  bottle :unneeded

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/gopasspw/gopass/releases/download/v1.12.2/gopass-1.12.2-darwin-amd64.tar.gz"
    sha256 "4892ac354bec8dee03af86caec3ab00f35215d78235fd0c03909c6e405031a23"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/gopasspw/gopass/releases/download/v1.12.2/gopass-1.12.2-darwin-arm64.tar.gz"
    sha256 "71f43dbe26542aa781d6a91114653bb1448c3e17711a849823478d16d302aac9"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gopasspw/gopass/releases/download/v1.12.2/gopass-1.12.2-linux-amd64.tar.gz"
    sha256 "ed9e46f47f87d970bf6be74699c5d88bc85fadfe881223a2f7a4458bde8b7371"
  end
  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://github.com/gopasspw/gopass/releases/download/v1.12.2/gopass-1.12.2-linux-armv6.tar.gz"
    sha256 "f4dd082dfae327051398e77f5fdb264a1c7464e0edbcec9e141869fa01d6bac0"
  end
  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/gopasspw/gopass/releases/download/v1.12.2/gopass-1.12.2-linux-arm64.tar.gz"
    sha256 "60dd711f48a94ba914c57ec22b8dcb3bc4f42c9564ef4d7f9d3cf3d67c6310ed"
  end

  depends_on "git"
  depends_on "gnupg"
  depends_on "terminal-notifier"

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/gopasspw/gopass").install buildpath.children

    cd "src/github.com/gopasspw/gopass" do
      ENV["PREFIX"] = prefix
      system "make", "install"
    end

    system bin/"gopass completion bash > bash_completion.bash"
    system bin/"gopass completion zsh > zsh_completion.zsh"
    bash_completion.install "bash_completion.bash"
    zsh_completion.install "zsh_completion.zsh"
  end

  def caveats; <<~EOS
    Gopass has been installed, have fun!
    If upgrading from `pass`, everything should work as expected.
    If installing from scratch, you need to either initialize a new repository now...
      gopass init
    ...or clone one from a source:
      gopass clone git@code.example.com:example/pass.git
    In order to use the great autocompletion features (they're helpful with gopass),
    please make sure you have autocompletion for homebrew enabled:
      https://github.com/bobthecow/git-flow-completion/wiki/Install-Bash-git-completion
    More information:
      https://www.gopass.pw/
      https://github.com/gopasspw/gopass/README.md
  EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gopass version")
  end
end
