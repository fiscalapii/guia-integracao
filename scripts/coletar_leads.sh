#!/bin/bash
# Script para coletar leads de stargazers de repos fiscais relevantes
# Uso: ./coletar_leads.sh > leads_stargazers.csv
#
# Requer: gh CLI autenticado

echo "username,email,name,company,blog,bio,repo_starred"

REPOS=(
    "nfephp-org/sped-nfe"
    "cuducos/minha-receita"
    "wmixvideo/nfe"
    "mariohmol/js-brasil"
    "akretion/nfelib"
    "nfewizard-org/nfewizard-io"
    "Purple-Stock/open-erp"
    "orochasamuel/fiscalbr-net"
    "georgevbsantiago/qsacnpj"
    "Thiagocfn/InscricaoEstadual"
    "fidelisrafael/brazilian_documents"
    "LukasMeine/emissor-nota-fiscal"
    "rictom/cnpj_consulta"
    "nfephp-org/sped-da"
    "nfephp-org/sped-efdreinf"
    "nfephp-org/sped-efd"
)

SEEN=""

for repo in "${REPOS[@]}"; do
    # Pegar stargazers (max 100 por repo para respeitar rate limit)
    stargazers=$(gh api "repos/${repo}/stargazers" --paginate -q '.[].login' 2>/dev/null | head -100)

    for user in $stargazers; do
        # Skip duplicados
        if echo "$SEEN" | grep -q "^${user}$"; then
            continue
        fi
        SEEN="${SEEN}
${user}"

        # Buscar perfil
        profile=$(gh api "users/${user}" 2>/dev/null)
        if [ -z "$profile" ]; then
            continue
        fi

        email=$(echo "$profile" | jq -r '.email // ""')
        name=$(echo "$profile" | jq -r '.name // ""')
        company=$(echo "$profile" | jq -r '.company // ""')
        blog=$(echo "$profile" | jq -r '.blog // ""')
        bio=$(echo "$profile" | jq -r '.bio // ""' | tr '\n' ' ' | tr ',' ';')

        # So incluir se tem email ou blog/company
        if [ -n "$email" ] || [ -n "$blog" ] || [ -n "$company" ]; then
            echo "\"${user}\",\"${email}\",\"${name}\",\"${company}\",\"${blog}\",\"${bio}\",\"${repo}\""
        fi

        # Rate limit: 0.5s entre chamadas
        sleep 0.5
    done
done
