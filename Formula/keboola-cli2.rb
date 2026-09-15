# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.94.0 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.94.0"
  license "Apache-2.0"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.94.0/keboola-cli2_0.94.0_darwin_arm64.zip"
      sha256 "c7e1c4677be9c8f76cb01c8d991465c974cb98bae4afeb95958da39a07a765fe"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.94.0/keboola-cli2_0.94.0_linux_arm64.zip"
      sha256 "3cad3e0c2221fc786408dedaf078b410c915705c35d546292b7cb8ad7a367d6d"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.94.0/keboola-cli2_0.94.0_linux_amd64.zip"
      sha256 "8c97848e5bdd0fba069f24ccaf6599b32004690593f21e6601522f1aece46c2b"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
