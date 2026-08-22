# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.88.0 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.88.0"
  license "Apache-2.0"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.88.0/keboola-cli2_0.88.0_darwin_arm64.zip"
      sha256 "ce251e8f4c08f5e3944fd489070ebc4d758ecfdbac32e414f11b9485af52c90f"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.88.0/keboola-cli2_0.88.0_linux_arm64.zip"
      sha256 "f0e45980e0cacb1807efcf61b7399c0a97afd23ee13e92c0eeb1a66487c0e49a"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.88.0/keboola-cli2_0.88.0_linux_amd64.zip"
      sha256 "c426c9e7f9a4baec4d788b912455d3b9d847eb160b03666f49241bcb18450bb5"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
