# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.84.0 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.84.0"
  license "Apache-2.0"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.84.0/keboola-cli2_0.84.0_darwin_arm64.zip"
      sha256 "318c54764753db86d042fcd2092829d64f786b17a3eab9669ce4721f72103023"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.84.0/keboola-cli2_0.84.0_linux_arm64.zip"
      sha256 "4fc0db591bec167ea912d77446e1b5301453770c09b6a5d1d412574f8a083a68"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.84.0/keboola-cli2_0.84.0_linux_amd64.zip"
      sha256 "c25b06515d680e3ce93b987f4d56aa1482b04a44e527f179ccd1877663a9362d"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
