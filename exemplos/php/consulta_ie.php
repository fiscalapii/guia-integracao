<?php
/**
 * FiscalAPI — Exemplo de consulta de Inscricao Estadual em PHP
 * https://fiscalapi.com.br
 */

$apiKey = getenv('FISCALAPI_KEY');
$baseUrl = 'https://api.fiscalapi.com.br';

/**
 * Consulta IE de um produtor rural em um estado especifico.
 */
function consultarIE(string $uf, ?string $cpf = null, ?string $cnpj = null, ?string $ie = null): array
{
    global $apiKey, $baseUrl;

    $params = ['uf' => $uf];
    if ($cpf) $params['cpf'] = $cpf;
    elseif ($cnpj) $params['cnpj'] = $cnpj;
    elseif ($ie) $params['ie'] = $ie;

    $url = $baseUrl . '/api/consultar?' . http_build_query($params);

    $ch = curl_init($url);
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_TIMEOUT => 90,
        CURLOPT_HTTPHEADER => [
            'X-API-Key: ' . $apiKey,
        ],
    ]);

    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    $data = json_decode($response, true);

    if ($httpCode !== 200) {
        throw new Exception("{$data['error']}: {$data['message']}");
    }

    return $data;
}

/**
 * Consulta IE em todos os estados simultaneamente.
 */
function consultarIETodos(?string $cpf = null, ?string $cnpj = null): array
{
    global $apiKey, $baseUrl;

    $params = [];
    if ($cpf) $params['cpf'] = $cpf;
    elseif ($cnpj) $params['cnpj'] = $cnpj;

    $url = $baseUrl . '/api/consultar-ie-todos?' . http_build_query($params);

    $ch = curl_init($url);
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_TIMEOUT => 120,
        CURLOPT_HTTPHEADER => [
            'X-API-Key: ' . $apiKey,
        ],
    ]);

    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    $data = json_decode($response, true);

    if ($httpCode !== 200) {
        throw new Exception("{$data['error']}: {$data['message']}");
    }

    return $data;
}

// Exemplo de uso
$resultado = consultarIE('MT', cpf: '12345678900');
echo "Encontradas " . count($resultado['results']) . " inscricoes em MT\n";

foreach ($resultado['results'] as $ie) {
    echo "  IE: {$ie['inscricao_estadual']} — {$ie['situacao_ie']}\n";
    echo "  Razao: {$ie['razao_social']}\n";
    echo "  Municipio: {$ie['municipio']}\n\n";
}
