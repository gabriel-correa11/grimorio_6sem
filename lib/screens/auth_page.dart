import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:grimorio/auth_controller.dart';
import 'package:grimorio/widgets/auth_header.dart';
import 'package:grimorio/widgets/auth_form_fields.dart';
import 'package:grimorio/widgets/auth_action_buttons.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthController(),
      child: Consumer<AuthController>(
        builder: (context, controller, child) {
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AuthHeader(isLogin: controller.isLogin),
                      AuthFormFields(
                        formKey: controller.formKey,
                        isLogin: controller.isLogin,
                        isPasswordVisible: controller.isPasswordVisible,
                        onTogglePasswordVisibility:
                        controller.togglePasswordVisibility,
                        nameController: controller.nameController,
                        emailController: controller.emailController,
                        passwordController: controller.passwordController,
                        confirmPasswordController:
                        controller.confirmPasswordController,
                      ),
                      AuthActionButtons(
                        isLogin: controller.isLogin,
                        isLoading: controller.isLoading,
                        onSubmit: () => controller.submit(context),
                        onResetPassword: () => controller.resetPassword(context),
                        onToggleAuthMode: controller.toggleAuthMode,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}