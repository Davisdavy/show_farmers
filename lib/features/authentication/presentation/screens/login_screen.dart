
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vet_mkononi/core/widgets/app_button_widget.dart';
import 'package:vet_mkononi/core/widgets/app_text_input_widget.dart';
import 'package:vet_mkononi/core/widgets/app_text_styles.dart';
import 'package:vet_mkononi/features/authentication/presentation/providers/auth_provider.dart';
import 'package:vet_mkononi/features/farmer/presentation/screens/farmer_list_screen.dart';
import 'package:vet_mkononi/features/farmer/presentation/screens/home_shell_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _msisdnController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _msisdnController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      final msisdn = _msisdnController.text.trim();
      final password = _passwordController.text.trim();
      ref.read(authProvider.notifier).login(msisdn, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<String?>>(authProvider, (previous, next) {
      next.whenOrNull(
        data: (token) {
          if (token != null && token.isNotEmpty) {
            Navigator.pushReplacement(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: const FarmerListScreen(),
              ),
            );
          }
        },
      );
    });

    final authState = ref.watch(authProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 100.0),
                Text("Welcome back,", style: AppTextStyles.heading),
                const SizedBox(height: 10.0),
                Text("Good to see you again, login to", style: AppTextStyles.subheading),
                Text("view new activities ,", style: AppTextStyles.subheading),
                const SizedBox(height: 50.0),

                AppTextInputWidget(
                  controller: _msisdnController,
                  hintText: 'Phone number',
                  prefixIcon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: (value) =>
                  value == null || value.isEmpty ? 'Enter phone number' : null,
                ),
                const SizedBox(height: 10.0),

                AppTextInputWidget(
                  controller: _passwordController,
                  hintText: 'Password',
                  prefixIcon: Icons.lock,
                  isPassword: true,
                  validator: (value) =>
                  value == null || value.isEmpty ? 'Enter password' : null,
                ),
                const SizedBox(height: 20.0),

                Center(child: Text("Forgot password", style: AppTextStyles.subheading)),
                const SizedBox(height: 35.0),

                authState.when(
                  data: (_) => AppButtonWidget(
                    width: MediaQuery.of(context).size.width,
                    label: 'Login',
                    onPressed: _login,
                  ),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (err, _) => Column(
                    children: [
                      Text('Login failed: $err', style: const TextStyle(color: Colors.red)),
                      const SizedBox(height: 10),
                      AppButtonWidget(
                        width: MediaQuery.of(context).size.width,
                        label: 'Retry',
                        onPressed: _login,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
