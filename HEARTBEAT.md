# HEARTBEAT.md

## Memory Harvesting (Run every 2-3 days)

When triggered, perform memory maintenance:

1. **Scan recent memory files**
   ```bash
   ls -lt memory/*.md | head -10
   ```

2. **Read last 3-7 days of memory**
   - Check for key decisions, user preferences, lessons learned
   
3. **Update MEMORY.md**
   - Add new curated entries
   - Remove outdated info

4. **Archive old files**
   - Move processed files to `memory/archive/`

## System Health Check (Weekly)

- Check Gateway status
- Verify tools are working
- Review recent errors in logs

## Skip if Nothing to Do

If HEARTBEAT.md contains only comments or is empty, reply HEARTBEAT_OK.
