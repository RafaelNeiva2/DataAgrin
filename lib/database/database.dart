import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:convert';
part 'database.g.dart';


enum Status { pendente, emAndamento, finalizada }


@DataClassName('WeatherCache')
class WeatherCaches extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get jsonData => text()();
  DateTimeColumn get lastUpdated => dateTime()();
}

class Tarefas extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nome => text().withLength(min: 1, max: 100)();
  TextColumn get talhao => text().named('talhao_ou_area')();
  DateTimeColumn get horaPrevista => dateTime()();
  IntColumn get status => intEnum<Status>()();
}

@DriftDatabase(tables: [Tarefas, WeatherCaches])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Stream<List<Tarefa>> watchAllTarefas() => select(tarefas).watch();

  Future<int> addTarefa(TarefasCompanion entry) {
    return into(tarefas).insert(entry);
  }

  Future<bool> updateTarefa(TarefasCompanion entry) {
    return update(tarefas).replace(entry);
  }

  Future<int> deleteTarefa(int id) {
    return (delete(tarefas)..where((t) => t.id.equals(id))).go();
  }

  Future<WeatherCache?> getLastWeather() =>
      (select(weatherCaches)..orderBy([(t) => OrderingTerm.desc(t.lastUpdated)]))
          .getSingleOrNull();

  Future<void> cacheWeather(String json) {
    return transaction(() async {
      await delete(weatherCaches).go();
      await into(weatherCaches).insert(
        WeatherCachesCompanion.insert(
          jsonData: json,
          lastUpdated: DateTime.now(),
        ),
      );
    });
  }
}


LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}