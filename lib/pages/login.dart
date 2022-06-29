import 'package:flutter/material.dart';
import 'package:lasei/authentication.dart';
import 'package:lasei/homepage.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;
  bool _isVisible = false;
  bool _logining = false;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    _autologin(context);
    return ModalProgressHUD(
        inAsyncCall: _logining,
        opacity: 0.6,
        color: Colors.black,
        child: SingleChildScrollView(
            reverse: true,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 60,
                  width: 200,
                ),
                const Image(
                  image: AssetImage('assets/sei.png'),
                ),

                // Wrong Password text
                Visibility(
                  visible: _isVisible,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      "Login incorrecto",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),

                // Textfields for username and password fields
                Container(
                  height: 140,
                  width: 530,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onTap: () {
                          setState(() {
                            _isVisible = false;
                          });
                        },
                        controller:
                            usernameController, // Controller for Username
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Email",
                            contentPadding: EdgeInsets.all(20)),
                        onEditingComplete: () =>
                            FocusScope.of(context).nextFocus(),
                      ),
                      const Divider(
                        thickness: 3,
                      ),
                      TextFormField(
                        onTap: () {
                          setState(() {
                            _isVisible = false;
                          });
                        },

                        controller:
                            passwordController, // Controller for Password
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Contraseña",
                            contentPadding: const EdgeInsets.all(20),
                            // Adding the visibility icon to toggle visibility of the password field
                            suffixIcon: IconButton(
                              icon: Icon(_isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            )),
                        obscureText: _isObscure,
                      ),
                    ],
                  ),
                ),

                // Submit Button
                Container(
                  width: 570,
                  height: 70,
                  padding: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.pink),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0))),
                      ),
                      //color: Colors.pink,
                      child: const Text("Conectar",
                          style: TextStyle(color: Colors.white)),
                      /* shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)), */
                      onPressed: () {
                        setState(() => _logining = true);
                        auth
                            .fetchCredentials(usernameController.text,
                                passwordController.text)
                            .then((value) => {
                                  if (auth.loginok)
                                    {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomePage()),
                                        (Route<dynamic> route) => false,
                                      )
                                    }
                                  else
                                    {
                                      setState(() {
                                        _isVisible = true;
                                        _logining = false;
                                      })
                                    }
                                });
                      }),
                ),

                // Recuperar contraseña
                Container(
                    padding:
                        const EdgeInsets.only(top: 40, left: 20, right: 20),
                    child: GestureDetector(
                        onTap: () => launchUrl(
                            Uri.parse('https://app.lasei.es/recuperar.php')),
                        child: const Center(
                            child: Text(
                          "Reestablecer contraseña",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ))))
              ],
            )));
  }

  void _autologin(context) async {
    final SharedPreferences prefs = await _prefs;
    if (prefs.containsKey('usuario') && (prefs.containsKey('contras'))) {
      final String usuario = prefs.getString('usuario').toString();
      final String contras = prefs.getString('contras').toString();
      auth.fetchCredentials(usuario, contras).then((value) => {
            if (auth.loginok)
              {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (Route<dynamic> route) => false,
                )
              }
          });
    }
  }
}
