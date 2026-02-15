#!/bin/bash
# Archive existing handover.md by renaming with timestamp
# Usage: archive_handover.sh <project_root>

PROJECT_ROOT="${1:-.}"
CLAUDE_DIR="$PROJECT_ROOT/.claude"
HANDOVER="$CLAUDE_DIR/handover.md"

# Create .claude dir if needed
mkdir -p "$CLAUDE_DIR"

# Archive existing handover.md if present
if [ -f "$HANDOVER" ]; then
    TIMESTAMP=$(date +"%Y-%m-%d-%H%M%S")
    ARCHIVE="$CLAUDE_DIR/handover-$TIMESTAMP.md"
    mv "$HANDOVER" "$ARCHIVE"
    echo "Archived: $ARCHIVE"
else
    echo "No existing handover.md to archive"
fi
