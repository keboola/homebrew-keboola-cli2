# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 1.1.0 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "1.1.0"
  license "Apache-2.0"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v1.1.0/keboola-cli2_1.1.0_darwin_arm64.zip"
      sha256 "443db11abdcc71708933bf9ca2143ad8eaeb6386cff44e6b1922813097544832"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v1.1.0/keboola-cli2_1.1.0_linux_arm64.zip"
      sha256 "2d9d53fada21bd22e5828aee72861db76d55fa32c884616b5d37e608a22a0f3b"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v1.1.0/keboola-cli2_1.1.0_linux_amd64.zip"
      sha256 "b59023ec5e4d66fe11e2033001eeb779ca0042c81777ac91153e329139decfcc"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
