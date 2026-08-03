# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.80.0 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.80.0"
  license "MIT"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.80.0/keboola-cli2_0.80.0_darwin_arm64.zip"
      sha256 "e6b1a25a4831e0c48e2b863d772a758a21c1dc6df816156b9d09ffae08869c27"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.80.0/keboola-cli2_0.80.0_linux_arm64.zip"
      sha256 "27753b722737026d54e8ced83a675ee73b81f2b70ea643bbdac63862382aca4d"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.80.0/keboola-cli2_0.80.0_linux_amd64.zip"
      sha256 "e525463baef7171070972d28c703f2afbaa07d109d4ad8bdaa208354cf8fbad9"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
