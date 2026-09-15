# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.93.2 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.93.2"
  license "Apache-2.0"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.93.2/keboola-cli2_0.93.2_darwin_arm64.zip"
      sha256 "643bac89c72c58fa8673b6c217e0723b76dc5b963addc61f494a7ca14372d1dd"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.93.2/keboola-cli2_0.93.2_linux_arm64.zip"
      sha256 "837df37518d1843ee1c678124977f03944b259ce150517375f1b48937cdc916a"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.93.2/keboola-cli2_0.93.2_linux_amd64.zip"
      sha256 "72a25bf1ee3447827b289e03fd8d19cfeee31da53e0c86e6efb3c79a054fb517"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
