# Vencop — Product Requirements Document

**Product:** Vencop
**Type:** B2B SaaS — Vendor Onboarding & Compliance Management
**Status:** MVP Development
**Document:** Product Requirements Document (PRD)

---

## 1. Product Overview

Vencop is a B2B SaaS platform that helps organizations onboard, manage, and monitor external vendors.

Vencop replaces fragmented vendor management processes such as:

- Email-based document collection
- Spreadsheets
- Shared folders
- Manual document expiry tracking
- Unstructured approval processes
- Repeated vendor onboarding
- Poor visibility into vendor compliance

Vencop provides a centralized workflow where organizations can:

1. Create an organization.
2. Invite internal team members.
3. Configure vendor requirements.
4. Invite vendors.
5. Allow vendors to submit company information and documents.
6. Review and approve or reject submitted documents.
7. Calculate vendor compliance.
8. Monitor document expiration.
9. Notify users about important events.

---

## 2. Problem

Organizations need to verify that external vendors satisfy their legal, financial, operational, and regulatory requirements before doing business with them.

This process is often managed using email, spreadsheets, PDFs, shared drives, and manual reminders — which creates recurring problems:

- Missing documents
- Expired documents
- Duplicate documents
- Unclear ownership/responsibility
- No standardized onboarding workflow
- Poor auditability
- Difficulty monitoring compliance at scale
- Repeated document submission across customers
- Difficulty scaling to hundreds of vendors

Vencop turns this process into a structured, trackable workflow.

---

## 3. Product Goal

> **Make vendor onboarding and compliance simple, structured, and trackable.**

The core workflow:

```
Organization
     ↓
Invite Vendor
     ↓
Vendor Accepts
     ↓
Vendor Submits Documents
     ↓
Reviewer Reviews
     ↓
Approve / Reject
     ↓
Compliance Calculated
     ↓
Vendor Becomes Compliant
```

---

## 4. Core Concepts

Vencop is built around four core concepts: **Organization**, **Vendor**, **Vendor Relationship**, and **Document**.

### 4.1 Organization

An organization is a customer company using Vencop to manage its vendors (e.g. *Acme Corporation*). It owns:

- Members
- Vendors
- Vendor relationships
- Document requirements
- Documents
- Compliance data
- Notifications
- Audit history

An organization is a **tenant** in the Vencop system.

### 4.2 Vendor

A vendor is an external company providing products or services (e.g. *Somaliland Transport Ltd*). A vendor is not owned by a single customer — it can have relationships with many organizations:

```
Somaliland Transport Ltd
        │
        ├── Acme Corporation
        ├── Global Logistics
        └── Soma Construction
```

The vendor's identity is shared across all of its relationships.

### 4.3 Vendor Relationship

The relationship between one organization and one vendor. This is the **most important concept in Vencop**.

```
Acme Corporation
        │
        ▼
Somaliland Transport Ltd
```

Each relationship independently tracks:

- Onboarding status
- Requirements
- Documents
- Compliance status
- Review activity

> **The vendor is global. The vendor relationship is organization-specific.**

Example — the same vendor can have completely different states per customer:

| Organization | Status | Compliance |
|---|---|---|
| Acme Corporation | ACTIVE | COMPLIANT |
| Global Logistics | ONBOARDING | PENDING |

### 4.4 Document

A file or record a vendor submits to satisfy a requirement (e.g. Business Registration, Tax Certificate, Transport License, Insurance Certificate, Safety Certificate). Documents always belong to a specific **vendor relationship** and **requirement**.

---

## 5. Users and Roles

Vencop has four primary roles: **OWNER**, **ADMIN**, **REVIEWER**, **VENDOR**.

The first three are internal organization roles. VENDOR is used by external vendor-side users.

### 5.1 Owner

Ultimate authority over the organization.

**Can:** view/update org settings, manage admins, manage reviewers, manage vendors, configure requirements, view compliance, view audit history, manage integrations, transfer ownership, delete the organization.

### 5.2 Admin

Runs the organization day-to-day.

**Can:** manage members, invite reviewers, invite vendors, manage vendors, configure requirements, manage onboarding, view compliance, view activity.

**Cannot:** transfer ownership, delete the organization, or perform owner-only actions.

| Role | Represents |
|---|---|
| Owner | Ultimate organizational authority |
| Admin | Day-to-day operational authority |

An organization can have multiple Admins, but typically one Owner.

### 5.3 Reviewer

Handles vendor document review.

**Can:** view assigned vendor relationships, view vendor profiles and requirements, view submitted documents, approve/reject documents, request replacement documents, view compliance and related activity.

**Cannot:** transfer ownership, delete the organization, manage billing, or modify critical org settings.

### 5.4 Vendor

An external company and its users.

**Can:** access their vendor account, view customer relationships, complete onboarding, view requirements, upload documents, replace rejected documents, view document status and compliance.

Vendor users can only access relationships they are explicitly authorized for.

---

## 6. Vendor Account Model

A vendor should not need a separate Vencop account per customer:

```
Vendor Company
       ↓
Vencop Vendor Account
       ↓
Multiple Customer Relationships
```

The vendor logs in **once**. After authentication, they see all authorized customer relationships and select one to establish the active relationship context.

---

## 7. Multi-Tenancy

Vencop is a multi-tenant application. Each organization is an isolated tenant:

```
Organization A                 Organization B
    ├── Members                    ├── Members
    ├── Vendors                    ├── Vendors
    ├── Relationships              ├── Relationships
    ├── Documents                  ├── Documents
    └── Activity                   └── Activity
```

**Organization A must never access Organization B's private data.** Tenant isolation is a fundamental product and security requirement.

> Technical implementation is defined separately in `docs/MULTI_TENANCY.md`.

---

## 8. Organization Registration

```
User
 ↓
Create Organization
 ↓
Provide company information
 ↓
Create user account
 ↓
Create organization
 ↓
Create OWNER membership
```

This operation must be **atomic** — if any step fails, the entire registration transaction rolls back.

---

## 9. Organization Members

An organization has multiple internal members, each with a role:

```
Acme Corporation
  Hana    → OWNER
  Ahmed   → ADMIN
  Fatima  → REVIEWER
```

Users never self-select their role. The backend derives the role strictly from the organization membership record.

---

## 10. Vendor Invitations

An organization invites a vendor by email. The invitation lifecycle:

```
PENDING → ACCEPTED
   or
PENDING → EXPIRED
```

Invitation tokens must be **secure and time-limited**.

---

## 11. Vendor Onboarding

```
Vendor receives invitation
        ↓
Accept invitation
        ↓
Create or access vendor account
        ↓
Open customer relationship
        ↓
View requirements
        ↓
Submit company information
        ↓
Upload documents
        ↓
Submit onboarding
        ↓
Reviewer reviews submission
```

Onboarding always belongs to a specific vendor relationship.

---

## 12. Vendor Relationship Lifecycle

Initial states:

```
INVITED → ONBOARDING → UNDER_REVIEW → ACTIVE
```

Additional states (introduced only as needed): `REJECTED`, `SUSPENDED`, `OFFBOARDED`.

**Compliance is separate from relationship status.** A relationship can be `ACTIVE` while compliance is `NON_COMPLIANT` — meaning the business relationship continues, but the vendor currently has outstanding compliance issues.

---

## 13. Document Requirements

Organizations define what documents vendors must provide. Requirements belong to the organization and can vary between organizations.

**Example — Transportation Vendor:**
- Business Registration
- Tax Certificate
- Transport License
- Insurance Certificate
- Safety Certificate

---

## 14. Requirement Properties

A requirement may define:

- Name
- Description
- Category
- Required / optional
- Expiration required (yes/no)
- Validity period
- Allowed file types
- Maximum file size

Advanced rules (by vendor category, risk level, or relationship) are **not required for MVP**.

---

## 15. Documents

A vendor submits documents against requirements. Document states:

```
MISSING → UPLOADED → PENDING_REVIEW → APPROVED
```

or

```
PENDING_REVIEW → REJECTED → (vendor re-uploads) → PENDING_REVIEW
```

Approved documents may later transition to `EXPIRING → EXPIRED`.

---

## 16. Document Versioning

Document history is **never overwritten**.

```
Transport License
  Version 1 — REJECTED
  Version 2 — APPROVED
```

Vencop must always retain: version number, uploader, upload date, reviewer, review date, decision, rejection reason, and which version is currently active.

---

## 17. Document Review

A Reviewer approves or rejects each document. **Rejections require a reason**, e.g.:

> *"The submitted license has expired."*

The vendor may then submit a replacement version.

---

## 18. Compliance

Compliance is calculated from a vendor relationship's requirements and current document states. **The backend is the single source of truth** — the frontend must never calculate and submit a final compliance value.

**Example (compliant):**
| Required | Approved | Missing | Rejected | Expired | Status |
|---|---|---|---|---|---|
| 5 | 5 | 0 | 0 | 0 | COMPLIANT |

**Example (non-compliant):**
| Required | Approved | Missing | Rejected | Expired | Status |
|---|---|---|---|---|---|
| 5 | 3 | 1 | 0 | 1 | NON_COMPLIANT |

---

## 19. Compliance States

Initial states: `PENDING`, `COMPLIANT`, `NON_COMPLIANT`.

Additional states are added only when a clear product requirement exists. Document expiration does **not** require a new relationship state — it simply drives compliance to `NON_COMPLIANT` while the relationship itself may remain `ACTIVE`.

---

## 20. Organization Dashboard

High-level view of vendor activity:

```
Vendors              127
Active                98
Onboarding            12
Non-Compliant         17
Pending Reviews       23
Expiring Soon         14
```

---

## 21. Vendor Dashboard

```
Your Organizations

Acme Corporation      — Compliance: 100%
Global Logistics      — Compliance: 80%
Soma Construction     — Compliance: 60%
```

Selecting a relationship shows its Requirements, Documents, Compliance, and Activity. Vendors only ever see data for the selected relationship.

---

## 22. Reviewer Dashboard

```
Pending Reviews

Somaliland Transport   — Transport License   — Uploaded Sept 8
Bright Cleaning        — Insurance           — Uploaded Sept 8
Hargeisa Security      — Safety Certificate  — Uploaded Sept 7
```

---

## 23. Notifications

**Initial events:** vendor invited, document uploaded/approved/rejected/expiring/expired, vendor becomes compliant/non-compliant.

**Initial channels:** Email, in-app notifications.

---

## 24. Document Expiration

```
30 days remaining  → Reminder
7 days remaining   → Urgent reminder
Expired            → Mark EXPIRED → Recalculate compliance
```

> Implementation of scheduled expiration checks is defined in the engineering docs.

---

## 25. Audit History

Every important action is recorded, including:

`ORGANIZATION_CREATED`, `USER_INVITED`, `USER_ROLE_CHANGED`, `VENDOR_INVITED`, `INVITATION_ACCEPTED`, `DOCUMENT_UPLOADED`, `DOCUMENT_APPROVED`, `DOCUMENT_REJECTED`, `DOCUMENT_EXPIRED`, `VENDOR_APPROVED`, `VENDOR_SUSPENDED`, `LOGIN_SUCCESS`, `LOGIN_FAILED`.

This allows questions like *"Who approved this document?"* to always be answerable:

```
Document: Transport License
Action:   DOCUMENT_APPROVED
Actor:    Ahmed Hassan
Date:     Sept 9, 2026
```

---

## 26. Security Requirements

Vencop must provide: secure authentication, password hashing, email verification, authorization, RBAC, tenant isolation, resource ownership checks, secure invitation tokens, protected document access, input validation, rate limiting, audit logging, secure HTTP configuration, and secure secret management.

> Detailed implementation lives in `docs/SECURITY.md`, `docs/AUTHENTICATION.md`, and `docs/MULTI_TENANCY.md`.

---

## 27. MVP Scope

One complete end-to-end workflow:

```
Organization → Owner → Invite Reviewer → Invite Vendor → Vendor Accepts
→ Vendor Sees Requirements → Vendor Uploads Document → Reviewer Reviews
→ Approve/Reject → Compliance Status
```

---

## 28. MVP Features

**Organization** — registration, creation, members (Owner/Admin/Reviewer)

**Authentication** — register, login, logout, password hashing, email verification, access/refresh tokens, password reset

**Vendors** — create, invite, accept invitation, vendor account, vendor relationship

**Requirements** — create, view, assign to relationships

**Documents** — upload, view, status, versioning, approve, reject, replace

**Compliance** — calculate, display status, missing/rejected/expired documents

**Security** — RBAC, tenant isolation, resource authorization, protected document access, input validation, rate limiting

---

## 29. Post-MVP Features

Automated expiration monitoring, email/in-app notifications, audit logs, webhooks (with retries and idempotency), advanced requirement rules, vendor categories, risk scoring, subscription plans, advanced analytics, enterprise SSO, AI document verification, OCR.

These must not delay validating the core product.

---

## 30. Non-Goals

Vencop is **not** initially: accounting software, procurement software, contract lifecycle management, invoice processing, payment or payroll software, full enterprise GRC, AI document verification/OCR software, or a mobile application. These may be revisited later.

---

## 31. Core Product Principle

> **Vendors are global. Vendor relationships are organization-specific.**

```
                    Vendor
                      │
        ┌─────────────┼─────────────┐
        ↓             ↓             ↓
      Acme          Global         Soma
                  Logistics      Construction
        │             │             │
        ↓             ↓             ↓
   Requirements   Requirements   Requirements
        │             │             │
        ↓             ↓             ↓
    Documents     Documents     Documents
        │             │             │
        ↓             ↓             ↓
   Compliance    Compliance    Compliance
```

This lets one vendor company work with many organizations without duplicating its global identity.

---

## 32. MVP Success Criteria

The MVP is successful when a real organization can, end-to-end:

1. Create an account and its organization.
2. Add a reviewer.
3. Create/invite a vendor.
4. Have the vendor accept the invitation.
5. Define required documents.
6. Have the vendor upload documents.
7. Have a reviewer review, approve, or reject them.
8. Allow rejected documents to be replaced.
9. Calculate and display vendor compliance.
10. Prevent unauthorized cross-organization data access.

---

## 33. Documentation Structure

The PRD defines *what* to build. Technical implementation is documented separately:

```
vencop/
│
├── frontend/
├── backend/
│
├── docs/
│   ├── PRD.md
│   ├── ARCHITECTURE.md
│   ├── DATABASE.md
│   ├── AUTHENTICATION.md
│   ├── SECURITY.md
│   ├── MULTI_TENANCY.md
│   ├── BACKGROUND_JOBS.md
│   ├── WEBHOOKS.md
│   ├── TESTING.md
│   ├── INFRASTRUCTURE.md
│   └── DEVELOPMENT.md
│
└── openapi/
    ├── openapi.yaml
    ├── paths/
    └── schemas/
```

The API contract is maintained as an **OpenAPI specification**, not as a Markdown document.

---

## 34. Guiding Principle

Do not build Vencop as a giant enterprise platform from day one. Build the smallest system that solves this problem extremely well:

> *"I need to onboard a vendor, collect their required documents, review them, and know whether they are compliant."*

Everything else should support that single workflow.