# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 1.4.0 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "1.4.0"
  license "Apache-2.0"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v1.4.0/keboola-cli2_1.4.0_darwin_arm64.zip"
      sha256 "ee2051a1211443434c7eb9103c7a1f4824ae740c28b3afcbcc5d1150a924694d"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v1.4.0/keboola-cli2_1.4.0_linux_arm64.zip"
      sha256 "e61a252ff87b2d1e2a01d744f8eb0761a794173cd9723da3d6ba215c3b38865c"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v1.4.0/keboola-cli2_1.4.0_linux_amd64.zip"
      sha256 "c369c217b9d378a6e606d917c68f670bf854033c25b845d30caa6ded1c2d0234"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
