import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class EstufaInteligenteFirebaseUser {
  EstufaInteligenteFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

EstufaInteligenteFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<EstufaInteligenteFirebaseUser> estufaInteligenteFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<EstufaInteligenteFirebaseUser>(
      (user) {
        currentUser = EstufaInteligenteFirebaseUser(user);
        return currentUser!;
      },
    );
