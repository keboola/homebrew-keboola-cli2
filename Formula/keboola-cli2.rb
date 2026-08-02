# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.79.0 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.79.0"
  license "MIT"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.79.0/keboola-cli2_0.79.0_darwin_arm64.zip"
      sha256 "391890ba9ce1adf0ba9838de0ed2ad056b99e8e4343302a8a853a1cc84d9c9ef"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.79.0/keboola-cli2_0.79.0_linux_arm64.zip"
      sha256 "2237cc5900ea59f12e686f72f026a7ea2e286c9f901619c58f7b5cf2910dd207"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.79.0/keboola-cli2_0.79.0_linux_amd64.zip"
      sha256 "c2a5da86bccda3511024f742c5e0a0c917bd8254aeb0f93045afbf79e4bb75d7"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
