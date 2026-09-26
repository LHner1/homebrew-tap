cask "claude-bar" do
  version "1.0.0"
  sha256 "77b2ac918b8a136636963d2cf0b1a0737972056bc1668fc66c4d386a3577d243"

  url "https://github.com/LHner1/claude-bar/releases/download/v#{version}/ClaudeBar.zip"
  name "ClaudeBar"
  desc "Menu bar app for Claude Code sessions, plan limits and token usage"
  homepage "https://github.com/LHner1/claude-bar"

  depends_on macos: ">= :sonoma"

  app "ClaudeBar.app"

  # ClaudeBar is ad-hoc signed but not notarized, so Gatekeeper would refuse to open it.
  # Clearing the quarantine flag has the same effect as "Open Anyway" in System Settings.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/ClaudeBar.app"],
        writable_paths: ["ClaudeBar.app"],
        writable_base:  :appdir
  end

  uninstall quit: "io.github.lhner1.ClaudeBar"

  zap trash: "~/.claude/claude-bar"

  caveats <<~EOS
    Connect ClaudeBar to the Claude Code status line (your current one keeps working):
      #{appdir}/ClaudeBar.app/Contents/Resources/statusline.sh enable

    Before uninstalling, restore your previous status line with:
      #{appdir}/ClaudeBar.app/Contents/Resources/statusline.sh disable
  EOS
end
