import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  String email;
  String password;
  AuthService({this.email, this.password});
  final FirebaseAuth _auth = FirebaseAuth.instance;

//sign in with email and password

  void login() async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: this.email,
        password: this.password,
      ))
          .user;
      print(user);
    } catch (e) {
      print("error $e ");
    }
  }

//register with email and password
// void _register() async {
//     final User user = (await _auth.createUserWithEmailAndPassword(
//       email: _emailController.text,
//       password: _passwordController.text,
//     ))
//         .user;
//     if (user != null) {
//       setState(() {
//         _success = true;
//         _userEmail = user.email;
//       });
//     } else {
//       _success = false;
//     }
//   }
// }
//sgin out

  void signOut() async {
    await _auth.signOut();
  }
}
