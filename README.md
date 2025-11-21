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
- **Ali Hassan:** Frontend (Product Details, Brands, Sub-Categories, All Products)
- **Youssef Hassan:** Backend (Product Details, Brands, Sub-Categories, All Products)
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
| 2025-11-09 | Mazen Wahed    | Pushed V2.5 (Search Feature, AutoPlay PromoSlider)         |
| 2025-11-10 | Mazen Wahed    | Pushed V2.6 (Unit Testing & Bug fixes)                     |
| 2025-11-11 | Mazen Wahed    | Pushed V2.6b (Order Details Screen & Date Sorting)         |
| 2025-11-11 | Mazen Wahed    | Pushed V2.7 (Sorting Fixes & Enhancements)                 |
| 2025-11-20 | Mazen Wahed    | Pushed V2.8 (Bug Fixes)                                    |
| 2025-11-21 | Mazen Wahed    | Pushed V2.8a (Hotfix)                                      |
| 2025-11-21 | Mazen Wahed    | Pushed V2.8b (Hotfix)                                      |

---

### 3. Version History (Changelog)

#### V2.8b (Latest)

- **Shared Wishlist (Critical Logic Fix):** Resolved a "Shadowing" bug where users who were both owners of a personal list and collaborators on a shared list would incorrectly see their own items when switching views. The issue was caused by an ambiguous Firestore query returning the first matching document.
  - **Fix:** Updated WishlistRepository to accept a specific targetOwnerId.
  - **Fix:** Updated FavouritesController and InvitationController to explicitly track and request the specific owner's ID when in "Shared Mode," ensuring the correct wishlist is always retrieved.

#### V2.8a

- **Shared Wishlist (State Fix):** Fixed a persistence bug where "Shared Mode" would incorrectly remain active after logout/login. Changed FavouritesController to use lazyPut with fenix: true, ensuring the controller resets to a fresh state on every new session.
- **Home UI (Flickering):** Resolved the issue where the greeting would display "Good Night ," with no name for a split second. The Appbar now waits until the user name is fully loaded before rendering the text.
- **Authentication (Navigation):** Fixed a potential crash on the Sign-Up screen by correcting the Get.off syntax to use a closure.
- **Core (Dependency Injection):** Optimized HomeAppBar to correctly use UserController.instance instead of creating a new instance, preserving the correct lifecycle and memory usage.
- **UX:** Removed the redundant "Shared Wishlist is ON" snackbar on app launch to reduce visual noise and confusion.

#### V2.8

- **Shared Wishlist (Real-time Sync):** Fixed a logic gap where collaborators wouldn't see status changes (like the owner turning off sharing) unless they visited the Invitation screen. Added `Get.find<InvitationController>()` to the **Wishlist Screen** to "wake up" the controller and listen for changes immediately upon viewing the wishlist.

- **Invitation Feature:**

  - **Memory Management:** Implemented robust `StreamSubscription` management in `InvitationController` to properly cancel listeners on close, resolving memory leaks and infinite snackbar loops.
  - **UI/UX:** The email text field now automatically clears after an invitation is successfully sent.

- **UI/UX (Appbar):**

  - **Customization:** The `CAppBar` widget now accepts a custom `backIcon`, allowing for greater flexibility in navigation icons.
  - **Dark Mode Fix:** Resolved an issue where Appbar icons were not adapting correctly to Dark Mode colors in specific scenarios.

- **Core:** Optimized dependency injection in `GeneralBindings` to ensure controllers are initialized and disposed of efficiently.

#### V2.7

- **Product Sorting Fix (Newest/Oldest):** Fixed a critical bug where `Newest` and `Oldest` sorting failed. This was because products in `dummy_data.dart` were missing the date field, causing them all to be null in Firebase. Dates have been added to all dummy products, and the sorting logic in `all_products_controller.dart` is now functional.
- **Product Sorting Enhancement (Sale):** The `Sale` sort option now correctly sorts products by the highest discount percentage first, rather than just the sale price. This required updating the logic in `all_products_controller.dart` to use the `CalculateSalePercentage` method.
- **Refactor (Sorting):** Made the date sorting logic in `all_products_controller.dart` more robust by safely handling potential `null` date values to prevent app crashes.

#### V2.6b

- **New Feature: Order Details Screen:** Added a new screen `Order Details` that users can navigate to from the `order history list`. It displays all information for a specific order, including order status, shipping address, payment method, and a list of all items in that order.
- **Order History Fix:** Orders in the `My Orders` list are now correctly sorted by date, with the newest orders appearing first.

#### V2.6

- **New Feature: Unit Testing:** Added unit tests for core business logic files: `formatters`, `pricing_calculator`, `product_controller`, and `validator`.
- **Invitation Bug Fix:** Fixed a critical bug where inviting a user who registered with email/password (not Google) would display their name as `Unknown User`. The system now correctly fetches their name from the Firestore 'Users' collection.
- **Invitation Bug Fix:** Fixed a UI bug where the "Remove Collaborator" dialog would persist after confirmation. It now closes as expected.
- **Shared Wishlist Snackbar Bug Fix:** Fixed an infinite loop of "Shared Wishlist is ON" snackbars. This was caused by a dependency conflict between the InvitationController's stream listener and the FavouritesController's ever listener, which was resolved by removing both the redundant refreshMode() call and the initial "Shared Wishlist is ON" snackbar from the `_handleCollaborationUpdate` function.
- **Cart Bug Fix:** The cart now correctly decreases item quantity by one and properly prompts the user with a dialog when removing the last item.
- **Cart Bug Fix:** Set `permanent: false` for the `CartController` in `GeneralBindings` to fix a bug where the cart icon counter would persist even after the cart was emptied.
- **Auth UI Fix:** Corrected a UI issue where the "Get back" arrow on the Forget Password screen was not visible in dark mode.
- **Auth UI Fix:** Removed the "Clear" button from the Reset Password screen; the "Done" button now correctly navigates to the Login screen.
- **Refactor:** Removed the completely unused `HomeController` to clean up the project structure.
- **Refactor:** Removed an unused `cartController` getter from the `VariationController` to reduce code clutter.
- **Refactor (Auth):** Replaced the `DropdownMenuFormField` with `DropdownButtonFormField` on the Sign-Up screen for better theme consistency.
- **Refactor (Products):** Updated `DropdownButtonFormField` in `sortable_products.dart` to use `value` instead of the `initialValue` property.
- **Core:** Reduced the default `Loaders.customToast` & `Loaders.successSnackBar` duration to 1.2 seconds to prevent conflicts with other snackbars or dialogs.

#### V2.5

- **New Feature: Real-time Search:** Implemented a debounced search feature in `CSearchController` using a Timer for efficient, real-time database queries. The `ProductRepository` was updated to use array-contains-any on a List<String> of search terms, allowing for multi-word "OR" matching.
- **Home:** Enabled autoPlay on the PromoSlider so banners now cycle automatically.
- **Home:** Fixed a state bug where the PromoSlider would visually reset to the first banner when rebuilding the screen, even though the page indicator (from BannerController) remembered the correct position. This was fixed by setting the initialPage in CarouselOptions.

#### V2.4

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
