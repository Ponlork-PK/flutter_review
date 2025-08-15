class EmpModel {
  final String name;
  final int age;
  final String position;

  EmpModel({required this.name, required this.age, required this.position});

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'age': age,
      'position': position,
    };
  }

  factory EmpModel.fromMap(Map<String, dynamic> map) {
    return EmpModel(
      name: map['name'],
      age: map['age'],
      position: map['position'],
    );
  }
}


