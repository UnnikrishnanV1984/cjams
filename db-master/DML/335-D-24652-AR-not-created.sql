--D-24652 Bug/Issue/Defect I202000357036 Did not recognize SDM selection as AR Intake was sent as ROH, supervisor added neglect type, but CJAMS only registered ROH. Service case was opened instead of AR neglect.

UPDATE intakeservicerequest
SET actiontype='AR', intakeservicerequestclassid='b74ded78-12dc-4e6d-94db-7662d6eaf093'
WHERE intakeserviceid='e60286b7-d3df-41a8-abd6-b7fce860350e'
 
UPDATE servicecase
SET activeflag=0
WHERE servicecaseid='55d5bc6a-bfe4-4bac-b585-3710e6a0dd51'