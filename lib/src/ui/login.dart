import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';
import 'package:tumbaso_warung/src/bloc/memberBloc.dart';
import 'package:tumbaso_warung/src/pref/preferences.dart';
import 'package:tumbaso_warung/src/ui/auth/auth.dart';
import 'package:tumbaso_warung/src/ui/lengkapiProfil.dart';
import 'package:tumbaso_warung/src/ui/utils/colorses.dart';
import 'package:tumbaso_warung/src/ui/utils/loading.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passwordVisible = true;
  // bool _validate = false;
  // var _username = TextEditingController();
  // var _password = TextEditingController();
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  // FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  String tokenUser;

  Future _signIn() async {
    Dialogs.showLoading(context, "Loading...");
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    UserCredential signIn = await signIntoFirebase(googleSignInAccount).catchError((onError) {
      Dialogs.dismiss(context);
      Toast.show(onError.toString(), context, duration: 3, gravity: Toast.BOTTOM);
    });
    blocMember.loginGmail(signIn.user.email, signIn.user.photoURL, signIn.user.displayName, tokenUser);
    blocMember.resLoginGmail.listen((login) {
      if (login.data.telepone != "") {
        Dialogs.dismiss(context);
        Future.delayed(Duration(seconds: 1)).then((value) {
          setToken(login.data.idToken);
          // setKota(login.data.kota.kode);
          setEmail(signIn.user.email);
          setNama(login.data.nama);
          setKdUser(login.data.key.idPenjual);
          setKdPasmak(login.data.key.idPenjualMakmur);
          Navigator.pushReplacementNamed(context, '/controllerPage');
        });
      } else {
        Dialogs.dismiss(context);
        Future.delayed(Duration(seconds: 1)).then((value) {
          Navigator.of(context).pushReplacement(PageTransition(
              settings: const RouteSettings(name: '/lengkapiProfil'),
              type: PageTransitionType.rightToLeft,
              duration: Duration(milliseconds: 400),
              child: LengkapiProfil(
                email: signIn.user.email,
                token: login.data.idToken,
                kdUser: login.data.key.idPenjual,
                nama: login.data.nama,
                kdPasmak : login.data.key.idPenjualMakmur
              )));
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height - 150,
                decoration: BoxDecoration(
                  color: colorses.dasar,
                  borderRadius: BorderRadius.only(bottomRight: Radius.elliptical(180.0, 50.0), bottomLeft: Radius.elliptical(180.0, 50.0)
                )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SafeArea(
                      child: Container(
                        height: 200,
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 7),
                        width: MediaQuery.of(context).size.width,
                        child: SvgPicture.asset(
                            "assets/warung.svg",
                            semanticsLabel: 'Acme Logo'
                        ),
                      ),
                    ),
                    SizedBox(height: 12,),
                    Text(
                      "Aplikasi untuk warung atau toko",
                      style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "di tumbas online dan pasmak",
                      style: TextStyle(fontSize: 18,color: Colors.white),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
              // Container(
              //   margin: EdgeInsets.symmetric(vertical: 10),
              //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              //   width: MediaQuery.of(context).size.width * 0.8,
              //   decoration: BoxDecoration(
              //     color: Colors.amber[200],
              //     borderRadius: BorderRadius.circular(29),
              //   ),
              //   child: TextField(
              //     controller: _username,
              //     cursorColor: colorses.dasar,
              //     decoration: InputDecoration(
              //       hintText: "Username",
              //       icon: Icon(
              //         Icons.person,
              //         color: colorses.dasar,
              //       ),
              //       border: InputBorder.none,
              //       errorText: _username.text.length < 3 && _validate
              //           ? 'Username harus diisi !'
              //           : null,
              //     ),
              //   ),
              // ),
              // Container(
              //   margin: EdgeInsets.symmetric(vertical: 10),
              //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              //   width: MediaQuery.of(context).size.width * 0.8,
              //   decoration: BoxDecoration(
              //     color: Colors.amber[200],
              //     borderRadius: BorderRadius.circular(29),
              //   ),
              //   child: TextField(
              //     obscureText: passwordVisible,
              //     controller: _password,
              //     cursorColor: colorses.dasar,
              //     decoration: InputDecoration(
              //       hintText: "Password",
              //       icon: Icon(
              //         Icons.lock,
              //         color: colorses.dasar,
              //       ),
              //       suffixIcon: IconButton(
              //         icon: Icon(passwordVisible ? Icons.visibility_off : Icons.visibility,),
              //         color: colorses.dasar,
              //         onPressed: (){
              //           this.setState(() {
              //             passwordVisible = !passwordVisible;
              //           });
              //         },
              //       ),
              //       errorText: _password.text.length < 3 && _validate
              //           ? 'Password harus diisi !'
              //           : null,
              //       border: InputBorder.none,
              //     ),
              //     // onChanged: (value){
              //     //   FocusScope.of(context).requestFocus(new FocusNode());
              //     // },
              //   ),
              // ),
              // SizedBox(height: 12,),
              // InkWell(
              //   onTap: (){
              //     if(_username.text.isEmpty || _password.text.isEmpty){
              //       setState(() {
              //         _validate= true;
              //       });
              //     } else {
              //       Dialogs.showLoading(context, "Loading");
              //       blocMember.login(_username.text, _password.text);
              //       blocMember.resLogin.listen((value) {
              //         if(value.status){
              //           Dialogs.dismiss(context);
              //           setToken(value.data.idToken);
              //           setKdUser(value.data.idPenjual);
              //           setNama(value.data.namaLengkap);
              //           setUsername(value.data.username);
              //           Navigator.of(context).pushNamedAndRemoveUntil('/controllerPage', (route) => false);
              //         } else{
              //           Dialogs.dismiss(context);
              //           Toast.show("User atau Password salah", context,
              //               duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              //         }
              //       });
              //     }
              //   },
              //   child: Container(
              //     margin: EdgeInsets.symmetric(vertical: 10),
              //     height: 50,
              //     width: MediaQuery.of(context).size.width * 0.8,
              //       decoration: BoxDecoration(
              //         color: colorses.dasar,
              //         borderRadius: BorderRadius.circular(29),
              //       ),
              //       child: Center(child: Text("LOGIN",style: TextStyle(color: Colors.white),))
              //   ),
              // ),
              //
              // Text("----- Atau -----"),
              SizedBox(height: 12,),
              Container(
                margin: EdgeInsets.only(top: 12),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(18), topLeft: Radius.circular(18)),
                            color: Colors.grey[200],
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 3,
                                offset: Offset(3, 5), // Shadow position
                              ),
                            ]),
                        child: Image.asset(
                          "assets/google.png",
                          scale: 7,
                        )),
                    InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => LengkapiProfil()),
                        // );
                        _signIn();
                      },
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(18), topRight: Radius.circular(18)),
                          color: colorses.orange,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 3,
                              offset: Offset(3, 5), // Shadow position
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "Login dengan google",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
