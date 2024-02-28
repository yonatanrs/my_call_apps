class LeadModel {
  String? id;
  final String name;
  String? initials;
  double distance;
  final String interactionType; // 'chat', 'call', dll.
  final DateTime lastInteractionTime;
  String? phoneNumber;
  final bool isMissed;
  // Tambahkan properti tambahan yang dibutuhkan oleh LeadDetailsPage
  String? grade;
  List<String>? subjects;
  DateTime? demoDate;
  int? budget;
  int? payment;
  String? qrCodeUrl;
  String? profileImage;

  LeadModel({
    this.id,
    required this.name,
    this.initials,
    required this.interactionType,
    required this.lastInteractionTime,
    this.phoneNumber,
    this.isMissed = false,
    this.distance = 4.7,
    // Inisialisasi properti tambahan dengan parameter yang diperlukan
    this.grade,
    this.subjects,
    this.demoDate,
    this.budget,
    this.payment,
    this.qrCodeUrl,
    this.profileImage,
  });
}
