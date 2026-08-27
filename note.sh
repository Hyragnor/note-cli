#!/bin/bash

# Grundlegende Setup-Variablen (Für Commit: "Add project structure")
DB_DIR=".notes/db"
mkdir -p "$DB_DIR"

COMMAND=$1

if [ "$COMMAND" == "add" ]; then
    # Für Commit: "Implement note add"
    CONTENT="${@:2}"
    if [ -z "$CONTENT" ]; then
        echo "Bitte Text eingeben. Beispiel: ./note.sh add Meine Notiz"
        exit 1
    fi
    # Erstellt einen SHA-Hash aus dem Inhalt
    HASH=$(echo -n "$CONTENT" | sha1sum | awk '{print $1}')
    echo "$CONTENT" > "$DB_DIR/$HASH"
    echo "Notiz gespeichert unter Hash: $HASH"

elif [ "$COMMAND" == "list" ]; then
    # Für Commit: "Implement note list"
    echo "Gespeicherte Notizen (Hashes):"
    ls -1 "$DB_DIR" 2>/dev/null || echo "Keine Notizen gefunden."

elif [ "$COMMAND" == "delete" ]; then
    # Für Branch: feature/delete (Commit: "Implement note delete")
    HASH=$2
    if [ -z "$HASH" ]; then
        echo "Bitte Hash angeben. Beispiel: ./note.sh delete <hash>"
        exit 1
    fi
    rm -f "$DB_DIR/$HASH"
    echo "Notiz $HASH gelöscht."

else
    echo "Verwendung: ./note.sh {add|list|delete} [Text oder Hash]"
fi