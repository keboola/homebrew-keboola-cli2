# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.90.0 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.90.0"
  license "Apache-2.0"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.90.0/keboola-cli2_0.90.0_darwin_arm64.zip"
      sha256 "c9de62cae1f151e7aad15e17fa99c9a285e04d29f2564455eea1e16193a78004"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.90.0/keboola-cli2_0.90.0_linux_arm64.zip"
      sha256 "3ff26c7c00de168b30861bb753e87761795de59b7e995950a7d57fbc4e5db9e6"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.90.0/keboola-cli2_0.90.0_linux_amd64.zip"
      sha256 "ac77f0596b6ce0c587421a6490769dfb2e4f7fe5e08fe780b724383fee637637"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
