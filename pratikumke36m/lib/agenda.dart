class Agenda {
  final int? id;
  final String judul;
  final String keterangan;
  final DateTime tanggal; // Field baru

  Agenda({
    this.id,
    required this.judul,
    required this.keterangan,
    required this.tanggal,
  });

  factory Agenda.fromJson(Map<String, dynamic> json) {
    return Agenda(
      id: json['id'],
      judul: json['judul'],
      keterangan: json['keterangan'],
      tanggal:
          DateTime.parse(json['tanggal']), // Parsing dari String ke DateTime
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'judul': judul,
      'keterangan': keterangan,
      'tanggal':
          tanggal.toIso8601String(), // Format agar cocok dikirim ke backend
    };
  }
}
