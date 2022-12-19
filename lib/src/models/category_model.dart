class Category {
  int? id;
  String? nombre;
  Category({this.id, this.nombre});
  Category.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nombre = map['nombre'];
  }
}
