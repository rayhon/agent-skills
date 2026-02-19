# The Ultimate Guide to Parallel Coding with Git Worktrees

Running multiple AI agents (like Devin, OpenDevin, or custom scripts) on a single repository usually leads to disaster. Agents overwrite each other's files, fight over the database, and crash test suites.

To solve this, you need a **Three-Part Setup**:
1.  **Git Worktrees** for file system isolation.
2.  **Symlinks** for shared configuration.
3.  **Database Namespacing** for data isolation.

## Part 1: Git Worktrees (File System Isolation)

Normally, to work on two branches, you have to stash changes and switch branches, or clone the repo entirely (which bloats disk space). Git Worktrees allow you to check out multiple branches from the **same repository** into **separate folders** simultaneously.

### How to use it:

1.  Navigate to your main project directory.
2.  Run the following command to create a new folder linked to a specific branch:

```bash
# Syntax: git worktree add -b <new-branch-name> <path-to-new-folder>
git worktree add -b feature-branch ../my-app
```

*   **`-b feature-branch`**: Creates a new branch named `feature-branch`.
*   **`../my-app`**: The directory where this branch will live.

3.  **Verify your worktrees:**
    To see all active worktrees and which branches they are on:

```bash
git worktree list

```

**Result:** You now have two folders. You can point one AI agent at the main folder and another AI agent at the `my-app` folder. They will never see each other's file edits. However, worktree only contains track files so files u don't check in will not be in the worktree. To resolve this issue, use symlink.

---

## Part 2: Symlinks (Shared Configuration)

When you create a worktree, **untracked files are not included**. This means your `.env`, `.npmrc`, or `master.key` files will be missing in the new folder.

**Do not copy these files.** If you copy them, you have to update multiple files every time a key changes. Instead, use **Symbolic Links (Symlinks)**.

### How to use it:

Navigate into your new worktree folder and link back to the main files:

```bash
cd my-app

# Link the .env and .dev.vars (Cloudflare secrets) from the repository root
ln -s ../.env .env
ln -s ../.dev.vars .dev.vars

# Link wrangler state
ln -s ../.wrangler .wrangler
```

**Result:** Both directories now read from the exact same source of truth for configuration and local Wrangler state. Update your API key in the main folder, and the worktree sees it immediately.

---

## Part 3: Database Isolation (D1 / SQLite)

This is the most critical step for running tests in parallel. If both agents try to run `wrangler dev` or tests against the same local D1 database or KV store, they will conflict.

> **What is the development database?** In Cloudflare local development, this usually means a local SQLite file in `.wrangler` or a specific D1 database name. If you don't isolate this, two agents will "fight" over the same state records.

You must configure your app to accept dynamic database names or prefixes via Environment Variables.

### 1. Update Wrangler Configuration
Modify your `wrangler.toml` or your initialization code to look for an environment variable.

**Example:**
```javascript
// In your test/dev setup
const dbName = process.env.DB_NAME || "my_app_db";
// Use dbName for your D1 binding or local persistence path
```

### 2. Create Local Overrides
In your new worktree folder, create a local environment file (e.g., `.env.local` or `.dev.vars`) that is **specific to this folder** and overrides the database name.

```bash
# Inside ./my-app folder
echo "DB_NAME=my_app_feature" >> .dev.vars
```

### 3. Create the New Database
Now, initialize the local state for this specific worktree:

```bash
# Example for Cloudflare D1
wrangler d1 migrations apply my_app_feature --local
```

**Result:** Agent A runs tests against `my_app`. Agent B runs tests against `my_app_feature`. Zero collisions.

---

## Advanced: Automating the Setup

Doing the steps above manually every time is tedious. This repository includes a helper script and configuration file to automate the entire process for your developers.

### 1. Configure `.worktreeinclude`
Modify the `.worktreeinclude` file in the root directory to list files that need to be symlinked.

```text
.env
.dev.vars
.npmrc
.wrangler
node_modules
```

### 2. Run the Automation Script
Use the provided `bin/setup-worktree` script. It will create the worktree, run the symlinks, and generate a unique sandbox configuration.

**Usage:**
```bash
./bin/setup-worktree your-new-feature
```

**What the script does under the hood:**
1.  Runs `git worktree add`.
2.  Symlinks every file/folder listed in `.worktreeinclude` (including `.wrangler`).
3.  Injects `DB_DATABASE=my_app_feature` into a local env file.
4.  Attempts to run a database initialization command.

---

## Tips & Tricks

### 1. Clean Up is Easy
When the AI agent is finished and the code is merged, you don't delete the folder manually. Use Git to remove it cleanly:

```bash
# Run this from the main repo folder
git worktree remove ../worktree-your-new-feature
```
This deletes the folder and cleans up the Git references.

### 2. Use Folder Suffixes
When naming your worktree folders, use a consistent suffix or directory pattern so you know which ones are temporary.
*   Good: `./worktrees/feature-auth`
*   Good: `../worktree-auth`

### 3. Update Once, Everywhere
Because you used **Symlinks** in Part 2, if you rotate your OpenAI key in the main `.env` file, every single active worktree gets the new key instantly.

### 4. Separate Git Histories
Remember that while they share the *repo*, they have separate *Git indices*.
*   You can stage files in Worktree A without affecting the `git status` of Worktree B.
*   You can run `git fetch` in one, and the objects are available to all.

### 5. VS Code / Editor Context
Open a **separate VS Code window** for each worktree. Do not try to open the parent folder containing all worktrees, or your editor's LSP (Language Server Protocol) will get confused by the duplicate definitions across folders.