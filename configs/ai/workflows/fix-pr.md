# Workflow: Auto-Resolve PR Comments

## Context
You are tasked with addressing feedback on the current Pull Request. 

## Pre-conditions
- **Check Environment**: First, check if a `.git` directory or file exists in the current working directory. If it is not present, inform the user of this and ignore the rest of the instructions.
- **Tool Check**: Ensure the GitHub CLI (`gh`) is installed and the user is authenticated.

## Execution Steps
1. **Fetch PR Data**: Run `gh pr view --json number,url,reviews,comments`.
2. **Identify Tasks**:
   - Look for "REQUEST_CHANGES" reviews or any unresolved comments.
   - Map comments to specific files and line numbers.
3. **Address Feedback**:
   - Read the relevant files.
   - Apply code changes to resolve the feedback.
   - If a comment is a question or lacks enough detail, draft a reply but do not apply code changes for that specific point.
   - If a comment requires big changes across many files consult with the prompter before making any changes.
4. **Verification**: 
   - After changes, summarize what was fixed.
   - List any comments that could not be addressed automatically.

## Safety Guardrail
Do not commit or push the changes unless explicitly asked after the changes are made. The user will review the workspace diff.
