import 'package:atividadeintegradora8/models/usuario.dart';
import 'package:atividadeintegradora8/repository/datauser.dart';
import 'package:atividadeintegradora8/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Cadastro extends StatefulWidget {
  var sexo = ['Masculino', 'Feminino'];
  var cursos = [
    'Administração',
    'Agronomia',
    'Arquitetura e Urbanismo',
    'Biomedicina',
    'Ciência da Computação',
    'Ciências Contábeis',
    'Direito',
    'Educação Física',
    'Enfermagem',
    'Engenharia Civil',
    'Estética e Cosmética',
    'Farmácia',
    'Fisioterapia',
    'Gastronomia',
    'Medicina',
    'Nutrição',
    'Odontologia',
    'Pedagogia',
    'Psicologia',
    'Veterinária',
  ];
  var _currentCurso;
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
  TextEditingController txtIdade = new TextEditingController();
  TextEditingController txtEmail = new TextEditingController();
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
                SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Informações Gerais:",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                _txtField(txtNome, "Nome completo *", TextInputType.name),
                _txtField(txtIdade, "Idade", TextInputType.number),
                SizedBox(height: 15),
                _dropdownSexo(),
                _txtField(txtEmail, "Email *", TextInputType.emailAddress),
                SizedBox(height: 15),
                _dropdownCurso(),
                _txtField(txtPeriodo, "Período", TextInputType.number),
                _txtField(txtTelefone, "Telefone", TextInputType.phone),
                _txtField(txtMatricula, "Matrícula *", TextInputType.number),
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
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 5),
                  child: Divider(color: Colors.grey, thickness: 3),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Senha:",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                _txtField(txtSenha, "", TextInputType.text),
                SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Confirmar Senha:",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                _txtField(txtConfirmaSenha, "", TextInputType.text),
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
    (hint == "") ? esconder = true : esconder = false;

    return Container(
      margin: EdgeInsets.only(top: 15),
      child: TextField(
        autofocus: true,
        inputFormatters: [
          if (hint == "Estado") UpperCase(),
          if (hint == "Cidade") UpperCase(),
          if (hint == "Bairro") UpperCase(),
          if (hint == "Idade" ||
              hint == "Período" ||
              hint == "Matrícula" ||
              hint == "Telefone")
            FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
          if (hint == "Idade") LengthLimitingTextInputFormatter(2),
          if (hint == "Período") LengthLimitingTextInputFormatter(2),
          if (hint == "Matrícula") LengthLimitingTextInputFormatter(9),
          if (hint == "Telefone") LengthLimitingTextInputFormatter(11),
        ],
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
                'Sexo *',
                style: TextStyle(color: Colors.black54, fontSize: 20),
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

  Widget _dropdownCurso() {
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
              value: widget._currentCurso,
              hint: Text(
                'Curso',
                style: TextStyle(color: Colors.black54, fontSize: 20),
              ),
              isDense: true,
              onChanged: (String newValue) {
                setState(() {
                  widget._currentCurso = newValue;
                  state.didChange(newValue);
                });
              },
              dropdownColor: Colors.white,
              style: TextStyle(fontSize: 20),
              items: widget.cursos.map((String value) {
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
          (txtNome.text.isEmpty)
              ? _dialog("Nome completo")
              : (widget._currentS == null)
                  ? _dialog("Sexo")
                  : (txtEmail.text.isEmpty)
                      ? _dialog("Email")
                      : (txtMatricula.text.isEmpty)
                          ? _dialog("Matrícula")
                          : _verificao();
        },
      ),
    );
  }

  _verificao() async {
    if (txtSenha.text.length < 6 || txtConfirmaSenha.text.length < 6) {
      await showDialog(
        context: (context),
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: Color.fromRGBO(17, 0, 119, 1.0), width: 5),
          ),
          title: Text("COLOQUE UMA SENHA DE PELO MENOS 6 DIGITOS"),
        ),
      );
    } else {
      if (txtSenha.text != txtConfirmaSenha.text) {
        await showDialog(
          context: (context),
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side:
                  BorderSide(color: Color.fromRGBO(17, 0, 119, 1.0), width: 5),
            ),
            title: Text("SENHA INCORRETA"),
          ),
        );
      } else {
        await authService.createEmailPasswd(txtEmail.text, txtSenha.text);
        await _getUID(txtEmail.text, txtSenha.text);
        await repository.addUsuario(
          Usuario(
            nome: txtNome.text,
            email: txtEmail.text,
            idade: (txtIdade.text.isEmpty)? null:int.parse(txtIdade.text),
            sexo: (widget._currentS == 'Masculino') ? false : true,
            curso: widget._currentCurso,
            matricula: txtMatricula.text,
            periodo: (txtPeriodo.text.isEmpty)? null:int.parse(txtPeriodo.text),
            estado: txtEstado.text,
            cidade: txtCidade.text,
            bairro: txtBairro.text,
            uid: uid,
          ),
        );
        await showDialog(
          context: (context),
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side:
                  BorderSide(color: Color.fromRGBO(17, 0, 119, 1.0), width: 5),
            ),
            title: Text("USUÁRIO CADASTRADO"),
          ),
        );
        Navigator.pop(context);
      }
    }
  }

  _getUID(String email, String passwd) async {
    dynamic result = await authService.signInEmailPasswd(email, passwd);
    uid = result.uid;
  }

  _dialog(String campoObrigatorio) async {
    return showDialog(
      context: (context),
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: Color.fromRGBO(17, 0, 119, 1.0), width: 5),
        ),
        title: Text("Preencha o campo $campoObrigatorio"),
      ),
    );
  }
}

class UpperCase extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
