import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rajinbaca/model.dart';
import 'package:rajinbaca/repository.dart';
import 'package:fluttertoast/fluttertoast.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MaterialApp(
    home: new Login(),
    routes: <String, WidgetBuilder>{
      '/login' : (BuildContext context) => new Login(),
      '/register' : (BuildContext context) => new Register(),
      '/home' : (BuildContext context) => new Home()
    },
  ));
}

// halaman login
class Login extends StatefulWidget{
  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login>{
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passowrdController = new TextEditingController();

  late bool _sucess;

  void _login() async{
    try {
      final User? user = (await _auth.signInWithEmailAndPassword(email: _emailController.text, password: _passowrdController.text)).user;
      if(user != null){
        Fluttertoast.showToast(
            msg: "Berhasil Login"
        );
        setState(() {
          _sucess: true;
        });
        Navigator.popAndPushNamed(context, '/home');
      }else{
        Fluttertoast.showToast(
            msg: "Gagal Login, check kembali username dan password"
        );
        setState(() {
          _sucess: false;
        });
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: "Gagal Login, check kembali username dan password"
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new SingleChildScrollView(
        child: new Padding(
            padding: new EdgeInsets.all(16.0),
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new SizedBox(
                    height: 120.0,
                  ),
                  new Text('Masuk Aplikasi',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  new Text('Selamat Datang, Silahkan Masukan Data',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 44.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  new SizedBox(
                    height: 44.0,
                  ),
                  // textfield email
                  new TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.email, color: Colors.black,)
                    ),
                  ),
                  new SizedBox(
                    height: 28.0,
                  ),
                  // textfield password
                  new TextField(
                    controller: _passowrdController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.lock, color: Colors.black,)
                    ),
                  ),
                  new SizedBox(
                    height: 18.0,
                  ),
                  // container
                  Container(
                    width: double.infinity,
                    // button
                    child: RawMaterialButton(
                      fillColor: Color(0xFF0069FE),
                      elevation: 0.0,
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                      onPressed: () async {
                        _login();
                      },
                      child: Text('Login', style: TextStyle(color: Colors.white, fontSize: 18.0),),
                    ),
                  ),
                  new SizedBox(
                    height: 18.0,
                  ),
                  new InkWell(
                    child: new Text("belum punya akun? daftar disini", style: TextStyle(color: Colors.blueAccent)),
                    onTap: (){
                      Navigator.pushNamed(context, "/register");
                    },
                  ),
                ]
            )
        ),
      )
    );
  }
}

//halaman register
class Register extends StatefulWidget{
  @override
  _RegisterState createState() => new _RegisterState(); 
  
}

class _RegisterState extends State<Register>{
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _confirmPasswordController = new TextEditingController();

  late bool _sucess;

  void _register() async{
    if(_passwordController.text == _confirmPasswordController.text){
      // final User user = ( await _auth.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text)).user;
      final User? user = (
          await _auth.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text)
      ).user;

      if(user != null) {
        setState(() {
          _sucess = true;
        });
        Fluttertoast.showToast(
            msg: "Berhasil!"
        );
        Navigator.pop(context);
      } else {
        setState(() {
          _sucess = false;
        });
        Fluttertoast.showToast(
            msg: "Gagal Register"
        );
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("register"),),
      body: new SingleChildScrollView(
        child: new Padding(
          padding: new EdgeInsets.all(16.0),
          child: new Column(
            children: <Widget>[
              new SizedBox(
                height: 20.0,
              ),
              // textfield email
              new TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.email, color: Colors.black,)
                ),
              ),
              new SizedBox(
                height: 28.0,
              ),
              // textfield password
              new TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock, color: Colors.black,)
                ),
              ),
              new SizedBox(
                height: 28.0,
              ),
              // textfield password
              new TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                    hintText: 'Confirm Password',
                    prefixIcon: Icon(Icons.lock, color: Colors.black,)
                ),
              ),
              new SizedBox(
                height: 28.0,
              ),
              Container(
                width: double.infinity,
                // button
                child: RawMaterialButton(
                  fillColor: Color(0xFF0069FE),
                  elevation: 0.0,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                  onPressed: () async {
                    _register();
                  },
                  child: Text('Register', style: TextStyle(color: Colors.white, fontSize: 18.0),),
                ),
              ),
              new SizedBox(
                height: 18.0,
              ),
              new InkWell(
                child: new Text("kembali ke halaman login", style: TextStyle(color: Colors.blueAccent)),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        )
      )
    );
  }
}

class Home extends StatefulWidget{
  @override
  _StateHome createState() => new _StateHome();
}

class _StateHome extends State<Home>{
  List<Person> listperson = [];
  Repository repository = new Repository();

  getdata() async{
    listperson = await repository.getData();
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text("Home")),
      body: new ListView.separated(itemBuilder: (context, index){
        return new Column(
          children: <Widget>[
            new Text(listperson[index].nama),
            new Text(listperson[index].keterangan),
          ]
        );
      }, separatorBuilder: (context, index){
        return Divider();
      }, itemCount: listperson.length),
    );
  }

}