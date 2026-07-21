# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.73.0 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.73.0"
  license "MIT"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.73.0/keboola-cli2_0.73.0_darwin_arm64.zip"
      sha256 "319f3c7effc6f9494d74621718b0fd1cd4a37060086602cc8f5cd83c109977e5"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.73.0/keboola-cli2_0.73.0_linux_arm64.zip"
      sha256 "4c0d124dec3aeee553762d6ea5c9500d5b3df10648e3e51d90ab37a8e9ea57da"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.73.0/keboola-cli2_0.73.0_linux_amd64.zip"
      sha256 "2e8a836b137cfa68961d2e53126f6926bc7e756ee9606a758935f49569580291"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
