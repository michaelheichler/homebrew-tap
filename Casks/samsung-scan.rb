cask "samsung-scan" do
  version "1.0.0"
  sha256 "5c6040d0aa038ba09b6eaabae7f99acf9fa8cb520625651531818bc175a219c9"

  url "https://github.com/michaelheichler/samsung-scan/releases/download/v#{version}/SamsungScan-#{version}.zip"
  name "Samsung Scan"
  desc "Scanning app for SANE scanners such as the Samsung C48x"
  homepage "https://github.com/michaelheichler/samsung-scan"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on formula: "sane-backends"
  depends_on macos: :tahoe

  app "Samsung Scan.app"

  # The app has no Apple notarization, so Gatekeeper blocks it while the quarantine flag is set.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Samsung Scan.app"]
  end

  zap trash: [
    "~/Library/Application Support/de.mheichler.samsungscan",
    "~/Library/Preferences/de.mheichler.samsungscan.plist",
    "~/Library/Saved Application State/de.mheichler.samsungscan.savedState",
  ]
end
