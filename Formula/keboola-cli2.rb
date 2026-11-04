# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 1.0.1 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "1.0.1"
  license "Apache-2.0"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v1.0.1/keboola-cli2_1.0.1_darwin_arm64.zip"
      sha256 "9905748862eb7756fb112fbee25badf338296fb22ca16635ff08fc1733bc8a75"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v1.0.1/keboola-cli2_1.0.1_linux_arm64.zip"
      sha256 "e4f7e89685423bb4802812a7f2d9343f544f2cf2bb07244c805e4a3897f7c82d"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v1.0.1/keboola-cli2_1.0.1_linux_amd64.zip"
      sha256 "0898592c42a9b655d9662935b9d32a6f38ada7e0cdff3a9514f94c1418838d36"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
