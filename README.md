
<div align="center">
<h1>Projeto Grimório</h1>
<h3><a href="#">Português</a> • <a href="#english-version">English</a></h3>
</div>

<div align="center">

Status do Projeto: Em Desenvolvimento Ativo 🚀

</div>

Este é o repositório do nosso projeto de faculdade, o Grimório. A proposta é criar um aplicativo mobile em Flutter que utiliza gamificação para incentivar o hábito da leitura, transformando cada livro em uma jornada de progressão e conhecimento.

1. O problema que queremos resolver
Em um mundo onde livros competem pela atenção com redes sociais e jogos que oferecem recompensas instantâneas, o Grimório busca usar essa mesma lógica a favor da leitura. O aplicativo foi projetado para dar ao usuário uma sensação tangível de progresso e conquista a cada capítulo lido e quiz finalizado.

2. Arquitetura e Decisões Técnicas
O projeto foi construído com foco em escalabilidade, manutenibilidade e performance, utilizando uma arquitetura limpa e tecnologias modernas.

Flutter & Dart: Escolha principal para o desenvolvimento multiplataforma (Android/iOS) a partir de um código único. A familiaridade prévia com orientação a objetos facilitou a adoção do Dart.

Firebase (Backend as a Service):

Firebase Authentication: Utilizado para um sistema de autenticação robusto e seguro, incluindo cadastro com e-mail/senha, verificação de e-mail e recuperação de senha.

Cloud Firestore: O coração da nossa gamificação. Utilizado como um banco de dados NoSQL para salvar o perfil e o progresso de cada usuário (XP, nível, último desempenho, etc.) de forma persistente e em tempo real.

Arquitetura em Camadas (Refatorada): O código foi reestruturado para seguir princípios de Arquitetura Limpa, separando as responsabilidades de forma clara:

core: Camada que contém toda a lógica de negócio, modelos de dados e comunicação com serviços externos (Firebase). É o cérebro do app.

presentation: Camada responsável por tudo que o usuário vê e interage (telas, widgets e tema visual).

Gerenciamento de Estado com Provider: Para lidar com a complexidade do estado da UI, especialmente na autenticação, utilizamos o Provider. O AuthController centraliza toda a lógica de formulários, validação e comunicação com os serviços, mantendo a camada de presentation limpa e reativa.

3. O que já está funcionando (Features)
✅ Sistema de Autenticação Completo: Cadastro, login, verificação de e-mail e recuperação de senha.

✅ Quiz de Múltipla Escolha: Sistema de quiz interativo com feedback visual instantâneo (certo/errado) e avanço automático.

✅ Gamificação e Progressão:

Sistema de Níveis e XP: O usuário ganha XP ao completar quizzes, subindo de nível automaticamente.

Títulos Mágicos: Cada nível corresponde a um título (Aprendiz, Escrivão, Mago), reforçando a jornada do usuário.

Persistência de Dados: O perfil do usuário, com seu XP e nível, é salvo no Cloud Firestore.

✅ Tela "Meu Grimório" (Perfil Dinâmico):

Exibe o nome, nível e título mágico do usuário.

Mostra uma barra de progresso visual para o próximo nível.

Apresenta um card com o desempenho do último quiz realizado.

✅ Estrutura de Código Profissional: O projeto foi totalmente refatorado para uma arquitetura em camadas (core e presentation), garantindo organização e escalabilidade.

✅ Tema Visual Centralizado: Um ThemeData global garante uma identidade visual coesa em todo o aplicativo.

4. Próximos Passos
Agora com a fundação do app sólida, nosso foco se volta para aprofundar a experiência de gamificação e conteúdo.

⏳ Rastrear Progresso por Livro: Implementar a lógica para salvar a conclusão de cada quiz, permitindo estatísticas como "Tomos Lidos" e a aplicação de regras de XP decrescente em repetições.

⏳ Implementar o Mapa de Mundos: Criar a interface visual para cada livro, onde os capítulos são "nós" a serem desbloqueados, como descrito na documentação (RF3).

⏳ Criar a "Estante de Conquistas": Desenvolver o sistema de badges e achievements para recompensar feitos específicos dos usuários.

⏳ Otimização de Performance: Investigar e resolver a lentidão inicial do aplicativo (Skipped frames) para garantir uma experiência de usuário fluida desde o primeiro segundo.

5. Como Executar o Projeto
Clone o repositório: git clone https://github.com/gabriel-correa11/grimorio_6sem.git

Garanta que o Flutter está instalado (flutter doctor).

Execute flutter pub get para baixar as dependências.

Execute flutter run para iniciar o aplicativo em um emulador ou dispositivo.

<hr>

<div id="english-version"></div>

English Version
<details>
<summary>Click to expand</summary>

<div align="center">
<h1>Project Grimorio</h1>
</div>

<div align="center">

Project Status: In Active Development 🚀

</div>

This is the repository for our college project, Grimorio. The goal is to create a mobile application in Flutter that uses gamification to encourage the reading habit by turning each book into a journey of progression and knowledge.

1. The Problem We Want to Solve
In a world where books compete for attention with social media and games that offer instant rewards, Grimorio aims to use the same logic in favor of reading. The app is designed to give the user a tangible sense of progress and achievement with each completed chapter and quiz.

2. Architecture and Technical Decisions
The project was built with a focus on scalability, maintainability, and performance, using a clean architecture and modern technologies.

Flutter & Dart: The primary choice for cross-platform development (Android/iOS) from a single codebase. Our previous experience with object-oriented programming made the transition to Dart smooth.

Firebase (Backend as a Service):

Firebase Authentication: Used for a robust and secure authentication system, including email/password sign-up, email verification, and password recovery.

Cloud Firestore: The heart of our gamification. Used as a NoSQL database to persistently save each user's profile and progress (XP, level, last quiz performance, etc.) in real-time.

Layered Architecture (Refactored): The code was restructured to follow Clean Architecture principles, clearly separating responsibilities:

core: The layer containing all business logic, data models, and communication with external services (Firebase). It's the app's brain.

presentation: The layer responsible for everything the user sees and interacts with (screens, widgets, and visual theme).

State Management with Provider: To handle UI state complexity, especially in authentication, we used Provider. The AuthController centralizes all form logic, validation, and communication with services, keeping the presentation layer clean and reactive.

3. What's Already Working (Features)
✅ Complete Authentication System: Sign-up, login, email verification, and password recovery.

✅ Multiple-Choice Quiz: An interactive quiz system with instant visual feedback (correct/incorrect) and automatic progression.

✅ Gamification and Progression:

Level and XP System: Users earn XP by completing quizzes, leveling up automatically.

Magical Titles: Each level corresponds to a title (Apprentice, Scribe, Mage), reinforcing the user's journey.

Data Persistence: The user's profile, with their XP and level, is saved in Cloud Firestore.

✅ "My Grimoire" Screen (Dynamic Profile):

Displays the user's name, level, and magical title.

Shows a visual progress bar for the next level.

Presents a card with the performance from the last quiz taken.

✅ Professional Code Structure: The project was fully refactored into a layered architecture (core and presentation), ensuring organization and scalability.

✅ Centralized Visual Theme: A global ThemeData ensures a cohesive visual identity throughout the app.

4. Next Steps
With the app's foundation now solid, our focus shifts to deepening the gamification experience and content.

⏳ Track Progress per Book: Implement the logic to save the completion of each quiz, enabling stats like "Tomes Read" and applying diminishing XP rules for repeats.

⏳ Implement the World Map: Create the visual interface for each book, where chapters are "nodes" to be unlocked, as described in the documentation (RF3).

⏳ Create the "Achievement Shelf": Develop the system for badges and achievements to reward specific user accomplishments.

⏳ Performance Optimization: Investigate and resolve the app's initial startup slowness (Skipped frames) to ensure a fluid user experience from the very first second.

5. How to Run the Project
Clone the repository: git clone https://github.com/gabriel-correa11/grimorio_6sem.git

Ensure Flutter is installed (flutter doctor).

Run flutter pub get to download dependencies.

Run flutter run to start the application on an emulator or device.

</details>
