# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.66.1 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.66.1"
  license "MIT"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.66.1/keboola-cli2_0.66.1_darwin_arm64.zip"
      sha256 "fea96dc7e16b12eb8c8eb56dabb77726d18ebbc49d45d33c2f70ea6d41ed5581"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.66.1/keboola-cli2_0.66.1_linux_arm64.zip"
      sha256 "2de975a604a5af0f1d69f0f654350b283c6456b2ccb9618ca78335e38e429359"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.66.1/keboola-cli2_0.66.1_linux_amd64.zip"
      sha256 "b99efb5a0128f7893cc9478b6968779f14198a626066243654c2248f884f9647"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
