#!/bin/bash

# Git History Rewrite Script
# Simulates a 10-day development cycle from Feb 2, 2026 to Feb 11, 2026

# Configuration
export GIT_AUTHOR_NAME="Rahul Juluru" # Replace with your name if needed, or git will use global config
export GIT_AUTHOR_EMAIL="rahul.juluru@example.com" # Replace with your email

# Safety Check
if [ -d ".git" ]; then
    echo "⚠️  WARNING: This will DELETE the existing .git directory and history!"
    read -p "Are you sure you want to proceed? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
    rm -rf .git
    echo "Deleted existing .git directory."
fi

# Initialize new repo
git init
echo "Initialized new git repository."

# Function to commit with date
commit_with_date() {
    local date_str="$1"
    local msg="$2"
    export GIT_AUTHOR_DATE="$date_str 12:00:00"
    export GIT_COMMITTER_DATE="$date_str 12:00:00"
    git add . # Stage all changes, then we commit specific files? NO.
    # The script logic I had before was better: git add SPECIFIC files.
    # But wait, the files already exist.
    # If I 'git add specific_file', it stages it.
    
    # PROBLEM: If I git add specific files and commit, the *other* files are still untracked.
    # That is fine. They will be added in subsequent commits.
    
    git commit -m "$msg"
}

# Wrapper to add and commit
add_and_commit() {
    local date_str="$1"
    local msg="$2"
    shift 2
    local files=("$@")
    
    git add "${files[@]}"
    export GIT_AUTHOR_DATE="$date_str 12:00:00"
    export GIT_COMMITTER_DATE="$date_str 12:00:00"
    git commit -m "$msg"
}


# --- Day 1: Feb 2, 2026 (Project Init) ---
echo "Processing Day 1..."
add_and_commit "2026-02-02" "Initial project setup with Next.js, TypeScript, and Tailwind" package.json tsconfig.json next.config.mjs postcss.config.mjs tailwind.config.ts .gitignore .eslintrc.json README.md

add_and_commit "2026-02-02" "Add global styles and shadcn utility functions" app/globals.css lib/utils.ts

# --- Day 2: Feb 3, 2026 (UI Components) ---
echo "Processing Day 2..."
add_and_commit "2026-02-03" "Add base UI components (Button, Input, Toast) and shadcn config" components/ui/button.tsx components/ui/input.tsx components/ui/toast.tsx components/ui/toaster.tsx components/ui/use-toast.ts components.json

# --- Day 3: Feb 4, 2026 (Auth & Layout) ---
echo "Processing Day 3..."
add_and_commit "2026-02-04" "Setup Clerk authentication and Root Layout structure" middleware.ts app/layout.tsx

# --- Day 4: Feb 5, 2026 (Backend Config) ---
echo "Processing Day 4..."
add_and_commit "2026-02-05" "Configure Firebase Admin and client SDK connection" firebase.ts firebaseAdmin.ts

add_and_commit "2026-02-05" "Add utility wrappers for Stripe and Pinecone" lib/stripe.ts lib/stripe-js.ts lib/pinecone.ts lib/getBaseUrl.ts

# --- Day 5: Feb 6, 2026 (PDF Logic) ---
echo "Processing Day 5..."
add_and_commit "2026-02-06" "Implement LangChain PDF loader, splitting, and Pinecone indexing logic" lib/langchain.ts

add_and_commit "2026-02-06" "Create PDF Viewer component using react-pdf" components/PdfView.tsx

# --- Day 6: Feb 7, 2026 (Dashboard UI) ---
echo "Processing Day 6..."
add_and_commit "2026-02-07" "Create Dashboard layout wrapper and Header component" app/dashboard/layout.tsx components/Header.tsx

# Check if file exists to avoid error
if [ -f "components/FileUploader.tsx" ]; then
    add_and_commit "2026-02-07" "Implement FileUploader with drag-and-drop functionality" components/FileUploader.tsx
fi

# --- Day 7: Feb 8, 2026 (Server Actions) ---
echo "Processing Day 7..."
add_and_commit "2026-02-08" "Add server action for generating vector embeddings" actions/generateEmbeddings.ts

add_and_commit "2026-02-08" "Add server action for RAG-based question answering" actions/askQuestion.ts

add_and_commit "2026-02-08" "Implement document deletion server action" actions/deleteDocument.ts

# --- Day 8: Feb 9, 2026 (Chat UI) ---
echo "Processing Day 8..."
add_and_commit "2026-02-09" "Build interactive Chat interface and message components" components/Chat.tsx components/ChatMessage.tsx

# --- Day 9: Feb 10, 2026 (Payments & Docs) ---
echo "Processing Day 9..."
add_and_commit "2026-02-10" "Implement Stripe checkout session and portal actions" actions/createCheckoutSession.ts actions/createStripePortal.ts

add_and_commit "2026-02-10" "Add Upgrade button and Pricing page modal" components/UpgradeButton.tsx app/dashboard/upgrade/page.tsx

add_and_commit "2026-02-10" "Build Document list view and upload page handling" components/Documents.tsx components/Document.tsx components/PlaceholderDocument.tsx app/dashboard/page.tsx app/dashboard/files/page.tsx app/dashboard/upload/page.tsx

# --- Day 10: Feb 11, 2026 (Landing Page & Polish) ---
echo "Processing Day 10..."
add_and_commit "2026-02-11" "Design Landing Page with feature sections" app/page.tsx public/

add_and_commit "2026-02-11" "Add Stripe Webhook handler" app/webhook/route.ts

# Commit any remaining files
git add .
export GIT_AUTHOR_DATE="2026-02-11 12:00:00"
export GIT_COMMITTER_DATE="2026-02-11 12:00:00"
git commit -m "Final polish, README updates, and cleanup"

echo "------------------------------------------------"
echo "✅ Git history rewrite complete!"
echo "Run 'git log --oneline --graph' to verify."
