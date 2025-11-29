
# 🌎 Bolden: The World Explorer App (Flutter)

A **Flutter** cross-platform mobile application built for exploring the world's countries.
---

## ✨ Key Features

* **Global Country Listing:** View all countries with essential details in a scrollable grid.
* **Search & Filter:** Quickly find countries by **Name**, **Capital**, or **Region**.
* **Dynamic Sorting:** Sort the country list by **Name** (A-Z/Z-A) or **Population** (Ascending/Descending).
* **Detailed Views:** Navigate to a dedicated screen for in-depth information, including **Flag**, **Capital**, **Population**, **Currencies**, **Languages**, and **Border Countries** (which are clickable for quick navigation).
* **Favorites Persistence:** Add and remove countries from a dedicated **Favorites** list, persisted locally using `shared_preferences`.
* **Modular Navigation:** A main `BottomNavigationBar` controls navigation across key app sections (Home, Favorites, Map/Explore, Game, Settings).

---

## ⚙️ Tech Stack & Dependencies


    bolden/
    ├── lib/
    │   ├── models/            # Data Models (Country, Currency)
    │   ├── services/          # API Services (CountryService)
    │   ├── providers/         # Application State/Business Logic (CountryProvider, FavoritesProvider, ThemeProvider)
    │   ├── screens/           # Main application pages (HomeScreen, DetailScreen, SettingsScreen)
    │   └── widgets/           # Reusable UI components (CountryCard, SearchBarWidget)

---

## 🧠 Application Architecture


### 1. Project Structure
bolden/
├── lib/
│   ├── models/            # Data Models (Country, Currency)
│   ├── services/          # API Services (CountryService)
│   ├── providers/         # Application State/Business Logic (CountryProvider, FavoritesProvider, ThemeProvider)
│   ├── screens/           # Main application pages (HomeScreen, DetailScreen, SettingsScreen)
│   └── widgets/           # Reusable UI components (CountryCard, SearchBarWidget)

---

## 2. State Management (Provider)

The application uses the **Provider** package to manage state, relying on the **ChangeNotifier** pattern for updates across the UI.

| Provider Class | Core Functionality | Data Persistence |
| :--- | :--- | :--- |
| **`CountryProvider`** | Fetches, caches, searches, filters, and sorts the main country list. Handles API status (`loading`, `loaded`, `error`). | None (In-memory cache) |
| **`FavoritesProvider`** | Manages the list of favorite country codes (`isFavorite`, `toggleFavorite`). | `shared_preferences` |
| **`ThemeProvider`** | Controls the application's current `ThemeMode` (Light/Dark). | `shared_preferences` |

### 3. Data Flow

1.  **Service Layer:** `CountryService` handles all networking, using the `http` package to fetch raw JSON data from the external country API endpoint.
2.  **Model Layer:** Raw JSON is immediately mapped into **immutable** Dart objects (**Country** and **Currency** models) using `fromJson` factory constructors that include robust null-handling.
3.  **Provider Layer:** `CountryProvider` consumes the models from the Service layer, stores the main list, and applies UI-specific logic (searching, sorting). It then notifies listening widgets of state changes.
4.  **UI Layer:** Screens and Widgets listen to the Providers and render the appropriate content based on the current state (Loading, Error, or Loaded Data).

---

## 🛠️ Installation & Setup

### Prerequisites

* **Flutter SDK** (Latest stable version recommended)
* **Dart SDK**

### Steps to Run

1.  **Clone the Repository:**
    ```bash
    git clone https://github.com/HaiderBey/country-explorer
    cd bolden
    ```

2.  **Install Dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Run the Application:**
    Connect a device or start an emulator and run:
    ```bash
    flutter run
    ```
