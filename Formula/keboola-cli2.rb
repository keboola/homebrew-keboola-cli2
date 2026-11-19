# Homebrew formula template for kbagent (package: keboola-cli2, binary: kbagent).
# The release workflow substitutes 1.4.1 and the per-arch {SHA256_*} and pushes
# the rendered formula to the kbagent-owned tap repo `keboola/homebrew-keboola-cli2`.
# Wraps the prebuilt PyInstaller binary — no Python required on the user's machine.
class KeboolaCli2 < Formula
  desc "AI-friendly CLI for managing Keboola projects (kbagent)"
  homepage "https://github.com/keboola/cli"
  version "1.4.1"
  license "Apache-2.0"

  on_macos do
    # Apple Silicon only (single macOS build env). Gate on arch so Intel Macs get a
    # clear error instead of a broken arm64 binary.
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v1.4.1/keboola-cli2_1.4.1_darwin_arm64.zip"
      sha256 "3cfb0bbd920a4f9ab0933517237c1c1f4c8b65debd82cc88a6c3edb3f9100e70"
    end
    on_intel do
      odie "keboola-cli2 ships Apple Silicon only on macOS. Install via: uv tool install keboola-cli"
    end
  end

  on_linux do
    on_arm do
      url "https://cli-dist.keboola.com/keboola-cli2/v1.4.1/keboola-cli2_1.4.1_linux_arm64.zip"
      sha256 "60438121d624f1547a02713483037368c10613bce813a02bd4ef50755dcc2e29"
    end
    on_intel do
      url "https://cli-dist.keboola.com/keboola-cli2/v1.4.1/keboola-cli2_1.4.1_linux_amd64.zip"
      sha256 "062a654b4c71a8521aa66690dc60912b5a4c2467f2e1f14b33917caca7ee47ef"
    end
  end

  def install
    bin.install "kbagent"
  end

  test do
    assert_match "kbagent v#{version}", shell_output("#{bin}/kbagent --version")
  end
end
