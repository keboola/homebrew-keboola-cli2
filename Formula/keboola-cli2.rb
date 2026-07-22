# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.75.0 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.75.0"
  license "MIT"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.75.0/keboola-cli2_0.75.0_darwin_arm64.zip"
      sha256 "86e1dc5899aae2bf945451c8fa0021230bce1633ac0d0ac21e8e56691b0a3bb8"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.75.0/keboola-cli2_0.75.0_linux_arm64.zip"
      sha256 "862af2a6844474d3e63936359b6cdb3ca65ace5c387a76e9e75bed78e6d4aace"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.75.0/keboola-cli2_0.75.0_linux_amd64.zip"
      sha256 "3cbf329139e87a8cda6b1c179927b7efde05d6a9273cdb6601f89e0a70efb8ae"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
