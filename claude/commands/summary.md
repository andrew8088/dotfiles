---
name: summary
description: Summarize code changes with fresh context to verify coherence
args:
  - name: target
    description: Branch or commit range to summarize (default: changes vs master)
    required: false
---

Generate a summary of code changes with NO prior context about what the changes were supposed to do.

**Philosophy**: If an AI with fresh context can't figure out what the code is doing, a human reviewer won't either. This reveals incoherence between implementation and intent.

Launch this as a fresh subagent with ZERO conversation context.

**CRITICAL**: You must immediately use the Task tool with the following configuration:

- **subagent_type**: "general-purpose"
- **model**: "sonnet"
- **description**: "Fresh change summary"
- **prompt**:

```
You are analyzing code changes with ZERO prior context. You don't know what the developer intended - your job is to determine what the code ACTUALLY does.

## Your Task
Examine the current code changes and produce a clear summary of:
1. What changed
2. What the changes accomplish (based solely on the code)
3. Whether the implementation is coherent and understandable

{{#if target}}
## Review Target
{{target}}
{{/if}}

## Step 1: Gather the Changes

Run these commands to understand the scope:

git log master...HEAD --oneline 2>/dev/null || echo "No commits ahead of master"
git diff master...HEAD --stat 2>/dev/null || git diff --stat
git diff master...HEAD 2>/dev/null || git diff

## Step 2: Read Changed Files

For each modified file, read it COMPLETELY to understand the full context.
Don't rely only on the diff - understand the surrounding code.

## Step 3: Analyze Without Assumptions

Answer these questions based ONLY on the code:

### What Changed?
List the files modified and what specifically changed in each.

### What Does This Code Do?
Explain the behavior/functionality based on reading the code.
- What inputs does it accept?
- What outputs does it produce?
- What side effects does it have?

### Is the Intent Clear?
- Can you determine the purpose from the code alone?
- Are there any confusing or ambiguous sections?
- Does the naming make the purpose obvious?

### Is It Coherent?
- Do all the changes fit together toward a single purpose?
- Are there any changes that seem unrelated or contradictory?
- Does the implementation match what the code structure suggests?

### What's Missing?
- Are there obvious gaps in the implementation?
- Missing error handling?
- Missing tests?
- Incomplete feature coverage?

## Step 4: Output Format

### Changes Overview
[Brief list of files and what changed]

### Inferred Purpose
[What you believe this code is meant to accomplish, based ONLY on the code]

### Coherence Assessment
- **Clear and coherent**: The code's purpose is obvious
- **Mostly clear**: Purpose is understandable with minor ambiguities
- **Unclear**: Difficult to determine intent from code alone
- **Incoherent**: Changes don't seem to fit together

### Concerns
[Any issues that stand out: confusing code, apparent bugs, missing pieces]

### Questions
[Things you'd want clarified if reviewing this PR]

## Important Reminders

- You have NO context about what the developer intended
- Base analysis ONLY on the code itself
- Don't assume - if something is unclear, say so
- Be honest about coherence - if the code is confusing, that's valuable feedback
- This is not a code review - don't nitpick style, focus on understanding
```

DO NOT do the summary yourself - immediately launch the subagent with the above configuration.
