# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.100.5 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.100.5"
  license "Apache-2.0"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.100.5/keboola-cli2_0.100.5_darwin_arm64.zip"
      sha256 "997acd6e8a8125438c9e46d5fbc25bb8e4151880a130780bf9c14f5737c64c2b"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.100.5/keboola-cli2_0.100.5_linux_arm64.zip"
      sha256 "fb125997af59ac786a9d0d2be6c7635cf4c9708243d2246c5d398891cf41c626"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.100.5/keboola-cli2_0.100.5_linux_amd64.zip"
      sha256 "47c6c5b2079dd05d9fcc735d2f8c700e44a50b278bce1f77549a1ba03ef8f776"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
