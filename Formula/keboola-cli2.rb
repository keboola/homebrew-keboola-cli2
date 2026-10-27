# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.100.4 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.100.4"
  license "Apache-2.0"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.100.4/keboola-cli2_0.100.4_darwin_arm64.zip"
      sha256 "341a18a11a2170aa83278663e1457d224a92e7954da4f5b2682cb7f8e1e1f1b0"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.100.4/keboola-cli2_0.100.4_linux_arm64.zip"
      sha256 "771befc19450e41c184ba2383bb15f45bb74a656ffa946bcee3e9492a2a80a4d"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.100.4/keboola-cli2_0.100.4_linux_amd64.zip"
      sha256 "5639ebbabcab4dac941ce9779f216387b871d48723fb01038f4c64abf49ac405"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
