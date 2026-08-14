# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.84.1 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.84.1"
  license "Apache-2.0"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.84.1/keboola-cli2_0.84.1_darwin_arm64.zip"
      sha256 "f52ba914c4ebdca24e0b9bc47f2211fe438babeabeb2b16bbdca1a218afe9854"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.84.1/keboola-cli2_0.84.1_linux_arm64.zip"
      sha256 "bc7635231577b0c8e5d93180e294742579687b1fc3c2407c906ec38e2846a57a"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.84.1/keboola-cli2_0.84.1_linux_amd64.zip"
      sha256 "7350e2e90cefd7da3bb18fbe93c8d7633d0b8dbde50c492a7cc2d4fa5660d026"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
