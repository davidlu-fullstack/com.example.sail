class User {
  final String userId;
  final String email;
  final String userType; //![1]
  final String userState; //![2]

  User({this.userId, this.email, this.userType, this.userState});

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
      'userType': userType, //![1]
      'userState': userState //![2]
    };
  }

  User.fromFirestore(Map<String, dynamic> firestore)
      : userId = firestore['userId'],
        email = firestore['email'],
        userType = firestore['userType'], //![1]
        userState = firestore['userState']; //![2];
}
