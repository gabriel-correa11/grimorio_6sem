import 'package:flutter/material.dart';

class AuthFormFields extends StatelessWidget {
  final bool isLogin;
  final bool isPasswordVisible;
  final VoidCallback onTogglePasswordVisibility;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const AuthFormFields({
    super.key,
    required this.isLogin,
    required this.isPasswordVisible,
    required this.onTogglePasswordVisibility,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (!isLogin)
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: TextField(
              controller: nameController,
              keyboardType: TextInputType.name,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Nome',
                labelStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(Icons.person_outline, color: Colors.white),
              ),
            ),
          ),
        TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            labelText: 'Email',
            labelStyle: TextStyle(color: Colors.white),
            prefixIcon: Icon(Icons.email_outlined, color: Colors.white),
          ),
        ),
        const SizedBox(height: 20.0),
        TextField(
          controller: passwordController,
          obscureText: !isPasswordVisible,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: 'Senha',
            labelStyle: const TextStyle(color: Colors.white),
            prefixIcon: const Icon(Icons.lock_outline, color: Colors.white),
            suffixIcon: IconButton(
              icon: Icon(isPasswordVisible ? Icons.visibility_off : Icons.visibility, color: Colors.white),
              onPressed: onTogglePasswordVisibility,
            ),
          ),
        ),
        if (!isLogin) ...[
          const SizedBox(height: 20.0),
          TextField(
            controller: confirmPasswordController,
            obscureText: !isPasswordVisible,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Confirmar Senha',
              labelStyle: const TextStyle(color: Colors.white),
              prefixIcon: const Icon(Icons.lock_outline, color: Colors.white),
              suffixIcon: IconButton(
                icon: Icon(isPasswordVisible ? Icons.visibility_off : Icons.visibility, color: Colors.white),
                onPressed: onTogglePasswordVisibility,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
