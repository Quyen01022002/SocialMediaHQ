import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';


class NewPassWordScreen extends StatefulWidget {
  final bool animated;

  const NewPassWordScreen({Key? key, required this.animated}) : super(key: key);

  @override
  State<NewPassWordScreen> createState() => _NewPassWordScreenState();
}

class _NewPassWordScreenState extends State<NewPassWordScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  late bool animated;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    animated = widget.animated;
    startAnimation();
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
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height,
            fit: BoxFit.cover,
          ),
          Image.asset(
            'assets/images/verify-back.png',
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: 280,
            fit: BoxFit.cover,
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            bottom: animated ? 0 : -200,
            child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: 560,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: Column(
                  children: [
                    Text(
                      "SET NEW PASSWORD",
                      style: TextStyle(fontSize: 16,color: Colors.blue,fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16,),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20,10,20,10),
                        child: Text("Nhập mật khẩu mới của bạn",style: TextStyle(fontSize: 16),textAlign: TextAlign.center,),
                      ),
                    ),
                    const SizedBox(height: 36,),
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
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      obscureText: _isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Comfirm Password',
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
                    const SizedBox(height: 36,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              100.0),
                        ),
                        backgroundColor: Color(0xFF8587F1),
                      ),
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(120, 18, 125, 18),
                        child: Text(
                          'SEND',
                          style: TextStyle(
                            color: Colors.white, // Màu chữ
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 66),
                    Image.asset(
                      'assets/images/bottom_backgroud.png',
                      fit: BoxFit.cover,
                    ),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> startAnimation() async {
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      animated = true;
    });
  }
}
