class Asciinema3 < Formula
  desc "Terminal session recorder. Unofficial release for version 3.0.0-rc.3"
  homepage "https://asciinema.org"
  url "https://github.com/asciinema/asciinema.git",
      branch: "develop"
  version "3.0.0-rc.3"
  license "GPL-3.0-only"

  depends_on "rust" => :build

  def install
    # Build with cargo build instead of cargo install
    # We do this because cargo install was giving me errors about Mac not being able to scan the binary - who knows if that is the right way to handle this?
    system "cargo", "build", "--release", "--locked"
    
    # Manually copy the binary to the bin directory and name it "asciinema3"
    bin.install "target/release/asciinema" => "asciinema3"

    # Tell the user this is unofficial
    ohai "Note: This is an unofficial Homebrew formula for asciinema version #{version}. It's been installed as asciinema3 to minimize confusion."
  end

  test do
    ENV["LC_ALL"] = "en_US.UTF-8"
    output = shell_output("#{bin}/asciinema3 --version 2>&1")
    assert_match "asciinema #{version}", output.strip
  end
end

# I tried the below, using prebuilt binaries, but Mac OS didn't want to run the unscanned binary

# class Asciinema < Formula
#   desc "Terminal session recorder"
#   homepage "https://asciinema.org"
#   version "3.0.0-rc.3"
#   license "GPL-3.0-only"
  
#   on_macos do
#     on_arm do
#       url "https://github.com/asciinema/asciinema/releases/download/v3.0.0-rc.3/asciinema-aarch64-apple-darwin"
#       sha256 "adca614cf61945f954c9c0ac0fedf23621f5c602cd925f0eb91921d0f5257cf0"
#     end
    
#     on_intel do
#       url "https://github.com/asciinema/asciinema/releases/download/v3.0.0-rc.3/asciinema-x86_64-apple-darwin"
#       sha256 "2841724b5ab89d250ae1676e00271a1dab17055494e89c91befee3635af49030"
#     end
#   end

  
#   # SHA256 checksums will be auto-computed by Homebrew during installation

#   def install
#     # No need to compile anything
#     bin.install Dir["*"].first => "asciinema"
#     chmod 0755, bin/"asciinema"
#   end

#   test do
#     ENV["LC_ALL"] = "en_US.UTF-8"
#     output = shell_output("#{bin}/asciinema auth 2>&1")
#     assert_match "Open the following URL in a web browser to link your " \
#                  "install ID with your asciinema.org user account", output
#   end
# end