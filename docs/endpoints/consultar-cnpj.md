# Consultar CNPJ na Receita Federal

Consulta dados publicos de um CNPJ na Receita Federal. Retorna razao social, situacao cadastral, CNAE, endereco e quadro societario.

**Endpoint:** `GET /api/consultar-cnpj`

## Parametros

| Parametro | Tipo | Obrigatorio | Descricao |
|-----------|------|-------------|-----------|
| `cnpj` | string | Sim | CNPJ da empresa (com ou sem formatacao) |

## Exemplo de Requisicao

```bash
curl -X GET "https://api.fiscalapi.com.br/api/consultar-cnpj?cnpj=12345678000199" \
  -H "X-API-Key: sua_api_key_aqui"
```

## Exemplo de Resposta

```json
{
  "request_id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "cnpj": "12345678000199",
  "cached": false,
  "source_status": { "status": "success", "error_code": "", "error_message": "" },
  "result": {
    "razao_social": "AGROPECUARIA BOA VISTA LTDA",
    "nome_fantasia": "FAZENDA BOA VISTA",
    "situacao_cadastral": "ATIVA",
    "data_situacao_cadastral": "2010-05-20",
    "cnae_principal_codigo": "0151-2/01",
    "cnae_principal_descricao": "CRIACAO DE BOVINOS PARA CORTE",
    "cnaes_secundarios": [
      { "codigo": "0111-3/01", "descricao": "CULTIVO DE ARROZ" }
    ],
    "natureza_juridica": "206-2 - Sociedade Empresaria Limitada",
    "capital_social": "500000.00",
    "endereco": {
      "logradouro": "ROD BR-364 KM 28",
      "numero": "S/N",
      "bairro": "ZONA RURAL",
      "municipio": "CUIABA",
      "uf": "MT",
      "cep": "78000-000"
    },
    "qsa": [
      { "nome": "JOAO DA SILVA", "qualificacao": "Socio-Administrador" }
    ],
    "porte": "PEQUENO PORTE"
  }
}
```

## Campos do Resultado

| Campo | Descricao |
|-------|-----------|
| `razao_social` | Razao social da empresa |
| `nome_fantasia` | Nome fantasia |
| `situacao_cadastral` | ATIVA, INAPTA, SUSPENSA, BAIXADA, etc. |
| `cnae_principal_codigo` | Codigo CNAE da atividade principal |
| `cnae_principal_descricao` | Descricao da atividade principal |
| `cnaes_secundarios` | Lista de CNAEs secundarios |
| `natureza_juridica` | Natureza juridica da empresa |
| `capital_social` | Capital social declarado |
| `endereco` | Endereco completo |
| `qsa` | Quadro de socios e administradores |
| `porte` | Porte da empresa |
