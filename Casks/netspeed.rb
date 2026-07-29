cask "netspeed" do
  version "1.0.0"
  sha256 "4541efcb15e41ac02a2dc0e1349dab096ee418dec789ce27e60d952b1cbb4e78"

  url "https://github.com/mohith-labs/MacNetspeed/releases/download/v#{version}/NetSpeed-v#{version}-macOS.zip"
  name "NetSpeed"
  desc "Lightweight macOS menu bar app that displays real-time network speed"
  homepage "https://github.com/mohith-labs/MacNetspeed"

  depends_on macos: :ventura

  app "NetSpeed.app"

  postflight do
    # Remove quarantine attribute so the app opens without Gatekeeper blocking it
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/NetSpeed.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Preferences/com.mohith.NetSpeed.plist",
    "~/Library/Caches/com.mohith.NetSpeed",
  ]

  caveats <<~EOS
    NetSpeed runs as a menu bar app (no Dock icon).
    Click the ▲/▼ speed display in your menu bar to see details.
    Enable "Launch at Login" from the dropdown menu.
  EOS
end
