import 'package:arknights_gerenciador/data/event_dao.dart';
import 'package:arknights_gerenciador/screens/initial_screen.dart';
import 'package:flutter/material.dart';

class Event extends StatefulWidget {
  final String name;
  final String image;
  final int originite;
  final int skins;
  final int skinsPrices;
  final saldo;

  Event(
      {this.saldo,
      required this.name,
      required this.image,
      required this.originite,
      required this.skins,
      required this.skinsPrices,
      Key? key})
      : super(key: key);

  @override
  State<Event> createState() => _EventState();
}

class _EventState extends State<Event> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 7,
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.black.withAlpha(30),
          onTap: () {
            EventDao().delete(widget.name);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Evento Deletado!'),
              ),
            );
            debugPrint('Cartao Tapped');
          },
          child: SizedBox(
            height: 220,
            width: 370,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 130,
                  width: 370,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white),
                  child: Container(
                      child: Image.asset(widget.image, fit: BoxFit.cover)),
                ),
                Container(
                  height: 90,
                  width: 370,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 370,
                          child: Text(
                            widget.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 24,
                              overflow: TextOverflow.ellipsis,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  height: 30,
                                  child: Row(
                                    children: [
                                      Text("${widget.originite}"),
                                      Image.asset(
                                        'assets/DIAMOND.webp',
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                child: Text("${widget.skins} Skins"),
                              ),
                              SizedBox(
                                height: 30,
                                child: Row(
                                  children: [
                                    Text("Saldo: ${widget.saldo}"),
                                    Image.asset(
                                      'assets/DIAMOND.webp',
                                      fit: BoxFit.cover,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
