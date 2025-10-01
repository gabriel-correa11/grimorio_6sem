# 🏰 Projeto Grimorio - Aplicativo de Gamificação de Leitura

**Status do Projeto:** Em Desenvolvimento Ativo

Este é o repositório oficial do projeto Grimorio, um aplicativo mobile desenvolvido como projeto para a disciplina de [Nome da Disciplina]. O objetivo é combater o declínio do hábito de leitura através de uma plataforma que gamifica a experiência literária.

---

### Tecnologias Utilizadas

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=Dart&logoColor=white)
![Firebase](https://img.shields.io/badge/firebase-%23039BE5.svg?style=for-the-badge&logo=firebase&logoColor=white)
![IntelliJ IDEA](https://img.shields.io/badge/IntelliJIDEA-000000.svg?style=for-the-badge&logo=intellij-idea&logoColor=white)

---

### 1. Problematização

O projeto propõe uma intervenção direta na atual cultura de consumo de conteúdo, onde a leitura profunda tem sido sistematicamente substituída por interações digitais superficiais. O problema central é a dificuldade de o livro, como mídia, competir em um ambiente saturado por estímulos de recompensa imediata. Para quebrar esse ciclo, o Grimorio funciona como um ecossistema de incentivo à leitura, construindo uma jornada interativa com elementos de progressão que tornam o ato de ler uma experiência mais estimulante.

---

### 2. Decisões de Arquitetura e Tecnologia

A escolha da stack tecnológica foi pautada na agilidade, performance e na experiência prévia da equipe.

* **Flutter & Dart:** Escolhido como framework principal devido à sua alta performance e capacidade de compilação nativa para múltiplas plataformas (Android e iOS) a partir de um único código-base. A linguagem Dart, por ser fortemente tipada e orientada a objetos, ofereceu uma transição suave para desenvolvedores com background em Java, acelerando o ciclo de aprendizado.

* **Firebase (Backend-as-a-Service):** Selecionado para gerenciar a autenticação de usuários. Utilizar o Firebase Authentication nos permitiu implementar um sistema de login e cadastro seguro e escalável (com e-mail/senha) sem a necessidade de construir e manter um backend do zero, permitindo que a equipe foque nas funcionalidades core do aplicativo.

* **Arquitetura Limpa (Clean Architecture):** O projeto foi estruturado seguindo o princípio de **Separação de Responsabilidades (SoC)**. O código está dividido em camadas distintas para garantir manutenibilidade e escalabilidade:
    * **`models` (`book.dart`):** Classes Puras (POJOs/POCOs) que definem a estrutura de dados da aplicação (Livros, Questões).
    * **`logic` (`quiz_brain.dart`):** Camada de lógica de negócios, totalmente desacoplada da UI. O `QuizBrain` gerencia o estado do jogo, as regras e os dados, sem saber como a UI é renderizada.
    * **`screens`:** Widgets que representam telas completas e gerenciam o estado da UI (`StatefulWidget`).
    * **`widgets`:** Widgets menores, reutilizáveis e "burros" (`StatelessWidget`), que recebem dados e os renderizam, promovendo a componentização.

---

### 3. Funcionalidades Implementadas

Até o momento, a base funcional do aplicativo foi concluída, incluindo:

#### 3.1. Autenticação Completa de Usuários
- **Tecnologia:** `firebase_auth`.
- **Descrição:** Implementação de uma tela de autenticação (`AuthPage`) que permite o **cadastro (`createUserWithEmailAndPassword`)** e **login (`signInWithEmailAndPassword`)** de usuários. As operações são assíncronas (`async/await`) para não bloquear a interface. Em caso de sucesso, o usuário é redirecionado para a home do app. A gestão de sessões é controlada pelo Firebase.

#### 3.2. Fluxo de Navegação e Múltiplas Telas
- **Tecnologia:** `MaterialApp Router` (Named Routes).
- **Descrição:** O aplicativo possui um fluxo de navegação claro entre múltiplas telas, gerenciado por rotas nomeadas (`/auth`, `/`, `/quiz`). A tela de seleção de livros (`BookSelectionPage`) passa o índice do livro selecionado como `arguments` para a tela de quiz (`QuizPage`), que por sua vez utiliza o `ModalRoute` para receber e processar essa informação, carregando o quiz correto.

#### 3.3. Módulo de Quiz Dinâmico e Interativo
- **Tecnologia:** `StatefulWidget`, `setState`, `rflutter_alert`.
- **Descrição:** O coração do app. A tela de quiz é um `StatefulWidget` que se reconstrói a cada resposta através do `setState`, atualizando a pergunta e a pontuação. A lógica é totalmente controlada pela classe `QuizBrain`. Ao final do quiz, um alerta customizado (`rflutter_alert`) é exibido com a pontuação final, e o usuário pode optar por voltar à tela de seleção, completando o ciclo de jogo.

#### 3.4. Arquitetura de UI Componentizada
- **Tecnologia:** `StatelessWidget`.
- **Descrição:** A UI foi refatorada em componentes reutilizáveis, como `QuestionDisplay` (para exibir o texto da pergunta) e `AnswerButton` (um botão de resposta genérico que recebe cor e função como parâmetros). Isso simplificou drasticamente o método `build` da tela principal, tornando-o mais legível e fácil de manter.

#### 3.5. Sistema de Tema e Identidade Visual
- **Tecnologia:** `ThemeData`.
- **Descrição:** Foi criado e aplicado um tema global no `MaterialApp` para garantir consistência visual em todo o aplicativo. Cores primárias, de fundo, estilos de `AppBar`, `ElevatedButton` e `OutlinedButton` foram centralizados, facilitando futuras alterações de design.

---

### 4. Próximos Passos (Roadmap)

1.  **Perfil do Usuário:** Criar uma tela de perfil onde o usuário possa ver seu progresso e fazer logout.
2.  **Gamificação (V2):** Implementar o salvamento de progresso (livros concluídos, pontuação total/XP) no Firebase (Firestore).
3.  **Quiz de Múltipla Escolha:** Evoluir o `QuizBrain` e a UI para suportar questões de múltipla escolha, em vez de apenas Verdadeiro/Falso.

---

### 5. Como Executar o Projeto

1.  Clone este repositório: `git clone [URL_DO_SEU_REPO]`
2.  Garanta que o Flutter SDK está instalado e o ambiente configurado (`flutter doctor`).
3.  Crie o arquivo `android/local.properties` com os caminhos para o seu SDK do Flutter e do Android.
4.  Execute `flutter pub get` para instalar as dependências.
5.  Execute `flutter run` para iniciar o aplicativo em um dispositivo ou emulador.