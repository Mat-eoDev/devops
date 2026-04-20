#!/bin/bash

CONTAINER="${1:-mongo-blog}"
ERR=0

echo "=== Check du conteneur $CONTAINER ==="

if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER}$"; then
  echo "[KO] Le conteneur tourne pas"
  exit 1
fi
echo "[OK] Conteneur actif"

USR=$(docker exec "$CONTAINER" whoami 2>/dev/null)
if [ "$USR" = "root" ]; then
  echo "[KO] Ca tourne en root !!"
  ERR=$((ERR + 1))
else
  echo "[OK] User = $USR (pas root)"
fi

DB=$(docker exec "$CONTAINER" mongosh --quiet --eval "db.getSiblingDB('blog_db').getName()" 2>/dev/null)
if [ "$DB" != "blog_db" ]; then
  echo "[KO] blog_db pas accessible"
  ERR=$((ERR + 1))
else
  echo "[OK] blog_db accessible"
fi

COUNT=$(docker exec "$CONTAINER" mongosh --quiet --eval "db.getSiblingDB('blog_db').posts.countDocuments()" 2>/dev/null)
if [ -z "$COUNT" ] || [ "$COUNT" -lt 5 ] 2>/dev/null; then
  echo "[KO] Pas assez de docs dans posts ($COUNT)"
  ERR=$((ERR + 1))
else
  echo "[OK] $COUNT documents dans posts"
fi

echo ""
if [ "$ERR" -gt 0 ]; then
  echo "=== FAIL : $ERR probleme(s) ==="
  exit 1
else
  echo "=== OK tout est bon ==="
fi
