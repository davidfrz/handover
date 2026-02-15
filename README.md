# handover skill

Generate a session handover document at `.claude/handover.md` to preserve session context across compaction and new conversations.

## Directory Layout

```
handover/
  scripts/
    archive_handover.sh
  SKILL.md
handover.skill
```

## Features

- Archive any existing `.claude/handover.md` with a timestamp
- Collect git status, diff stats, and recent commits (with safe fallbacks outside git repos)
- Summarize session accomplishments and remaining tasks
- Record key decisions and rationale
- List changed files and categorize by Backend/Frontend/Config/Other
- Capture pitfalls, workarounds, and lessons learned
- Produce prioritized next steps
- Write a structured handover with a generation timestamp

## Output Format

The handover file is written to `.claude/handover.md` with sections for:

- Session Summary
- Tasks (Completed / In Progress)
- Key Decisions
- Files Changed (Backend / Frontend / Config / Other)
- Pitfalls & Workarounds
- Lessons Learned
- Git Status and Diff Stats
- Next Steps

## Usage

- Trigger manually by typing `/handover`
- Trigger automatically via a PreCompact hook

## Hook Configuration

Configure two hooks in your environment:

1. PreCompact hook
   - Before context compaction, run the `/handover` command to generate the latest handover.

2. New-session hook
   - At the start of every new conversation, check for `.claude/handover.md` in the project.
   - If it exists, load and read it before any other actions so the session starts with the last handover.

Example logic (adapt to your hook system):

```
hooks:
  PreCompact:
    - run: "/handover"
  SessionStart:
    - if_exists: ".claude/handover.md"
      read: ".claude/handover.md"
```

## Development & Packaging

Package as a distributable `.skill` file:

```bash
scripts/package_skill.py /path/to/handover
```

## Entry Points

- Main instructions: `handover/SKILL.md`
- Archive script: `handover/scripts/archive_handover.sh`
