import 'package:arknights_gerenciador/components/event.dart';
import 'package:arknights_gerenciador/data/event_dao.dart';
import 'package:flutter/material.dart';

import 'form_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);


  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {

  int myOrignite = 18;
  int partialOriginite = 0;

  // Future<void> _showMyDialog() async{
  //   return showDialog<void>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return const AlertDialog(
  //         title: Text("Quantidade de Originite Prime"),
  //         content: SingleChildScrollView(
  //         ),
  //       )
  //     }
  //   )
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Principal"),
        actions: [
          InkWell(
            splashColor: Colors.white.withAlpha(30),
            onTap: () {
              partialOriginite = myOrignite;
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Suas Originites: $myOrignite"),
                  ),
                  SizedBox(
                    width: 30,
                    child: Image.asset(
                      'assets/DIAMOND.webp',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(onPressed: () {
            partialOriginite = myOrignite;
            setState(() {});
          }, icon: const Icon(Icons.update)),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 70),
          child: FutureBuilder<List<Event>>(
            future: EventDao().findAll(),
            builder: (context, snapshot) {
              List<Event>? items = snapshot.data;
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return const Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Text('1'),
                      ],
                    ),
                  );
                case ConnectionState.waiting:
                  return const Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Text('2'),
                      ],
                    ),
                  );
                case ConnectionState.active:
                  return const Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Text('3'),
                      ],
                    ),
                  );
                case ConnectionState.done:
                  if (snapshot.hasData && items != null) {
                    if (items.isNotEmpty) {
                      return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int index) {
                          partialOriginite +=
                              items[index].originite - items[index].skinsPrices;
                          final Event event = Event(
                            name: items[index].name,
                            image: items[index].image,
                            originite: items[index].originite,
                            skins: items[index].skins,
                            skinsPrices: items[index].skinsPrices,
                            saldo: partialOriginite);
                          //items[index];
                          return event;
                        },
                      );
                    }
                    return const Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 128,
                          ),
                          Text(
                            'Não há nenhum Evento',
                            style: TextStyle(fontSize: 32),
                          )
                        ],
                      ),
                    );
                  }
                  return const Text('Erro ao carregar Eventos');
              }
            },
          )
        //Event(name: 'Invitation To Wine Rerun', image: 'assets/maxresdefault.jpg', originite: 0, skins: 0, skinsPrices: 0,),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contextNew) => FormScreen(eventContext: context),
            ),
          ).then((value) =>
              setState(() {
                print('Recarregando a tela inicial');
              }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
