# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.87.0 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.87.0"
  license "Apache-2.0"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.87.0/keboola-cli2_0.87.0_darwin_arm64.zip"
      sha256 "d570a1b6f831e8ef1ecba95392eccc56fc8d3dc352faa4c7de9bc62777a8d795"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.87.0/keboola-cli2_0.87.0_linux_arm64.zip"
      sha256 "f8f58f36913ea0a69f277bb166effddc8af6883916650a8c1034a22833b725d1"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.87.0/keboola-cli2_0.87.0_linux_amd64.zip"
      sha256 "ca1e6584696cb68b29aedc1a06f3ea58993fefb5ea426d8809c49a505f22c731"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
