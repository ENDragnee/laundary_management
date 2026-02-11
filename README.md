# Laundry Manager 🧺

**Laundry Manager Pro** is a high-performance, offline-first bookkeeping and management solution designed specifically for laundry businesses. Built with **Flutter**, **Supabase**, and **PowerSync**, it ensures that shop operators can continue their workflow even without an internet connection, with seamless cloud synchronization when back online.

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Supabase](https://img.shields.io/badge/Supabase-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white)](https://supabase.com)
[![PowerSync](https://img.shields.io/badge/PowerSync-FF6F00?style=for-the-badge&logo=databricks&logoColor=white)](https://powersync.com)

---

## ✨ Key Features

- **Offline-First Architecture**: Powered by PowerSync and Drift (SQLite), allowing 100% functionality in areas with spotty internet.
- **Order Management**: Create, update, and track laundry orders with unique secure codes for customer retrieval.
- **Smart Retrieval**: Search orders instantly by Customer Name, Phone Number, or Unique Order Code.
- **Multi-Tier Account Logic**:
  - **TRIAL**: Limited to 100 orders. Existing orders are Read-Only to ensure data integrity.
  - **REGULAR**: Unlimited orders, full editing, and cloud backup.
  - **PREMIUM**: (Upcoming) Advanced analytics dashboards and multi-branch management.
- **Real-time Sync**: Automatic background synchronization to a Supabase PostgreSQL backend.
- **Rose Pine Aesthetic**: A beautiful, minimal UI designed for focus and ease of use in high-traffic shop environments.

---

## 🛠 Tech Stack

- **Frontend**: Flutter (Dart)
- **Local Database**: [Drift](https://drift.simonbinder.eu/) (formerly Moor)
- **Sync Engine**: [PowerSync](https://www.powersync.com/) (Real-time SQLite-to-Postgres sync)
- **Backend/Auth**: [Supabase](https://supabase.com/)
- **Navigation**: [GoRouter](https://pub.dev/packages/go_router)
- **State Management**: [Provider](https://pub.dev/packages/provider)
- **Theming**: Rose Pine Palette (Dark & Light modes)

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest version)
- A Supabase Project
- A PowerSync Instance

### Setup Instructions

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/laundary_management.git
   cd laundary_management
   ```

2. **Configure Environment Variables:**
   Create a `.env` file in the root directory:
   ```env
   SUPABASE_URL=your_supabase_project_url
   SUPABASE_ANON_KEY=your_supabase_anon_key
   POWERSYNC_URL=your_powersync_instance_url
   APP_STATUS=DEVELOPMENT
   ```

3. **Install Dependencies:**
   ```bash
   flutter pub get
   ```

4. **Generate Database Code:**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

5. **Run the App:**
   ```bash
   flutter run
   ```

---

## 🔐 Security & Database Logic

This app uses **PostgreSQL Row Level Security (RLS)** and **Database Triggers** to enforce business rules:
- **Tenancy**: Users can only see and edit data belonging to their own laundry shop ID.
- **Validation**: A `BEFORE INSERT` trigger on the server rejects orders if a `TRIAL` user exceeds the 100-order limit.
- **Integrity**: Timestamps and Enums (OrderStatus) are managed at the database level to ensure consistency across all devices.

---

## 💰 Monetization Strategy

The app follows a SaaS model with three tiers:
1. **Trial**: Free to start, giving users a taste of the system's efficiency.
2. **Regular**: A paid one-time or subscription fee to unlock the full potential of unlimited bookkeeping.
3. **Premium**: Targeted at shop owners who need business insights and analytics.

---

## 👨‍💻 Author

**Mastwal Mesfin**
- **Portfolio**: [mastwal-mesfin.vercel.app](https://mastwal-mesfin.vercel.app/)
- **Email**: [mesfinmastwal@gmail.com](mailto:mesfinmastwal@gmail.com)
- **Telegram**: [@Redglance](https://t.me/Redglance)

---

## 📄 License

Copyright © 2024-2026 Mastwal Mesfin. All rights reserved.

This project is proprietary. Unauthorized copying, modification, distribution, or use of this software via any medium is strictly prohibited. For licensing inquiries or to upgrade your account, please contact the author.

---
*Developed with ❤️ in Addis Ababa, Ethiopia.*
