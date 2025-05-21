<#
  Commit Fusion template file
  use to create large detailed commits
#>
$Params = @{
  Type             = "wip";
  Scope            = "main command";
  Description      = "logic and switches";
  GitUser          = "sgkens";
  #GitGroup         = "phellams";
  Notes            = @(
    "ADD: Param switch to to switch modes",
    "ADD: 2 additional modes list and rewrite",
    "ADD: Param switch to enable optional message output for bars and spinners",
    "ADD: Param switch to enable/disable debug logging",
    "ADD: Param switches for Color support for bars and spinners base 16 colors",
    "ADD: switch to enable/disable demo mode for bars and spinners",
    "ADD: Param switch to call the clearlines function to rewrite lines in the console",
    "ADD: Update help function call to include updated help function call",
    "ADD: Param switch to list all|bars|spinners themes",
    "ADD: Default text for message for spinners and bars, overide default message by entering a empty message string or -nm|--nomessage",
    "UPDATE: show help to now output error/warning notifications to under help output",
    "UPDATE: Debug output to reflect switch state and values for better debugging"
  );

  # FeatureAdditions = @(
  #   "Output command help --help"
  # );
  semver = "patch";
  # BugFixes = @(
  #   "- Emojis that were output to the console within a PSObject disrupt the alignment of the object, throwing other field alignments off.",
  #   "- FIX: `Select-Object` to manually output in order so that emoji is last; this fixed the alignment."
  # );
  #BreakingChanges = @();
  # FeatureNotes = @(
  #   "Package available on PowerShell Gallery.",
  #   "Package available on chocolatey.org."
  #   "package available on gitlab.com"
  #   "Documentation hosting provided by GitLab Pages: https://sgkens.gitlab.io/commitfusion/"
  # );
  #AsString = $true #Default is $true
  footer           = $false
}

# ACTIONS
# -------

# ConventionalCommit with params sent commit
New-Commit @Params

# ConventionalCommit with params sent commit
#New-Commit @Params | Set-Commit

# ConventionalCommit with params, written to changelog and sent commit
#New-Commit @Params | Format-FusionMD | Update-ChangeLog -logfile .\changelog.md | Set-Commit