class Fomo < Formula
  desc "Cornwall's wave buoys and forecast in the macOS menu bar"
  homepage "https://github.com/gregrmunday/fomo"
  url "https://github.com/gregrmunday/fomo/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "f5c25dcb80cf399671faf71a9566e5b112c863fd3ef0b738fd4aac3e416674d1"
  license "MIT"
  head "https://github.com/gregrmunday/fomo.git", branch: "main"

  depends_on "rust" => :build
  depends_on macos: :monterey

  def install
    system "cargo", "install", *std_cargo_args
    # A menu bar app runs from a bundle, so move the binary into one.
    contents = prefix/"Fomo.app/Contents"
    contents.install "packaging/Info.plist"
    (contents/"MacOS").install bin/"fomo"
    # Seal the bundle with an ad hoc signature, as the app's own build script does.
    system "codesign", "--force", "--sign", "-", prefix/"Fomo.app"
    bin.install_symlink contents/"MacOS/fomo"
  end

  def caveats
    <<~EOS
      Start Fomo now and at every login:
        brew services start fomo

      Or open it once:
        open #{opt_prefix}/Fomo.app
    EOS
  end

  service do
    run opt_prefix/"Fomo.app/Contents/MacOS/fomo"
    run_type :immediate
    process_type :interactive
  end

  test do
    assert_match "fomo #{version}", shell_output("#{bin}/fomo --version")
  end
end
