# Consultar Imoveis Rurais (CNIR/CAFIR)

Consulta dados de pessoa fisica ou juridica e imoveis rurais cadastrados no CAFIR (Cadastro Fiscal de Imoveis Rurais) via CNIR.

**Endpoint:** `GET /api/consultar-cnir`

## Parametros

| Parametro | Tipo | Obrigatorio | Descricao |
|-----------|------|-------------|-----------|
| `cpf` | string | Um dos dois | CPF do proprietario |
| `cnpj` | string | Um dos dois | CNPJ da empresa |

> Informe **apenas um** documento.

## Exemplo de Requisicao

```bash
curl -X GET "https://api.fiscalapi.com.br/api/consultar-cnir?cpf=12345678900" \
  -H "X-API-Key: sua_api_key_aqui"
```

## Exemplo de Resposta

```json
{
  "request_id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "document": "12345678900",
  "document_type": "cpf",
  "source_status": { "status": "success" },
  "pessoa_fisica": {
    "nome": "JOAO DA SILVA",
    "data_nascimento": "1975-03-15",
    "situacao_cadastral": "REGULAR",
    "sexo": "M"
  },
  "imoveis_cafir": [
    {
      "cib": "0.000.000-0",
      "nirf": "0000000000000",
      "denominacao": "FAZENDA SANTA MARIA",
      "area_total": 1250.5,
      "situacao": "ATIVO",
      "ni_proprietario": "12345678900",
      "percentual_proprietario": 100.0,
      "condominos": [],
      "dados_tributarios": {
        "indicador_descaracterizacao": false,
        "origem_imovel": 1,
        "data_aquisicao": "2005-06-20",
        "area_adquirida": 1250.5,
        "tipo_aquisicao": "COMPRA",
        "imunidades": [],
        "possui_decisao_judicial": false
      },
      "municipio_sede": {
        "codigo": "5107602",
        "uf": "MT",
        "nome": "RONDONOPOLIS"
      }
    }
  ],
  "total_imoveis": 1,
  "total_imoveis_ativos": 1
}
```

## Campos do Resultado

### Dados da Pessoa

| Campo | Descricao |
|-------|-----------|
| `pessoa_fisica.nome` | Nome completo |
| `pessoa_fisica.situacao_cadastral` | Situacao no CAFIR |
| `pessoa_juridica` | Presente quando consultado por CNPJ |

### Dados dos Imoveis

| Campo | Descricao |
|-------|-----------|
| `cib` | Cadastro de Imovel Brasileiro |
| `nirf` | Numero do Imovel na Receita Federal |
| `denominacao` | Nome do imovel rural |
| `area_total` | Area total em hectares |
| `situacao` | ATIVO, CANCELADO, etc. |
| `municipio_sede` | Municipio e UF do imovel |
| `dados_tributarios` | Dados fiscais do imovel (ITR, aquisicao, imunidades) |
| `condominos` | Lista de condominos do imovel (se houver) |

## Caso de Uso

- **Credito rural**: Verificar imoveis do produtor para analise de garantias
- **Compliance**: Confirmar posse de terras declarada
- **Agritech**: Enriquecer cadastro com dados patrimoniais
