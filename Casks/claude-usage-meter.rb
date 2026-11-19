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

  uninstall quit: "com.local.claude-usage-meter"

  zap trash: [
    "~/.claude/usage-meter-cache.json",
    "~/Library/Preferences/com.local.claude-usage-meter.plist",
  ]

  caveats <<~EOS
    Claude Usage Meter is not notarized, so macOS blocks its first launch.
    Open it once, then allow it in:
      System Settings → Privacy & Security → Open Anyway

    To show usage in Claude Code as well, click the menu bar bars and choose
    "Set up Claude Code status line".
  EOS
end
