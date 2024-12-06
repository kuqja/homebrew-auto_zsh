class AutoZsh < Formula
  desc "Automates Zsh setup with Oh My Zsh, plugins, and themes"
  homepage "https://github.com/kuqja/homebrew-auto_zsh"
  url "https://github.com/kuqja/homebrew-auto_zsh/blob/main/auto_zsh.zip"
  sha256 "32c74440401b182dde2991b106af4c2bb631873c0544a263223cae0dd013fbaf"
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
