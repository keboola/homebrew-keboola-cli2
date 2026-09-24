# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.95.0 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.95.0"
  license "Apache-2.0"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.95.0/keboola-cli2_0.95.0_darwin_arm64.zip"
      sha256 "c2f290b733d805ca507e8021d47e95eb6603144b277017620fdb9838789cc140"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.95.0/keboola-cli2_0.95.0_linux_arm64.zip"
      sha256 "508a5e2ada614945a4636057a242e164ce7df3242449433ddd7e0cfa87c31952"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.95.0/keboola-cli2_0.95.0_linux_amd64.zip"
      sha256 "7dcc66e986e9717dea4a91ac608b2a2204ca2267e38aa22f7a8df3ccfbaa1848"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
