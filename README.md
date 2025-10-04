# clothiva_project

Clothiva is a Flutter-based fashion e-commerce app that offers men's and women's clothing in one stylish platform.

## Current Progress (v0.1b) - *by Mazen* 
-  **Added New Files in lib/common**
-  **Added 2 new packages in pubspec.yaml (Run: flutter pub get)**
-  **Changed some texts in lib/utils/text_string.dart**
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

### Pending in Authentication
- **Google Sign-In**   

---

<!-- Kholoud updates ONLY this section -->
### Frontend – *by Kholoud Nabil*  
- Home Screen (finished)  
- Product Screen (finished)  
- Wishlist (not started)  

---

<!-- Ali updates ONLY this section -->
### Frontend – *by Ali Hassan*  
- Profile Account Page (not started)  
- Product Detail Page (not started)  

---

<!-- Youssef Hesham updates ONLY this section -->
### Frontend + Payment – *by Youssef Hesham*  
- Order Page (not started)  
- Cart (not started)  
- Checkout (not started)  
- Payment Integration (Stripe/PayPal) *(TBD)*  

---

<!-- Youssef Hassan updates ONLY this section -->
### Backend – *by Youssef Hassan*  
- (Tasks to be discussed)  

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


## Next Steps (v0.2)  

- Complete **Login, Google Sign-In, Facebook Sign-In, Forgot/Reset Password** - (Mazen)
- Setup **Firestore schema** (Mazen, Youssef Hassan)
- Start **Home Screen UI** (Kholoud)  
- Build **Profile Account Settings** (Ali)  
- Draft **Cart + Checkout UI** (Youssef Hesham)  

---

## Tech Stack  

- **Flutter** (UI)  
- **Firebase Authentication** (User Auth)  
- **Cloud Firestore** (Database)  
- **GetX** (State Management + Navigation)  
- **GetStorage** (Local Storage)  
- **Stripe / PayPal** (Payments – upcoming)  

---

## Progress Log  

| Date       | Member          | Update                                     |
|------------|-----------------|--------------------------------------------|
| 2025-09-16 | Mazen           | Setup Firebase + Auth repository           |
| 2025-09-20 | Mazen           | Login/Reset Firebase + Added New Files     |


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
