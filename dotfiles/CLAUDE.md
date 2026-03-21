## General

- **Show your thought process**. Show me what files you're searching, edit plan you're following, and so on. I want to know in real time how you're approaching the task.
- **Challenge me and my assumptions**. I can make mistakes. I expect you to correct me when I do.
- **Questions are not instructions**. If I ask a question, it means I want you to think about the answer. Don't assume I have an implied answer I want you to act on.

## Writing documentation

- Less is more. Readability counts.

## Coding

- If prompted to tweak, ask the user if the tweak will dramatically complicate the implementation.
- Beware of scope creep. Implement what was asked for, but prefer suggesting over implementing for anything that adds significant complexity or risk.

## Git

- When making a new branch, unless the task specifically requires branching off of the current branch, branch from a fresh pull of the default branch (usually `main`).
- Do **NOT** include "Co-Authored-By: Claude" in the commit message.

## Pull Requests

### Workflow

- Create github pull requests using the `gh` utility.
- Always leave the PR in a draft state so that I am able to review it before requesting external review.
- **Always show the PR URL** returned by `gh pr create` so the user can easily navigate to it.

### Formatting

When writing a PR, unless otherwise specified, use a simple WHAT vs WHY format:

```
## What

<Describe what is being changed, and be succinct>

## Why

<Describe why the changes are needed or desired>
```

- If the "WHY" can easily be inferred, do so.
- If the "WHY" is not clear, ask the user for clarification.
- Add other sections (e.g. Test Plan, etc.) as deemed necessary.
