import 'repositories.dart';

enum RepoType { MOCK, PROD }

class Injector {
  static final Injector _singleton = Injector._internal();

  static RepoType _repoType;

  static void configure(RepoType repoType) {
    _repoType = repoType;
  }

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  TodoRepo get todoRepo {
    switch (_repoType) {
      case RepoType.MOCK:
        return TodoRepoImpl();
      default:
        return TodoRepoImpl();
    }
  }

  UserRepo get userRepo {
    switch(_repoType) {
      case RepoType.MOCK:
        return UserRepoImpl();
      case RepoType.PROD:
        return UserRepoImpl();
    }
  }
}