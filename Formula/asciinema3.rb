class Asciinema3 < Formula
  desc "Terminal session recorder. Unofficial release for version 3.0.0-rc.3"
  homepage "https://asciinema.org"
  url "https://github.com/asciinema/asciinema.git",
      branch: "develop"
  version "3.0.0-rc.3"
  license "GPL-3.0-only"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
    
    # Manually copy the binary to the bin directory and name it "asciinema3"
    # You might think that you could do `bin.install "target/release/asciinema" => "asciinema3"`
    # however, asciinema is already installed as a binary by the cargo install command.
    # so calling `bin.install` again makes a duplicate entry in the bin directory.
    mv bin/"asciinema", bin/"asciinema3"

    # Tell the user this is unofficial
    ohai "Note: This is an unofficial Homebrew formula for asciinema version #{version}." \
          "It's been installed as asciinema3 to minimize confusion."
  end

  test do
    ENV["LC_ALL"] = "en_US.UTF-8"
    output = shell_output("#{bin}/asciinema3 --version 2>&1")
    assert_match "asciinema #{version}", output.strip
  end
end