/**
 * FiscalAPI — Exemplo de consulta de Inscricao Estadual em C# / .NET
 * https://fiscalapi.com.br
 *
 * Requer .NET 6+
 */

using System.Text.Json;

var apiKey = Environment.GetEnvironmentVariable("FISCALAPI_KEY")
    ?? throw new Exception("FISCALAPI_KEY nao definida");
var baseUrl = "https://api.fiscalapi.com.br";

using var client = new HttpClient();
client.DefaultRequestHeaders.Add("X-API-Key", apiKey);

// Consulta IE em Mato Grosso por CPF
async Task<JsonDocument> ConsultarIE(string uf, string cpf)
{
    var url = $"{baseUrl}/api/consultar?uf={Uri.EscapeDataString(uf)}&cpf={Uri.EscapeDataString(cpf)}";
    var response = await client.GetAsync(url);
    response.EnsureSuccessStatusCode();

    var json = await response.Content.ReadAsStringAsync();
    return JsonDocument.Parse(json);
}

// Consulta IE em todos os estados
async Task<JsonDocument> ConsultarIETodos(string cpf)
{
    var url = $"{baseUrl}/api/consultar-ie-todos?cpf={Uri.EscapeDataString(cpf)}";
    var response = await client.GetAsync(url);
    response.EnsureSuccessStatusCode();

    var json = await response.Content.ReadAsStringAsync();
    return JsonDocument.Parse(json);
}

// Perfil completo do produtor
async Task<JsonDocument> PerfilProdutor(string? cpf = null, string? cnpj = null)
{
    var param = cpf != null ? $"cpf={Uri.EscapeDataString(cpf)}" : $"cnpj={Uri.EscapeDataString(cnpj!)}";
    var url = $"{baseUrl}/api/perfil-produtor?{param}";
    var response = await client.GetAsync(url);
    response.EnsureSuccessStatusCode();

    var json = await response.Content.ReadAsStringAsync();
    return JsonDocument.Parse(json);
}

// Exemplo de uso
var resultado = await ConsultarIE("MT", "12345678900");
var results = resultado.RootElement.GetProperty("results");
Console.WriteLine($"Encontradas {results.GetArrayLength()} inscricoes em MT");

foreach (var ie in results.EnumerateArray())
{
    Console.WriteLine($"  IE: {ie.GetProperty("inscricao_estadual")} — {ie.GetProperty("situacao_ie")}");
    Console.WriteLine($"  Razao: {ie.GetProperty("razao_social")}");
    Console.WriteLine($"  Municipio: {ie.GetProperty("municipio")}\n");
}
