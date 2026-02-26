# Project Plan: D-lang AI Email Analyzer

This document outlines the plan to build a GUI application in D-lang to connect to an email inbox, download messages, create a RAG database, and run AI queries against the data set.

### 1. Project Setup & Dependencies

*   **Initialize Project:** Use `dub` to create a new D project.
*   **Dependencies (dub.json):**
    *   **GUI:** `dlangui`
    *   **DotEnv:** A library to load `.env.local` files.
    *   **Email (IMAP):** Search for a D-native IMAP library. If unavailable, fallback to using `std.net.curl`.
    *   **JSON:** Use the built-in `std.json`.
    *   **Database:** `sqlite` for local data storage.

### 2. Backend Development

*   **Environment Module:** Create a module to load `EMAIL_HOST`, `EMAIL_USER`, `EMAIL_PASS`, and `GEMINI_API_KEY` from `.env.local`.
*   **Email Service:**
    *   Connect to the IMAP server.
    *   Authenticate.
    *   Fetch and download all email bodies.
    *   Save emails (sender, subject, date, clean text body) into a local SQLite database (`emails.db`).
*   **RAG Database Service:**
    *   Read emails from `emails.db`.
    *   Generate vector embeddings for each email's content via a text embedding API (e.g., Google's).
    *   Store these embeddings in the SQLite database, linked to the emails.

### 3. GUI Development (DlangUI)

*   **Main Window:** The main application window.
*   **Status Panel:** Display application status (e.g., "Disconnected", "Downloading...", "Ready").
*   **Action Buttons:**
    *   "Download Emails": Triggers the email fetching and RAG creation process.
    *   A progress bar to show activity for long-running tasks.
*   **Query Interface:**
    *   Text input for the user's question.
    *   "Submit Query" button.
*   **Results View:** A read-only text area to display the AI-generated answer.

### 4. AI Query Logic (RAG Core)

1.  **Embed Query:** When a query is submitted, generate its vector embedding.
2.  **Search:** Perform a vector similarity search in the SQLite database to find the most relevant emails.
3.  **Contextualize:** Retrieve the full text of the top N matching emails.
4.  **Prompt:** Construct a prompt for a generative AI model (Gemini) containing the retrieved email context and the user's query.
5.  **Generate:** Send the prompt to the AI API and get the final answer.
6.  **Display:** Show the answer in the GUI.

### 5. Prerequisites

*   A `.env.local` file in the project root containing:
    ```
    EMAIL_HOST=imap.example.com
    EMAIL_USER=your_email@example.com
    EMAIL_PASS="your_app_password"
    GEMINI_API_KEY=your_google_ai_api_key
    ```
