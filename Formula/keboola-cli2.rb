# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.74.0 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.74.0"
  license "MIT"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.74.0/keboola-cli2_0.74.0_darwin_arm64.zip"
      sha256 "f4ad79beef2984ec4efc489aa7595356931f29622973fb367e04e4660fb4c0b8"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.74.0/keboola-cli2_0.74.0_linux_arm64.zip"
      sha256 "59a26051541e2ab7a4f2367606fea8a820d1c22b05a819b099267cfa841d2f43"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.74.0/keboola-cli2_0.74.0_linux_amd64.zip"
      sha256 "17d743f36959d763478a6b48b630a06c8f648dc7c7a94cef49521bda45cf58de"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
