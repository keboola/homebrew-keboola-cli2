# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.89.0 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.89.0"
  license "Apache-2.0"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.89.0/keboola-cli2_0.89.0_darwin_arm64.zip"
      sha256 "581013f4f931d11843945c70d84f0dab1bed5f6d2d69bb984633b67041a78ed0"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.89.0/keboola-cli2_0.89.0_linux_arm64.zip"
      sha256 "407689d98941c0a0f45ada37c9292a0052eb864d49e94aa49e4e7e70308d5f2d"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.89.0/keboola-cli2_0.89.0_linux_amd64.zip"
      sha256 "c8d6ff3a82bdc1158e90f2f6caf732fad332543c0a8921226243733ccde11b9f"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
