# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.76.3 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.76.3"
  license "MIT"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.76.3/keboola-cli2_0.76.3_darwin_arm64.zip"
      sha256 "8b9d23c22a4ca8632e79a3cda7655d64ae3fc358d5972974efc4d99758af7967"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.76.3/keboola-cli2_0.76.3_linux_arm64.zip"
      sha256 "d412d4134277c8d8665998174946c61204228e4c1a9f760e8cda1d69b3891c68"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.76.3/keboola-cli2_0.76.3_linux_amd64.zip"
      sha256 "34b8c449e837a995312c0f02bfb89fccaa98e390f847142fa2e48aa777e845de"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
