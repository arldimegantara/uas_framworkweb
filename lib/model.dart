class Person {
  final String id;
  final String nama;
  final String keterangan;

  const Person({
    required this.id,
    required this.nama,
    required this.keterangan,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      nama: json['nama'],
      keterangan: json['keteragan'],
    );
  }
}