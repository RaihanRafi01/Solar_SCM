# **SCUBE SCM: Control & Monitoring System**

**SCUBE SCM** is a mission-critical industrial monitoring solution designed for real-time visibility into energy infrastructure. It bridges the gap between complex hardware data and human oversight through high-fidelity visualization, enabling engineers to monitor power distribution, analyze consumption trends, and manage revenue-to-cost ratios in one centralized dashboard.

---

## **🏗️ Architecture**

This project follows a **Layered Clean Architecture** pattern using the GetX ecosystem. It is designed for maximum separation of concerns, making the codebase highly testable and scalable.

### **Folder Structure**

```text
lib/
├── app/
│   ├── core/                  # Engine Room: Global configurations
│   │   ├── bindings/          # Global dependency injection
│   │   ├── constants/         # App assets (app_assets.dart)
│   │   └── theme/             # Theming (colors, styles, theme data)
│   ├── data/                  # Repository Layer (API/Storage)
│   │   ├── datasource/        # Remote & Local providers
│   │   ├── model/             # Data Transfer Objects (DTOs)
│   │   └── services/          # Long-running background processes
│   ├── modules/               # Feature Modules (Binding, Controller, View)
│   │   ├── authentication/    # Auth & Security
│   │   └── scm/               # Dashboard & Monitoring logic
│   └── routes/                # Named Routing Manifest (app_pages, app_routes)
├── main.dart                  # App Entry Point
└── shared/                    # Reusable UI & Feature-specific widgets

```

---

## **🚀 Getting Started**

### **Prerequisites**

* **Flutter SDK** (Latest Stable)
* **Dart SDK**
* **GetX CLI** (Optional, for scaffolding)

### **Installation & Running**

1. **Clone & Install:**
```bash
git clone https://github.com/RaihanRafi01/Solar_SCM.git
flutter pub get

```


2. **Run the app:**
```bash
flutter run

```


---

## **🛠️ Technical Stack**

* **State Management:** `GetX` (Reactive logic using `.obs`)
* **Responsive UI:** `flutter_screenutil` (Base design: 360x800)
* **Vector Graphics:** `flutter_svg`
* **Typography:** `google_fonts`

---

## **📁 Key Directories & Logic**

### **4.1 Custom Graphics Engine**

The application utilizes the `CustomPainter` API for precision industrial graphics:

* **`CustomArcPainter`**: A mathematical implementation using Start and Sweep angles to represent dynamic energy loads.
* **Power Circular Indicator**: A multi-layered stack with a background track and an animated foreground value.

### **4.2 Navigation Lifecycle**

Navigation is strategically handled using **Named Routes** to optimize device memory:

### **4.3 Theming System**

Located in `lib/app/core/theme/`:

* **`app_colors.dart`**: Defines the semantic color palette for industrial monitoring.
* **`app_text_styles.dart`**: Standardized typography scaling via Google Fonts.
* **`app_theme.dart`**: Unified Light and Dark mode configurations.

---

## **📦 Module Breakdown**

### **🔐 Authentication**

* **UI**: Responsive login form with integrated validation.
* **Logic**: Reactive session initialization and password visibility toggles.

### **📊 SCM (Summary & Monitoring)**

* **Real-time List**: A custom-built scrollable list with a **Gradient Bottom Fade** and **Custom Scrollbar Thumb**.
* **Switching Logic**: A custom `enum` state in the `ScmController` dictates the rendering of Summary, Action Grid, or Detail views within a single `Obx` widget.

### **📈 Data Detail**

* **Interactive Toggles**: Seamless switching between "Data View" (Usage metrics) and "Revenue View" (Financial cost).
* **Smooth Transitions**: Uses `AnimatedCrossFade` for "Data & Cost Info" panels to ensure a fluid user experience.

---

## **📄 License**

Copyright © 2025 SCUBE. All rights reserved.

---