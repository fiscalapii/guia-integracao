# Perfil Completo do Produtor

Gera perfil consolidado do produtor rural combinando dados de multiplas fontes em uma unica chamada:
- **Inscricoes Estaduais** de todos os estados suportados
- **Dados da Receita Federal** (se informado CNPJ)
- **CND Estaduais** de todos os estados com provider disponivel

**Endpoint:** `GET /api/perfil-produtor`

## Parametros

| Parametro | Tipo | Obrigatorio | Descricao |
|-----------|------|-------------|-----------|
| `cpf` | string | Um dos dois | CPF do produtor |
| `cnpj` | string | Um dos dois | CNPJ da empresa |

## Exemplo de Requisicao

```bash
curl -X GET "https://api.fiscalapi.com.br/api/perfil-produtor?cnpj=12345678000199" \
  -H "X-API-Key: sua_api_key_aqui"
```

## Exemplo de Resposta

```json
{
  "request_id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "document": "12345678000199",
  "receita_federal": {
    "request_id": "...",
    "cnpj": "12345678000199",
    "cached": false,
    "source_status": { "status": "success" },
    "result": {
      "razao_social": "AGROPECUARIA BOA VISTA LTDA",
      "nome_fantasia": "FAZENDA BOA VISTA",
      "situacao_cadastral": "ATIVA"
    }
  },
  "inscricoes_estaduais": {
    "request_id": "...",
    "document": "12345678000199",
    "document_type": "cnpj",
    "results": [
      {
        "uf": "MT",
        "source_status": { "status": "success" },
        "results": [
          {
            "inscricao_estadual": "13.123.456-7",
            "razao_social": "AGROPECUARIA BOA VISTA LTDA",
            "situacao_ie": "ATIVA",
            "uf_ie": "MT"
          }
        ]
      }
    ]
  },
  "cnd_estaduais": {
    "request_id": "...",
    "document": "12345678000199",
    "document_type": "cnpj",
    "results": [
      {
        "uf": "MT",
        "source_status": { "status": "success" },
        "result": {
          "status": "negativa",
          "validade": "2026-09-13"
        }
      }
    ]
  }
}
```

## Caso de Uso

Este endpoint e ideal para **onboarding de fornecedores** e **due diligence**. Em uma unica chamada voce obtem:

1. Se a empresa esta ativa na Receita Federal
2. Em quais estados possui IE e se estao ativas
3. Se possui certidoes negativas de debito estaduais

Isso substitui dezenas de consultas manuais em portais diferentes.
