class ThriftUser {
  late String uid, name, email;
  late String? profileImg;

  ThriftUser({
    required this.email,
    required this.name,
    required this.uid,
    this.profileImg,
  });
}
