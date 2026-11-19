# Rendered by packaging/homebrew/render-formula.sh in the nuvem repository.
# Edit the template there, not this file: the release workflow overwrites it.
class Nuvem < Formula
  desc "Terminal UI for Google Cloud, in the spirit of k9s"
  homepage "https://nuvem.fyi"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/filipeaaoliveira/nuvem/releases/download/v0.1.0/nuvem-aarch64-apple-darwin.tar.gz"
      sha256 "4767b41142e0f18c27cb9123870dc7232409928a29e077a3cdeede58dc3dafe1"
    end
    on_intel do
      url "https://github.com/filipeaaoliveira/nuvem/releases/download/v0.1.0/nuvem-x86_64-apple-darwin.tar.gz"
      sha256 "21b6d1ae1535e14e539be5e9c1be714317e3f1969ec7b4e23a7beab206b2702e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/filipeaaoliveira/nuvem/releases/download/v0.1.0/nuvem-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d879c8145393566cd3f4a19f736ae40ed121e7e117fc4c8b77aa7a9193cd49fb"
    end
    on_intel do
      url "https://github.com/filipeaaoliveira/nuvem/releases/download/v0.1.0/nuvem-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e69e071fdf56007be969106e622fd1c13b1e34c454f7d1e37f53fddf9758f7b3"
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
