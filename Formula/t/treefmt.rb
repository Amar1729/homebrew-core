class Treefmt < Formula
  desc "One CLI to format the code tree"
  homepage "https://treefmt.com/latest/"
  url "https://github.com/numtide/treefmt/archive/refs/tags/v2.2.0.tar.gz"
  sha256 "9ddb3eb4a03c7d273754dc250f485be8e23b7ef94446576d7e97aaa79e0c1463"
  license "MIT"
  head "https://github.com/numtide/treefmt.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f2a426f65294df81445e47dc1152e442dac0f002174211aeefdb35499505453f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f2a426f65294df81445e47dc1152e442dac0f002174211aeefdb35499505453f"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f2a426f65294df81445e47dc1152e442dac0f002174211aeefdb35499505453f"
    sha256 cellar: :any_skip_relocation, sonoma:        "0c33dfea2710b67fb44954c2ad2934900623498c2475fe877caa5c55a0ab3ebf"
    sha256 cellar: :any_skip_relocation, ventura:       "0c33dfea2710b67fb44954c2ad2934900623498c2475fe877caa5c55a0ab3ebf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "47494c6dee4c5b9b385806320f3a6b8692bc447f16be268ca7668e464d6b86b6"
  end

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X github.com/numtide/treefmt/v2/build.Version=#{version}"
    system "go", "build", *std_go_args(ldflags:)
  end

  test do
    output = shell_output("#{bin}/treefmt 2>&1", 1)
    assert_match "failed to find treefmt config file: could not find [treefmt.toml .treefmt.toml]", output
    assert_match version.to_s, shell_output("#{bin}/treefmt --version")
  end
end
