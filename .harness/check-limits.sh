#!/usr/bin/env bash
# 上限超過のファイルだけ報告する。正常時は無出力
check() {
  local f=$1 max=$2
  [ -f "$f" ] || return 0
  local n; n=$(wc -l < "$f")
  [ "$n" -gt "$max" ] && echo "LIMIT: $f ${n}行（上限${max}）→ rules/state-format.md に従い退避してから作業すること"
  return 0
}
check CLAUDE.md 60
check .harness/state.md 40
check .harness/backlog.md 40
check docs/constraints.md 80
check docs/product.md 80
check docs/architecture.md 150
for f in .harness/rules/*.md; do check "$f" 120; done
for f in .harness/tasks/*.md;  do check "$f" 80;  done
exit 0
