# Security Policy

## Supported Versions

We release patches for security vulnerabilities. Which versions are eligible for receiving such patches depends on the CVSS v3.0 Rating:

| Version | Supported          |
| ------- | ------------------ |
| 1.0.x   | :white_check_mark: |

## Reporting a Vulnerability

The Aetheria team and community take security bugs in Aetheria seriously. We appreciate your efforts to responsibly disclose your findings, and will make every effort to acknowledge your contributions.

### How to Report Security Issues

**Please do not report security vulnerabilities through public GitHub issues.**

Instead, please report them via email to: [your-email@example.com]

You should receive a response within 48 hours. If for some reason you do not, please follow up via email to ensure we received your original message.

### Information to Include

Please include the requested information listed below (as much as you can provide) to help us better understand the nature and scope of the possible issue:

* Type of issue (e.g. buffer overflow, SQL injection, cross-site scripting, etc.)
* Full paths of source file(s) related to the manifestation of the issue
* The location of the affected source code (tag/branch/commit or direct URL)
* Any special configuration required to reproduce the issue
* Step-by-step instructions to reproduce the issue
* Proof-of-concept or exploit code (if possible)
* Impact of the issue, including how an attacker might exploit the issue

This information will help us triage your report more quickly.

### Firebase and API Security

Given that Aetheria uses Firebase and Google's Vertex AI, please pay special attention to:

* Firebase configuration exposure
* API key misuse or exposure
* Authentication bypasses
* Data leakage through improper Firebase rules
* Vertex AI prompt injection or manipulation
* Client-side data exposure

## Preferred Languages

We prefer all communications to be in English.

## Policy

* We will respond to your report within 48 hours with our evaluation of the report and an expected resolution date.
* If you have followed the instructions above, we will not take any legal action against you regarding the report.
* We will handle your report with strict confidentiality, and not pass on your personal details to third parties without your permission.
* We will keep you informed of the progress towards resolving the problem.
* In the public information concerning the problem reported, we will give your name as the discoverer of the problem (unless you desire otherwise).

## Scope

This security policy applies to the following components of Aetheria:

### In Scope
* The main Aetheria Flutter application
* Firebase integration and configuration
* Vertex AI integration
* Authentication mechanisms
* Data handling and storage
* API endpoints and communications

### Out of Scope
* Third-party dependencies (report to their respective maintainers)
* Social engineering attacks
* Physical attacks
* Attacks requiring physical access to user devices
* Attacks on Firebase or Google Cloud infrastructure (report to Google)

## Recognition

We appreciate the security research community's efforts in helping keep Aetheria and our users safe. Researchers who report valid security issues will be acknowledged in our security advisories and release notes, unless they prefer to remain anonymous.

## Comments on this Policy

If you have suggestions on how this process could be improved please submit a pull request or file an issue to discuss.
