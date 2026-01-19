# 🥒 Rick and Morty Wiki

![Swift](https://img.shields.io/badge/Swift-5.5+-orange.svg)
![Platform](https://img.shields.io/badge/Platform-iOS%2015.0+-lightgrey.svg)
![License](https://img.shields.io/badge/UI-UIKit%20(Code)-blue.svg)
![Architecture](https://img.shields.io/badge/Architecture-MVVM-green.svg)

Демонстрационное iOS-приложение для просмотра персонажей вселенной "Рик и Морти". 
Проект написан для демонстрации работы с **Modern Concurrency (Async/Await)**, чистой архитектуры **MVVM** и верстки кодом.

## 📱 Демонстрация (Demo)

| Live Demo (GIF) | Список персонажей | Детальный экран |
|:---:|:---:|:---:|
| <img src="https://github.com/user-attachments/assets/a47bb4c1-7583-4d73-8a95-e3843912ed1c" width="230" /> | <img src="https://github.com/user-attachments/assets/25e841a4-3e65-4836-a1a2-10fc92838dca" width="230" /> | <img src="https://github.com/user-attachments/assets/60cb8875-99ae-4c80-88cb-290ba16a38b5" width="230" /> |
## 🛠 Технологический стек

* **Language:** Swift 5+
* **UI:** UIKit (No Storyboards, Programmatic UI)
* **Networking:** URLSession + Swift Concurrency (Async/Await)
* **Architecture:** MVVM (Model-View-ViewModel) + State Driven
* **Data:** REST API (Rick and Morty API)
* **Layout:** Auto Layout (NSLayoutAnchor)

## 💡 Реализованные фичи

### 1. Modern Concurrency
Сетевой слой полностью построен на `async/await` и `Actors`. Это позволяет писать асинхронный код линейно, избегая "Callback Hell" и утечек памяти в замыканиях.

### 2. State Management
ViewModel управляет состоянием экрана через Enum (`.loading`, `.success`, `.error`). View реактивно обновляется при смене состояния.

### 3. Производительность (Performance)
* **Custom Image Caching:** Картинки загружаются один раз и хранятся в памяти.
* **Reusable Cells:** Корректная обработка переиспользования ячеек (`prepareForReuse`) и отмена загрузки изображений при быстром скролле.

### 4. UI/UX
* Верстка полностью кодом (читаемость и контроль).
* Обработка ошибок (Alerts) и состояний загрузки (Activity Indicator).

---
## 👨‍💻 Автор

**Димитрий Кондратенко** — Junior iOS Developer  
Telegram: [@KondratenkoDev](https://t.me/KondratenkoDev)
