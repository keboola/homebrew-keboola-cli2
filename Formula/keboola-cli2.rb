# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.82.0 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.82.0"
  license "Apache-2.0"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.82.0/keboola-cli2_0.82.0_darwin_arm64.zip"
      sha256 "e0f8667055ec9a4a7d282d81763f627bbf89d79dad9a671dbca7239f3cab222e"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.82.0/keboola-cli2_0.82.0_linux_arm64.zip"
      sha256 "944d1470610e3b0f198472b78f324f71148b3be890a06a53d6d45e677377ba36"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.82.0/keboola-cli2_0.82.0_linux_amd64.zip"
      sha256 "53f83b01677d7872301615501e7f65e2cbc9a871f7bdd27084dc3b5e44bb6bb4"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
