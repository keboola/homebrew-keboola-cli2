# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.91.0 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.91.0"
  license "Apache-2.0"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.91.0/keboola-cli2_0.91.0_darwin_arm64.zip"
      sha256 "fdc5f146d8fb501f79d730ee1536aefb7e046e870b9cd72bce571fa69a74edc7"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.91.0/keboola-cli2_0.91.0_linux_arm64.zip"
      sha256 "81f035023024ec8f3fce446cbf270dde7b6944bf78fcc744930631b6e0381ead"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.91.0/keboola-cli2_0.91.0_linux_amd64.zip"
      sha256 "e36713a94e72976995ce3eb82ff1053f273afa9489578b5ecbf1402637154507"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
