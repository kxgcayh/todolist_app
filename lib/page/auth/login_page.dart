import 'package:checklist_app/data/models/login_model.dart';
import 'package:checklist_app/data/providers/authentication_provider.dart';
import 'package:checklist_app/data/repositories/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final txtUsername = useTextEditingController(text: '');
    final txtPassword = useTextEditingController(text: '');
    final isFilled = useState(false);

    bool areFormFilled() {
      isFilled.value = txtUsername.text != '' && txtPassword.text != '';
      return isFilled.value;
    }

    return Scaffold(
      appBar: AppBar(title: 'Login Page'.text.make()),
      body: VStack([
        VStack([
          TextFormField(
            controller: txtUsername,
            decoration: InputDecoration(
              label: 'Username'.text.make(),
            ),
            onChanged: (_) => areFormFilled(),
          ),
          TextFormField(
            controller: txtPassword,
            decoration: InputDecoration(
              label: 'Password'.text.make(),
            ),
            onChanged: (_) => areFormFilled(),
          ),
        ]).px(28),
        VStack([
          ElevatedButton(
            onPressed: isFilled.value
                ? () async {
                    LoginModel response;
                    response = await ref.read(authProvider).login(
                          username: txtUsername.value.text,
                          password: txtPassword.value.text,
                        );
                    if (response.statusCode != 2110) {
                      print('${response.errorMessage}');
                    } else {
                      final repo = ref.read(authenticationRepository);
                      repo.login(txtUsername.value.text, response.data!.token);
                      context.vxNav.replace(Uri(path: '/todos/list'));
                    }
                  }
                : null,
            child: 'LOGIN'.text.make(),
          ),
          TextButton(
            onPressed: () => context.vxNav.clearAndPush(Uri(path: '/register')),
            child: 'REGISTER'.text.make(),
          ),
        ]).objectCenter(),
      ]).scrollVertical(),
    );
  }
}
