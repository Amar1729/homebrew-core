class Swagger2markupCli < Formula
  desc "Swagger to AsciiDoc or Markdown converter"
  homepage "https://github.com/Swagger2Markup/swagger2markup"
  url "https://jcenter.bintray.com/io/github/swagger2markup/swagger2markup-cli/1.3.3/swagger2markup-cli-1.3.3.jar"
  sha256 "93ff10990f8279eca35b7ac30099460e557b073d48b52d16046ab1aeab248a0a"
  license "Apache-2.0"
  revision 2

  bottle do
    sha256 cellar: :any_skip_relocation, all: "462e764f4e4d57ad2f1c0c668c265fa0a57885bb5d97a3578b79e6da5ff8f2f2"
  end

  depends_on "openjdk"

  def install
    libexec.install "swagger2markup-cli-#{version}.jar"
    bin.write_jar_script libexec/"swagger2markup-cli-#{version}.jar", "swagger2markup"
  end

  test do
    (testpath/"test.yaml").write <<~EOS
      swagger: "2.0"
      info:
        version: "1.0.0"
        title: TestSpec
        description: Example Swagger spec
      host: localhost:3000
      paths:
        /test:
          get:
            responses:
              "200":
                description: Describe the test resource
    EOS
    shell_output("#{bin}/swagger2markup convert -i test.yaml -f test")
    assert_match "= TestSpec", shell_output("head -n 1 test.adoc")
  end
end
