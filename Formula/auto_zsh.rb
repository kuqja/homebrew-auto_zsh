class AutoZsh < Formula
  desc "Automates Zsh setup with Oh My Zsh and plugins"
  homepage "https://github.com/kuqja/homebrew-auto_zsh"
  url "https://github.com/kuqja/homebrew-auto_zsh/archive/refs/heads/main.zip"
  sha256 "33d0f4d34247471387f78674383172be22f240e300ee4844a3bc86d738b99a5e"
  version "1.0.0"

  def install
    bin.install "auto_zsh.sh"
  end

  def post_install
    system "#{bin}/auto_zsh.sh"
  end
end
