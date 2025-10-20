import 'package:flutter/material.dart';

class AuthFormFields extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final bool isLogin;
  final bool isPasswordVisible;
  final VoidCallback onTogglePasswordVisibility;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const AuthFormFields({
    super.key,
    required this.formKey,
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
    return Form(
      key: formKey,
      child: Column(
        children: [
          if (!isLogin)
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nome',
                icon: Icon(Icons.person),
              ),
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Por favor, insira seu nome.';
                }
                return null;
              },
            ),
          const SizedBox(height: 12),
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              icon: Icon(Icons.email),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || !value.contains('@')) {
                return 'Por favor, insira um e-mail válido.';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: passwordController,
            obscureText: !isPasswordVisible,
            decoration: InputDecoration(
              labelText: 'Senha',
              icon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: onTogglePasswordVisibility,
              ),
            ),
            validator: (value) {
              if (value == null || value.length < 7) {
                return 'A senha deve ter pelo menos 7 caracteres.';
              }
              return null;
            },
          ),
          if (!isLogin) const SizedBox(height: 12),
          if (!isLogin)
            TextFormField(
              controller: confirmPasswordController,
              obscureText: !isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Confirmar Senha',
                icon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: onTogglePasswordVisibility,
                ),
              ),
              validator: (value) {
                if (value != passwordController.text) {
                  return 'As senhas não coincidem.';
                }
                return null;
              },
            ),
        ],
      ),
    );
  }
}