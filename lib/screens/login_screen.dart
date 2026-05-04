import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../data/strings.dart';
import '../state/app_state.dart';
import '../widgets/kids_background.dart';
import '../widgets/language_switcher.dart';
import '../widgets/primary_button.dart';
import 'home_shell.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _carteId = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _showPassword = false;
  UserRole _role = UserRole.parent;

  @override
  void dispose() {
    _carteId.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    return Scaffold(
      body: KidsBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).maybePop(),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const LanguageSwitcher(),
                  ],
                ),
                const SizedBox(height: 8),
                Image.asset('assets/images/logo.png',
                    width: 110, height: 110),
                const SizedBox(height: 8),
                Text(
                  S.get('welcome_back'),
                  style:
                      const TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 4),
                Text(
                  S.get('login_subtitle'),
                  style: const TextStyle(color: AppColors.textMuted),
                ),
                const SizedBox(height: 24),
                _RolePicker(
                  selected: _role,
                  onChanged: (r) => setState(() => _role = r),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _carteId,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: S.get('carte_nationale'),
                    prefixIcon: const Icon(Icons.credit_card),
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: S.get('email'),
                    prefixIcon: const Icon(Icons.alternate_email),
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: _password,
                  obscureText: !_showPassword,
                  decoration: InputDecoration(
                    labelText: S.get('password'),
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      onPressed: () =>
                          setState(() => _showPassword = !_showPassword),
                      icon: Icon(_showPassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(S.get('forgot_password')),
                  ),
                ),
                const SizedBox(height: 8),
                PrimaryButton(
                  label: S.get('log_in'),
                  icon: Icons.login,
                  gradient: AppColors.orangeGradient,
                  onPressed: () {
                    state.setRole(_role);
                    state.userName = _email.text.split('@').first.isEmpty
                        ? S.get(_role == UserRole.parent ? 'role_parent' : _role == UserRole.teacher ? 'role_teacher' : 'role_doctor')
                        : _email.text.split('@').first;
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const HomeShell()),
                      (route) => false,
                    );
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${S.get('no_account')}  "),
                    TextButton(
                      onPressed: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (_) => const SignupScreen()),
                      ),
                      child: Text(S.get('sign_up'),
                          style: const TextStyle(fontWeight: FontWeight.w800)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RolePicker extends StatelessWidget {
  final UserRole selected;
  final ValueChanged<UserRole> onChanged;
  const _RolePicker({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    Widget chip(UserRole role, IconData icon, String label) {
      final s = selected == role;
      return Expanded(
        child: GestureDetector(
          onTap: () => onChanged(role),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              gradient: s ? AppColors.blueGradient : null,
              color: s ? null : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: s ? Colors.transparent : AppColors.border),
              boxShadow: s
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ]
                  : null,
            ),
            child: Column(
              children: [
                Icon(icon,
                    color: s ? Colors.white : AppColors.primary, size: 28),
                const SizedBox(height: 6),
                Text(label,
                    style: TextStyle(
                        color: s ? Colors.white : AppColors.textDark,
                        fontWeight: FontWeight.w800,
                        fontSize: 12)),
              ],
            ),
          ),
        ),
      );
    }

    return Row(
      children: [
        chip(UserRole.parent, Icons.family_restroom, S.get('role_parent')),
        chip(UserRole.teacher, Icons.school_outlined, S.get('role_teacher')),
        chip(UserRole.doctor, Icons.medical_services_outlined,
            S.get('role_doctor')),
      ],
    );
  }
}
