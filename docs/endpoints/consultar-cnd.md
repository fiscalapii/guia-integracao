# Consultar CND Estadual

Consulta Certidao Negativa de Debitos Estadual (ICMS) para uma UF especifica.

**Endpoint:** `GET /api/consultar-cnd`

## Parametros

| Parametro | Tipo | Obrigatorio | Descricao |
|-----------|------|-------------|-----------|
| `uf` | string | Sim | Sigla do estado (ex: MT, SP, RJ) |
| `cpf` | string | Um dos dois | CPF do contribuinte |
| `cnpj` | string | Um dos dois | CNPJ do contribuinte |

## Exemplo de Requisicao

```bash
curl -X GET "https://api.fiscalapi.com.br/api/consultar-cnd?uf=MT&cnpj=12345678000199" \
  -H "X-API-Key: sua_api_key_aqui"
```

## Exemplo de Resposta

```json
{
  "request_id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "document": "12345678000199",
  "document_type": "cnpj",
  "uf": "MT",
  "cached": false,
  "source_status": { "status": "success", "error_code": "", "error_message": "" },
  "result": {
    "status": "negativa",
    "status_raw": "Certidao Negativa",
    "validade": "2026-09-13",
    "emissao": "2026-03-13",
    "protocolo": "123456",
    "pdf_base64": "JVBERi0xLjQ...",
    "url_verificacao": "https://sefaz.mt.gov.br/verificar/123456"
  }
}
```

## Status Possiveis

| Status | Descricao |
|--------|-----------|
| `negativa` | Sem debitos — situacao regular |
| `positiva` | Possui debitos pendentes |
| `positiva_com_efeitos_de_negativa` | Debitos parcelados ou com exigibilidade suspensa |
| `nao_contribuinte` | CPF/CNPJ nao e contribuinte naquela UF |
| `erro` | Falha na consulta |

## PDF da Certidao

Quando disponivel, o campo `pdf_base64` contem o PDF da certidao codificado em base64. Para salvar:

```python
import base64

pdf_bytes = base64.b64decode(resultado["result"]["pdf_base64"])
with open("cnd.pdf", "wb") as f:
    f.write(pdf_bytes)
```
