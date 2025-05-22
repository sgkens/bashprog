<#
  Commit Fusion template file
  use to create large detailed commits
#>
$Params = @{
  Type             = "docs";
  Scope            = "bar/spinner generation script";
  Description      = "update bar/spinner example generation scripts";
  GitUser          = "sgkens";
  #GitGroup         = "phellams";
  Notes            = @(
    "UDPATE: bash script to output progress bars and spinners example svgs and markdown code"

    );

  # FeatureAdditions = @(
  #   "Output command help --help"
  # );
  #semver = "patch";
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