---
name: handover
description: >
  Generate a session handover document (.claude/handover.md) capturing session summary,
  completed/in-progress tasks, key decisions, changed files, pitfalls, lessons learned,
  git status, and next steps. Use when the user types "/handover" or when triggered
  automatically by PreCompact hook to preserve session context before context window compaction.
---

# Session Handover

Generate a comprehensive handover document at `.claude/handover.md` in the current project.

## Procedure

### 1. Archive existing handover

Run the archive script to rename any existing `handover.md` with a timestamp:

```bash
bash <skill_path>/scripts/archive_handover.sh <project_root>
```

Replace `<skill_path>` with the absolute path to this skill directory, and `<project_root>` with the current working directory.

### 2. Gather git information

Run these commands and capture output:

```bash
git status 2>/dev/null || echo "Not a git repository"
git diff --stat 2>/dev/null || echo ""
git log --oneline -5 2>/dev/null || echo ""
```

### 3. Analyze session context

Review the full conversation history to extract:
- What was accomplished (summary)
- Tasks completed and still in progress
- Decisions made and why
- Files that were modified (categorize as Backend/Frontend/Config/Other)
- Problems hit and how they were resolved
- Insights and lessons
- What should be done next

### 4. Write handover.md

Create `.claude/handover.md` with this structure (fill each section from context analysis):

```markdown
# Session Handover
> Generated: YYYY-MM-DD HH:MM

## Session Summary
<!-- 2-3 sentence overview of what this session accomplished -->

## Tasks
### Completed
- [x] task 1
- [x] task 2

### In Progress
- [ ] task with current status note

## Key Decisions
| Decision | Rationale |
|----------|-----------|
| ... | ... |

## Files Changed
### Backend
- `path/to/file` - what changed

### Frontend
- `path/to/file` - what changed

### Config
- `path/to/file` - what changed

### Other
- `path/to/file` - what changed

## Pitfalls & Workarounds
- **Problem**: description
  **Workaround**: how it was solved

## Lessons Learned
- Lesson 1
- Lesson 2

## Git Status
\```
<paste git status output here>
\```

### Diff Stats
\```
<paste git diff --stat output here>
\```

## Next Steps
1. [P0] Highest priority item
2. [P1] Next priority item
3. [P2] Lower priority item
```

### Guidelines

- Be concise but complete - this document is for the next session's Claude to pick up where you left off
- If a section has no content (e.g., no pitfalls), write "None this session" instead of omitting it
- Categorize files by role: API/DB/service code -> Backend, UI/components/styles -> Frontend, env/config/CI -> Config
- Next steps should be actionable and priority-ordered
- Always include the generation timestamp
