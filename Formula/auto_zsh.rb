class AutoZsh < Formula
  desc "Automates Zsh setup with Oh My Zsh, plugins, and themes"
  homepage "https://github.com/kuqja/homebrew-auto_zsh"
  url "https://github.com/kuqja/homebrew-auto_zsh/archive/refs/heads/main.zip"
  sha256 "13ceb61369e8d0a0cc6a3cba76c81f5927b0794be63e479877e3341c2b67b313"
  version "1.0.0"

  def install
    bin.install "auto_zsh.sh"
  end

  def caveats
    <<~EOS
      To start Zsh setup, run:
        auto_zsh.sh
      This will install Zsh, Oh My Zsh, plugins, and the Powerlevel10k theme.
    EOS
  end

  def post_install
    system "#{bin}/auto_zsh.sh"
  end
end
