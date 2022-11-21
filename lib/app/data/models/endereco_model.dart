class EnderecoModel {
  late String id;
  String nomeContato = '';
  String telefoneContato = '';
  String cep = '';
  String estado = '';
  String cidade = '';
  String bairro = '';
  String nomeRua = '';
  String numero = '';
  String complemento = '';

  setNomeContato(String v) => nomeContato = v;
  setTelefoneContato(String v) => telefoneContato = v;
  setCep(String v) => cep = v;
  setEstado(String v) => estado = v;
  setCidade(String v) => cidade = v;
  setBairro(String v) => bairro = v;
  setNomeRua(String v) => nomeRua = v;
  setNumero(String v) => numero = v;
  setComplemento(String v) => complemento = v;

  EnderecoModel.fromNew() {
    id = DateTime.now().toLocal().microsecondsSinceEpoch.toString();
  }

  EnderecoModel.fromJson(Map json) {
    id = json['id'];
    nomeContato = json['nomeContato'];
    telefoneContato = json['telefoneContato'];
    cep = json['cep'];
    estado = json['estado'];
    cidade = json['cidade'];
    bairro = json['bairro'];
    nomeRua = json['nomeRua'];
    numero = json['numero'];
    complemento = json['complemento'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nomeContato'] = nomeContato;
    data['telefoneContato'] = telefoneContato;
    data['cep'] = cep;
    data['estado'] = estado;
    data['cidade'] = cidade;
    data['bairro'] = bairro;
    data['nomeRua'] = nomeRua;
    data['numero'] = numero;
    data['complemento'] = complemento;
    return data;
  }
}
