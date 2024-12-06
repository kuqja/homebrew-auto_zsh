class AutoZsh < Formula
  desc "Automates Zsh setup with Oh My Zsh and plugins"
  homepage "https://github.com/kuqja/homebrew-auto_zsh"
  url "https://github.com/kuqja/homebrew-auto_zsh/archive/refs/heads/main.zip"
  sha256 "8a468d78642cbbb0e012d5bd08b60c0eb5e921431e503cf987ea61343cb42b28"
  version "1.0.0"

  def install
    bin.install "auto_zsh.sh"
  end

  def post_install
    system "#{bin}/auto_zsh.sh"
  end
end
