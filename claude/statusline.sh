#!/bin/bash
input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name')
DIR=$(echo "$input" | jq -r '.workspace.current_dir')
COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
DURATION_MS=$(echo "$input" | jq -r '.cost.total_duration_ms // 0')
WEEKLY_PCT=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty' | cut -d. -f1)
WEEKLY_RESET=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // empty')
FIVEH_PCT=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty' | cut -d. -f1)
FIVEH_RESET=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')

CYAN='\033[36m'; GREEN='\033[32m'; YELLOW='\033[33m'; RED='\033[31m'; RESET='\033[0m'

if [ "$PCT" -ge 90 ]; then BAR_COLOR="$RED"
elif [ "$PCT" -ge 70 ]; then BAR_COLOR="$YELLOW"
else BAR_COLOR="$GREEN"; fi

FILLED=$((PCT / 10)); EMPTY=$((10 - FILLED))
printf -v FILL "%${FILLED}s"; printf -v PAD "%${EMPTY}s"
BAR="${FILL// /█}${PAD// /░}"

MINS=$((DURATION_MS / 60000)); SECS=$(((DURATION_MS % 60000) / 1000))

# Usage windows (only present for Pro/Max, and only after the first API response)
usage_color() {
  if [ "$1" -ge 90 ]; then echo "$RED"
  elif [ "$1" -ge 70 ]; then echo "$YELLOW"
  else echo "$GREEN"; fi
}

FIVEH_SEG=""
if [ -n "$FIVEH_PCT" ]; then
  F_COLOR=$(usage_color "$FIVEH_PCT")
  F_RESET_STR=""
  [ -n "$FIVEH_RESET" ] && F_RESET_STR=" (resets $(date -d "@$FIVEH_RESET" '+%-I:%M%P'))"
  FIVEH_SEG=" | ${F_COLOR}⏳ 5h ${FIVEH_PCT}%${RESET}${F_RESET_STR}"
fi

WEEKLY_SEG=""
if [ -n "$WEEKLY_PCT" ]; then
  WK_COLOR=$(usage_color "$WEEKLY_PCT")
  RESET_STR=""
  [ -n "$WEEKLY_RESET" ] && RESET_STR=" (resets $(date -d "@$WEEKLY_RESET" '+%b %-d'))"
  WEEKLY_SEG=" | ${WK_COLOR}📊 wk ${WEEKLY_PCT}%${RESET}${RESET_STR}"
fi

BRANCH=""
git -C "$DIR" rev-parse --git-dir > /dev/null 2>&1 && BRANCH=" | 🌿 $(git -C "$DIR" branch --show-current 2>/dev/null)"

echo -e "${CYAN}[$MODEL]${RESET} 📁 ${DIR##*/}$BRANCH"
COST_FMT=$(printf '$%.2f' "$COST")
echo -e "${BAR_COLOR}${BAR}${RESET} ${PCT}% | ${YELLOW}${COST_FMT}${RESET} | ⏱️ ${MINS}m ${SECS}s${FIVEH_SEG}${WEEKLY_SEG}"
