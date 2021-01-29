
import 'package:rxdart/rxdart.dart';
import 'package:tumbaso_warung/src/models/getProdukModel.dart';
import 'package:tumbaso_warung/src/models/getStatusModel.dart';
import 'package:tumbaso_warung/src/models/resLoginModel.dart';
import 'package:tumbaso_warung/src/models/resUpdateStatusTokoModel.dart';
import 'package:tumbaso_warung/src/resources/repositories.dart';

class MemberBloc {
  final _repository = Repositories();
  final _loginFetcher = PublishSubject<ResLoginModel>();
  final _statusFetcher = PublishSubject<GetStatusModel>();
  final _updateStatusTokoFetcher = PublishSubject<ResUpdateStatusTokoModel>();
  final _getProdukFetcher = PublishSubject<GetProdukModel>();

  PublishSubject<ResLoginModel> get resLogin => _loginFetcher.stream;
  PublishSubject<GetStatusModel> get getStatus => _statusFetcher.stream;
  PublishSubject<ResUpdateStatusTokoModel> get resStatusToko => _updateStatusTokoFetcher.stream;
  PublishSubject<GetProdukModel> get listProduk => _getProdukFetcher.stream;

  login(String username, String password) async {
    ResLoginModel getResLogin = await _repository.login(username, password);
    _loginFetcher.sink.add(getResLogin);
  }

  status(String idPenjual) async {
    GetStatusModel getStatusModel = await _repository.status(idPenjual);
    _statusFetcher.sink.add(getStatusModel);
  }

  updateStatusToko(String username, String status,String token) async {
    ResUpdateStatusTokoModel resUpdateStatusTokoModel = await _repository.updateStatusToko(username, status, token);
    _updateStatusTokoFetcher.sink.add(resUpdateStatusTokoModel);
  }

  getProduk(String username,String idPenjual,String token) async {
    GetProdukModel getProdukModel = await _repository.getProduk(username, idPenjual, token);
    _getProdukFetcher.sink.add(getProdukModel);
  }


  dispose(){
    _loginFetcher.close();
    _statusFetcher.close();
    _updateStatusTokoFetcher.close();
    _getProdukFetcher.close();
  }
}

final blocMember = MemberBloc();