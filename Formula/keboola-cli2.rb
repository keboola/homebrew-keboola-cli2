# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.99.1 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.99.1"
  license "Apache-2.0"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.99.1/keboola-cli2_0.99.1_darwin_arm64.zip"
      sha256 "a6e17f77726bfcbedfdc0d800c51a7111e7417cc6ef7973230ba2f2d8c906bd0"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.99.1/keboola-cli2_0.99.1_linux_arm64.zip"
      sha256 "20d06da55d85c7c294550dc5a57c4ac4c07205aacda9e5cee866eba3ea4c4d7f"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.99.1/keboola-cli2_0.99.1_linux_amd64.zip"
      sha256 "415d56280bfe2fbf35aef1e4464c46fff6593d5e88d5b38b0a0c54d7de066bf2"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
