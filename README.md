# Policy-Driven Cloud Guardrails Platform

## 🚀 Project Overview
An internal platform tool designed to enforce security, compliance, and operational best practices across cloud infrastructure. 

Unlike traditional "security scanners," this platform operates as a **control plane**, enforcing guardrails at two distinct stages:
1.  **Pre-Deployment (Prevent):** analyzing Infrastructure-as-Code (Terraform) to block insecure configurations before they exist.
2.  **Post-Deployment (Detect):** monitoring live cloud resources to detect drift and manual changes.

## 🏗 Architecture
The system follows a **Cloud-Agnostic Design** pattern:
* **Input:** Terraform Plans & Cloud Events
* **Decision Engine:** Open Policy Agent (OPA) / Checkov
* **Enforcement:** CI/CD Pipelines (GitHub Actions)
* **Target:** AWS (Primary Implementation)

## 🛡 Key Capabilities
* **Preventive Guardrails:** Blocks deployments that violate security policy (e.g., Public S3 buckets, Wildcard IAM).
* **Detective Guardrails:** Alerts on infrastructure drift or manual console changes.
* **Policy-as-Code:** All security rules are version-controlled and written in code, not clicked in a dashboard.

## 📂 Repository Structure
* `/infrastructure`: Terraform modules for cloud resources.
* `/policies`: Rego/Python policies defining the guardrails.
* `/scripts`: Automation logic for the guardrail controller.
* `/docs`: Architecture diagrams and threat models.
