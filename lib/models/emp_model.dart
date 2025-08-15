class EmpModel {
  final int? id;
  final String name;
  final int age;
  final String position;

  EmpModel({ this.id, required this.name, required this.age, required this.position});

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'name': name,
      'age': age,
      'position': position,
    };
  }

  factory EmpModel.fromMap(Map<String, dynamic> map) {
    return EmpModel(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      position: map['position'],
    );
  }
}


