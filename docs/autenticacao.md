# Autenticacao

Todas as requisicoes a API FiscalAPI exigem autenticacao via API Key.

## Obtendo sua API Key

1. Crie uma conta em [app.fiscalapi.com.br](https://app.fiscalapi.com.br)
2. Acesse **Dashboard > API Keys**
3. Clique em **Gerar nova chave**
4. Copie a chave — ela so e exibida uma vez

## Usando a API Key

Envie a chave no header `X-API-Key` de cada requisicao:

```bash
curl -X GET "https://api.fiscalapi.com.br/api/consultar?uf=SP&cpf=12345678900" \
  -H "X-API-Key: sk_live_abc123def456"
```

## Formatos de Chave

| Prefixo | Ambiente |
|---------|----------|
| `sk_live_` | Producao |
| `sk_test_` | Sandbox |
| `sk_demo_` | Demo (acesso limitado) |

## Chave Demo

A chave demo permite testar o endpoint `/api/consultar` sem cadastro:
- Limite: 3 consultas por minuto por IP
- Dados retornados sao parcialmente mascarados
- Apenas o endpoint de consulta IE esta disponivel

## Erros de Autenticacao

| Codigo | Erro | Descricao |
|--------|------|-----------|
| 403 | `API_KEY_ERROR` | Chave ausente, invalida ou revogada |
| 403 | `ACESSO_NEGADO` | Chave demo tentando acessar endpoint restrito |

## Boas Praticas

- **Nunca exponha sua API key no frontend** — faca chamadas pelo backend
- **Use variaveis de ambiente** para armazenar a chave
- **Rotacione chaves periodicamente** via dashboard
- **Use chaves diferentes** para cada ambiente (dev, staging, prod)

```python
import os

API_KEY = os.environ["FISCALAPI_KEY"]
```

```javascript
const API_KEY = process.env.FISCALAPI_KEY;
```

```php
$apiKey = getenv('FISCALAPI_KEY');
```
