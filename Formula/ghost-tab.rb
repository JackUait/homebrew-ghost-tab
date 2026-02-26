class GhostTab < Formula
  desc "Ghostty + tmux wrapper for AI-assisted development with Claude Code"
  homepage "https://github.com/JackUait/ghost-tab"
  url "https://github.com/JackUait/ghost-tab/archive/refs/tags/v2.2.0.tar.gz"
  sha256 "3d7453250ab9bc18339497f48a2edf497d00d52f298c69a3688547293e293985"
  license "MIT"

  depends_on "tmux"
  depends_on "lazygit"
  depends_on "broot"
  depends_on "node@22"
  depends_on :macos

  def install
    bin.install "bin/ghost-tab"
    (share/"ghost-tab").install "ghostty"
  end

  def caveats
    missing = []
    missing << "  brew install --cask ghostty" unless Dir.exist?("/Applications/Ghostty.app")
    missing << "  brew install --cask claude" unless File.exist?("/opt/homebrew/bin/claude") || File.exist?("/usr/local/bin/claude")

    if missing.empty?
      <<~EOS
        All dependencies installed. Run `ghost-tab` to set up your environment.
      EOS
    else
      <<~EOS
        These casks are required but not installed automatically:
        #{missing.join("\n")}

        Then run `ghost-tab` to set up your environment.
      EOS
    end
  end

  test do
    assert_match "macOS", shell_output("#{bin}/ghost-tab --help 2>&1", 1)
  end
end
