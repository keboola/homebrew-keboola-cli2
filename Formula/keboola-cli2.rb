# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.85.0 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.85.0"
  license "Apache-2.0"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.85.0/keboola-cli2_0.85.0_darwin_arm64.zip"
      sha256 "62c44afeb3dc84ec906e36ad9234981177c1db31ac3a48a6cdda39b04cadb0c6"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.85.0/keboola-cli2_0.85.0_linux_arm64.zip"
      sha256 "9497d93ec79ddad3dfad3ee6023fd38c50fed50d11ab7ca6e2f5db68bf18528c"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.85.0/keboola-cli2_0.85.0_linux_amd64.zip"
      sha256 "3d4e6312096c65808497805a96a86d95026bf7d33d578513eb7a6cd4c468b05f"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
