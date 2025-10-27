
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grimorio/core/services/auth_service.dart';
import 'package:grimorio/core/services/database_service.dart';
import 'package:grimorio/presentation/theme/app_colors.dart';

class AuthController with ChangeNotifier {
  final AuthService _authService = AuthService();
  final DatabaseService _databaseService = DatabaseService();

  bool _isLogin = true;
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool _termsAccepted = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();

  bool get isLogin => _isLogin;
  bool get isPasswordVisible => _isPasswordVisible;
  bool get isLoading => _isLoading;
  bool get termsAccepted => _termsAccepted;

  void toggleAuthMode() {
    _isLogin = !_isLogin;
    _termsAccepted = false;
    _clearControllers();
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void acceptTerms() {
    if (!_termsAccepted) {
      _termsAccepted = true;
      notifyListeners();
    }
  }


  Future<void> submit(BuildContext context) async {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    if (!_isLogin && !_termsAccepted) {
      _showFeedbackDialog(context, 'Termos e Condições',
          'Você precisa ler e aceitar os Termos e Condições e a Política de Privacidade para criar uma conta.');
      return;
    }


    _setLoading(true);

    try {
      if (_isLogin) {
        await _authService.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
      } else {
        final userCredential =
        await _authService.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          name: nameController.text.trim(),
        );

        if (userCredential.user != null) {
          await _databaseService.createUserProfile(
            userCredential.user!,
            nameController.text.trim(),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Ocorreu um erro desconhecido.';
      if (e.code == 'weak-password') {
        errorMessage = 'A senha fornecida é muito fraca.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'Este e-mail já está em uso.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'O endereço de e-mail não é válido.';
      } else if (e.code == 'invalid-credential') {
        errorMessage = 'Credenciais inválidas. Verifique seu e-mail e senha.';
      }
      if (context.mounted) {
        _showFeedbackDialog(context, 'Erro de Autenticação', errorMessage);
      }
    } finally {
      _setLoading(false);
    }
  }

  Future<void> resetPassword(BuildContext context) async {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      _showFeedbackDialog(
        context,
        'Atenção',
        'Por favor, digite seu e-mail no campo correspondente para redefinir a senha.',
      );
      return;
    }

    _setLoading(true);
    try {
      await _authService.sendPasswordResetEmail(email: email);
      if (!context.mounted) return;
      _showFeedbackDialog(
        context,
        'Sucesso',
        'E-mail de redefinição de senha enviado! Verifique sua caixa de entrada.',
      );
    } on FirebaseAuthException catch (_) {
      if (!context.mounted) return;
      _showFeedbackDialog(
        context,
        'Ocorreu um Erro',
        'Não foi possível enviar o e-mail. Verifique se o endereço está correto e tente novamente.',
      );
    } finally {
      _setLoading(false);
    }
  }

  void showTermsDialog(BuildContext context) {
    const String termsText = '''
Bem-vindo ao Grimório! Estes Termos de Uso ("Termos") regem seu acesso e uso do nosso aplicativo móvel ("App") e quaisquer serviços relacionados oferecidos por Gabriel Correa ("nós", "nosso"). Ao criar uma conta ou usar nosso App, você concorda em cumprir estes Termos. Se você não concordar, por favor, não use o App.

**1. Aceitação dos Termos**
Ao acessar ou usar o App, você confirma que leu, entendeu e concorda em estar vinculado a estes Termos e à nossa Política de Privacidade (Nota: Link a ser adicionado posteriormente). Se você estiver usando o App em nome de uma organização, você concorda com estes Termos em nome dessa organização.

**2. Elegibilidade e Contas de Usuário**
* **Idade:** Para criar uma conta, você deve ter pelo menos 13 anos de idade ou ter o consentimento de seus pais ou responsáveis legais se for menor de idade em sua jurisdição. [IMPORTANTE: Verifique a legislação brasileira sobre idade mínima e consentimento parental - LGPD].
* **Registro:** Você concorda em fornecer informações precisas e completas ao criar sua conta e em mantê-las atualizadas. Você é responsável por manter a confidencialidade da sua senha e por todas as atividades que ocorrem em sua conta.
* **Uso da Conta:** Sua conta é pessoal e intransferível.

**3. Uso do Aplicativo**
* **Propósito:** O Grimório foi projetado para incentivar o hábito de leitura através de quizzes e elementos de gamificação baseados em livros.
* **Conduta:** Você concorda em usar o App apenas para fins legais e de acordo com estes Termos. Você não deve:
    * Usar o App de forma fraudulenta ou ilegal.
    * Tentar obter acesso não autorizado aos nossos sistemas ou contas de outros usuários.
    * Interferir no funcionamento normal do App.

**4. Conteúdo e Propriedade Intelectual**
* **Conteúdo do App:** O App, incluindo seu design, textos, gráficos, código e a seleção e organização dos mesmos, são de nossa propriedade exclusiva ou licenciados para nós e protegidos por leis de direitos autorais e outras leis de propriedade intelectual.
* **Conteúdo de Terceiros:** Os quizzes são baseados em obras literárias de terceiros. Os direitos autorais dessas obras pertencem aos seus respectivos autores e editoras. O Grimório utiliza informações sobre essas obras para fins educacionais e de entretenimento, dentro dos limites permitidos por lei.
* **Licença de Uso:** Concedemos a você uma licença limitada, não exclusiva, intransferível e revogável para usar o App para seu uso pessoal e não comercial, sujeito a estes Termos.

**5. Gamificação (XP, Níveis, Conquistas)**
* Os pontos de experiência (XP), níveis, títulos (Aprendiz, Mago, etc.) e conquistas obtidos no App são elementos virtuais projetados exclusivamente para fins de engajamento e entretenimento dentro do App.
* Estes elementos não possuem valor monetário real, não são transferíveis e não podem ser trocados por dinheiro ou bens fora do ambiente do App.

**6. Recursos Premium (se aplicável)**
* Podemos oferecer recursos adicionais ou conteúdo exclusivo através de assinaturas ou compras ("Recursos Premium"). O acesso e uso desses recursos podem estar sujeitos a termos e condições de pagamento adicionais, que serão apresentados a você antes da compra.

**7. Privacidade**
* Nossa coleta e uso de suas informações pessoais, incluindo seu endereço de e-mail, são regidos por nossa Política de Privacidade (Nota: Link a ser adicionado posteriormente). Ao usar o App, você consente com tal coleta e uso.

**8. Isenção de Garantias**
* O App é fornecido "como está" e "conforme disponível", sem garantias de qualquer tipo, expressas ou implícitas. Não garantimos que o App será ininterrupto, livre de erros ou seguro.

**9. Limitação de Responsabilidade**
* Na extensão máxima permitida pela lei aplicável, não seremos responsáveis por quaisquer danos indiretos, incidentais, especiais, consequenciais ou punitivos, ou qualquer perda de lucros ou receitas, incorridos direta ou indiretamente, ou qualquer perda de dados, uso, boa vontade ou outras perdas intangíveis, resultantes do seu acesso ou uso ou incapacidade de acessar ou usar o App.

**10. Modificações nos Termos**
* Reservamo-nos o direito de modificar estes Termos a qualquer momento. Se fizermos alterações, notificaremos você publicando os Termos revisados no App ou por outros meios. Seu uso continuado do App após a data efetiva dos Termos revisados constitui sua aceitação das alterações.

**11. Rescisão**
* Podemos suspender ou encerrar seu acesso ao App a qualquer momento, por qualquer motivo, incluindo violação destes Termos.

**12. Legislação Aplicável**
* Estes Termos serão regidos e interpretados de acordo com as leis da República Federativa do Brasil.

**13. Contato**
* Se você tiver alguma dúvida sobre estes Termos, entre em contato conosco em: gabrielpcorrea2002@gmail.com.
''';

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.azulRoyal,
        title: const Text('TERMOS E POLÍTICA',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
        content: const Scrollbar(
          thumbVisibility: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Text(
                termsText,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
        ),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        actions: <Widget>[
          TextButton(
            child: const Text('RECUSAR', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
          TextButton(
            child: const Text('ACEITAR',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            onPressed: () {
              acceptTerms();
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }


  void _showFeedbackDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.azulRoyal,
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        content: Text(
          content,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        actions: <Widget>[
          TextButton(
            child:
            const Text('Ok', style: TextStyle(color: AppColors.azulClaro)),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _clearControllers() {
    formKey.currentState?.reset();
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}