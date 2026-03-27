#!/bin/bash
# FiscalAPI — Exemplos com cURL
# https://fiscalapi.com.br
#
# Configure sua API key:
#   export FISCALAPI_KEY="sua_api_key_aqui"

API_KEY="${FISCALAPI_KEY:?Defina FISCALAPI_KEY}"
BASE_URL="https://api.fiscalapi.com.br"

echo "=== Consulta IE em MT por CPF ==="
curl -s -X GET "${BASE_URL}/api/consultar?uf=MT&cpf=12345678900" \
  -H "X-API-Key: ${API_KEY}" | python3 -m json.tool

echo ""
echo "=== Consulta IE em Todos os Estados ==="
curl -s -X GET "${BASE_URL}/api/consultar-ie-todos?cpf=12345678900" \
  -H "X-API-Key: ${API_KEY}" | python3 -m json.tool

echo ""
echo "=== Consulta CNPJ na Receita Federal ==="
curl -s -X GET "${BASE_URL}/api/consultar-cnpj?cnpj=12345678000199" \
  -H "X-API-Key: ${API_KEY}" | python3 -m json.tool

echo ""
echo "=== Perfil Completo do Produtor ==="
curl -s -X GET "${BASE_URL}/api/perfil-produtor?cnpj=12345678000199" \
  -H "X-API-Key: ${API_KEY}" | python3 -m json.tool

echo ""
echo "=== CND Estadual em MT ==="
curl -s -X GET "${BASE_URL}/api/consultar-cnd?uf=MT&cnpj=12345678000199" \
  -H "X-API-Key: ${API_KEY}" | python3 -m json.tool

echo ""
echo "=== CND em Todos os Estados ==="
curl -s -X GET "${BASE_URL}/api/consultar-cnd-todos?cnpj=12345678000199" \
  -H "X-API-Key: ${API_KEY}" | python3 -m json.tool

echo ""
echo "=== Consulta CNIR/CAFIR ==="
curl -s -X GET "${BASE_URL}/api/consultar-cnir?cpf=12345678900" \
  -H "X-API-Key: ${API_KEY}" | python3 -m json.tool
