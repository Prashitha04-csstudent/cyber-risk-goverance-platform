-- =========================================================
-- AI-AssISTED CYBERSECURITY RISK MANAGEMENT PLATFORM
-- COMPLETE ANALYSIS QUERIES
-- =========================================================


-- =========================================================
-- DATABASE SELECTION
-- =========================================================

USE cyber_risk_platform;


-- =========================================================
-- VIEW ALL INCIDENTS
-- Purpose:
-- Display all cybersecurity incidents
-- =========================================================

SELECT * FROM incidents;


-- =========================================================
-- CRITICAL INCIDENTS
-- Purpose:
-- Identify incidents requiring immediate action
-- =========================================================

SELECT *
FROM incidents
WHERE severity = 'Critical';


-- =========================================================
-- OPEN INCIDENTS COUNT
-- Purpose:
-- KPI for unresolved incidents
-- =========================================================

SELECT COUNT(*) AS open_incidents
FROM incidents
WHERE status = 'Open';


-- =========================================================
-- INCIDENTS BY DEPARTMENT
-- Purpose:
-- Identify departments with high incident frequency
-- =========================================================

SELECT department,
       COUNT(*) AS total_incidents
FROM incidents
GROUP BY department;


-- =========================================================
-- SEVERITY DISTRIBUTION
-- Purpose:
-- Analyze organizational risk levels
-- =========================================================

SELECT severity,
       COUNT(*) AS total_incidents
FROM incidents
GROUP BY severity;


-- =========================================================
-- INCIDENT ASSIGNMENT ANALYSIS
-- Purpose:
-- Monitor workload distribution among teams
-- =========================================================

SELECT assigned_to,
       COUNT(*) AS assigned_cases
FROM incidents
GROUP BY assigned_to;


-- =========================================================
-- OPEN CRITICAL INCIDENTS
-- Purpose:
-- Identify unresolved high-risk incidents
-- =========================================================

SELECT *
FROM incidents
WHERE severity = 'Critical'
AND status != 'Closed';


-- =========================================================
-- CRITICAL INCIDENTS BY DEPARTMENT
-- Purpose:
-- Detect departments exposed to severe threats
-- =========================================================

SELECT department,
       COUNT(*) AS critical_incidents
FROM incidents
WHERE severity = 'Critical'
GROUP BY department;


-- =========================================================
-- INCIDENT STATUS OVERVIEW
-- Purpose:
-- Governance and operational monitoring
-- =========================================================

SELECT status,
       COUNT(*) AS total
FROM incidents
GROUP BY status;


-- =========================================================
-- INCIDENT TREND ANALYSIS
-- Purpose:
-- Track incidents over time
-- =========================================================

SELECT created_date,
       COUNT(*) AS incidents_per_day
FROM incidents
GROUP BY created_date
ORDER BY created_date;


-- =========================================================
-- HIGH-RISK DEPARTMENTS
-- Purpose:
-- Departments with multiple incidents
-- =========================================================

SELECT department,
       COUNT(*) AS incident_count
FROM incidents
GROUP BY department
HAVING COUNT(*) > 1;


-- =========================================================
-- INCIDENT OWNERSHIP TRACKING
-- Purpose:
-- Track accountability and ownership
-- =========================================================

SELECT incident_id,
       incident_type,
       assigned_to,
       status
FROM incidents;


-- =========================================================
-- EXECUTIVE KPI SUMMARY
-- Purpose:
-- Executive-level governance dashboard metrics
-- =========================================================

SELECT
    COUNT(*) AS total_incidents,

    SUM(CASE
        WHEN severity = 'Critical' THEN 1
        ELSE 0
    END) AS critical_incidents,

    SUM(CASE
        WHEN status = 'Open' THEN 1
        ELSE 0
    END) AS open_incidents

FROM incidents;


-- =========================================================
-- VIEW ALL RISKS
-- Purpose:
-- Display all organizational risks
-- =========================================================

SELECT * FROM risks;


-- =========================================================
-- HIGHEST RISKS
-- Purpose:
-- Prioritize critical organizational risks
-- =========================================================

SELECT *
FROM risks
ORDER BY risk_score DESC;


-- =========================================================
-- HIGH-RISK DEPARTMENTS
-- Purpose:
-- Identify departments with highest risk exposure
-- =========================================================

SELECT department,
       MAX(risk_score) AS highest_risk
FROM risks
GROUP BY department;


-- =========================================================
-- CRITICAL RISKS ONLY
-- Purpose:
-- Show business-critical risks requiring action
-- =========================================================

SELECT *
FROM risks
WHERE risk_score >= 15;


-- =========================================================
-- AVERAGE RISK SCORE BY DEPARTMENT
-- Purpose:
-- Compare departmental risk exposure
-- =========================================================

SELECT department,
       AVG(risk_score) AS average_risk_score
FROM risks
GROUP BY department;


-- =========================================================
-- RISK DISTRIBUTION
-- Purpose:
-- Analyze organizational risk landscape
-- =========================================================

SELECT risk_score,
       COUNT(*) AS total_risks
FROM risks
GROUP BY risk_score
ORDER BY risk_score DESC;


-- =========================================================
-- RISK MITIGATION OVERVIEW
-- Purpose:
-- Display mitigation strategies for risks
-- =========================================================

SELECT risk_name,
       mitigation_plan
FROM risks;


-- =========================================================
-- HIGH LIKELIHOOD RISKS
-- Purpose:
-- Identify frequently occurring risks
-- =========================================================

SELECT *
FROM risks
WHERE likelihood >= 4;


-- =========================================================
-- HIGH IMPACT RISKS
-- Purpose:
-- Identify risks causing major business disruption
-- =========================================================

SELECT *
FROM risks
WHERE impact_score >= 4;


-- =========================================================
-- EXECUTIVE RISK SUMMARY
-- Purpose:
-- Governance dashboard metrics for leadership
-- =========================================================

SELECT
    COUNT(*) AS total_risks,

    MAX(risk_score) AS highest_risk_score,

    AVG(risk_score) AS average_risk_score

FROM risks;


-- =========================================================
-- COMBINED INCIDENT + RISK VIEW
-- Purpose:
-- Correlate incidents with departmental risk exposure
-- =========================================================

SELECT
    i.department,
    COUNT(i.incident_id) AS total_incidents,
    MAX(r.risk_score) AS department_risk_score

FROM incidents i

JOIN risks r
ON i.department = r.department

GROUP BY i.department;


-- =========================================================
-- DEPARTMENT GOVERNANCE SUMMARY
-- Purpose:
-- Business governance overview for leadership
-- =========================================================

SELECT
    i.department,

    COUNT(i.incident_id) AS total_incidents,

    SUM(CASE
        WHEN i.status = 'Open' THEN 1
        ELSE 0
    END) AS open_incidents,

    MAX(r.risk_score) AS highest_risk_score

FROM incidents i

JOIN risks r
ON i.department = r.department

GROUP BY i.department;