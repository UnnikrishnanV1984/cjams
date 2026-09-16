ALTER TABLE intakeservicerequestncps RENAME COLUMN  servicereferraltypekey TO nonreferralreason;
ALTER TABLE intakeservicerequestncps RENAME COLUMN  resaoncomments TO "comments";
ALTER TABLE intakeservicerequestncps ADD COLUMN IF NOT EXISTS suggestedresources TEXT;
ALTER TABLE intakeservicerequestncps ADD COLUMN IF NOT EXISTS requestedservices TEXT;