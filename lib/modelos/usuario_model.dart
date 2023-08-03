class UsuarioModel {
  String nome;
  String email;
  String senha;
  String? tipoUsuario;



  UsuarioModel({
    required this.nome,
    required this.email,
    required this.senha,
    this.tipoUsuario
    });

  
  UsuarioModel.fromMap(Map<String, dynamic> map, String id)
      : nome = map['nome'],
        email = map['email'],
        senha = map['senha'],
        tipoUsuario = map['tipoUsuario'];


  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'email': email,
      'senha': senha,
      'tipoUsuario': tipoUsuario,
    };
  }
  

}