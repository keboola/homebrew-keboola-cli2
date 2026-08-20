# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.86.0 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.86.0"
  license "Apache-2.0"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.86.0/keboola-cli2_0.86.0_darwin_arm64.zip"
      sha256 "a57547cb5e18632f5be3ad6ba070e66c8a8fc803ef2d98e191ca5dd38aa7ef77"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.86.0/keboola-cli2_0.86.0_linux_arm64.zip"
      sha256 "1612d90e41b16bf3f86cf4ec2d048780336b2976b4838354d4a59a51ce857d2d"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.86.0/keboola-cli2_0.86.0_linux_amd64.zip"
      sha256 "e63673239dce8f09a49e60e37896814d732e4358fc2b1ed30dafbcfab84b16c2"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
