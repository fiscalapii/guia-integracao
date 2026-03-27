# Consultar CND em Todos os Estados

Consulta CND Estadual (ICMS) em **todos os estados com provider disponivel**. Retorna resultados parciais se alguns estados falharem.

**Endpoint:** `GET /api/consultar-cnd-todos`

## Parametros

| Parametro | Tipo | Obrigatorio | Descricao |
|-----------|------|-------------|-----------|
| `cpf` | string | Um dos dois | CPF do contribuinte |
| `cnpj` | string | Um dos dois | CNPJ do contribuinte |

## Exemplo de Requisicao

```bash
curl -X GET "https://api.fiscalapi.com.br/api/consultar-cnd-todos?cnpj=12345678000199" \
  -H "X-API-Key: sua_api_key_aqui"
```

## Exemplo de Resposta

```json
{
  "request_id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "document": "12345678000199",
  "document_type": "cnpj",
  "results": [
    {
      "uf": "MT",
      "source_status": { "status": "success" },
      "result": {
        "status": "negativa",
        "status_raw": "Certidao Negativa",
        "validade": "2026-09-13",
        "emissao": "2026-03-13",
        "protocolo": "123456"
      }
    },
    {
      "uf": "GO",
      "source_status": { "status": "success" },
      "result": {
        "status": "nao_contribuinte"
      }
    },
    {
      "uf": "SP",
      "source_status": { "status": "error", "error_code": "TIMEOUT", "error_message": "SEFAZ SP nao respondeu" },
      "result": null
    }
  ]
}
```

## Comportamento

- Consulta todos os estados com provider CND implementado em paralelo
- Retorna resultados parciais — estados que falharam aparecem com `source_status.status: "error"`
- Ideal para verificacao de compliance em multiplos estados simultaneamente
