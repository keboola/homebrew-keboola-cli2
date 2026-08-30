# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.92.0 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.92.0"
  license "Apache-2.0"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.92.0/keboola-cli2_0.92.0_darwin_arm64.zip"
      sha256 "5994d2e4347ab6c2574cb49c8a1509ab8dae6ba4f92099225664c842260247c6"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.92.0/keboola-cli2_0.92.0_linux_arm64.zip"
      sha256 "647e803cec2d53ddd8fe9649db07a0f8d2459c56fdddd17d19c65627a5a3897d"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.92.0/keboola-cli2_0.92.0_linux_amd64.zip"
      sha256 "29e72bbc48519950de973ed5ef89da8b66cbd5ad845f4ab7191e5b043648d465"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
