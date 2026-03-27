/**
 * FiscalAPI — Exemplo de consulta de Inscricao Estadual em Java
 * https://fiscalapi.com.br
 *
 * Requer Java 11+ (HttpClient nativo)
 */

import java.net.URI;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;

public class ConsultaIE {

    private static final String API_KEY = System.getenv("FISCALAPI_KEY");
    private static final String BASE_URL = "https://api.fiscalapi.com.br";

    private final HttpClient client = HttpClient.newHttpClient();

    /**
     * Consulta IE por UF e CPF.
     */
    public String consultarIE(String uf, String cpf) throws Exception {
        String url = String.format("%s/api/consultar?uf=%s&cpf=%s",
                BASE_URL,
                URLEncoder.encode(uf, StandardCharsets.UTF_8),
                URLEncoder.encode(cpf, StandardCharsets.UTF_8));

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .header("X-API-Key", API_KEY)
                .GET()
                .build();

        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

        if (response.statusCode() != 200) {
            throw new RuntimeException("Erro HTTP " + response.statusCode() + ": " + response.body());
        }

        return response.body();
    }

    /**
     * Consulta IE em todos os estados.
     */
    public String consultarIETodos(String cpf) throws Exception {
        String url = String.format("%s/api/consultar-ie-todos?cpf=%s",
                BASE_URL,
                URLEncoder.encode(cpf, StandardCharsets.UTF_8));

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .header("X-API-Key", API_KEY)
                .GET()
                .build();

        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

        if (response.statusCode() != 200) {
            throw new RuntimeException("Erro HTTP " + response.statusCode() + ": " + response.body());
        }

        return response.body();
    }

    public static void main(String[] args) throws Exception {
        ConsultaIE api = new ConsultaIE();

        // Consulta IE em Mato Grosso
        String resultado = api.consultarIE("MT", "12345678900");
        System.out.println("Resultado MT: " + resultado);

        // Consulta em todos os estados
        String todos = api.consultarIETodos("12345678900");
        System.out.println("Todos os estados: " + todos);
    }
}
