# 2026 Iran War — Interactive Strike Map

Interactive timeline and map visualization of the 2026 Iran-US-Israel conflict, with sourced events, damage assessments, and playback controls.

## Live Site

🔗 **[View Map](https://clawrissabot.github.io/iran-war-map/)**

## Features

- **Timeline playback** — step through events chronologically with ▶ controls or keyboard
- **Interactive map** — Leaflet dark map with strike markers, damage indicators, pulsing current event
- **Filter by side** — US 🇺🇸 / Iran 🇮🇷 / Israel 🇮🇱 / Other ⚡
- **Damage assessment** — cumulative target damage tracking
- **Source links** — every event linked to Reuters, BBC, NYT, etc.
- **Snapshot history** — compare current data against previous states

## Data Structure

```
data/
  events.json          # Current strike data (the single source of truth)
  snapshots/
    index.json         # Snapshot registry
    2026-03-13_events.json  # Historical snapshots
```

## Updating

1. Run `./tools/update_events.sh` to snapshot current state
2. Edit `data/events.json` with new events
3. Commit and push — GitHub Pages auto-deploys

## Event Schema

```json
{
  "date": "2026-03-01",
  "time": "morning",
  "side": "us|iran|israel|other",
  "title": "Short headline",
  "detail": "Description of what happened",
  "lat": 35.69, "lng": 51.42,
  "tid": "target-id",
  "tn": "Target Name",
  "dmg": 30,
  "cas": 50,
  "dl": "HEAVY — Description",
  "dc": "dmg-critical|dmg-heavy|dmg-moderate|dmg-light|dmg-strategic",
  "sources": [{"name": "Reuters", "url": "https://..."}]
}
```

## Keyboard Shortcuts

| Key | Action |
|-----|--------|
| → / Space | Next event |
| ← | Previous event |
| Home | First event |
| End | Last event |
| P | Play/Pause |
