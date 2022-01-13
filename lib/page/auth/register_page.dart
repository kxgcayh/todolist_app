import 'package:checklist_app/data/models/login_model.dart';
import 'package:checklist_app/data/models/register_model.dart';
import 'package:checklist_app/data/providers/authentication_provider.dart';
import 'package:checklist_app/data/repositories/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

class RegisterPage extends HookConsumerWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final txtUsername = useTextEditingController(text: '');
    final txtEmail = useTextEditingController(text: '');
    final txtPassword = useTextEditingController(text: '');
    final isFilled = useState(false);

    bool areFormFilled() {
      isFilled.value = txtUsername.text != '' &&
          txtPassword.text != '' &&
          txtEmail.text != '';
      return isFilled.value;
    }

    return Scaffold(
      appBar: AppBar(title: 'Register Page'.text.make()),
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
            controller: txtEmail,
            decoration: InputDecoration(
              label: 'Email'.text.make(),
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
                    RegistrationModel response;
                    response = await ref.read(authProvider).register(
                          username: txtUsername.value.text,
                          email: txtEmail.value.text,
                          password: txtPassword.value.text,
                        );
                    if (response.statusCode != 2000) {
                      print('${response.errorMessage}');
                    } else {
                      context.vxNav.clearAndPush(Uri(path: '/'));
                    }
                  }
                : null,
            child: 'REGISTER'.text.make(),
          ),
          TextButton(
            onPressed: () => context.vxNav.clearAndPush(Uri(path: '/')),
            child: 'LOGIN'.text.make(),
          ),
        ]).objectCenter(),
      ]).scrollVertical(),
    );
  }
}
