# Clothiva: Flutter E-Commerce App

![Status](https://img.shields.io/badge/status-in_development-blue) ![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white) ![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black) ![GetX](https://img.shields.io/badge/GetX-8A2BE2?style=for-the-badge)

---

## 📝 Project Overview

Clothiva is a full-stack, real-time e-commerce application built for iOS and Android using Flutter and the Firebase suite. This project demonstrates a comprehensive understanding of cross-platform development, from initial UI/UX and static builds to secure backend integration with Firebase Authentication and Cloud Firestore.

It features robust, real-time CRUD operations for managing products, categories, and user data, and implements an advanced collaboration feature **"Shared Wishlist"**, that fulfills the core project objective for a collaborative, real-time sharing feature.

|                                                   Dark Mode                                                   |                                                   Light Mode                                                    |
| :-----------------------------------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------------------------------------: |
| ![Clothiva App Dark Mode](https://res.cloudinary.com/dcirfqr6o/image/upload/v1762534624/dark_mode_rkqvty.png) | ![Clothiva App Light Mode](https://res.cloudinary.com/dcirfqr6o/image/upload/v1762534627/light_mode_jfloc9.png) |

---

## 👥 Flutter Cross Mobile Application Team Members

### Contributors

- **Mazen Wahed:** Project Lead, Firebase Auth, Core Structure, Shared Wishlist
- **Kholoud Nabil:** Frontend (Home & Store Screens), Local Wishlist
- **Ali Hassan:** Frontend (Product Details, Ratings, Sub-Categories, All Products)
- **Youssef Hassan:** Backend (Product Details, Brands, Sub-Categories)
- **Youssef Hesham:** Full-Stack (Addresses, Cart, Orders, Checkout), Invitation Feature

---

## ✨ Key Features

This project meets all core requirements of a full-stack mobile application, including:

- **Firebase Authentication:** Secure user registration, login, and password reset system.
- **Real-Time Firestore Database:** Implements full CRUD (Create, Read, Update, Delete) operations for all core features (Products, Categories, Cart, Orders). All data is synced in real-time across devices.
- **Collaborative Sharing Feature:** A unique **Shared Wishlist** allows users to invite friends via an invitation system to build a list together.
- **Full E-Commerce Flow:** Complete user journey from browsing (Home, Store, Categories) to purchase (Cart, Checkout, Order History).
- **Clean State Management:** Uses GetX for efficient state management as data flows from Firebase to the UI.
- **Cross-Platform UI:** A single, high-quality codebase for a responsive UI on both iOS and Android.

---

## 🛠️ Tech Stack

- **Framework:** Flutter
- **Backend:** Firebase (Authentication, Cloud Firestore)
- **State Management:** GetX
- **Local Storage:** GetStorage
- **Image Storage:** Cloudinary

---

## 📂 Project Structure

```
lib/
├── 📁 bindings/            # GetX Bindings for dependency injection
│
├── 📁 common/              # Globally reusable widgets and styles
│   ├── 📁 styles/          # Spacing, shadows, etc.
│   └── 📁 widgets/         # Custom app bars, buttons, shimmers, etc.
│
├── 📁 data/                # Data layer
│   ├── 📁 repositories/    # Repositories for Auth, User, Product, Category, etc.
│   └── 📁 services/        # Services (Cloudinary Storage)
│
├── 📁 features/            # All app feature screens, controllers, and models
│   ├── 📁 authentication/  # Login, Signup, Email Verification, Password Reset
│   ├── 📁 cart/            # Cart
│   ├── 📁 checkout/        # Checkout, Payment
│   ├── 📁 order/           # Order history
│   ├── 📁 invitation/      # Invitation Feature
│   ├── 📁 personalization/ # User Profile, Settings, Change Name, Address
│   └── 📁 shop/            # Home, Store, Categories, Brands, Wishlist (Local & Shared)
│           └── 📁 product/        # Product Details, Ratings
│
└── 📁 utils/               # Core utilities
    ├── 📁 constants/       # Enums, API keys, image strings, sizes
    ├── 📁 device/          # Device-specific helpers
    ├── 📁 exceptions/      # Firebase Exceptions
    ├── 📁 formatters/      # Text formatters
    ├── 📁 helpers/         # Helper functions
    ├── 📁 local_storage/   # GetStorage function Bucket
    ├── 📁 popups/          # Loaders
    ├── 📁 themes/          # App themes (light & dark)
    └── 📁 validators/      # Input validation
```

---

## 🚀 Project Timeline & Progress

### 1. Project Plan & Deliverables

| Week  | Tasks                                                                                                                | Deliverables                                                                                            |
| :---- | :------------------------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------ |
| **1** | • Project Setup<br>• UI/UX Design (wireframes)<br>• Build Static UI                                                  | • Initialized Flutter project on GitHub<br>• Wireframes for main screens<br>• Static UI screens ready   |
| **2** | • Integrate Firebase (Android & iOS)<br>• Implement Firebase Authentication<br>• Design Firestore database structure | • Firebase connected<br>• Functional login & registration<br>• Firestore configured with security rules |
| **3** | • Implement CRUD operations<br>• Manage app state (real-time)<br>• Write Unit Tests                                  | • CRUD working with real-time updates<br>• Unit tests passing<br>• Functional documentation written     |
| **4** | • Implement sharing feature<br>• End-to-end testing<br>• Prepare for release                                         | • Working sharing feature<br>• Final tested app<br>• Release-ready builds                               |

---

### 2. Progress Log

| Date       | Member         | Update                                                     |
| :--------- | :------------- | :--------------------------------------------------------- |
| 2025-09-16 | Mazen Wahed    | Setup Firebase + Auth repository                           |
| 2025-09-20 | Mazen Wahed    | Login/Reset Firebase + Added New Files                     |
| 2025-10-04 | Kholoud Nabil  | Home & Store Screen (Frontend)                             |
| 2025-10-05 | Ali Hassan     | Product Detail Page (Started)                              |
| 2025-10-06 | Mazen Wahed    | Settings + Storage Service + New Files                     |
| 2025-10-06 | Ali Hassan     | Product Detail widgets & image slider                      |
| 2025-10-12 | Mazen Wahed    | Store & Settings (Firestore) + Update V1.1                 |
| 2025-10-16 | Ali Hassan     | Product Details Screen (Finished)                          |
| 2025-10-20 | Ali Hassan     | User Ratings and Reviews (Frontend)                        |
| 2025-10-22 | Ali Hassan     | Sub-Categories & All Products pages (Frontend)             |
| 2025-10-22 | Youssef Hassan | Backend for Product Details, Brands & Sub-Categories       |
| 2025-10-26 | Youssef Hesham | Created Addresses, Cart, Orders & Checkout (Full-Stack)    |
| 2025-10-31 | Mazen Wahed    | Pushed Update V2.0                                         |
| 2025-11-01 | Youssef Hesham | Implemented Invitation feature                             |
| 2025-11-02 | Youssef Hesham | Added user email checks for Invitation controller          |
| 2025-11-03 | Mazen Wahed    | Pushed Update V2.1 (Shared Wishlist)                       |
| 2025-11-04 | Mazen Wahed    | Pushed V2.2 (Bug Fixes)                                    |
| 2025-11-07 | Mazen Wahed    | Pushed V2.3 (Refactor, bug fixes, & profile enhancements)  |
| 2025-11-08 | Mazen Wahed    | Pushed V2.4 (Theme Feature, Realtime Wishlist & bug fixes) |

---

### 3. Version History (Changelog)

#### V2.4 (Latest)

- **New Feature: Theme Control:** Implemented 3-state theme switching (System Default, Light, Dark) accessible via the Settings Appbar. Theme preference is saved locally using GetStorage.
- **Realtime Shared Wishlist:** The shared wishlist now updates in real-time for all users using a Stream instead of a FutureBuilder, so all collaborators see new items added by others instantly.
- **Cart Bug Fix:** Fixed a bug where the "Remove Item" dialog would persist after the item was removed. The dialog now closes correctly, and a confirmation snackbar is shown.
- **Core Cleanup:** Explicitly added all major Repositories (Product, Brand, Category, etc.) to `GeneralBindings` to ensure robust dependency injection and prevent runtime errors.
- **Refactor:** Removed unnecessary nested `Obx` widget inside the Profile Screen for cleaner state management.
- **Cleanup:** Removed several redundant and unused files from the project source code.

#### V2.3

- **Auth & Profile:**

  - New Feature: Added "Gender" to the Sign-Up form and Profile screen.
  - New Feature: Profile fields for "Gender" and "Phone Number" can now be updated by the user after registration (especially for Google Sign-In users).
  - New Feature: User ID is now copyable from the profile screen.
  - Bug Fix: Fixed a critical bug where the "Verify Email" timer would persist after logout, conflicting with Google Sign-In and showing the wrong success screen.

- **Checkout & Address:**

  - New Feature: The Checkout process is now blocked if no shipping address is selected, with a warning snackbar shown.
  - Bug Fix: Fixed an infinite loading bug caused by a conflict between snackbars and dialogs when selecting an address.
  - Refactor: Removed the non-functional "Promo Code" section from the checkout screen.
  - UI/UX: Removed the "View All" button from the "Selected Address" section in checkout.

- **Product & Home:**

  - New Feature: The "View All" button for "Products Flash Sale" on the home screen now correctly links to a page showing _all_ sale items.
  - Bug Fix: Fixed a major bug where the price and stock status ("In Stock" / "Out of Stock") would not update when a product variation was selected.
  - Refactor: Removed the hard-coded (fake) "Product Reviews" feature to improve honesty and focus on core, functional features.
  - UI/UX: The home screen search bar is no longer "dead" and now displays a "Coming Soon" snackbar on tap.

- **Core & Refactor:**
  - Refactor: Cleaned up the Settings screen by removing unnecessary tiles.
  - Refactor: Simplified theme management by removing `context_extension.dart` and relying on GetX (`context.isDarkMode`).
  - Refactor: Refactored `Order` logic into its own controller from `CheckoutController`.

#### V2.2

- **Wishlist:** Fixed a minor bug upon sending invites to people already in a group.
- **Wishlist:** Added a check for duplicate invites.
- **Core:** Removed unnecessary repositories to clean up the data layer.

#### V2.1

- **New Feature:** Implemented the Shared Wishlist & Invitation System (by Mazen Wahed & Youssef Hesham).
- **Theme:** Fixed the Log Out button theme in Dark Mode.

#### V2.0 (Big Update)

- **UI/UX:** Added animations to Wishlist, Cart & Order screens.
- **Theme:** Fixed Light & Dark mode themes for Dropdown Menus.
- **Data:** Fixed Dummy Data for Category Product & Brand Category.
- **User:** Users can now add their orders & addresses to Firestore (by Youssef Hesham).
- **Home:** `product_card_vertical.dart` is now fully responsive.
- **Product:** Implemented full Product Details, Ratings, & Reviews (by Ali Hassan & Youssef Hassan).
- **Product:** Fixed `variation_controller.dart`; attributes & variations now work properly and are fully connected to the Cart.
- **Cart:** Cart feature added (by Youssef Hesham).
- **Checkout:** Checkout feature added (by Youssef Hesham).
- **Order:** Fixed `order_repository.dart` to show user's orders on Firestore properly.
- **Category:** Sub-Category Screen added (by Ali Hassan & Youssef Hassan) and fixed `category_repository`.

#### V1.1

- **Store:** Store Screen categories are now fully connected to Firebase.
- **Core:** Updated Load Data Screen; all data has been uploaded to Firestore & Cloudinary.
- **Core:** Refactored `success_signup_screen` to a reusable `success_screen`.
- **UI/UX:** Updated shimmers, brand icons, and border colors.

#### V1.0 (Major Update)

- **Home:** Home Screen (Categories & Banners) is fully connected to Firebase.
- **Screens:** Implemented Product Detail, Wishlist UI, Settings, and Profile screens.
- **Profile:** Authenticated User data is fully connected to User Settings.
- **Core:** Log out feature is functional in the Settings Menu.
- **Backend:** Added new Repositories, Models, and Dummy Data for core features (Categories, Brands, Products, Cart, etc.).
- **Backend:** Integrated Cloudinary Service for image storage.

#### V0.1b

- **Auth:** Integrated Firebase for Login & Forget Password.
- **Auth:** Added an initial Log out feature.

#### V0.1 (Project Init)

- Initialized Flutter project, themes, and folder structure.
- Configured Firebase & `google-services.json`.
- Implemented Sign Up Screen (UI + Firebase Authentication + Firestore).
- Created initial Authentication & User repositories.

---

## 🤝 Contribution Rules

### Update Rules (Important)

1.  **Only update your section**
    - Don’t overwrite or delete other members' work.
2.  **Log progress in the Progress Log table**
    - Add date + short description of what you did.
3.  **Use clear commit messages**
    - Example: `feat: added wishlist UI` or `fix: resolved cart variation bug`
4.  **Always pull before pushing**
    - Run: `git pull origin main` before making changes.
    - Resolve any conflicts locally before pushing.
5.  **Communicate big changes**
    - If you change project structure or shared files, notify the team on WhatsApp.
