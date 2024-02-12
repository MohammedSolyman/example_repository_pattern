import 'package:my_repository/providers/my_provider.dart';

abstract class Repo {
  getData();
}

class MyRepo implements Repo {
  MyProvider myProvider;
  MyRepo(this.myProvider);

  @override
  Future<dynamic> getData() async {
    return await myProvider.myFun();
  }
}
