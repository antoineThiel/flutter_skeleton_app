import 'package:flutter/material.dart';
import 'package:flutter_skeleton_app/components/buttons/large_text_button_decoration.dart';
import 'package:flutter_skeleton_app/pages/login_page.dart';
import 'package:flutter_skeleton_app/services/graphql/graphql_api.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import '../services/states/authentication_state.dart';
import '../components/text_field.dart';
import '../main.dart';
import '../services/graphql/graphql_routes.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String username = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    "Create Account,",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    "Sign up to get started!",
                    style: TextStyle(fontSize: 20, color: Colors.grey.shade400),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  MyTextField(
                    labelText: "Full Name",
                    onchanged: (value) => username = value,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  MyTextField(
                    labelText: "Email",
                    onchanged: (value) => email = value,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  MyTextField(
                    labelText: "Password",
                    obscureText: true,
                    onchanged: (value) => password = value,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 50,
                    child: TextButton(
                        onPressed: () async {
                          GraphQLClient client = GraphQLProvider.of(context).value;
                          bool isRegistered = await GraphQLApi.register(
                              email: email,
                              username: username,
                              password: password,
                              client: client);
                          if (isRegistered) {
                            String token = await GraphQLApi.authenticate(
                                email: email,
                                password: password,
                                client: client);
                            if (!mounted) return;
                            if (token.isNotEmpty){
                              Provider.of<AuthenticationState>(context, listen: false).authenticate(token);
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return const MyHomePage();
                                })
                              );
                            }
                          }
                        },
                        child: const LargeTextButtonDecoration(title: "Sign in")),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "I'm already a member.",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const LoginPage();
                        }));
                      },
                      child: const Text(
                        "Sign in.",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
