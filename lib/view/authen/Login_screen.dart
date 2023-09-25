import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socialmediahq/view/authen/sign_up_screen.dart';
import 'package:socialmediahq/view/authen/verify_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Loginscreen extends StatefulWidget {
  final bool animated;

  const Loginscreen({Key? key, required this.animated}) : super(key: key);

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GoogleSignInAccount? _currentUser;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  late bool animated;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    animated = widget.animated;
    startAnimation();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
  }

  void _handleSignOut() {
    _googleSignIn.signOut();
    setState(() {
      _currentUser = null;
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    // Thực hiện xác thực và xử lý đăng nhập ở đây
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/backgourd.png',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Image.asset(
            'assets/images/login-back.png',
            width: MediaQuery.of(context).size.width,
            height: 280,
            fit: BoxFit.cover,
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            bottom: animated ? 0 : -200,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 560,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
                child: Column(
                  children: [
                    TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50.0),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Color(0xFFF3F5F7),
                        hintStyle: TextStyle(
                          color: Colors.grey, // Đặt màu cho hint text
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      obscureText: _isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50.0),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Color(0xFFF3F5F7),
                        hintStyle: TextStyle(
                          color: Colors.grey, // Đặt màu cho hint text
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                          child: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 36),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: VerifyScreen(animated: false,),
                          ),
                        );
                      },
                      child: const Text(
                        "FOR GOT PASSWORD",
                        style: TextStyle(
                          // Hiển thị dưới nét gạch chân
                          fontSize: 14,
                          color: Color(0xFF5252C7),
                        ),
                      ),
                    ),
                    const SizedBox(height: 36),
                    Center(
                      child: _currentUser == null
                          ? ElevatedButton(
                        onPressed: _handleSignIn,
                        child: Text('Sign in with Google'),
                      )
                          : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ListTile(
                            leading: GoogleUserCircleAvatar(
                              identity: _currentUser!,
                            ),
                            title: Text(_currentUser!.displayName ?? ''),
                            subtitle: Text(_currentUser!.email ?? ''),
                          ),
                          ElevatedButton(
                            onPressed: _handleSignOut,
                            child: Text('Sign out'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 36),
                    Column(
                      children: [
                        Text(
                          "OR LOG IN BY",
                          style:
                              TextStyle(color: Color(0xFF606060), fontSize: 14),
                        ),
                        const SizedBox(height: 6),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _handleSignIn();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/images/google.png',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  'assets/images/facebook.png',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 36),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: SignUpScreeen(animated: false),
                              ),
                            );
                          },
                          child: RichText(
                            text: const TextSpan(
                              text: "Don't have account?",
                              style: TextStyle(
                                  color: Color(0xFF606060), fontSize: 14),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'SIGN UP',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> startAnimation() async {
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      animated = true;
    });
  }
}
