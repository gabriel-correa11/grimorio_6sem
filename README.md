<div align="center">
<h3><a href="#">Português</a> • <a href="#">English</a></h3>
</div>
<hr>

🏰 Projeto Grimorio
<div align="center">

</div>

Status do Projeto: Em Desenvolvimento 🚀

Este é o repositório do nosso projeto de faculdade, o Grimorio. A ideia é criar um app em Flutter que usa elementos de jogos para incentivar o hábito da leitura, transformando cada livro em uma jornada interativa.

<details>
<summary>View in English</summary>

Project Status: In Development 🚀

This is the repository for our college project, Grimorio. The idea is to create an app in Flutter that uses gamification elements to encourage the habit of reading, turning each book into an interactive journey.

</details>

1. O Problema que Queremos Resolver
   Hoje em dia, os livros competem pela nossa atenção com redes sociais e jogos, que oferecem recompensas rápidas. Nossa ideia com o Grimorio é usar essa mesma lógica a favor da leitura, criando um app que dê ao usuário uma sensação de progresso e conquista a cada capítulo ou livro finalizado.

<details>
<summary>View in English</summary>

1. The Problem We Want to Solve
   Nowadays, books compete for our attention with social media and games, which offer quick rewards. Our idea with Grimorio is to use this same logic in favor of reading, creating an app that gives the user a sense of progress and achievement with each chapter or book finished.

</details>

2. Arquitetura e Decisões Técnicas
   Escolhemos nossas ferramentas pensando em agilidade e performance:

Flutter & Dart: A escolha principal. Com o Flutter, podemos criar um app para Android e iOS com um único código. Como já tínhamos uma base de orientação a objetos com Java, a transição para o Dart foi bem tranquila.

Firebase: Para cuidar do backend. Usamos o Firebase Authentication para ter um sistema de login e cadastro seguro (com e-mail, senha e verificação) sem precisar construir um servidor do zero.

Arquitetura Limpa e Gerenciamento de Estado:

Separação de Responsabilidades: Desde o início, separamos o código em camadas: screens para as telas, widgets para componentes reutilizáveis e classes de lógica.

State Management com Provider: A tela de autenticação ficou muito complexa. Para resolver isso, refatoramos a arquitetura: criamos uma classe AuthController que gerencia toda a lógica e estado da página, enquanto a UI (AuthPage) apenas exibe os dados. Isso deixou o código muito mais limpo e fácil de manter.

<details>
<summary>View in English</summary>

2. Architecture and Technical Decisions
   We chose our tools thinking about agility and performance:

Flutter & Dart: Our main choice. With Flutter, we can create an app for Android and iOS from a single codebase. As we already had a background in object-oriented programming with Java, the transition to Dart was very smooth.

Firebase: To take care of the backend. We use Firebase Authentication to have a secure login and registration system (with email, password, and verification) without needing to build a server from scratch.

Clean Architecture and State Management:

Separation of Concerns: From the beginning, we separated the code into layers: screens for the pages, widgets for reusable components, and logic classes.

State Management with Provider: The authentication screen started to get very complex. To solve this, we refactored the architecture: we created an AuthController class that manages all the logic and page state, while the UI (AuthPage) just displays the data. This made the code much cleaner and easier to maintain.

</details>

3. O que já está funcionando (Features)
   Sistema de Autenticação Completo: Cadastro, login, verificação de e-mail, "esqueci a senha", e validação de campos. Tudo gerenciado por um Controller separado da UI.

UI Componentizada: A tela de autenticação foi dividida em múltiplos widgets (AuthHeader, AuthFormFields, AuthActionButtons), deixando o código mais organizado.

Módulo de Quiz Funcional: O fluxo principal do app (login -> seleção de livro -> quiz -> pontuação) está completo.

Tema Visual Centralizado: Um ThemeData global garante que todo o app tenha uma aparência consistente.

<details>
<summary>View in English</summary>

3. What's Already Working (Features)
   Complete Authentication System: User registration, login, email verification, "forgot password," and field validation. Everything is managed by a Controller separated from the UI.

Component-Based UI: The authentication screen was broken down into multiple widgets (AuthHeader, AuthFormFields, AuthActionButtons), making the code more organized.

Functional Quiz Module: The main app flow (login -> book selection -> quiz -> score) is complete.

Centralized Visual Theme: A global ThemeData ensures the entire app has a consistent look and feel.

</details>

4. Próximos Passos
   Tela de Perfil: Construir a tela de perfil do usuário com a opção de logout.

Salvar Progresso: Usar o Firestore para salvar a pontuação e os livros completos.

Evoluir o Quiz: Mudar as perguntas para o formato de Múltipla Escolha.

<details>
<summary>View in English</summary>

4. Next Steps
   Profile Screen: Build the user profile screen with a logout option.

Save Progress: Use Firestore to save scores and completed books.

Evolve the Quiz: Change the questions to a Multiple Choice format.

</details>

5. Como Executar o Projeto
   Clone o repositório.

Garanta que o Flutter está instalado (flutter doctor).

Rode flutter pub get para baixar as dependências.

Rode flutter run para iniciar o app.

<details>
<summary>View in English</summary>

5. How to Run the Project
   Clone the repository.

Ensure Flutter is installed (flutter doctor).

Run flutter pub get to download dependencies.

Run flutter run to start the app.

</details>