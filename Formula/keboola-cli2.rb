# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.90.1 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.90.1"
  license "Apache-2.0"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.90.1/keboola-cli2_0.90.1_darwin_arm64.zip"
      sha256 "cdface22e7248069b42b8d82a891f67a23a47b3fcd49f8d1bc845df9763802f4"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.90.1/keboola-cli2_0.90.1_linux_arm64.zip"
      sha256 "4df197e033fcb9db259becf23b29c3264ca4ae240901831723e701fa9a33a602"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.90.1/keboola-cli2_0.90.1_linux_amd64.zip"
      sha256 "0aa42321f3842f9e7a303a89e7fbfe3fa982b3e010be436e7f0c07585261cb88"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
