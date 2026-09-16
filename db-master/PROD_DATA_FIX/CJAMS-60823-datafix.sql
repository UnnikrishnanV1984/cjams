/*
  Issue Description: User requested to connect the intake (I251013325005) with the existing service case (3038867) to fix the issue
  Root cause: Service case is not being populated for the intake (I251013325005) .
  Fix provided : User requested to connect the intake (I251013325005) with the existing service case (3038867) to fix the issue
  Pull request# for code fix: N/A
  Reason why no related code fix: N/A 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: N/A
*/
--intakeserviceid --> bb2327a1-d3db-4082-9d2c-709aef25cf2c
--servicerequestnumber --> 3038867


select * from cjams.createservicecase('bb2327a1-d3db-4082-9d2c-709aef25cf2c', 'd95d7d23-b576-4686-ac2f-4bc6c66f4d98', 0, 'c20f6f1d-64d7-48d5-ad34-4ff6c3fa4688', '{}');