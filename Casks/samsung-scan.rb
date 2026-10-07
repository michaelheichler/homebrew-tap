cask "samsung-scan" do
  version "1.1.0"
  sha256 "e78814a6dd1bac2408f8220631b17b13e1e1e34fac8a2e6ea369bace86d81e6d"

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
