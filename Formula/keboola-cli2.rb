# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.71.0 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.71.0"
  license "MIT"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.71.0/keboola-cli2_0.71.0_darwin_arm64.zip"
      sha256 "f1165d0f72a4dec953ec17e27950f3b39a449a39e3e97cade5de865f603cedbd"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.71.0/keboola-cli2_0.71.0_linux_arm64.zip"
      sha256 "7f1f9e87a687a15b3bd43eb3e19316bc130ae517836b330cc1f4a809d9b26bcd"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.71.0/keboola-cli2_0.71.0_linux_amd64.zip"
      sha256 "67b9194577b328d22ce9ce7fbf894bcdf2b978edfb8cb9c3c564363cc8b5b5a4"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
