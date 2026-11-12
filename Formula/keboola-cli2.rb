# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 1.3.0 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "1.3.0"
  license "Apache-2.0"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v1.3.0/keboola-cli2_1.3.0_darwin_arm64.zip"
      sha256 "44b613ec2e6fb7556beb0b26864d65de2bfab1de50ac4ba82444835c601907fe"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v1.3.0/keboola-cli2_1.3.0_linux_arm64.zip"
      sha256 "f78ad13a233287a10eaa39cc4b69be0cdf19d2f02bae86acad0b0841ae55ea81"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v1.3.0/keboola-cli2_1.3.0_linux_amd64.zip"
      sha256 "04219e8f93ca8c990d0fda2bc87253a28900ccd9a4a048a9d486bcd2464258f6"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
