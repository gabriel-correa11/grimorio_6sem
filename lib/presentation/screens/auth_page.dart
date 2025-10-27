import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:grimorio/core/providers/auth_controller.dart';
import 'package:grimorio/presentation/widgets/auth_header.dart';
import 'package:grimorio/presentation/widgets/auth_form_fields.dart';
import 'package:grimorio/presentation/widgets/auth_action_buttons.dart';
import 'package:grimorio/presentation/theme/app_colors.dart';

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
                      if (!controller.isLogin)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: TextButton(
                            onPressed: () => controller.showTermsDialog(context),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  controller.termsAccepted
                                      ? 'Termos e Política Aceitos'
                                      : 'Ler e Aceitar Termos e Política',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: controller.termsAccepted
                                        ? Colors.green.shade300
                                        : Colors.white,
                                    decoration: TextDecoration.underline,
                                    decorationColor: controller.termsAccepted
                                        ? Colors.green.shade300
                                        : Colors.white,
                                    decorationThickness: 1.5,
                                  ),
                                ),
                                if (controller.termsAccepted)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Icon(Icons.check_circle, color: Colors.green.shade300, size: 18),
                                  ),
                              ],
                            ),
                          ),
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