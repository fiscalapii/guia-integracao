"""
FiscalAPI — Exemplo de consulta CNPJ na Receita Federal
https://fiscalapi.com.br
"""

import os
import requests

API_KEY = os.environ["FISCALAPI_KEY"]
BASE_URL = "https://api.fiscalapi.com.br"


def consultar_cnpj(cnpj: str) -> dict:
    """Consulta dados publicos de um CNPJ na Receita Federal."""
    response = requests.get(
        f"{BASE_URL}/api/consultar-cnpj",
        params={"cnpj": cnpj},
        headers={"X-API-Key": API_KEY},
        timeout=30,
    )
    response.raise_for_status()
    return response.json()


if __name__ == "__main__":
    resultado = consultar_cnpj("12345678000199")

    if resultado["source_status"]["status"] == "success" and resultado["result"]:
        empresa = resultado["result"]
        print(f"Razao Social: {empresa['razao_social']}")
        print(f"Situacao: {empresa['situacao_cadastral']}")
        print(f"CNAE: {empresa['cnae_principal_codigo']} — {empresa['cnae_principal_descricao']}")
        print(f"Porte: {empresa['porte']}")

        if empresa["qsa"]:
            print("Socios:")
            for socio in empresa["qsa"]:
                print(f"  - {socio['nome']} ({socio['qualificacao']})")
