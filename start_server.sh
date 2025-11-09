#!/bin/bash

export DATABASE_HOST=localhost
export DATABASE_PORT=5432
export DATABASE_NAME=vapor_database
export DATABASE_USERNAME=vapor_username
export DATABASE_PASSWORD=vapor_password

echo "🚀 Iniciando servidor VerhuisVriend na porta 8081..."
echo "⚠️  NÃO pressione Ctrl+C - mantenha este terminal aberto!"
echo ""

swift run App serve --hostname 127.0.0.1 --port 8081
