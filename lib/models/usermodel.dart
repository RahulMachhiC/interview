class Users {
  final int id;
  final String firstname;
  final String lastname;
  final String username;
  final String email;
  final String password;
  final String confirmationpassword;

  const Users(
      {required this.id,
      required this.firstname,
      required this.lastname,
      required this.username,
      required this.email,
      required this.password,
      required this.confirmationpassword});

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Users.fromMap(Map<String, dynamic> result)
      : id = result["id"],
        firstname = result["firstname"],
        lastname = result["lastname"],
        username = result["username"],
        email = result["email"],
        password = result["password"],
        confirmationpassword = result["confirmationpassword"];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'username': username,
      'email': email,
      'password': password,
      'confirmationpassword': confirmationpassword,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Users{id: $id, firstname: $firstname, lastname: $lastname, username: $username, email:$email, password: $password, confirmationpassword:$confirmationpassword}';
  }
}
