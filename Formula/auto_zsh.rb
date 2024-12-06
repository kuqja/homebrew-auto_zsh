class AutoZsh < Formula
  desc "Automates Zsh setup with Oh My Zsh and plugins"
  homepage "https://github.com/kuqja/homebrew-auto_zsh"
  url "https://github.com/kuqja/homebrew-auto_zsh/archive/refs/heads/main.zip"
  sha256 "045339ac9f5f87b60592a7cd5b6f57ba2bad3218e692c55b1355d7b1e4a62e7f"
  version "1.0.0"

  def install
    bin.install "auto_zsh.sh"
  end

  def post_install
    system "#{bin}/auto_zsh.sh"
  end
end
