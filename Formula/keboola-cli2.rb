# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.99.0 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.99.0"
  license "Apache-2.0"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.99.0/keboola-cli2_0.99.0_darwin_arm64.zip"
      sha256 "e525c9aa4f965f537c1abb0700e489c7eb2b1796217ae48ee6cad9347c8df9a6"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.99.0/keboola-cli2_0.99.0_linux_arm64.zip"
      sha256 "59cdbdb257af5b69881d0739734277d4811d02b3677f1d63bc73af0f33244a90"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.99.0/keboola-cli2_0.99.0_linux_amd64.zip"
      sha256 "0fef636f1bc1319ec795aa7ca67a7a91cdcbd24f6229202139eba768118f142a"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
