# Vencop--B2B-Vendor-Onboarding-Compliance-Platform
# Vencop

### B2B Vendor Onboarding & Compliance Platform

Vencop is a multi-tenant platform for managing the vendor lifecycle — from onboarding and document collection to compliance review, expiry monitoring, and external system integration.

Built as a backend-focused project to explore production-oriented API design, security, data isolation, asynchronous processing, and reliable integrations.

>  **Status:** In active development

---

## Overview

Vencop helps organizations replace manual vendor compliance processes with a centralized workflow.

```text
Invite Vendor
     ↓
Onboarding
     ↓
Document Requirements
     ↓
Submission & Review
     ↓
Approval / Rejection
     ↓
Compliance Monitoring
     ↓
Expiry & Renewal
     ↓
Audit & Integrations
```

The system is designed around the idea that vendor compliance is more than document storage — it is a **workflow that needs to be automated, secured, and auditable**.

---

## Key Features

* **Multi-Tenancy** — Isolated organizations and tenant-scoped data
* **Authentication** — Email verification, access/refresh tokens, sessions, password reset
* **RBAC** — Admin, Reviewer, and Vendor permissions
* **Vendor Onboarding** — Invitations and configurable onboarding requirements
* **Document Lifecycle** — Upload, review, approval, rejection, expiry, and versioning
* **Compliance Scoring** — Measure vendor compliance based on required documents
* **Background Jobs** — Automated expiry checks and notifications
* **Audit Logs** — Track important business and security events
* **Webhooks** — Reliable event delivery to external systems
* **Idempotency** — Safe processing of retried requests and events
* **Subscriptions** — Organization plans and backend-enforced limits
* **REST API** — Pagination, filtering, validation, and consistent error handling
* **Testing & CI/CD** — Unit tests, integration tests, and automated pipelines
* **OpenAPI** — Interactive API documentation

---

## Architecture

```text
                    React
                      │
                      ▼
                REST API
                      │
          ┌───────────┼───────────┐
          ▼           ▼           ▼
       Auth/RBAC   Business     Validation
                    Logic
                      │
          ┌───────────┼───────────┐
          ▼           ▼           ▼
      PostgreSQL    Redis         S3
                      │
                      ▼
                Background Jobs
                      │
                      ▼
                  Webhooks
                      │
                      ▼
              External Systems
```

---

## Tech Stack

| Layer      | Technology                      |
| ---------- | ------------------------------- |
| Frontend   | React, TypeScript, Tailwind CSS |
| Backend    | Node.js, Express, TypeScript    |
| Database   | PostgreSQL                      |
| Storage    | AWS S3                          |
| Jobs       | BullMQ, Redis                   |
| Validation | Zod                             |
| API Docs   | Swagger / OpenAPI               |
| Testing    | Unit & Integration Tests        |
| CI/CD      | GitHub Actions                  |

---

## Engineering Focus

Vencop is intentionally designed beyond basic CRUD.

The main engineering challenges are:

* Secure authentication and authorization
* Strict tenant isolation
* Relational data modeling
* Transactional workflows
* Secure document access
* Background processing
* Reliable webhook delivery
* Idempotent event handling
* Auditability
* API consistency
* Automated testing

---

## Project Status

### Phase 1 — Foundation

* [ ] Project architecture
* [ ] PostgreSQL schema
* [ ] REST API foundation
* [ ] Validation
* [ ] Error handling

### Phase 2 — Identity & Organizations

* [ ] Authentication
* [ ] Email verification
* [ ] Sessions
* [ ] RBAC
* [ ] Multi-tenancy
* [ ] Invitations

### Phase 3 — Vendor Compliance

* [ ] Vendor onboarding
* [ ] Document requirements
* [ ] Document workflow
* [ ] Document versioning
* [ ] Compliance scoring

### Phase 4 — Automation & Integrations

* [ ] Background jobs
* [ ] Notifications
* [ ] Expiry monitoring
* [ ] Audit logs
* [ ] Webhooks
* [ ] Idempotency

### Phase 5 — Production Readiness

* [ ] Subscription management
* [ ] Unit & integration testing
* [ ] OpenAPI documentation
* [ ] CI/CD
* [ ] Deployment

---

## API Documentation

Swagger / OpenAPI documentation will be available once the API foundation is complete.

---

## License

This project is meant to be Open Source.

