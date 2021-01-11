
import 'package:flutter/material.dart';
import 'package:tumbaso_warung/src/bloc/memberBloc.dart';
import 'package:tumbaso_warung/src/pref/preferences.dart';
import 'package:tumbaso_warung/src/ui/utils/colorses.dart';
import 'package:tumbaso_warung/src/ui/utils/loading.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passwordVisible = true;
  bool _validate = false;
  var _username = TextEditingController();
  var _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: colorses.background,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SafeArea(
                child: Container(height: 200,
                  margin: EdgeInsets.only(top: 12),
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset("assets/baru2.png"),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.amber[200],
                  borderRadius: BorderRadius.circular(29),
                ),
                child: TextField(
                  controller: _username,
                  cursorColor: colorses.dasar,
                  decoration: InputDecoration(
                    hintText: "Username",
                    icon: Icon(
                      Icons.person,
                      color: colorses.dasar,
                    ),
                    border: InputBorder.none,
                    errorText: _username.text.length < 3 && _validate
                        ? 'Username harus diisi !'
                        : null,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.amber[200],
                  borderRadius: BorderRadius.circular(29),
                ),
                child: TextField(
                  obscureText: passwordVisible,
                  controller: _password,
                  cursorColor: colorses.dasar,
                  decoration: InputDecoration(
                    hintText: "Password",
                    icon: Icon(
                      Icons.lock,
                      color: colorses.dasar,
                    ),
                    suffix: IconButton(
                      icon: Icon(passwordVisible ? Icons.visibility_off : Icons.visibility,),
                      color: colorses.dasar,
                      onPressed: (){
                        this.setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                    errorText: _password.text.length < 3 && _validate
                        ? 'Password harus diisi !'
                        : null,
                    border: InputBorder.none,
                  ),
                  // onChanged: (value){
                  //   FocusScope.of(context).requestFocus(new FocusNode());
                  // },
                ),
              ),
              SizedBox(height: 12,),
              InkWell(
                onTap: (){
                  if(_username.text.isEmpty || _password.text.isEmpty){
                    setState(() {
                      _validate= true;
                    });
                  } else {
                    Dialogs.showLoading(context, "Loading");
                    blocMember.login(_username.text, _password.text);
                    blocMember.ResLogin.listen((value) {
                      if(value.status){
                        Dialogs.dismiss(context);
                        setToken(value.data.idToken);
                        setKdUser(value.data.username);
                        setNama(value.data.namaLengkap);
                        Navigator.of(context).pushNamedAndRemoveUntil('/controllerPage', (route) => false);
                      } else {
                        Dialogs.dismiss(context);
                      }
                    });
                  }
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      color: colorses.dasar,
                      borderRadius: BorderRadius.circular(29),
                    ),
                    child: Center(child: Text("LOGIN",style: TextStyle(color: Colors.white),))
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
