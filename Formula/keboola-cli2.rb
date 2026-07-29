# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.77.0 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.77.0"
  license "MIT"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.77.0/keboola-cli2_0.77.0_darwin_arm64.zip"
      sha256 "c72e581731d302696658c4a277396ba977fe387fe10c43a2f814dddc5f521434"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.77.0/keboola-cli2_0.77.0_linux_arm64.zip"
      sha256 "19086edf67328d4886cd662cc78d0f98e0fdd368b5194ce04244490f4bce6ae4"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.77.0/keboola-cli2_0.77.0_linux_amd64.zip"
      sha256 "7e5f541ea55a98f68b92a9414516c34e9d867f2e20e24743841561ff7be2421e"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
