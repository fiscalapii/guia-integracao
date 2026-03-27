"""
FiscalAPI — Exemplo de consulta CNIR/CAFIR (imoveis rurais)
https://fiscalapi.com.br
"""

import os
import requests

API_KEY = os.environ["FISCALAPI_KEY"]
BASE_URL = "https://api.fiscalapi.com.br"


def consultar_cnir(cpf: str | None = None, cnpj: str | None = None) -> dict:
    """Consulta imoveis rurais no CAFIR via CNIR."""
    params = {}
    if cpf:
        params["cpf"] = cpf
    elif cnpj:
        params["cnpj"] = cnpj

    response = requests.get(
        f"{BASE_URL}/api/consultar-cnir",
        params=params,
        headers={"X-API-Key": API_KEY},
        timeout=60,
    )
    response.raise_for_status()
    return response.json()


if __name__ == "__main__":
    resultado = consultar_cnir(cpf="12345678900")

    if resultado["source_status"]["status"] == "success":
        print(f"Total de imoveis: {resultado['total_imoveis']}")
        print(f"Imoveis ativos: {resultado['total_imoveis_ativos']}")

        for imovel in resultado["imoveis_cafir"]:
            print(f"\n  CIB: {imovel['cib']}")
            print(f"  Denominacao: {imovel['denominacao']}")
            print(f"  Area: {imovel['area_total']} ha")
            print(f"  Situacao: {imovel['situacao']}")
            if imovel.get("municipio_sede"):
                mun = imovel["municipio_sede"]
                print(f"  Local: {mun['nome']}/{mun['uf']}")
