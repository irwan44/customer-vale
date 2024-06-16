
import 'package:customer_bengkelly/app/modules/authorization/router/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../componen/authentication_ui.dart';
import '../componen/forget_password.dart';
import '../componen/login_page.dart';
import '../componen/new_password.dart';
import '../componen/password_changed.dart';
import '../componen/signup_page.dart';

final router = GoRouter(routes: [
  GoRoute(
    path: Routers.authenticationpage.path,
    name: Routers.authenticationpage.name,
    pageBuilder: (context, state) {
      return const CupertinoPage(child: AuthenticationUI());
    },
  ),
  GoRoute(
    path: Routers.loginpage.path,
    name: Routers.loginpage.name,
    pageBuilder: (context, state) {
      return const CupertinoPage(child: LoginPage());
    },
  ),
  GoRoute(
    path: Routers.signuppage.path,
    name: Routers.signuppage.name,
    pageBuilder: (context, state) {
      return const CupertinoPage(child: SignupPage());
    },
  ),
  GoRoute(
    path: Routers.forgetpassword.path,
    name: Routers.forgetpassword.name,
    pageBuilder: (context, state) {
      return const CupertinoPage(child: ForgetPasswordPage());
    },
  ),
  GoRoute(
    path: Routers.newpassword.path,
    name: Routers.newpassword.name,
    pageBuilder: (context, state) {
      return const CupertinoPage(child: NewPasswordPage());
    },
  ),
  GoRoute(
    path: Routers.passwordchanges.path,
    name: Routers.passwordchanges.name,
    pageBuilder: (context, state) {
      return const CupertinoPage(child: PasswordChangesPage());
    },
  )
]);
