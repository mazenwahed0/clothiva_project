# clothiva_project

Clothiva is a Flutter-based fashion e-commerce app that offers men's and women's clothing in one stylish platform.

---

## Progress Log  

| Date       | Member          | Update                                     |
|------------|-----------------|--------------------------------------------|
| 2025-09-16 | Mazen           | Setup Firebase + Auth repository           |
| 2025-09-20 | Mazen           | Login/Reset Firebase + Added New Files     |
| 2025-10-4  | Kholoud         | Home & Store Screen                        |
| 2025-10-5  | Ali             | Product Detail Page                        |
| 2025-10-6  | Mazen           | Settings + Storage Service + New Files     |
| 2025-10-12 | Mazen           | Store & Settings (Firestore) + Update Files|

---

## Current Progress (Update v1.1) - *by Mazen* 
 # Screens:
-  **Store Screen**
(Categories are fully connected to Firebase now)
- Updated **Load Data Screen** & fully connected with all Repositories & Dummy Data
(Important Note: All data has been uploaded to Firestore & Cloudinary, DON'T UPLOAD AGAIN!)

 # Updated Files:
- **Changed success_signup_screen to success_screen as several screens are using it**
- **Updated Brands Icons** (assets/icons/brands)
- **Updated image_strings.dart** (utils/constants)
- **Updated Shimmers for Backend** (common/widgets/shimmers)
- **Changed colors for Borders in Rounded Container** (common/widgets/custom_shapes/containers)
- **Several fixes for Repositories (Brands & Products)**
- **Updated Dummy Data**


## Previous Updates:

# (Big Update v1.0) - *by Kholoud, Mazen & Ali* 
 # Screens:
-  **Home Screen by (Kholoud)** 
(Categories & Banners are fully connected to Firebase now, & Some changes to work effectively in Dark Mode)
-  **Store Screen by (Kholoud)**
-  **Product Detail Screen by (Ali)** 
(Some Changes to work effectively in Dark Mode)
-  **Wishlist UI**
-  **Settings, Profile, and Change Name Screens**
(Authenticated Users via Database is fully connected to User Settings. User can edit their data on *Profile Screen*)
-  **Log out feature is back & fully functional in Settings Menu**
-  **Load Data Screen (to deal with Firebase & Cloudinary)**
 # New Files Added (for the Front & Backend team):
-  **Added some new packages in pubspec.yaml (Run: flutter pub get)**
-  **New Repositories and Models Added (Categories, Brands, Products, Banners, Cart, Orders & Address...)**
-  **Dummy Data Created (Backend should connect it with their controllers and add them in Load Data Screen)**
-  **Added and Changed some Widgets in lib/common/widgets (New Shimmer Files and other files related to Home, Store, Products & Wishlist Screens)**
-  **Added Cloudinary Service for Storage on Firebase Database (in /repository and its keys are ready in /utils/constants)**
-  **New Assets, so many files changed in /utils are changed**
(Changed some texts in lib/utils/constants/text_string.dart)
(Added some new enums in lib/utils/constants/enums.dart)
(New Themes added in lib/utils/themes)

---

(v0.1b) - *by Mazen* 
-  **Added New Files in lib/common**
-  **Added 2 new packages in pubspec.yaml (Run: flutter pub get)**
-  **Changed some texts in lib/utils/constants/text_string.dart**
-  **Login Firebase Integration**
-  **Forget Password Firebase Integration**
-  **Log out feature is fully functional in Home Screen**

(v0.1) - *by Mazen* 
- `Initialized Flutter project`  
- `Added folder structure (`lib/`, `assets/`, `fonts/`)`
- `Themes, helpers, and reusable widgets set up (spacing, loaders, widgets, etc.)`
### Authentication (Started)
-  **Configured Firebase & google-services.json** 
-  **Sign Up Screen (UI + connected with Firebase Authentication + Firestore)**  
-  **Login Screen (UI)**
-  **Authentication Repository & User Repository created for data handling**  
-  **Bindings and Controllers for Authentication flow**

---

<!-- Kholoud updates ONLY this section -->
### Frontend (Core) + Backend (Wishlist only) – *by Kholoud Nabil*  
- Home Screen (finished)  
- Product Screen (finished)  
- Wishlist (started)
- Backend (Wishlist (Local Storage)) (not started)

---

<!-- Ali updates ONLY this section -->
### Frontend – *by Ali Hassan* 
- Product Detail Page (Details, Rating, Reviews) (started)
- Sub-Categories, All Products, Brands (not started)

---

<!-- Youssef Hassan updates ONLY this section -->
### Backend – *by Youssef Hassan*  
- Product Detail Page (Details, Rating, Reviews) (not started)
- Sub-Categories, All Products, Brands (not started)

---
<!-- Youssef Hesham updates ONLY this section -->
### Frontend + Backend + Payment Integration – *by Youssef Hesham*  
- Addresses Page (not started)
- Order Page (not started)
- Cart Page (not started)
- Checkout Page (not started)
- Payment Integration (Stripe/PayPal) (not started)

---

## Next Steps (v1.0a)  
- Finish **Product Detail Page** (Ali Hassan)
- Setup **Product Detail Backend** (Youssef Hassan)
- Start **Wishlist UI + Backend** (Kholoud)  
- Finish **Addresses, Cart, Order Page, Checkout Frontend** (Youssef Hesham)  

---

## Tech Stack  

- **Flutter** (UI)  
- **Firebase Authentication** (User Auth)  
- **Cloud Firestore** (Database)  
- **GetX** (State Management + Navigation)  
- **GetStorage** (Local Storage)  
- **Stripe / PayPal** (Payments – upcoming)

---

### Update Rules (Important)
1. **Only update your section** 
   - Don’t overwrite or delete other members' work.

2. **Log progress in the Progress Log table**  
   - Add date + short description of what you did.

3. **Use clear commit messages**  
   - Example: `feat: added wishlist UI`

4. **Always pull before pushing**  
   - Run: `git pull origin main` before making changes.  
   - Resolve any conflicts locally before pushing.  

5. **Communicate big changes**  
   - If you change project structure or shared files, notify the team in WhatsApp.

---

## Project Structure
lib/
│
├── bindings/ # GetX bindings
│ 
├── common/ # Global helpers & reusable widgets
│ ├── styles/ # App styles
│ └── widgets/ # Loaders, dividers, social buttons, etc.
│
├── data/ # Data layer (repositories & services)
│ ├── repositories/
│ │ ├── authentication/
│ │ │ └── authentication_repository.dart
│ │ └── user/
│ │ └── user_repository.dart
│ └── services/ # Future Firebase/REST services
│
├── features/ # App features
│ ├── authentication/
│ │ ├── controllers/ # Signup controller
│ │ ├── models/ # User model
│ │ └── screens/ # Login, Signup, Onboarding, Password reset, Welcome
│ ├── checkout/
│ ├── favourites/
│ ├── products/
│ ├── shop/
│ └── personalization/ # (Placeholder for Account/Profile)
│
├── localization/ # Multi-language support (future)
├── utils/ # Utilities, constants & themes
