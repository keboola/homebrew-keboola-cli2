# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.98.0 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.98.0"
  license "Apache-2.0"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.98.0/keboola-cli2_0.98.0_darwin_arm64.zip"
      sha256 "b0a323a4dc01cf3e2c9104a4acf26db9526dcac1419fcafdf4db2d866c385bf6"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.98.0/keboola-cli2_0.98.0_linux_arm64.zip"
      sha256 "a86b70c0e68855b755ce9a72d6fb8283c5f2cc397bc6245715b086dfee18b593"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.98.0/keboola-cli2_0.98.0_linux_amd64.zip"
      sha256 "a5129c9eda6310914190c84582bae1bf99f741a6ab6091f1cc1efc3c7c617bbd"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
