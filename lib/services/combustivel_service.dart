import 'dart:convert';
import 'package:http/http.dart' as http;

class PrecoService {
  static final Uri _url = Uri.parse('https://combustivelapi.com.br/api/precos');

  static Future<Map<String, String>> buscarPorEstado(String estado) async {
    final response = await http.get(_url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['error'] == false) {
        final gasolina = data['precos']['gasolina'][estado.toLowerCase()];
        final diesel = data['precos']['diesel'][estado.toLowerCase()];

        return {
          'gasolina': gasolina,
          'diesel': diesel,
        };
      } else {
        throw Exception('Erro na resposta da API: ${data['message']}');
      }
    } else {
      throw Exception('Erro HTTP: ${response.statusCode}');
    }
  }
}
