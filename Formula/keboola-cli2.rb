# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 1.2.0 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "1.2.0"
  license "Apache-2.0"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v1.2.0/keboola-cli2_1.2.0_darwin_arm64.zip"
      sha256 "ff07bfdbeb57870199c271ef4cc4047685326e4307a7aaf9139d85ad72534f78"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v1.2.0/keboola-cli2_1.2.0_linux_arm64.zip"
      sha256 "50eea90b661f54d397669610530f5101c4675076356de6c213f00a6f4b787a07"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v1.2.0/keboola-cli2_1.2.0_linux_amd64.zip"
      sha256 "4dc15dbf5c75574d6ac8f6da32f10d39d4fd4866ccbf80b45ba44bab969cc520"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
