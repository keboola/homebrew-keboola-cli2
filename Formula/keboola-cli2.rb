# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.96.2 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.96.2"
  license "Apache-2.0"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.96.2/keboola-cli2_0.96.2_darwin_arm64.zip"
      sha256 "66301ffa0da3b001283763c0e166b3f257f51ea17db6aa148441a062d451e970"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.96.2/keboola-cli2_0.96.2_linux_arm64.zip"
      sha256 "86d7852eec6b897b6bc08bcf8f3dfdc0d75ba8328bfd2fb2f2a98708fcaa6bcc"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.96.2/keboola-cli2_0.96.2_linux_amd64.zip"
      sha256 "da5c29f867751e85c6585f957c3ada7fc03c60b29dcd2dd13073090a5e65b975"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
