import 'package:atividadeintegradora8/custompaint.dart';
import 'package:atividadeintegradora8/models/relatorio.dart';
import 'package:atividadeintegradora8/repository/datarelatorio.dart';
import 'package:flutter/material.dart';

class Etapa3 extends StatefulWidget {
  bool checked1 = false;
  bool checked2 = false;
  Relatorio relatorio;

  Etapa3(this.relatorio);

  @override
  _Etapa3State createState() => _Etapa3State();
}

class _Etapa3State extends State<Etapa3> {
  RelatorioRepository relatorioRepository = new RelatorioRepository();

  @override
  Widget build(BuildContext context) {
    double leftRight = MediaQuery.of(context).size.width * 0.0444;

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
            child: _corpo(),
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

  Widget _corpo() {
    double heightContainer = MediaQuery.of(context).size.height * 0.0375;
    return Column(
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
            "Etapa 3",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
        SizedBox(height: 250),
        Text(
          "Mora ou trabalha com alguém que apresentou diagnóstico positivo para Covid-19, nos últimos 15 dias ?",
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 20),
        _check(),
        SizedBox(height: 50),
        Stack(
          children: [
            CustomPaint(
              painter: Fundo(),
            ),
            _botaoProximo(),
          ],
        ),
      ],
    );
  }

  Widget _check() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              offset: Offset(0.3, 1.0),
              blurRadius: 4,
              spreadRadius: 1,
              color: Colors.black.withOpacity(0.25)),
        ],
      ),
      child: Column(
        children: [
          _checkBoxListTile(1, "Sim"),
          _checkBoxListTile(2, "Não"),
        ],
      ),
    );
  }

  Widget _checkBoxListTile(int i, String txt) {
    bool value;
    (i == 1) ? value = widget.checked1 : value = widget.checked2;

    return CheckboxListTile(
      activeColor: Color.fromRGBO(76, 64, 153, 1.0),
      controlAffinity: ListTileControlAffinity.leading,
      value: value,
      onChanged: (bool newValue) {
        setState(() {
          value = newValue;
          (i == 1) ? widget.checked1 = value : widget.checked2 = newValue;
        });
      },
      title: Text(
        "$txt",
        style: TextStyle(fontSize: 17),
      ),
    );
  }

  Widget _botaoProximo() {
    return Container(
      width: 250,
      height: 40,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 30),
            Text(
              "Próxima etapa",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            SizedBox(width: 20),
            Icon(
              Icons.arrow_forward,
              size: 30,
              color: Colors.white,
            ),
          ],
        ),
        onPressed: () async {
          if (widget.checked1 == true) {
            await _update();
            await showDialog(
              context: (context),
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(color: Colors.deepOrange, width: 10),
                ),
                title: Text(
                    "Você pode estar infectado pelo novo coronavírus, mesmo que não tenha nenhum sintoma. É muito importante que você use máscara sempre e mantenha o distanciamento social para sua proteção e para proteção das outras pessoas. Se apresentar algum sintoma, como tosse, falta de ar, dor de garganta e alteração do olfato ou paladar, procure atendimento médico."),
              ),
            );
          }
          await _update();
        },
      ),
    );
  }

  Future _update() {
    String dia = DateTime.now().day.toString();
    String mes = DateTime.now().month.toString();
    String ano = DateTime.now().year.toString();
    (widget.checked1 == true)
        ? widget.relatorio.moraOuTrabalha = true
        : widget.relatorio.moraOuTrabalha = false;
    widget.relatorio.data = dia + "/" + mes + "/" + ano;
    relatorioRepository.addRelatorio(widget.relatorio);
  }
}
