class User {
  String username;
  String password;

  User({required this.username, required this.password});
}

final List<User> userList = [
  User(username: 'abc', password: '123'),
  User(username: 'wowo', password: '456'),
  User(username: 'wiwi', password: '789'),
];
