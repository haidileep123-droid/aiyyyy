# CodeGumi — Supabase Backend & Database Setup Guide

Welcome to the backend setup guide for **CodeGumi — Learn. Code. Grow.**!
This guide is written especially for **B.Tech students**. Even if this is your very first time using a cloud database, follow these steps and you'll have your Supabase PostgreSQL backend running in under 5 minutes.

---

## 🌟 Why Supabase?
Supabase is an open-source Firebase alternative powered by **PostgreSQL**.
It gives you:
- **Free Tier**: 100% free hosting for projects.
- **User Authentication**: Secure Sign Up and Log In (Email & Password).
- **PostgreSQL Database**: Real relational tables for storing notes, quiz scores, and practice submissions.
- **Row Level Security (RLS)**: Protects your students' data so one student can never view or overwrite another student's data.

---

## 🚀 Step-by-Step Setup (Takes ~5 Minutes)

### Step 1: Create a Free Supabase Account
1. Open your browser and go to: [https://supabase.com](https://supabase.com)
2. Click **Start your project** or **Sign In with GitHub**.
3. It's completely free — no credit card required!

### Step 2: Create a New Project
1. In the Supabase dashboard, click **+ New project**.
2. Fill in the project details:
   - **Name**: `codegumi-db` (or any name you prefer)
   - **Database Password**: Choose a strong password and save it in a safe place.
   - **Region**: Choose the region closest to you (e.g., *Central India (Mumbai)* or *Singapore* for fast response).
   - **Pricing Plan**: Select **Free tier**.
3. Click **Create new project** and wait ~1-2 minutes while Supabase sets up your PostgreSQL database.

---

### Step 3: Run the Database Schema SQL
1. On the left navigation sidebar in your Supabase dashboard, click on the **SQL Editor** icon (looks like `>_` or a terminal/database icon).
2. Click **+ New query**.
3. Open the `schema.sql` file provided in this repository.
4. Copy the entire contents of `schema.sql` and paste it into the Supabase SQL Editor query box.
5. Click the green **Run** button (or press `Ctrl + Enter`).
6. You should see a success message: `Success. No rows returned.`

#### What did this SQL query do?
- Created `profiles` table to store student details (name, college, branch, semester, XP, streak).
- Created `quiz_scores` table to store quiz results, accuracy, and weak topic tags.
- Created `practice_submissions` table to store coding arena code, runtimes, and status.
- Created `user_notes` table to store personal revision notes.
- Created `study_logs` table to store Pomodoro study timer sessions.
- Created `learning_gaps` table to store detected topic weaknesses.
- Enabled **Row Level Security (RLS)** on all tables.
- Created an automatic trigger `handle_new_user()` so whenever a student signs up, their profile record is created instantly!

---

### Step 4: Get Your Supabase URL and Anon Key
To connect CodeGumi frontend to your database securely:
1. In the Supabase left sidebar, click the **Settings** gear icon at the bottom, then click **API** (or click **Project Settings** > **API**).
2. Find the section labeled **Project API keys**:
   - **Project URL**: Something like `https://xyzcompanyabcdefgh.supabase.co`
   - **anon (public)** key: A long string starting with `eyJhbGciOi...`
3. Copy both of these values.

> 🔒 **Security Notice for B.Tech Students:**
> - The **`anon` (public)** key is completely safe to use in frontend code because Supabase uses Row Level Security (RLS) to enforce permissions.
> - **NEVER** share or put your **`service_role` (secret)** key in frontend code! The service_role key bypasses all security rules. CodeGumi only requires the `anon` key.

---

### Step 5: Connect CodeGumi to Your Supabase Backend
1. Open `index.html` in your web browser (double-click the file or use VS Code Live Server).
2. Look at the top right of the navigation bar — you will see a badge that says **"Demo Mode (Local)"**.
3. Click the **"Connect Supabase"** button in the header (or navigate to the **Settings** tab in the sidebar).
4. Paste your:
   - **Supabase Project URL**
   - **Supabase Anon (Public) Key**
5. Click **"Save & Connect"**.
6. CodeGumi will test the connection. When connected, the badge will turn green: **"Supabase Connected"**!
7. You can now use the **Sign Up / Sign In** buttons to register accounts, save your notes to the cloud, track quiz scores, and sync your coding submissions!

---

### Step 6: Test Local Demo Mode vs Cloud Mode
- If you don't connect Supabase, CodeGumi operates in **Demo Mode using `localStorage`**.
- In Demo Mode:
  - All features work immediately out of the box!
  - Notes, quiz history, flashcard mastery, and study timer logs are stored in your browser's local memory.
  - When you later connect Supabase, you can click **"Sync Local Data to Cloud"** to preserve everything!

---

## 🛠️ Troubleshooting & FAQs

### 1. "Failed to fetch" when connecting to Supabase
- Verify that you copied the complete Project URL including `https://`.
- Verify that your Supabase project status is **Active** (not paused). Free tier projects that are inactive for a month may pause; simply unpause them from the dashboard.

### 2. Can I use multiple devices?
- Yes! Once connected to Supabase, sign in with the same email and password on your laptop, college lab PC, or mobile phone to access your saved notes, roadmap progress, and quiz history.

### 3. How do I inspect my saved data?
- In the Supabase Dashboard, click on **Table Editor** on the left menu.
- Click on any table (`profiles`, `user_notes`, `quiz_scores`, `practice_submissions`) to see your live student data!
