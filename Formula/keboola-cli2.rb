# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.100.2 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.100.2"
  license "Apache-2.0"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.100.2/keboola-cli2_0.100.2_darwin_arm64.zip"
      sha256 "fab27504e9568f08d174c4a9e2575e2b01d0dd093208150f330217e329c48230"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.100.2/keboola-cli2_0.100.2_linux_arm64.zip"
      sha256 "c237b48a30caf56233c59caa5c11d68cb5589e5ded3dee8a03368a2b34acffa7"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.100.2/keboola-cli2_0.100.2_linux_amd64.zip"
      sha256 "bad01fd616f274a0a719fe4422eedf7fa0a6fab70611e38a4a275323c8f44e74"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
