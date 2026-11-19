# Rendered by packaging/homebrew/render-formula.sh in the nuvem repository.
# Edit the template there, not this file: the release workflow overwrites it.
class Nuvem < Formula
  desc "Terminal UI for Google Cloud, in the spirit of k9s"
  homepage "https://nuvem.fyi"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/filipeaaoliveira/nuvem/releases/download/v0.1.1/nuvem-aarch64-apple-darwin.tar.gz"
      sha256 "4d2f2a126c6014d75801b306e2b6160f073fdce186a992a20dd0f10fba4c56aa"
    end
    on_intel do
      url "https://github.com/filipeaaoliveira/nuvem/releases/download/v0.1.1/nuvem-x86_64-apple-darwin.tar.gz"
      sha256 "6ce7ead9dc56ddb12397dfd06a721ef48118d9c123d75313bb25d7476d095a34"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/filipeaaoliveira/nuvem/releases/download/v0.1.1/nuvem-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8808a7ea4114fcbff87f2f9b7ec97161f75d21d2374f273b84339e914a90a1c1"
    end
    on_intel do
      url "https://github.com/filipeaaoliveira/nuvem/releases/download/v0.1.1/nuvem-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "439d38a863805d9a713d77689997f678fec9f90b9adfdd45e7c93a94c18abcd8"
    end
  end

  def install
    # Each archive holds one directory, nuvem-<target>/, which Homebrew has
    # already stepped into.
    bin.install "nuvem"
    doc.install "README.md", "CHANGELOG.md"
  end

  def caveats
    <<~EOS
      nuvem needs the Google Cloud CLI (gcloud) at runtime: it takes its
      credentials from gcloud and runs gcloud for every change it makes.
      If you do not have it yet:
        brew install --cask gcloud-cli
        gcloud auth login

      To try nuvem without a Google Cloud project or credentials:
        nuvem --demo
    EOS
  end

  test do
    # `info` runs headless and needs neither gcloud nor credentials.
    assert_match "nuvem #{version}", shell_output("#{bin}/nuvem info")
    # Without a terminal the UI must refuse with exit status 3.
    assert_match "interactive terminal", shell_output("#{bin}/nuvem --demo 2>&1 </dev/null", 3)
  end
end
