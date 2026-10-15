# CodeGumi — Comprehensive Quality & Testing Checklist

Use this testing checklist to verify every feature, interactive element, and edge case of **CodeGumi — Learn. Code. Grow.**.

---

## 📋 1. Core Layout & Navigation
- [ ] **Modern UI & Responsive Design**:
  - [ ] Website loads cleanly with smooth gradients, modern typography, glassmorphism cards.
  - [ ] Dark / Light theme toggle switches colors seamlessly across all components.
  - [ ] Theme selection persists across browser refreshes (saved in `localStorage`).
  - [ ] Desktop sidebar is fixed/sticky and tabs switch with zero flicker.
  - [ ] Mobile responsive: Hamburger button toggles the slide-out navigation drawer smoothly on small screens.
  - [ ] Header displays current active view, streak badge, mode badge, theme toggle, AI tutor button, and profile button.

---

## 📚 2. Programming Tutorials (C, Python, Java, HTML, CSS, JavaScript)
- [ ] **Subject Selection**:
  - [ ] Language tabs switch smoothly between C, Python, Java, HTML, CSS, and JavaScript.
  - [ ] Each language features tailored chapters based on core B.Tech engineering curriculum.
- [ ] **Tutorial Reader**:
  - [ ] Chapter selection loads chapter title, concepts, syntax-highlighted code examples, and B.Tech exam/interview tips.
  - [ ] "Copy Code" button copies code snippet to clipboard with toast notification.
  - [ ] "Try in Practice Arena" button opens the Coding Arena with pre-loaded code sample.
  - [ ] Progress tracker shows completed chapters in the subject.

---

## 💻 3. Coding Practice Arena & Compiler
- [ ] **Problem Explorer**:
  - [ ] Filter problems by Difficulty (All, Easy, Medium, Hard).
  - [ ] Filter by Category (Arrays, Strings, Pointers, OOP, Logic, Web).
  - [ ] Search input dynamically filters problem list.
  - [ ] Selecting a problem displays title, difficulty badge, tags, problem description, constraints, and sample I/O.
- [ ] **Hints & Sample Solutions**:
  - [ ] Step-by-step collapsible hints (Hint 1, Hint 2, Hint 3) reveal on click.
  - [ ] "View Sample Solution" reveals full code with explanation and time/space complexity analysis.
- [ ] **Code Editor**:
  - [ ] Language dropdown switches between C, Python, Java, and JavaScript with starter boilerplate templates.
  - [ ] Editor supports Tab indentation, line numbers, and comfortable coding area.
  - [ ] Custom STDIN input box allows custom inputs for testing edge cases.
- [ ] **Real Compiler Execution (Zero Mocking / No Fake Compilers)**:
  - [ ] C execution connects to Judge0 GCC 14.1.0 engine and outputs real compilation/execution results.
  - [ ] Java execution connects to Judge0 OpenJDK 17 engine and outputs real compilation/execution results.
  - [ ] Python execution runs via Judge0 / Python runtime and displays real output.
  - [ ] JavaScript execution runs in-browser sandbox with captured `console.log` and error stack traces.
  - [ ] If offline or unable to connect, displays an honest message: *"Cannot connect to compiler engine. Code execution requires an active connection to run real C/Java code."*
- [ ] **Test Cases & Submission**:
  - [ ] "Run Code" executes current code against custom or sample input.
  - [ ] "Submit Solution" tests against multiple test cases and reports pass/fail with execution time and memory.

---

## 🎯 4. Interactive Quizzes, Scores & Leaderboard
- [ ] **Quiz Selection**:
  - [ ] Quizzes available for C Basics & Pointers, Python Data Structures, Java OOP, Web Development, and B.Tech GATE/Campus Aptitude.
- [ ] **Interactive Quiz Runner**:
  - [ ] Question timer option, progress bar, multiple choice options.
  - [ ] Immediate feedback reveals whether selected option was correct with full rationale.
  - [ ] Completed quiz displays final score, percentage, XP earned, and confetti animation.
  - [ ] Saves quiz score to history and updates learning-gap detection data.

---

## 🗺️ 5. B.Tech Roadmap & Learning-Gap Detection
- [ ] **B.Tech 4-Year Semester Roadmap**:
  - [ ] Semester 1 through Semester 8 interactive breakdown (Problem Solving with C -> Data Structures -> DBMS & OS -> Web Dev -> Capstone & Placement Prep).
  - [ ] Each semester shows key subjects, syllabus highlights, and recommended lab practicals.
- [ ] **Learning-Gap Detection Engine**:
  - [ ] Analyzes all student quiz results and coding attempts across categories (Pointers, OOP, Recursion, Memory, Strings, etc.).
  - [ ] Displays visual breakdown of strong topics vs weak topics.
  - [ ] Flags any topic with accuracy below 60% as a **Critical Learning Gap**.
  - [ ] Automatically generates an actionable **Remedial Action Plan** with direct links to the relevant tutorial and practice question!

---

## ⏱️ 6. B.Tech Study Tools
- [ ] **Pomodoro Study Timer**:
  - [ ] Presets: 25-minute Focus, 5-minute Short Break, 15-minute Long Break.
  - [ ] Custom duration setting.
  - [ ] Start, Pause, and Reset controls work smoothly.
  - [ ] Visual circular progress indicator counts down accurately.
  - [ ] Completion chime triggers via Web Audio API (no broken audio links).
  - [ ] Logs completed study session and increments daily focus minutes.
- [ ] **Interactive Flashcards**:
  - [ ] 3D flip card animation on click.
  - [ ] Subject deck filter (C Pointers, Python Time Complexity, Java Collections, Web HTTP & DOM).
  - [ ] "Mastered" and "Needs Review" buttons track retention rate.
  - [ ] Next, Previous, and Shuffle buttons navigate deck.
- [ ] **Personal Revision Notes**:
  - [ ] Add new note with title, subject tag, and markdown-friendly content.
  - [ ] Search notes by keyword or subject filter.
  - [ ] Edit existing notes.
  - [ ] Pin notes to top.
  - [ ] Delete note with confirmation.
  - [ ] Export notes to `.json` or `.txt` format.

---

## ☁️ 7. Supabase Backend, Demo Mode & Security
- [ ] **Demo Mode (Local Storage)**:
  - [ ] App operates seamlessly without Supabase configuration.
  - [ ] Header shows "Demo Mode (Local)" badge.
  - [ ] All notes, scores, timer logs, and settings persist in `localStorage`.
- [ ] **Supabase Integration**:
  - [ ] Settings modal allows student to enter their Supabase Project URL and Anon Key.
  - [ ] Connection test verifies validity of keys.
  - [ ] Sign In / Sign Up modal handles authentication.
  - [ ] Data sync button uploads local storage data to Supabase PostgreSQL tables.
- [ ] **Security**:
  - [ ] Zero secret keys (`service_role`) exposed in code.
  - [ ] RLS policies prevent unauthorized data access.

---

## 🤖 8. Optional AI Tutor Integration
- [ ] Floating AI Tutor modal / drawer opens from header button.
- [ ] If user provides a free Google Gemini API key, AI queries Google Gemini directly from client.
- [ ] If no API key is provided, the built-in offline CS Knowledge Engine answers questions, explains error messages, and suggests debugging tips!
- [ ] No mandatory paid APIs.
