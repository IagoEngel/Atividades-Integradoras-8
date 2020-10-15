import 'package:atividadeintegradora8/models/usuario.dart';
import 'package:atividadeintegradora8/repository/datauser.dart';
import 'package:atividadeintegradora8/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Cadastro extends StatefulWidget {
  var sexo = ['Masculino', 'Feminino'];
  var _currentS;

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  //CONEXAO COM O BANCO FIREBASE
  UsuarioRepository repository = UsuarioRepository();
  AuthService authService = AuthService();

  //INFORMAÇÕES PESSOA
  var uid;
  TextEditingController txtNome = new TextEditingController();
  TextEditingController txtData = new TextEditingController();
  TextEditingController txtEmail = new TextEditingController();
  TextEditingController txtCurso = new TextEditingController();
  TextEditingController txtPeriodo = new TextEditingController();
  TextEditingController txtTelefone = new TextEditingController();
  TextEditingController txtMatricula = new TextEditingController();
  TextEditingController txtSenha = new TextEditingController();
  TextEditingController txtConfirmaSenha = new TextEditingController();
  //ENDERECO
  TextEditingController txtEstado = new TextEditingController();
  TextEditingController txtCidade = new TextEditingController();
  TextEditingController txtBairro = new TextEditingController();
  TextEditingController txtRua = new TextEditingController();
  TextEditingController txtNCasa = new TextEditingController();
  TextEditingController txtCep = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    double leftRight = MediaQuery.of(context).size.width * 0.0444;
    double heightContainer = MediaQuery.of(context).size.height * 0.0375;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(17, 0, 119, 1.0),
        toolbarHeight: MediaQuery.of(context).size.height * 0.1171,
        leadingWidth: 70,
        leading: Image.asset(
          'assets/images/unifenasLOGO1.png',
        ),
        title: _textoCovid(),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Container(
            margin: EdgeInsets.only(left: leftRight, right: leftRight),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: heightContainer,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(106, 96, 170, 1.0),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      )),
                  child: Text(
                    "Cadastro",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
                SizedBox(height: 15),
                _txtField(txtNome, "Nome completo", TextInputType.name),
                _txtField(
                    txtData, "Data de nascimento", TextInputType.datetime),
                SizedBox(height: 15),
                _dropdownSexo(),
                _txtField(txtEmail, "Email", TextInputType.emailAddress),
                _txtField(txtCurso, "Curso", TextInputType.name),
                _txtField(txtPeriodo, "Periodo", TextInputType.number),
                _txtField(txtTelefone, "Telefone", TextInputType.phone),
                _txtField(txtMatricula, "Matrícula", TextInputType.number),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: Divider(color: Colors.grey, thickness: 3),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Endereço:",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                SizedBox(height: 15),
                _txtField(txtEstado, "Estado", TextInputType.name),
                _txtField(txtCidade, "Cidade", TextInputType.name),
                _txtField(txtBairro, "Bairro", TextInputType.name),
                _txtField(txtRua, "Rua", TextInputType.name),
                _txtField(txtNCasa, "Nº casa", TextInputType.number),
                _txtField(txtCep, "CEP", TextInputType.number),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 5),
                  child: Divider(color: Colors.grey, thickness: 3),
                ),
                _txtField(txtSenha, "Senha", TextInputType.text),
                _txtField(
                    txtConfirmaSenha, "Confirmar Senha", TextInputType.text),
                _botaoConfirmar(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textoCovid() {
    return Stack(
      children: [
        Text(
          "Controle Covid - 19",
          style: TextStyle(
            fontSize: 30,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.5
              ..color = Colors.white,
          ),
        ),
        Text(
          "Controle Covid - 19",
          style: TextStyle(fontSize: 30),
        ),
      ],
    );
  }

  Widget _txtField(
      TextEditingController txtController, String hint, TextInputType tipo) {
    bool esconder;
    (hint == "Senha" || hint == "Confirmar Senha") ? esconder = true : esconder = false;
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: TextField(
        controller: txtController,
        style: TextStyle(fontSize: 20),
        keyboardType: tipo,
        obscureText: esconder,
        decoration: InputDecoration(
          hintText: "$hint",
          hintStyle: TextStyle(fontSize: 20),
          enabledBorder: new OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 3),
          ),
          border: new OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 3),
          ),
          focusedBorder: new OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 3),
          ),
        ),
      ),
    );
  }

  Widget _dropdownSexo() {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
            hintStyle: TextStyle(fontSize: 20),
            enabledBorder: new OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 3),
            ),
            border: new OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 3),
            ),
            focusedBorder: new OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 3),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.black,
              ),
              value: widget._currentS,
              hint: Text(
                'Sexo',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              isDense: true,
              onChanged: (String newValue) {
                setState(() {
                  widget._currentS = newValue;
                  state.didChange(newValue);
                });
              },
              dropdownColor: Colors.white,
              style: TextStyle(fontSize: 20),
              items: widget.sexo.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(color: Colors.black),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _botaoConfirmar() {
    return Container(
      width: 250,
      height: 40,
      margin: EdgeInsets.only(top: 50, bottom: 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            blurRadius: 0,
            spreadRadius: 3,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: FlatButton(
        color: Color.fromRGBO(76, 64, 153, 1.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          "Confirmar Cadastro",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        onPressed: () async {
          await authService.createEmailPasswd(txtEmail.text, txtSenha.text);
          await _getUID(txtEmail.text, txtSenha.text);
          await repository.addUsuario(
            Usuario(
              nome: txtNome.text,
              email: txtEmail.text,
              dataNasc: txtData.text,
              sexo: (widget._currentS == 'Masculino') ? false : true,
              telefone: txtTelefone.text,
              curso: txtCurso.text,
              matricula: txtMatricula.text,
              periodo: int.parse(txtPeriodo.text),
              estado: txtEstado.text,
              cidade: txtCidade.text,
              bairro: txtBairro.text,
              rua: txtRua.text,
              ncasa: txtNCasa.text,
              cep: txtCep.text,
              uid: uid,
            ),
          );
          await showDialog(
            context: (context),
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(color: Colors.deepOrange, width: 10),
              ),
              title: Text("USUÁRIO CADASTRADO"),
            ),
          );
          Navigator.pop(context);
        },
      ),
    );
  }

  _getUID(String email, String passwd) async {
    dynamic result = await authService.signInEmailPasswd(email, passwd);
    uid = result.uid;
  }
}
