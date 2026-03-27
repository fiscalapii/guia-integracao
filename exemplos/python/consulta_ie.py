"""
FiscalAPI — Exemplo de consulta de Inscricao Estadual em Python
https://fiscalapi.com.br
"""

import os
import requests

API_KEY = os.environ["FISCALAPI_KEY"]
BASE_URL = "https://api.fiscalapi.com.br"


def consultar_ie(uf: str, cpf: str | None = None, cnpj: str | None = None) -> dict:
    """Consulta IE de um produtor rural em um estado especifico."""
    params = {"uf": uf}
    if cpf:
        params["cpf"] = cpf
    elif cnpj:
        params["cnpj"] = cnpj

    response = requests.get(
        f"{BASE_URL}/api/consultar",
        params=params,
        headers={"X-API-Key": API_KEY},
        timeout=90,
    )
    response.raise_for_status()
    return response.json()


def consultar_ie_todos(cpf: str | None = None, cnpj: str | None = None) -> dict:
    """Consulta IE em todos os estados simultaneamente."""
    params = {}
    if cpf:
        params["cpf"] = cpf
    elif cnpj:
        params["cnpj"] = cnpj

    response = requests.get(
        f"{BASE_URL}/api/consultar-ie-todos",
        params=params,
        headers={"X-API-Key": API_KEY},
        timeout=120,
    )
    response.raise_for_status()
    return response.json()


def perfil_produtor(cpf: str | None = None, cnpj: str | None = None) -> dict:
    """Perfil completo do produtor (IE + Receita Federal + CND)."""
    params = {}
    if cpf:
        params["cpf"] = cpf
    elif cnpj:
        params["cnpj"] = cnpj

    response = requests.get(
        f"{BASE_URL}/api/perfil-produtor",
        params=params,
        headers={"X-API-Key": API_KEY},
        timeout=120,
    )
    response.raise_for_status()
    return response.json()


if __name__ == "__main__":
    # Consulta IE em Mato Grosso por CPF
    resultado = consultar_ie(uf="MT", cpf="12345678900")
    print(f"Encontradas {len(resultado['results'])} inscricoes em MT")

    for ie in resultado["results"]:
        print(f"  IE: {ie['inscricao_estadual']} — {ie['situacao_ie']}")
        print(f"  Razao: {ie['razao_social']}")
        print(f"  Municipio: {ie['municipio']}")
        print()

    # Consulta em todos os estados
    todos = consultar_ie_todos(cpf="12345678900")
    for uf_result in todos["results"]:
        uf = uf_result["uf"]
        status = uf_result["source_status"]["status"]
        qtd = len(uf_result["results"])
        print(f"  {uf}: {status} — {qtd} IE(s)")
