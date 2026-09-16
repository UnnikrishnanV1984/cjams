/*
   Issue Description: CIDM-11564 Psychotropic Secondary Review and HCDM statewide rollout effective 11/10/2025
   Category/Module: Psychotropic Secondary Review / HCDM
   Root Cause: The statewide go-live date was not configured for Psychotropic Secondary Review and HCDM.
   Fix Provided: Updated the statewide go-live date to 11/10/2025 for Psychotropic Secondary Review and HCDM.
   Code Fix Ticket#: NA
   Reason Why No Related Code Fix: This is a database configuration update only. No application code changes are required.
   Status of the Code Fix if Already Submitted and Expected Production Fix Date: NA
   Backup Before Update/Delete: NA
*/  
  
  
  UPDATE cjams.countygoliveconfig
SET statewide  = '2026-01-12',
    updatedby = 'CIDM-11564',
    updatedon = now()
WHERE objecttype IN (
    'psycotrophic-secondary-review',
    'psycotrophic-hcdm'
);