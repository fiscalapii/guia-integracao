# Consultar IE em Todos os Estados

Consulta a inscricao estadual de um produtor em **todos os estados suportados simultaneamente**. Ideal para descobrir em quais estados um produtor possui IE ativa.

**Endpoint:** `GET /api/consultar-ie-todos`

## Parametros

| Parametro | Tipo | Obrigatorio | Descricao |
|-----------|------|-------------|-----------|
| `cpf` | string | Um dos dois | CPF do produtor |
| `cnpj` | string | Um dos dois | CNPJ da empresa |

> Este endpoint **nao aceita IE** como parametro. Use CPF ou CNPJ.

## Exemplo de Requisicao

```bash
curl -X GET "https://api.fiscalapi.com.br/api/consultar-ie-todos?cpf=12345678900" \
  -H "X-API-Key: sua_api_key_aqui"
```

## Exemplo de Resposta

```json
{
  "request_id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "document": "12345678900",
  "document_type": "cpf",
  "cached_ufs": [],
  "results": [
    {
      "uf": "MT",
      "source_status": { "status": "success", "error_code": "", "error_message": "" },
      "results": [
        {
          "inscricao_estadual": "13.123.456-7",
          "razao_social": "JOAO DA SILVA FAZENDA SANTA MARIA",
          "situacao_ie": "ATIVA",
          "uf_ie": "MT"
        }
      ]
    },
    {
      "uf": "GO",
      "source_status": { "status": "success", "error_code": "", "error_message": "" },
      "results": []
    },
    {
      "uf": "SP",
      "source_status": { "status": "error", "error_code": "TIMEOUT", "error_message": "SEFAZ nao respondeu" },
      "results": []
    }
  ]
}
```

## Campos da Resposta

| Campo | Descricao |
|-------|-----------|
| `results` | Lista com resultado de cada UF consultada |
| `results[].uf` | Sigla do estado |
| `results[].source_status` | Status da consulta naquela UF (`success`, `error`, `timeout`, `skipped`) |
| `results[].results` | Lista de IEs encontradas (mesma estrutura do endpoint `/api/consultar`) |
| `cached_ufs` | Lista de UFs cujo resultado veio do cache |

## Comportamento

- Consulta todas as UFs suportadas em paralelo
- Retorna **resultados parciais** se alguns estados falharem
- O campo `source_status` indica o que aconteceu em cada UF
- Estados sem IE para o documento retornam `results: []` com `status: "success"`
