-- ==============================================================================
-- CodeGumi — Learn. Code. Grow.
-- Supabase PostgreSQL Database Schema
-- Tailored for B.Tech Programming Education Platform
-- ==============================================================================

-- Enable UUID extension if not already enabled
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ==============================================================================
-- 1. PROFILES TABLE (Stores user details, semester, streak, XP, and stats)
-- ==============================================================================
CREATE TABLE IF NOT EXISTS public.profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    email TEXT NOT NULL,
    full_name TEXT DEFAULT 'B.Tech Student',
    college_name TEXT DEFAULT 'Engineering College',
    branch TEXT DEFAULT 'Computer Science & Engineering',
    semester INTEGER DEFAULT 1 CHECK (semester BETWEEN 1 AND 8),
    avatar_url TEXT DEFAULT '',
    xp INTEGER DEFAULT 100,
    streak_count INTEGER DEFAULT 1,
    last_active_date DATE DEFAULT CURRENT_DATE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- ==============================================================================
-- 2. QUIZ SCORES TABLE (Tracks quiz attempts, subject, score, and weak topics)
-- ==============================================================================
CREATE TABLE IF NOT EXISTS public.quiz_scores (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
    subject TEXT NOT NULL,               -- e.g. 'c', 'python', 'java', 'web', 'aptitude'
    topic TEXT NOT NULL,                 -- e.g. 'Pointers', 'OOP', 'Data Structures'
    score INTEGER NOT NULL,              -- e.g. 4
    total_questions INTEGER NOT NULL,    -- e.g. 5
    percentage NUMERIC(5,2) NOT NULL,    -- e.g. 80.00
    weak_areas TEXT[] DEFAULT '{}',      -- Array of topics where user made errors
    completed_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- ==============================================================================
-- 3. PRACTICE SUBMISSIONS TABLE (Tracks code attempts, language, status)
-- ==============================================================================
CREATE TABLE IF NOT EXISTS public.practice_submissions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
    problem_id TEXT NOT NULL,            -- e.g. 'two-sum', 'reverse-array-pointers'
    problem_title TEXT NOT NULL,
    language TEXT NOT NULL,              -- 'c', 'python', 'java', 'javascript'
    code TEXT NOT NULL,
    status TEXT NOT NULL,                -- 'Accepted', 'Wrong Answer', 'Compile Error', 'Runtime Error'
    runtime_ms NUMERIC(8,3) DEFAULT 0,
    memory_kb NUMERIC(10,2) DEFAULT 0,
    submitted_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- ==============================================================================
-- 4. USER NOTES TABLE (Personal notes for B.Tech study & revision)
-- ==============================================================================
CREATE TABLE IF NOT EXISTS public.user_notes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
    title TEXT NOT NULL,
    content TEXT NOT NULL,
    subject TEXT DEFAULT 'General',     -- 'C', 'Python', 'Java', 'HTML/CSS', 'JavaScript', 'General'
    tags TEXT[] DEFAULT '{}',
    is_pinned BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- ==============================================================================
-- 5. STUDY LOGS TABLE (Pomodoro study timer tracking)
-- ==============================================================================
CREATE TABLE IF NOT EXISTS public.study_logs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
    session_type TEXT NOT NULL,         -- 'focus', 'short_break', 'long_break'
    duration_minutes INTEGER NOT NULL,  -- e.g. 25
    subject TEXT DEFAULT 'Programming',
    completed_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- ==============================================================================
-- 6. LEARNING GAPS CACHE TABLE (Stores detected learning gaps per user)
-- ==============================================================================
CREATE TABLE IF NOT EXISTS public.learning_gaps (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
    topic TEXT NOT NULL,                -- e.g. 'C Pointers & Dynamic Memory'
    subject TEXT NOT NULL,              -- e.g. 'C'
    accuracy_rate NUMERIC(5,2) NOT NULL,-- e.g. 40.00
    recommendation TEXT NOT NULL,       -- Actionable plan to bridge the gap
    detected_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- ==============================================================================
-- ROW LEVEL SECURITY (RLS) POLICIES
-- Ensures each student can only access and modify their own data!
-- ==============================================================================

-- Enable RLS on all tables
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.quiz_scores ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.practice_submissions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_notes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.study_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.learning_gaps ENABLE ROW LEVEL SECURITY;

-- 1. Profiles Policies
CREATE POLICY "Users can view their own profile"
    ON public.profiles FOR SELECT
    USING (auth.uid() = id);

CREATE POLICY "Users can update their own profile"
    ON public.profiles FOR UPDATE
    USING (auth.uid() = id);

CREATE POLICY "Users can insert their own profile"
    ON public.profiles FOR INSERT
    WITH CHECK (auth.uid() = id);

-- 2. Quiz Scores Policies
CREATE POLICY "Users can view their own quiz scores"
    ON public.quiz_scores FOR SELECT
    USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own quiz scores"
    ON public.quiz_scores FOR INSERT
    WITH CHECK (auth.uid() = user_id);

-- 3. Practice Submissions Policies
CREATE POLICY "Users can view their own submissions"
    ON public.practice_submissions FOR SELECT
    USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own submissions"
    ON public.practice_submissions FOR INSERT
    WITH CHECK (auth.uid() = user_id);

-- 4. User Notes Policies
CREATE POLICY "Users can view their own notes"
    ON public.user_notes FOR SELECT
    USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own notes"
    ON public.user_notes FOR INSERT
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own notes"
    ON public.user_notes FOR UPDATE
    USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own notes"
    ON public.user_notes FOR DELETE
    USING (auth.uid() = user_id);

-- 5. Study Logs Policies
CREATE POLICY "Users can view their own study logs"
    ON public.study_logs FOR SELECT
    USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own study logs"
    ON public.study_logs FOR INSERT
    WITH CHECK (auth.uid() = user_id);

-- 6. Learning Gaps Policies
CREATE POLICY "Users can view their own learning gaps"
    ON public.learning_gaps FOR SELECT
    USING (auth.uid() = user_id);

CREATE POLICY "Users can insert or update their own learning gaps"
    ON public.learning_gaps FOR INSERT
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete their own learning gaps"
    ON public.learning_gaps FOR DELETE
    USING (auth.uid() = user_id);

-- ==============================================================================
-- AUTOMATIC PROFILE CREATION TRIGGER ON SIGNUP
-- Automatically creates a public.profiles record when a new user signs up in auth.users
-- ==============================================================================
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO public.profiles (id, email, full_name, college_name, branch, semester)
    VALUES (
        NEW.id,
        NEW.email,
        COALESCE(NEW.raw_user_meta_data->>'full_name', 'B.Tech Student'),
        COALESCE(NEW.raw_user_meta_data->>'college_name', 'Engineering College'),
        COALESCE(NEW.raw_user_meta_data->>'branch', 'Computer Science & Engineering'),
        COALESCE((NEW.raw_user_meta_data->>'semester')::INTEGER, 1)
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger execution
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE PROCEDURE public.handle_new_user();

-- ==============================================================================
-- HELPER INDEXES FOR PERFORMANCE
-- ==============================================================================
CREATE INDEX IF NOT EXISTS idx_quiz_scores_user ON public.quiz_scores(user_id);
CREATE INDEX IF NOT EXISTS idx_practice_submissions_user ON public.practice_submissions(user_id);
CREATE INDEX IF NOT EXISTS idx_user_notes_user ON public.user_notes(user_id);
CREATE INDEX IF NOT EXISTS idx_study_logs_user ON public.study_logs(user_id);
CREATE INDEX IF NOT EXISTS idx_learning_gaps_user ON public.learning_gaps(user_id);
