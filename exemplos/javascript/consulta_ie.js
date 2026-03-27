/**
 * FiscalAPI — Exemplo de consulta de Inscricao Estadual em JavaScript/Node.js
 * https://fiscalapi.com.br
 */

const API_KEY = process.env.FISCALAPI_KEY;
const BASE_URL = "https://api.fiscalapi.com.br";

async function consultarIE(uf, { cpf, cnpj, ie } = {}) {
  const params = new URLSearchParams({ uf });
  if (cpf) params.set("cpf", cpf);
  else if (cnpj) params.set("cnpj", cnpj);
  else if (ie) params.set("ie", ie);

  const response = await fetch(`${BASE_URL}/api/consultar?${params}`, {
    headers: { "X-API-Key": API_KEY },
  });

  if (!response.ok) {
    const error = await response.json();
    throw new Error(`${error.error}: ${error.message}`);
  }

  return response.json();
}

async function consultarIETodos({ cpf, cnpj } = {}) {
  const params = new URLSearchParams();
  if (cpf) params.set("cpf", cpf);
  else if (cnpj) params.set("cnpj", cnpj);

  const response = await fetch(`${BASE_URL}/api/consultar-ie-todos?${params}`, {
    headers: { "X-API-Key": API_KEY },
  });

  if (!response.ok) {
    const error = await response.json();
    throw new Error(`${error.error}: ${error.message}`);
  }

  return response.json();
}

async function perfilProdutor({ cpf, cnpj } = {}) {
  const params = new URLSearchParams();
  if (cpf) params.set("cpf", cpf);
  else if (cnpj) params.set("cnpj", cnpj);

  const response = await fetch(`${BASE_URL}/api/perfil-produtor?${params}`, {
    headers: { "X-API-Key": API_KEY },
  });

  if (!response.ok) {
    const error = await response.json();
    throw new Error(`${error.error}: ${error.message}`);
  }

  return response.json();
}

// Exemplo de uso
async function main() {
  // Consulta IE em Mato Grosso
  const resultado = await consultarIE("MT", { cpf: "12345678900" });
  console.log(`Encontradas ${resultado.results.length} inscricoes em MT`);

  for (const ie of resultado.results) {
    console.log(`  IE: ${ie.inscricao_estadual} — ${ie.situacao_ie}`);
    console.log(`  Razao: ${ie.razao_social}`);
    console.log(`  Municipio: ${ie.municipio}\n`);
  }

  // Consulta em todos os estados
  const todos = await consultarIETodos({ cpf: "12345678900" });
  for (const ufResult of todos.results) {
    const { uf, source_status, results } = ufResult;
    console.log(`  ${uf}: ${source_status.status} — ${results.length} IE(s)`);
  }
}

main().catch(console.error);

module.exports = { consultarIE, consultarIETodos, perfilProdutor };
