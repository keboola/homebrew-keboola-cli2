# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.84.2 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.84.2"
  license "Apache-2.0"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.84.2/keboola-cli2_0.84.2_darwin_arm64.zip"
      sha256 "9568518ef97a0a81b861703bc111b4c62cf7547e05af0a7c4041d9e39566820e"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.84.2/keboola-cli2_0.84.2_linux_arm64.zip"
      sha256 "a7dfb0434a3a2d067ae207daf29ee35ccdf3db54526fd6d0d135e0b13d8f5961"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.84.2/keboola-cli2_0.84.2_linux_amd64.zip"
      sha256 "fb1fafcc316c131ccf9b40a7e0d61f0c830a257bae135edc6d23bd01f0be6bc7"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
