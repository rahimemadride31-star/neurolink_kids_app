import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../data/strings.dart';
import '../state/app_state.dart';
import '../widgets/kids_background.dart';
import '../widgets/language_switcher.dart';
import '../widgets/primary_button.dart';
import 'add_child_screen.dart';
import 'home_shell.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _name = TextEditingController();
  final _carteId = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  bool _showPwd = false;
  UserRole _role = UserRole.parent;

  @override
  void dispose() {
    _name.dispose();
    _carteId.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
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
                const SizedBox(height: 4),
                Image.asset('assets/images/logo.png',
                    width: 90, height: 90),
                const SizedBox(height: 4),
                Text(
                  S.get('create_account'),
                  style:
                      const TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 4),
                Text(
                  S.get('join_community'),
                  style: const TextStyle(color: AppColors.textMuted),
                ),
                const SizedBox(height: 18),
                Text(S.get('choose_role'),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w800)),
                const SizedBox(height: 10),
                _RoleSelector(
                  selected: _role,
                  onChanged: (r) => setState(() => _role = r),
                ),
                const SizedBox(height: 18),
                TextField(
                  controller: _carteId,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: S.get('carte_nationale'),
                    prefixIcon: const Icon(Icons.credit_card),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _name,
                  decoration: InputDecoration(
                    labelText: S.get('full_name'),
                    prefixIcon: const Icon(Icons.person_outline),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: S.get('email'),
                    prefixIcon: const Icon(Icons.alternate_email),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _password,
                  obscureText: !_showPwd,
                  decoration: InputDecoration(
                    labelText: S.get('password'),
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      onPressed: () => setState(() => _showPwd = !_showPwd),
                      icon: Icon(
                        _showPwd ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _confirm,
                  obscureText: !_showPwd,
                  decoration: InputDecoration(
                    labelText: S.get('confirm_password'),
                    prefixIcon: const Icon(Icons.lock_outline),
                  ),
                ),
                const SizedBox(height: 22),
                PrimaryButton(
                  label: S.get('create_account'),
                  icon: Icons.arrow_forward,
                  gradient: AppColors.orangeGradient,
                  onPressed: _onSignup,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${S.get('have_account')}  "),
                    TextButton(
                      onPressed: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (_) => const LoginScreen()),
                      ),
                      child: Text(S.get('log_in'),
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

  void _onSignup() {
    final state = AppStateScope.of(context);
    state.userName = _name.text.isEmpty
        ? S.get('role_parent')
        : _name.text;
    state.setRole(_role);

    if (_role == UserRole.parent) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => const AddChildScreen(),
      ));
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const HomeShell()),
        (route) => false,
      );
    }
  }
}

class _RoleSelector extends StatelessWidget {
  final UserRole selected;
  final ValueChanged<UserRole> onChanged;
  const _RoleSelector({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    Widget card(UserRole role, IconData icon, String label) {
      final s = selected == role;
      return Expanded(
        child: GestureDetector(
          onTap: () => onChanged(role),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.symmetric(vertical: 16),
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
        card(UserRole.parent, Icons.family_restroom, S.get('role_parent')),
        card(UserRole.teacher, Icons.school_outlined, S.get('role_teacher')),
        card(UserRole.doctor, Icons.medical_services_outlined,
            S.get('role_doctor')),
      ],
    );
  }
}
