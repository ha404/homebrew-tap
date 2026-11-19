cask "claude-usage-meter" do
  # The app updates itself from GitHub releases, so the cask tracks the latest one
  # rather than pinning a version that would need bumping on every push.
  version :latest
  sha256 :no_check

  url "https://github.com/ha404/claude-usage-meter/releases/latest/download/ClaudeUsageMeter.zip"
  name "Claude Usage Meter"
  desc "Shows Claude plan usage in the menu bar and the Claude Code status line"
  homepage "https://github.com/ha404/claude-usage-meter"

  auto_updates true
  depends_on macos: :sonoma

  app "ClaudeUsageMeter.app"

  # The app is ad-hoc signed, not notarized, so Gatekeeper would refuse to launch the
  # quarantined copy Homebrew installs. Clearing the attribute lets it open normally.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/ClaudeUsageMeter.app"],
        must_succeed: false
  end

  uninstall quit: "com.local.claude-usage-meter"

  zap trash: [
    "~/.claude/usage-meter-cache.json",
    "~/Library/Preferences/com.local.claude-usage-meter.plist",
  ]

  caveats <<~EOS
    Claude Usage Meter is not notarized. This cask removes the quarantine attribute
    so macOS will open it without a Gatekeeper prompt.

    To show usage in Claude Code as well, click the menu bar bars and tick
    "Claude Code status line".
  EOS
end
