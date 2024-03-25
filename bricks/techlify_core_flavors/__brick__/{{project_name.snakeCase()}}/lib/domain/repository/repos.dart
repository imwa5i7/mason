import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:togo_mobile/data/repository/auth_repo_impl.dart';
import 'package:togo_mobile/data/repository/user_repo_impl.dart';
import 'package:togo_mobile/domain/repository/auth_repo.dart';
import 'package:togo_mobile/domain/repository/user_repo.dart';

final userRepo = Provider<UserRepo>((ref) => UserRepoImpl());
final authRepo = Provider<AuthRepo>((ref) => AuthRepoImpl());
