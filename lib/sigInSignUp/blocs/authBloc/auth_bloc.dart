import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interviewapp/repository/user_repository.dart';
import 'package:interviewapp/sigInSignUp/blocs/authBloc/auth_events.dart';
import 'package:interviewapp/sigInSignUp/blocs/authBloc/auth_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(AuthenticationInitial initialState) : super(initialState);

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    UserRepository? userRepository;

    if(event is AuthenticationStarted){
      try {
        yield AuthenticationLoading();
        var isSignedIn = await userRepository!.isSignedIn();
        if(isSignedIn){
          var user = await userRepository.getCurrentUser();
          yield AuthenticationSuccess(user: user);
        }else{
          yield const AuthenticationFailure(error: "Something Went Wrong");
        }
      } catch (e) {
        yield AuthenticationFailure(error: e.toString());
      }
    }

    if (event is SignUpButtonEvent) {
      try {
        yield AuthenticationLoading();
        UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: event.email, password: event.password);
        user = userCredential.user;
        yield AuthenticationSuccess(user: user);
      } catch (e) {
        yield AuthenticationFailure(error: e.toString());
      }
    }

    if (event is LoginButtonEvent) {
      try {
        yield AuthenticationLoading();
        UserCredential userCredential = await auth.signInWithEmailAndPassword(email: event.email, password: event.password);
        user = userCredential.user;
        yield AuthenticationSuccess(user: user);
      } catch (e) {
        yield AuthenticationFailure(error: e.toString());
      }
    }
  }
}
