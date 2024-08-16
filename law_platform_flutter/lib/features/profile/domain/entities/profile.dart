abstract class Profile {
  final int id;
  final String name;
  final String email;
  final String accountType;
  final String? profilePicture;

  Profile({
    required this.id,
    required this.name,
    required this.email,
    required this.accountType,
    required this.profilePicture,
  });
}
