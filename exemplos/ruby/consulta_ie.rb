# FiscalAPI — Exemplo de consulta de Inscricao Estadual em Ruby
# https://fiscalapi.com.br

require "net/http"
require "uri"
require "json"

API_KEY = ENV.fetch("FISCALAPI_KEY")
BASE_URL = "https://api.fiscalapi.com.br"

def consultar_ie(uf:, cpf: nil, cnpj: nil, ie: nil)
  params = { uf: uf }
  params[:cpf] = cpf if cpf
  params[:cnpj] = cnpj if cnpj
  params[:ie] = ie if ie

  uri = URI("#{BASE_URL}/api/consultar?#{URI.encode_www_form(params)}")
  request = Net::HTTP::Get.new(uri)
  request["X-API-Key"] = API_KEY

  response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true, read_timeout: 90) do |http|
    http.request(request)
  end

  data = JSON.parse(response.body)
  raise "#{data['error']}: #{data['message']}" unless response.is_a?(Net::HTTPSuccess)

  data
end

def consultar_ie_todos(cpf: nil, cnpj: nil)
  params = {}
  params[:cpf] = cpf if cpf
  params[:cnpj] = cnpj if cnpj

  uri = URI("#{BASE_URL}/api/consultar-ie-todos?#{URI.encode_www_form(params)}")
  request = Net::HTTP::Get.new(uri)
  request["X-API-Key"] = API_KEY

  response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true, read_timeout: 120) do |http|
    http.request(request)
  end

  data = JSON.parse(response.body)
  raise "#{data['error']}: #{data['message']}" unless response.is_a?(Net::HTTPSuccess)

  data
end

# Exemplo de uso
if __FILE__ == $PROGRAM_NAME
  resultado = consultar_ie(uf: "MT", cpf: "12345678900")
  puts "Encontradas #{resultado['results'].length} inscricoes em MT"

  resultado["results"].each do |ie|
    puts "  IE: #{ie['inscricao_estadual']} — #{ie['situacao_ie']}"
    puts "  Razao: #{ie['razao_social']}"
    puts "  Municipio: #{ie['municipio']}\n\n"
  end
end
