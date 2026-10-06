# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 0.97.0 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "0.97.0"
  license "Apache-2.0"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.97.0/keboola-cli2_0.97.0_darwin_arm64.zip"
      sha256 "d3e48ac3b231ae9f8d872335ffa97df61d28a451b3effaab085d9301bf3f5353"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.97.0/keboola-cli2_0.97.0_linux_arm64.zip"
      sha256 "12119e1c01363741ce050d87f34cf6950efab2a3fc4788e26bee30b48828a2bc"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v0.97.0/keboola-cli2_0.97.0_linux_amd64.zip"
      sha256 "ba5385383760a0917bc24474a6a10b46c49eedae8bec6f0849f3260a6b4ee0da"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
