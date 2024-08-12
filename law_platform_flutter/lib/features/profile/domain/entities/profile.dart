abstract class Profile {
  final int id;
  final String name;
  final String email;
  final String? profilePicture;

  Profile({
    required this.id,
    required this.name,
    required this.email,
    required this.profilePicture,
  });
}
