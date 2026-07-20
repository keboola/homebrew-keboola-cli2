# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.72.0 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.72.0"
  license "MIT"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.72.0/keboola-cli2_0.72.0_darwin_arm64.zip"
      sha256 "c72a46d831372cecd1246c08fab820913e042b02b15aea4a538062c5a5034eb3"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.72.0/keboola-cli2_0.72.0_linux_arm64.zip"
      sha256 "be444648ebf80559ae71b043a6b1633c5e37f092fc4aeae67f5d593d6f5586b2"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.72.0/keboola-cli2_0.72.0_linux_amd64.zip"
      sha256 "75fa82bcf2fc145d8df2a4d03285ec76c51cb4c28ddcccb5293d422dbddc42e2"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
