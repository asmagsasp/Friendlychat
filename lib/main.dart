import 'package:flutter/material.dart';

void main() {
  runApp(new FriendlychatApp());
}

class FriendlychatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Friendlychat",
      home: new ChatScreen(),
    );
  }
}

// Modify the ChatScreen class definition to extend StatefulWidget.

class ChatScreen extends StatefulWidget {
  @override
  State createState() => new ChatScreenState();

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Friendlychat"),
      ),
    );
  }
}

// Add the ChatScreenState class definition in main.dart.
class ChatScreenState extends State<ChatScreen> {
  // Para gerenciar as interações com o campo de texto
  final TextEditingController _textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Friendlychat"),
      ),
      body: _buildTextComposer(),
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear;
  }

  //
  //    Adicione um TextFieldwidget e configure-o da seguinte forma para gerenciar as interações do usuário:

  //    Para ter controle sobre o conteúdo do campo de texto, forneceremos ao TextFieldconstrutor um TextEditingController.
  //    Este controlador também pode ser usado para limpar o campo ou ler seu valor.
  //    Para ser notificado quando o usuário enviar uma mensagem, use o onSubmittedargumento para fornecer um método de retorno de chamada particular _handleSubmitted().
  //    Por enquanto, esse método apenas limpará o campo e, posteriormente, adicionaremos mais código para enviar a mensagem. Defina este método da seguinte maneira:
  //

  Widget _buildTextComposer() {
    return new IconTheme(
        data: IconThemeData(color: Theme.of(context).accentColor),
        child: new Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: new Row(
                children: <Widget>[
              new Flexible(
                child: TextField(
                  controller: _textController,
                  onSubmitted: _handleSubmitted,
                  decoration:
                      new InputDecoration.collapsed(hintText: "Send a message"),
                ),
              ),
              new Container(
                  margin: new EdgeInsets.symmetric(horizontal: 4.0),
                  child: new IconButton(
                      icon: new Icon(Icons.send),
                      onPressed: () => _handleSubmitted(_textController.text))),
            ]
            )
        )
    );
  }
}
