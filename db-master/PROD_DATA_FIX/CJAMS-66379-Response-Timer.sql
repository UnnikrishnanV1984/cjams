/*
   Issue Description: CJAMS-66379
   Root cause:carry out data fix to update CPS case start date and time from 03/09/2026 4:38 PM to 03/12/2026 3:34 PM against CPS IR # 261023691728
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



update intakeservicerequest 
set reporteddate = '2026-03-12 15:34:00',updatedby = 'CJAMS-66379', updatedon = now()
where servicerequestnumber = '261023691728' and activeflag = 1;