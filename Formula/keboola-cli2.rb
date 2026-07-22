# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.76.0 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.76.0"
  license "MIT"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.76.0/keboola-cli2_0.76.0_darwin_arm64.zip"
      sha256 "300ab19e1b7a0e184c4dbd5e115498ff22a0bc3e8749943798a2908b2296ad4b"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.76.0/keboola-cli2_0.76.0_linux_arm64.zip"
      sha256 "8d027821259ab623d5afb59e476521ec9592c33f171fa66ffcc56652fdab2835"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.76.0/keboola-cli2_0.76.0_linux_amd64.zip"
      sha256 "5ff6d9ea2c122bca06adcd0098db47b1926f14b25b13a7c870f6425d602dc61e"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
