# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.84.3 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.84.3"
  license "Apache-2.0"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.84.3/keboola-cli2_0.84.3_darwin_arm64.zip"
      sha256 "019ac3c346dc4a706df50a06c3aa0e278365dea194e3ef0f4272a8a7e852e72f"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.84.3/keboola-cli2_0.84.3_linux_arm64.zip"
      sha256 "8de88ff3b049a841685cd80f143be38a68e74e9769f96d53a248bb6052c7b25e"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.84.3/keboola-cli2_0.84.3_linux_amd64.zip"
      sha256 "3968e7da70f4d4a9f7d56a361f6a9efea7e55743741a5a581e4ce528265ef884"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
