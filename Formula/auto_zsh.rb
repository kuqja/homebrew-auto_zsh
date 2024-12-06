class AutoZsh < Formula
  desc "Automates Zsh setup with Oh My Zsh and plugins"
  homepage "https://github.com/kuqja/homebrew-auto_zsh"
  url "https://github.com/kuqja/homebrew-auto_zsh/archive/refs/heads/main.zip"
  sha256 "98070afac1b7844f119a1c4245a9f0ba4441aaf62930a77e2872088958945374"
  version "1.0.0"

  def install
    bin.install "auto_zsh.sh"
  end

  def post_install
    system "#{bin}/auto_zsh.sh"
  end
end
