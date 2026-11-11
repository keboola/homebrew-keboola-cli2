# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 1.2.1 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "1.2.1"
  license "Apache-2.0"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v1.2.1/keboola-cli2_1.2.1_darwin_arm64.zip"
      sha256 "5be89dc3bcac9bcc8507bf73c326573dc7df882bc15da82a36b82ac11bb880d8"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v1.2.1/keboola-cli2_1.2.1_linux_arm64.zip"
      sha256 "5eec3c0eea53c6ea3eb793d094b9662b7219024c27f50e6bf824fbf28fce763a"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v1.2.1/keboola-cli2_1.2.1_linux_amd64.zip"
      sha256 "c06e3829d8957ddebb106b2138f703534177594cf6dc077f1b49528d5e38f67c"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
