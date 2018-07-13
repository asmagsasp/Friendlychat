import 'package:flutter/material.dart';

const String _name = "Abel Magalhães";

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
class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  // Cria um Array para armazenar as mensagens enviadas
  final List<ChatMessage> _messages = <ChatMessage>[];

  // Para gerenciar as interações com o campo de texto
  final TextEditingController _textController = new TextEditingController();

  // Variavel para controlar a animação
  final AnimationController animationController;

  @override

  void dispose() {
    for(ChatMessage message in _messages)
      message.animationController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Friendlychat"),
        ),
        body: new Column(
          children: <Widget>[
            new Flexible(
              child: new ListView.builder(
                padding: new EdgeInsets.all(8.0),
                reverse: true,
                itemBuilder: (_, int index) => _messages[index],
                itemCount: _messages.length,
              ),
            ),
            new Divider(height: 1.0,),
            new Container(
              decoration: new BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTextComposer(),
            ),
          ],
        ));
  }

  void _handleSubmitted(String text) {
    _textController.clear;
    ChatMessage message = new ChatMessage(
      text: text,
      animationController: new AnimationController(
        duration: new Duration(milliseconds: 500),
        vsync: this,
      )
    );
    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
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
            child: new Row(children: <Widget>[
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
            ])));
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.animationController});

  final String text;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return new SizeTransition(
      sizeFactor: new CurvedAnimation(
        parent: animationController,
        curve: Curves.fastOutSlowIn
      ),
     child: new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: new CircleAvatar(
              child: new Text(_name[0]),
            ),
          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(_name, style: Theme.of(context).textTheme.subhead),
              new Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: Text(text),
              )
            ],
          )
        ],
      ),
    )
    );
  }
}
