import 'package:flutter/material.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';

class LoginPage extends StatefulWidget {
  LoginPage({
    Key key,
  }) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email, _password;
  bool _validate = false;
  bool _isObscured = true;
  Color _eyeButtonColor = Colors.grey;
  Padding buildLoginTitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('Login', style: TextStyle(fontSize: 42.8)),
    );
  }

  Padding buildLineUnderLogin() {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, left: 11.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 38.0,
          height: 1.5,
          color: Colors.black,
        ),
      ),
    );
  }

  TextFormField buildEmailTextField() {
    return TextFormField(
      onSaved: (emailInput) => _email = emailInput,
      keyboardType: TextInputType.emailAddress,
      maxLength: 64,
      decoration: InputDecoration(
        labelText: "Email Address",
        hintText: "abcd@abcd.com",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      validator: validateEmail,
    );
  }

  TextFormField buildPasswordTextField(context) {
    return TextFormField(
      onSaved: (passwordInput) => _password = passwordInput,
      keyboardType: TextInputType.text,
      maxLength: 32,
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "........",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        suffixIcon: IconButton(
          onPressed: () {
            if (_isObscured) {
              setState(() {
                _isObscured = false;
                _eyeButtonColor = Theme.of(context).primaryColor;
              });
            } else {
              setState(() {
                _isObscured = true;
                _eyeButtonColor = Colors.grey;
              });
            }
          },
          icon: Icon(
            Icons.remove_red_eye,
            color: _eyeButtonColor,
          ),
        ),
      ),
      validator: validatePassword,
      obscureText: _isObscured,
    );
  }

  Padding buildForgetPassword() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          onTap: () {},
          child: Text('Forget Password',
              style: TextStyle(color: Colors.grey, fontSize: 15.0)),
        ),
      ),
    );
  }

  Align buildLoginButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 50.0,
        width: 280.0,
        child: FlatButton(
          onPressed: () {
            _sendToServer();
          },
          color: Colors.grey[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Text(
            "Login",
            style: Theme.of(context).primaryTextTheme.button,
          ),
        ),
      ),
    );
  }

  Align buildLabelSignInWith() {
    return Align(
      alignment: Alignment.center,
      child: Text(
        "or SignIn with ",
        style: TextStyle(fontSize: 14.0, color: Colors.grey),
      ),
    );
  }

  Container buildSocialIcons(IconData icon, Color iconColor) {
    return Container(
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(30.0),
        child: Icon(icon, color: iconColor),
      ),
      height: 46.0,
      width: 46.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey[600], width: 2.0),
      ),
    );
  }

  Row buildSocialIconsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        buildSocialIcons(
          GroovinMaterialIcons.google,
          Color(0xFF34A853),
        ),
        SizedBox(width: 10),
        buildSocialIcons(GroovinMaterialIcons.facebook, Color(0xFF4267B2)),
        SizedBox(width: 10),
        buildSocialIcons(
          GroovinMaterialIcons.twitter,
          Color(0xFF4285F4),
        )
      ],
    );
  }

  Align buildSignUP() {
    return Align(
      child: InkWell(
        onTap: () {},
        child: RichText(
          text: TextSpan(
            text: 'You Don\'t have an acount? ',
            style: TextStyle(fontSize: 12.0, color: Colors.grey),
            children: <TextSpan>[
              TextSpan(
                text: 'Sign UP',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.grey[800]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _sendToServer() {
    if (_formKey.currentState.validate()) {
      //No error in validation case...
      _formKey.currentState.save();
      print("Email: $_email");
      print("Password: $_password");
    } else {
      setState(() {
        //found error in validation case...
        _validate = true;
      });
    }
  }

  String validateEmail(emailInput) {
    String emailRegExp =
        r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp exp = RegExp(emailRegExp);
    if (emailInput.isEmpty)
      return "Email Address Required";
    else if (!exp.hasMatch(emailInput))
      return "Email is Invalid";
    else
      return null;
  }

  String validatePassword(passwordInput) {
    String passwordRegExp = r'^(?=.*?[a-z])(?=.*?[0-9]).{0,}$';
//    String StrongPassReqExp =
//        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp exp = RegExp(passwordRegExp);
    if (passwordInput.isEmpty)
      return "Password can't empty";
    else if (passwordInput.length < 8)
      return "password must be eight or more characters";
    else if (!exp.hasMatch(passwordInput))
      return "Password must contain combination of numbers and letters";
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        autovalidate: _validate,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(22.0, 0.0, 22.0, 22.0),
          children: <Widget>[
            SizedBox(height: kToolbarHeight),
            buildLoginTitle(),
            buildLineUnderLogin(),
            SizedBox(height: 90.0),
            buildEmailTextField(),
            SizedBox(height: 20.0),
            buildPasswordTextField(context),
            buildForgetPassword(),
            SizedBox(height: 50.0),
            buildLoginButton(context),
            SizedBox(height: 30.0),
            buildLabelSignInWith(),
            SizedBox(height: 15.0),
            buildSocialIconsRow(),
            SizedBox(height: 120),
            buildSignUP()
          ],
        ),
      ),
    );
  }
}
