class AutoZsh < Formula
  desc "Automates Zsh setup with Oh My Zsh and plugins"
  homepage "https://github.com/kuqja/homebrew-auto_zsh"
  url "https://github.com/kuqja/homebrew-auto_zsh/archive/refs/heads/main.zip"
  sha256 "d24791bae23f5bc6481ff97c54e9707a7b9f3a515eaed29938108cb52ad90db5"
  version "1.0.0"

  def install
    bin.install "auto_zsh.sh"
  end

  def post_install
    system "#{bin}/auto_zsh.sh"
  end
end
