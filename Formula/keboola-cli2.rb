# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.76.1 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.76.1"
  license "MIT"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.76.1/keboola-cli2_0.76.1_darwin_arm64.zip"
      sha256 "8827360058ae73536526e9a63376799e721ee236f2f29fc6b981cd992884e5e3"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.76.1/keboola-cli2_0.76.1_linux_arm64.zip"
      sha256 "e896ac55bf7e3886724e6c04ef28a3a90885d9d74102a064db63c2a9a64c20c7"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.76.1/keboola-cli2_0.76.1_linux_amd64.zip"
      sha256 "5ff95cb29b08d61dc3ffbbd25ebe51dfb710a42742062c032eee86ca869c61b4"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
