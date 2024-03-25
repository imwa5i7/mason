import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{project_name.snakeCase()}}/domain/repository/user_repo.dart';
import 'package:{{project_name.snakeCase()}}/data/repository/user_repo_impl.dart';

final userRepo = Provider<UserRepo>((ref) => UserRepoImpl());
