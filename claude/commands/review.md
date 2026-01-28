---
name: review
description: Comprehensive automated code review with extensive quality checks
args:
  - name: target
    description: Branch or commit range to review (default: staged/unstaged changes)
    required: false
---

Run a comprehensive, automated code review. This command executes an extensive barrage of quality checks designed to catch issues that human reviewers miss.

**Philosophy**: Every time a defect slips through, add the check here. Build an ever-growing suite of automated verification.

## Review Scope

{{#if target}}
Review target: `{{target}}`
{{else}}
Review current changes (staged and unstaged, or committed changes on branch vs master)
{{/if}}

## Step 1: Gather Changes

First, determine what to review:

```bash
git status
git diff master...HEAD --stat 2>/dev/null || git diff --stat
git diff master...HEAD 2>/dev/null || git diff
```

## Step 2: Run Verification Suite

Execute ALL of the following checks. Do not skip any.

### 2.1 Build & Type Checks
- Run `pnpm exec tsc --noEmit` or equivalent typecheck
- Run build if applicable
- Report ALL errors, not just the first few

### 2.2 Lint & Format
- Run `pnpm exec eslint` on changed files
- Check for formatting issues with prettier

### 2.3 Test Execution
- Run tests related to changed files
- Report coverage changes if measurable

## Step 3: Code Quality Analysis

Read EVERY changed file completely and check:

### 3.1 Security (OWASP Top 10)
- [ ] SQL injection: parameterized queries only, no string concatenation
- [ ] XSS: proper output encoding, no dangerouslySetInnerHTML without sanitization
- [ ] Authentication: no hardcoded credentials, proper session handling
- [ ] Authorization: permission checks on all protected resources
- [ ] Sensitive data exposure: no secrets in code, proper logging hygiene
- [ ] Input validation: all external input validated and sanitized
- [ ] CSRF: proper token handling on state-changing operations
- [ ] Dependency vulnerabilities: no known-vulnerable packages added

### 3.2 Error Handling
- [ ] All async operations have error handling
- [ ] Errors are logged with sufficient context
- [ ] No swallowed exceptions (empty catch blocks)
- [ ] User-facing errors are informative but don't leak internals
- [ ] Database operations wrapped in proper transaction handling

### 3.3 Performance
- [ ] No N+1 query patterns
- [ ] No unbounded data fetches (missing pagination/limits)
- [ ] No blocking operations in hot paths
- [ ] Proper use of indexes for new queries
- [ ] No memory leaks (event listeners, subscriptions cleaned up)
- [ ] No unnecessary re-renders or recomputation

### 3.4 Logic & Correctness
- [ ] Edge cases handled (null, undefined, empty arrays, zero values)
- [ ] Off-by-one errors checked
- [ ] Race conditions considered for concurrent operations
- [ ] State mutations are intentional and controlled
- [ ] Boolean logic is correct (De Morgan's law, short-circuit evaluation)
- [ ] Comparisons use correct operators (=== vs ==, proper null checks)

### 3.5 TypeScript Quality
- [ ] No `any` types without justification
- [ ] Proper null/undefined handling (noUncheckedIndexedAccess patterns)
- [ ] Type assertions (`as`) are justified and safe
- [ ] Generic types used appropriately
- [ ] Return types are explicit on public functions

### 3.6 Code Organization
- [ ] Functions are single-purpose and reasonable length (<50 lines ideal)
- [ ] Files are focused and not overly long (<400 lines ideal)
- [ ] No code duplication (DRY principle applied sensibly)
- [ ] Naming is clear and descriptive
- [ ] No dead code or commented-out code
- [ ] Imports are used and organized

### 3.7 Testing
- [ ] New functionality has corresponding tests
- [ ] Tests cover happy path AND edge cases
- [ ] Tests are deterministic (no flaky time/random dependencies)
- [ ] Test descriptions clearly state what's being tested
- [ ] Mocks are minimal and don't test implementation details

### 3.8 Architecture & Patterns
- [ ] Changes follow existing codebase patterns
- [ ] Layer boundaries respected (resources → models → queryBuilders)
- [ ] No circular dependencies introduced
- [ ] Proper separation of concerns
- [ ] Database access only through QueryBuilders

### 3.9 Documentation & Communication
- [ ] Complex logic has explanatory comments
- [ ] API changes are backward compatible or properly versioned
- [ ] Breaking changes are clearly documented

## Step 4: Output Format

Structure your review as follows:

### Build Status
[Pass/Fail with details]

### Critical Issues (Must Fix)
[Bugs, security vulnerabilities, data corruption risks, breaking changes]

### High Priority (Should Fix)
[Logic errors, performance problems, missing error handling]

### Medium Priority (Recommend)
[Code quality, maintainability, test coverage gaps]

### Low Priority (Consider)
[Style, minor improvements, nice-to-haves]

### Summary
[Overall assessment: APPROVE / REQUEST CHANGES / NEEDS DISCUSSION]

## Important

- Be thorough but prioritize substance over style
- Every finding must include file path and line number
- Explain WHY something is an issue, not just that it is
- If checks pass, say so explicitly - don't manufacture issues
- Focus on the changes, not pre-existing code (unless it's now broken)
