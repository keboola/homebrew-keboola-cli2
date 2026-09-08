# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.93.1 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.93.1"
  license "Apache-2.0"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.93.1/keboola-cli2_0.93.1_darwin_arm64.zip"
      sha256 "1fd2194c35b52e4205b184236f3c0c0db7d72b65e4eebac4ba3491654296e10c"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.93.1/keboola-cli2_0.93.1_linux_arm64.zip"
      sha256 "c5568ff6b0c6a2bfb5f8ff1a7136222852d985eca941f62802f4ecbbe7d90e75"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.93.1/keboola-cli2_0.93.1_linux_amd64.zip"
      sha256 "4ff0c3a9255b63c651fd109681c2ed668c9881381587e1070e51127fd71f5d3e"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
