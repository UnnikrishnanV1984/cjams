/*
-- Issue Description: 
   User requested to change the Worker Visit to Monthly Visit
   -- CJAMS-69479 - Reason for Visit change to Monthly Visit

Good afternoon,I am requesting that one of my contact notes for Case #3265767 (the Marshall case) be corrected.Please update the contact note dated July 14 to include the monthly visit for Maliyah Marshall

-- Root cause: Data Issue (Exception scenario)
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/


update 	progressnote 
set progressnotereasontypekey = 'MV,SMEE',updatedby = 'CJAMS-69479',updatedon = now()
where progressnoteid = 'bbfa9760-5911-4eaa-b6c6-b3079522fa07' and activeflag = 1;
