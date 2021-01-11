
import 'package:rxdart/rxdart.dart';
import 'package:tumbaso_warung/src/models/login.dart';
import 'package:tumbaso_warung/src/resources/repositories.dart';

class MemberBloc {
  final _repository = Repositories();
  final _loginFetcher = PublishSubject<Login>();

  PublishSubject<Login> get ResLogin => _loginFetcher.stream;

  login(String username, String password) async {
    Login getResLogin = await _repository.login(username, password);
    _loginFetcher.sink.add(getResLogin);
  }

  dispose(){
    _loginFetcher.close();
  }
}

final blocMember = MemberBloc();