# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.100.3 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.100.3"
  license "Apache-2.0"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.100.3/keboola-cli2_0.100.3_darwin_arm64.zip"
      sha256 "8bc76bce7fc024d0cca177102bbc07d98818a092ec526772539d272a654e08e2"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.100.3/keboola-cli2_0.100.3_linux_arm64.zip"
      sha256 "224255406dd3de2fc70f8b610e2e41b130c3109a899543ee02d88aa283daab34"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.100.3/keboola-cli2_0.100.3_linux_amd64.zip"
      sha256 "93676d670eef869cdd127d58389210bbea18ab9cf5b230e6f38a91ccad03bcfd"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
