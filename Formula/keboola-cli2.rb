# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.100.0 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.100.0"
  license "Apache-2.0"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.100.0/keboola-cli2_0.100.0_darwin_arm64.zip"
      sha256 "82f3f535349a4c309c9366a27756445c08591dc7705d6ffb57390121e0732b98"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.100.0/keboola-cli2_0.100.0_linux_arm64.zip"
      sha256 "4660badf8900ff8289093d63ff12f95319bd88997ac547d2f09f2bba708db8d6"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.100.0/keboola-cli2_0.100.0_linux_amd64.zip"
      sha256 "d090d261491948021ab589ded00fa82d85241aa749b927b77555c56a05a75681"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
