CREATE DATABASE cyber_risk_platform;

USE cyber_risk_platform;

CREATE TABLE incidents (
    incident_id INT AUTO_INCREMENT PRIMARY KEY,
    incident_type VARCHAR(100),
    severity VARCHAR(50),
    department VARCHAR(100),
    assigned_to VARCHAR(100),
    status VARCHAR(50),
    created_date DATE
);