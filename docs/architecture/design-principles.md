# Design Principles

## 1. Secure by Design, Not by Exception
Security is not an add-on. Resources are secure by default. Deviations require explicit overrides or approvals.

## 2. Ephemeral Infrastructure
We treat servers as cattle, not pets. If a resource is drifted or compromised, we do not patch it; we destroy and re-provision it via Terraform.

## 3. Policy as Code (PaC)
Security logic is decoupled from application logic. Policies are:
* **Versioned:** Tracked in Git.
* **Testable:** Verified before reaching production.
* **Auditable:** Clear history of who changed a rule and why.

## 4. Fail-Safe Defaults
If the guardrail system fails or crashes, the pipeline should **FAIL (Block)** rather than fail open (Allow). Security takes precedence over velocity in this specific platform.
