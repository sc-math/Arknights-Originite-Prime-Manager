import 'package:arknights_gerenciador/components/event.dart';
import 'package:arknights_gerenciador/data/db.dart';
import 'package:sqflite/sqflite.dart';

class EventDao {

  //Variaveis
  static const _tablename = 'eventTable';
  static const _name = 'nome';
  static const _image = 'imagem';
  static const _originite = 'originite';
  static const _skins = 'skins';
  static const _skinsPrices = 'skinsPrices';

  //Tabela
  static const String tableSql = 'CREATE TABLE $_tablename('
      '$_name TEXT PRIMARY KEY,'
      '$_image TEXT,'
      '$_originite INTEGER,'
      '$_skins INTEGER,'
      '$_skinsPrices INTEGER)';

  //Funções do Banco de Dados

  save(Event evento) async {
    print('Acessando o save: ');

    final Database db = await getDatabase();

    var itemExists = await find(evento.name);
    Map<String, dynamic> eventMap = toMap(evento);

    if (itemExists.isEmpty) {
      print('O evento não existia.');

      return await db.insert(_tablename, eventMap);
    } else {
      print('O evento já existia');

      return await db.update(_tablename, eventMap,
          where: '$_name = ?', whereArgs: [evento.name]);
    }
  }

  Future<List<Event>> findAll() async {
    print('Acessando o findAll: ');

    final Database db = await getDatabase();

    final List<Map<String, dynamic>> result = await db.query(_tablename);

    print('Procurando dados no banco de dados... encontrado: $result');

    return toList(result);
  }

  Future<List<Event>> find(String nomeDoEvento) async {
    print('Acessando find:');

    final Database db = await getDatabase();

    final List<Map<String, dynamic>> result = await db
        .query(_tablename, where: '$_name = ?', whereArgs: [nomeDoEvento]);

    print('Evento encontrado: ${toList(result)}');

    return toList(result);
  }

  delete(String nomeDoEvento) async {
    print('Deletando uma Tarefa: $nomeDoEvento');

    final Database db = await getDatabase();

    return db.delete(
      _tablename,
      where: '$_name = ?',
      whereArgs: [nomeDoEvento],
    );
  }

  //Conversores List <~~> Map

  List<Event> toList(List<Map<String, dynamic>> eventMap) {
    print('Convertendo to List:');

    final List<Event> eventList = [];

    for (Map<String, dynamic> row in eventMap) {
      final Event event = Event(
          name: row[_name],
          image: row[_image],
          originite: row[_originite],
          skins: row[_skins],
          skinsPrices: row[_skinsPrices]);
      eventList.add(event);
    }

    print('Lista de Eventos $eventList');

    return eventList;
  }

  Map<String, dynamic> toMap(Event event) {
    print('Convertendo to Map:');

    final Map<String, dynamic> eventMap = {};

    eventMap[_name] = event.name;
    eventMap[_image] = event.image;
    eventMap[_originite] = event.originite;
    eventMap[_skins] = event.skins;
    eventMap[_skinsPrices] = event.skinsPrices;

    print('Mapa de Eventos: $eventMap');

    return eventMap;
  }

}
