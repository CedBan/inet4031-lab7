# QA Report — Cybersecurity & Governance Track

- **Author / Tester:** Baledi Cedric Banzeba (`cedban`)
- **Environment:** WSL Local VM (Ubuntu / k3s)
- **Date:** 2026-11-21

## Week 11 Kickoff Test Cases (Drafted Prior to Remediation)

| Test ID | Target / Control | Test Procedure | Expected Result | Actual Result (Week 11) |
|---|---|---|---|---|
| QA-01 | Environment Checkpoint (C-03, C-04, C-05) | Run node, pod, networkpolicy, serviceaccount, and `/health` checks | Cluster node Ready; expected pods/services healthy | Pending verification in `env-checkpoint.txt` |
| QA-02 | Tooling & Versions (C-02) | Verify `trivy`, `gitleaks`, `kube-score`, `checkov`, `jq`, `git`, `lynis` | All tools installed and recorded in `TOOL-VERSIONS.txt` | Verified (`TOOL-VERSIONS.txt` generated) |
| QA-03 | Secrets History Scan (C-01) | Run `gitleaks git --redact --report-format json ... .` | 0 unresolved secrets in git history | 0 leaks found across 6 commits |
| QA-04 | IaC & Manifest Scans (C-08) | Run `checkov -d week-5 --framework terraform`, `trivy config week-5`, and `kube-score` | Baseline findings captured in evidence folder | Saved in `evidence/week-11-kickoff/` |
| QA-05 | RBAC Permissions (Week 12) | Run `kubectl auth can-i` for `system:serviceaccount:default:default` and monitoring SA | Predicted allow/deny matches actual cluster RBAC | Planned for Week 12 |
| QA-06 | NetworkPolicy Enforcement (C-05, C-06) | Test blocked traffic to `db:5432` from non-allowed pods | Connections blocked per policy | Planned for Week 12 |
