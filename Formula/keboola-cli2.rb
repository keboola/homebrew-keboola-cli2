# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.76.2 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.76.2"
  license "MIT"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.76.2/keboola-cli2_0.76.2_darwin_arm64.zip"
      sha256 "877d7ec677393e7eaaf4fd469331d4995995447341d87eee43ef7138f245d273"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.76.2/keboola-cli2_0.76.2_linux_arm64.zip"
      sha256 "a247f6464c8e498314cacdda3b345a7c1cbcae95972dd27db19d7dbee84d39d8"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.76.2/keboola-cli2_0.76.2_linux_amd64.zip"
      sha256 "089ad2ba89b07fdf8a1aca545a50111d476a44b0fb07c2a7bf6708248812c670"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
