import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_review/models/emp_model.dart';

class EmpFileStore {

  // ignore: unnecessary_string_escapes
  static const String _filePath = 'E:\flutter_review\lib\core\file_storage\employees.txt';

  Future<File> _file() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(path.join(dir.path, _filePath));
    await file.parent.create(recursive: true);
    return file;
  }

  Future<List<EmpModel>> loadEmployees() async {
    final file = await _file();
    if (!await file.exists()) return [];
    final lines = await file.readAsLines();
    final items = <EmpModel>[];

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i].trim();
      if (line.isEmpty) continue;
      
      if (i == 0 && line.toLowerCase().startsWith('id\t')) continue;

      final parts = line.split('\t');

      final id = parts.isNotEmpty ? int.tryParse(parts[0]) : null;
      final name = parts.length > 1 ? parts[1] : '';
      final age = parts.length > 2 ? (int.tryParse(parts[2]) ?? 0) : 0;
      final position = parts.length > 3 ? parts[3] : '';

      items.add(EmpModel(id: id, name: name, age: age, position: position));
    }
    return items;
  }

  Future<void> saveAll(List<EmpModel> employees) async {
    final file = await _file();
    final buf = StringBuffer();
    buf.writeln('id\tname\tage\tposition'); 
    for (final emp in employees) {
      final safeName = emp.name.replaceAll('\t', ' ').replaceAll('\n', ' ');
      final safePos  = emp.position.replaceAll('\t', ' ').replaceAll('\n', ' ');
      final idStr = (emp.id ?? '').toString();
      buf.writeln('$idStr\t$safeName\t${emp.age}\t$safePos');
    }
    await file.writeAsString(buf.toString());
  }
}
