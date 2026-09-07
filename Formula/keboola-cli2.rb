# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.93.0 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.93.0"
  license "Apache-2.0"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.93.0/keboola-cli2_0.93.0_darwin_arm64.zip"
      sha256 "1817e3cc51a0fa40dff54af13c7565897831a0cd0f24bd1c61172ff212460776"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.93.0/keboola-cli2_0.93.0_linux_arm64.zip"
      sha256 "62b66108b22303dd68e30c7a7c93028f1a25d549422e597d0c46dc02b3f91143"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.93.0/keboola-cli2_0.93.0_linux_amd64.zip"
      sha256 "48f3b87964826d7aa88715f910d3ee94a8b4e8ea79d37a173eb6105925dcc505"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
