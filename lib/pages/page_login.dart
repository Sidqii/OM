import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pusdatin_end/pages/page_home.dart';
import 'package:pusdatin_end/pages/page_pemulihan.dart';
import 'package:pusdatin_end/widget/component/animate/comp_loading.dart';
import 'package:pusdatin_end/providers/providers_login.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(_onFocusChange);
    _passwordFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Mengakses AuthModel melalui Provider untuk login
      final authModel = Provider.of<AuthService>(context, listen: false);
      try {
        await authModel.login(
          _emailController.text,
          _passwordController.text,
        );
        if (authModel.isLoggedIn) {
          await Future.delayed(const Duration(milliseconds: 500));
          _onLoadingComplete();
        } else {
          _showErrorSnackBar(authModel.errorMessage ?? 'Login gagal');
          setState(() {
            _isLoading = false;
          });
        }
      } catch (e) {
        _showErrorSnackBar(
            'Terjadi kesalahan saat proses login. Silahkan coba lagi.');
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _onLoadingComplete() async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;
    final authModel = Provider.of<AuthService>(context, listen: false);
    if (authModel.isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(user: authModel.currentUser!)),
      );
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3D0E22),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/logo/pusdatin.png',
                        width: 250,
                        height: 250,
                      ),
                    ),
                    const SizedBox(height: 0.0),
                    const Text(
                      'Masuk Akun',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    _buildEmailField(),
                    const SizedBox(height: 20.0),
                    _buildPasswordField(),
                    const SizedBox(height: 20.0),
                    _buildLoginButton(),
                    const SizedBox(height: 10.0),
                    _buildForgotPasswordLink(),
                  ],
                ),
              ),
            ),
          ),
          if (_isLoading)
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.0, end: 5.0),
              duration: const Duration(milliseconds: 500),
              builder: (context, sigma, child) {
                return BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
                  child: Container(
                    color: Colors.black.withOpacity(0.2),
                  ),
                );
              },
            ),
          if (_isLoading)
            AnimatedOpacity(
              opacity: _isLoading ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: Center(
                child: CustomLoading(
                  width: 100,
                  onCompleted: _onLoadingComplete,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      cursorColor: Colors.white,
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: TextStyle(
          color: _emailFocusNode.hasFocus || _emailController.text.isNotEmpty
              ? Colors.white
              : Colors.grey,
        ),
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
        ),
        prefixIcon: Icon(
          Icons.email,
          color: _emailFocusNode.hasFocus || _emailController.text.isNotEmpty
              ? Colors.white
              : Colors.grey,
        ),
      ),
      style: const TextStyle(color: Colors.white),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email tidak boleh kosong';
        }
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}').hasMatch(value)) {
          return 'Masukkan email yang valid';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      cursorColor: Colors.white,
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: TextStyle(
          color:
              _passwordFocusNode.hasFocus || _passwordController.text.isNotEmpty
                  ? Colors.white
                  : Colors.grey,
        ),
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
        ),
        prefixIcon: Icon(
          Icons.lock,
          color:
              _passwordFocusNode.hasFocus || _passwordController.text.isNotEmpty
                  ? Colors.white
                  : Colors.grey,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: _passwordFocusNode.hasFocus ||
                    _passwordController.text.isNotEmpty
                ? Colors.white
                : Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
      ),
      style: const TextStyle(color: Colors.white),
      obscureText: !_isPasswordVisible,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (value) {
        _login();
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password tidak boleh kosong';
        }
        if (value.length < 6) {
          return 'Password minimal 6 karakter';
        }
        return null;
      },
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _login,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          minimumSize: const Size.fromHeight(50),
        ),
        child: const Text(
          'Masuk',
          style: TextStyle(
            color: Color(0xFF3D0E22),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPasswordLink() {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PagePemulihan()));
          },
          child: const Text(
            'Lupa Password?',
            style: TextStyle(
              color: Colors.white,
            ),
          )),
    );
  }
}
