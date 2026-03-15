#!/bin/bash
# update_events.sh — Snapshot current events, then update data/events.json
# Usage: ./tools/update_events.sh
# Called by Clawrissa after curating new events into events.json

set -euo pipefail
cd "$(dirname "$0")/.."

DATE=$(date +%Y-%m-%d)
EVENTS_FILE="data/events.json"
SNAPSHOTS_DIR="data/snapshots"
INDEX_FILE="$SNAPSHOTS_DIR/index.json"

# Count current events
EVENT_COUNT=$(node -e "console.log(JSON.parse(require('fs').readFileSync('$EVENTS_FILE','utf8')).length)")

# Snapshot current state before any changes
SNAPSHOT_FILE="${DATE}_events.json"
if [ ! -f "$SNAPSHOTS_DIR/$SNAPSHOT_FILE" ]; then
  cp "$EVENTS_FILE" "$SNAPSHOTS_DIR/$SNAPSHOT_FILE"
  echo "📸 Snapshot saved: $SNAPSHOT_FILE ($EVENT_COUNT events)"

  # Update index
  node -e "
    const fs = require('fs');
    const idx = JSON.parse(fs.readFileSync('$INDEX_FILE','utf8'));
    if (!idx.find(e => e.file === '$SNAPSHOT_FILE')) {
      idx.push({
        file: '$SNAPSHOT_FILE',
        label: '$DATE — $EVENT_COUNT events',
        date: '$DATE',
        eventCount: $EVENT_COUNT
      });
      fs.writeFileSync('$INDEX_FILE', JSON.stringify(idx, null, 2));
    }
  "
else
  echo "ℹ️  Snapshot for $DATE already exists"
fi

echo "✅ Ready — edit data/events.json with new events, then commit & push"
echo "   Current: $EVENT_COUNT events"
