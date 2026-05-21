# Repository GitHub — Workshop Flutter Avancé

## Structure complète du projet

```text
flutter-advanced-workshop/
│
├── README.md
├── .gitignore
├── analysis_options.yaml
├── pubspec.yaml
├── firebase.json
├── firestore.rules
├── .env.example
│
├── assets/
│   ├── images/
│   │   ├── logo.png
│   │   ├── empty.png
│   │   └── chatbot.png
│   │
│   └── animations/
│       └── loading.json
│
├── lib/
│   ├── main.dart
│   │
│   ├── core/
│   │   ├── constants/
│   │   │   ├── app_colors.dart
│   │   │   ├── app_theme.dart
│   │   │   └── api_constants.dart
│   │   │
│   │   ├── utils/
│   │   │   ├── validators.dart
│   │   │   ├── extensions.dart
│   │   │   └── logger.dart
│   │   │
│   │   └── services/
│   │       ├── auth_service.dart
│   │       ├── firestore_service.dart
│   │       ├── api_service.dart
│   │       ├── cache_service.dart
│   │       └── ai_service.dart
│   │
│   ├── data/
│   │   ├── models/
│   │   │   ├── user_model.dart
│   │   │   ├── task_model.dart
│   │   │   ├── post_model.dart
│   │   │   └── message_model.dart
│   │   │
│   │   ├── repositories/
│   │   │   ├── auth_repository.dart
│   │   │   ├── task_repository.dart
│   │   │   ├── post_repository.dart
│   │   │   └── chat_repository.dart
│   │   │
│   │   └── providers/
│   │       ├── auth_provider.dart
│   │       ├── task_provider.dart
│   │       ├── post_provider.dart
│   │       └── theme_provider.dart
│   │
│   ├── presentation/
│   │   ├── pages/
│   │   │   ├── splash_page.dart
│   │   │   ├── login_page.dart
│   │   │   ├── signup_page.dart
│   │   │   ├── home_page.dart
│   │   │   ├── posts_page.dart
│   │   │   ├── chatbot_page.dart
│   │   │   └── settings_page.dart
│   │   │
│   │   ├── widgets/
│   │   │   ├── custom_textfield.dart
│   │   │   ├── task_card.dart
│   │   │   ├── loading_widget.dart
│   │   │   ├── post_tile.dart
│   │   │   ├── empty_widget.dart
│   │   │   └── message_bubble.dart
│   │   │
│   │   └── navigation/
│   │       ├── app_router.dart
│   │       └── routes.dart
│   │
│   └── firebase_options.dart
│
├── test/
│   ├── unit/
│   │   ├── post_model_test.dart
│   │   ├── auth_repository_test.dart
│   │   └── cache_service_test.dart
│   │
│   └── widget/
│       ├── login_page_test.dart
│       ├── home_page_test.dart
│       └── chatbot_page_test.dart
│
├── docs/
│   ├── workshop_slides.pdf
│   ├── architecture.png
│   └── setup_guide.md
│
└── screenshots/
    ├── login.png
    ├── home.png
    ├── posts.png
    └── chatbot.png
```

---

# README.md

````md
# Flutter Advanced Workshop

Workshop interactif Flutter :
- Firebase Auth
- Firestore CRUD
- API REST
- Cache local Hive
- Performance Flutter
- Material 3
- IA Chatbot
- Tests unitaires et widgets

## Technologies

- Flutter 3.x
- Firebase
- Firestore
- Provider
- Hive
- HTTP
- Material 3

---

# Installation

## 1. Cloner le projet

```bash
git clone https://github.com/username/flutter-advanced-workshop.git
cd flutter-advanced-workshop
````

## 2. Installer les dépendances

```bash
flutter pub get
```

## 3. Configurer Firebase

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

## 4. Lancer le projet

```bash
flutter run
```

---

# Fonctionnalités

## Authentification Firebase

* Signup
* Login
* Logout
* Session persistante

## Firestore

* CRUD temps réel
* Synchronisation automatique

## API REST

* Consommation API
* Gestion erreurs
* FutureBuilder

## Cache Offline

* Hive
* Offline First

## UI

* Material 3
* Dark mode
* Navigation moderne

## IA

* Mini chatbot

## Tests

* Tests unitaires
* Tests widgets

---

# Structure Architecture

```text
Presentation
    ↓
Provider
    ↓
Repository
    ↓
Services
    ↓
Firebase / API
```

---

# Captures

| Login                      | Home                      |
| -------------------------- | ------------------------- |
| ![](screenshots/login.png) | ![](screenshots/home.png) |

---

# Workshop

Projet réalisé dans le cadre du cours :
Développement Multiplateforme — Flutter

````

---

# pubspec.yaml

```yaml
name: flutter_advanced_workshop

description: Workshop Flutter avancé

publish_to: 'none'

version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter

  cupertino_icons: ^1.0.6

  firebase_core: ^2.24.2
  firebase_auth: ^4.15.3
  cloud_firestore: ^4.13.6

  provider: ^6.1.1

  http: ^1.1.2

  hive: ^2.2.3
  hive_flutter: ^1.1.0

  flutter_dotenv: ^5.1.0

  lottie: ^2.7.0

  google_fonts: ^6.1.0

  flutter_spinkit: ^5.2.0

  intl: ^0.18.1

dev_dependencies:
  flutter_test:
    sdk: flutter

  flutter_lints: ^3.0.1

flutter:
  uses-material-design: true

  assets:
    - assets/images/
    - assets/animations/
    - .env
````

---

# .gitignore

```gitignore
.dart_tool/
.packages
.pub/
build/
android/.gradle/
ios/Pods/

.env
firebase_options.dart

.idea/
.vscode/
```

---

# firestore.rules

```js
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    match /tasks/{taskId} {
      allow read, write: if request.auth != null;
    }
  }
}
```

---

# main.dart

```dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Workshop',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const Scaffold(
        body: Center(
          child: Text('Flutter Workshop'),
        ),
      ),
    );
  }
}
```

---

# Branches Git recommandées

```text
main
│
├── step-0-setup
├── step-1-auth
├── step-2-firestore
├── step-3-api
├── step-4-cache
├── step-5-ui
├── step-6-ai
└── final-project
```

---

# Workflow pédagogique recommandé

## Avant le workshop

Le formateur prépare :

* Projet Firebase
* API key
* Repo GitHub
* Branches step-by-step

## Pendant le workshop

Les étudiants :

1. clonage repo
2. checkout branche
3. réalisation défis
4. commit progression

---

# Convention Git

```bash
git checkout -b feature/login

git add .

git commit -m "Add Firebase login"

git push origin feature/login
```

---

# Releases GitHub recommandées

```text
v1.0 - Setup Flutter
v1.1 - Firebase Auth
v1.2 - Firestore CRUD
v1.3 - API REST
v1.4 - Offline Cache
v1.5 - Material 3
v1.6 - AI Chatbot
v2.0 - Final Workshop
```

---

# GitHub Actions (CI Flutter)

Créer :
.github/workflows/flutter.yml

```yaml
name: Flutter CI

on:
  push:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3

      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.16.0'

      - run: flutter pub get

      - run: flutter analyze

      - run: flutter test
```

---

# Arborescence pédagogique recommandée

## Pour les étudiants

```text
step-0 = setup
step-1 = auth
step-2 = firestore
step-3 = api
step-4 = cache
step-5 = ui
step-6 = ai
final = solution complète
```

---

# Bonus : organisation des commits

```text
feat(auth): add firebase login
feat(api): add REST service
feat(cache): implement Hive storage
feat(ai): add chatbot page
fix(ui): improve loading state
refactor(home): split widgets
```

---

# Déploiement futur possible

* Firebase Hosting
* Android APK
* Play Store
* Web Flutter
* Desktop Flutter

---

# Ressources utiles

## Flutter

[https://flutter.dev](https://flutter.dev)

## Firebase

[https://firebase.google.com](https://firebase.google.com)

## Provider

[https://pub.dev/packages/provider](https://pub.dev/packages/provider)

## Hive

[https://pub.dev/packages/hive](https://pub.dev/packages/hive)

## HTTP

[https://pub.dev/packages/http](https://pub.dev/packages/http)

---

# Résultat final attendu

Application Flutter complète avec :

✅ Firebase Auth
✅ Firestore temps réel
✅ API REST
✅ Cache Offline
✅ Material 3
✅ Dark mode
✅ Architecture propre
✅ Provider
✅ Tests
✅ Chatbot IA
✅ Déploiement GitHub
