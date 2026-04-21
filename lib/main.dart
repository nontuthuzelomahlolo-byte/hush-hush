import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(HushHushApp());

class HushHushApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Segoe UI', 
        brightness: Brightness.light,
      ),
      home: AuthParentScreen(),
    );
  }
}

class AuthParentScreen extends StatefulWidget {
  @override
  _AuthParentScreenState createState() => _AuthParentScreenState();
}

class _AuthParentScreenState extends State<AuthParentScreen> {
  // Color Palette
  final Color skyBlue = const Color(0xFF87CEEB);
  final Color hotPink = const Color(0xFFFF69B4);
  final Color softPink = const Color(0xFFFFF0F5);

  // App States: 'register', 'login', 'forgot'
  String authMode = 'register'; 
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Icon(Icons.favorite_rounded, size: 70, color: hotPink),
              const Text("HUSH-HUSH", 
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: 2)),
              Text("Your safe space.", 
                style: TextStyle(color: skyBlue, fontSize: 14, fontWeight: FontWeight.w500)),
              const SizedBox(height: 40),

              // --- DYNAMIC FORM CONTENT ---
              if (authMode == 'register') _buildRegisterForm(),
              if (authMode == 'login') _buildLoginForm(),
              if (authMode == 'forgot') _buildForgotForm(),

              const SizedBox(height: 20),

              // --- BOTTOM NAVIGATION ---
              if (authMode == 'register')
                TextButton(
                  onPressed: () => setState(() => authMode = 'login'),
                  child: Text("Already a member? Log In", style: TextStyle(color: skyBlue, fontWeight: FontWeight.bold)),
                ),
              if (authMode == 'login' || authMode == 'forgot')
                TextButton(
                  onPressed: () => setState(() => authMode = 'register'),
                  child: Text("Need an account? Register", style: TextStyle(color: hotPink, fontWeight: FontWeight.bold)),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // 1. REGISTRATION FORM
  Widget _buildRegisterForm() {
    return Column(
      children: [
        _inputField("Alias Name", Icons.face_rounded),
        const SizedBox(height: 15),
        _inputField("Email Address", Icons.mail_outline),
        const SizedBox(height: 15),
        _passwordField(),
        const SizedBox(height: 25),
        _pinSection(),
        const SizedBox(height: 25),
        _actionButton("ENTER HUSH-HUSH"),
      ],
    );
  }

  // 2. LOGIN FORM
  Widget _buildLoginForm() {
    return Column(
      children: [
        _inputField("Email or Alias", Icons.person_outline),
        const SizedBox(height: 15),
        _passwordField(),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => setState(() => authMode = 'forgot'),
            child: Text("Forgot Password?", style: TextStyle(color: skyBlue, fontSize: 12)),
          ),
        ),
        const SizedBox(height: 20),
        _actionButton("LOG IN"),
      ],
    );
  }

  // 3. FORGOT PASSWORD FORM
  Widget _buildForgotForm() {
    return Column(
      children: [
        const Text("Don't worry, Sister.", style: TextStyle(fontWeight: FontWeight.bold)),
        const Text("Enter your email to reset your vault access.", textAlign: TextAlign.center),
        const SizedBox(height: 25),
        _inputField("Email Address", Icons.mark_email_read_outlined),
        const SizedBox(height: 25),
        _actionButton("SEND RESET LINK"),
      ],
    );
  }

  // REUSABLE COMPONENTS
  Widget _inputField(String label, IconData icon) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: skyBlue),
        filled: true,
        fillColor: softPink,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _passwordField() {
    return TextField(
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        labelText: "Password",
        prefixIcon: Icon(Icons.lock_open_rounded, color: skyBlue),
        suffixIcon: IconButton(
          icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off, color: Colors.black26),
          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
        ),
        filled: true,
        fillColor: softPink,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _pinSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("  4-Digit Security PIN", style: TextStyle(color: Colors.black54, fontSize: 12, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(4, (index) => SizedBox(
            width: 60,
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 1,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                counterText: "",
                filled: true,
                fillColor: softPink,
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: skyBlue.withOpacity(0.3))),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: hotPink, width: 2)),
              ),
            ),
          )),
        ),
      ],
    );
  }

  Widget _actionButton(String label) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: hotPink,
        minimumSize: const Size(double.infinity, 60),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      onPressed: () {},
      child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1)),
    );
  }
}