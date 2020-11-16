import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  final googleSignIn = GoogleSignIn();
  final auth = FirebaseAuth.instance;

  ensureLoggedIn() async {
    GoogleSignInAccount user = googleSignIn.currentUser;
    if (user == null) user = await googleSignIn.signInSilently();
    if (user == null) user = await googleSignIn.signIn();
    if (await auth.currentUser == null) {
      GoogleSignInAuthentication credentials =
          await googleSignIn.currentUser.authentication;
      await auth.signInWithCustomToken(credentials.accessToken);
    }
  }
}
