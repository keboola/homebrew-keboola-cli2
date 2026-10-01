# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.96.1 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.96.1"
  license "Apache-2.0"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.96.1/keboola-cli2_0.96.1_darwin_arm64.zip"
      sha256 "3f21d473f0489265baabcde29a20cf947f527e60ca4c468a3d821b5259a36c55"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.96.1/keboola-cli2_0.96.1_linux_arm64.zip"
      sha256 "4ef6b094c26f7b7555c02812b77a15e3ce33a3638240b354f234def738d0132f"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.96.1/keboola-cli2_0.96.1_linux_amd64.zip"
      sha256 "8a176ebe1a36a18c882ef2926cd60376d692626a853e91642507055c4fae0bd4"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
