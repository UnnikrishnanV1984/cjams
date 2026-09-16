/*
-- Issue Description: Contact should be shown in CPS case too	
-- Category/ Module: Contact Notes
-- Root cause: TDB 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

UPDATE cjams.progressnote
SET intakeserviceid='08ec63fb-8da5-466d-9327-93495aa0ebed', entitytype = 'intakeservicerequest', entitytypeid = '08ec63fb-8da5-466d-9327-93495aa0ebed', updatedby='CDM-33357'
WHERE progressnoteid='01bc47d2-9ae2-42b3-a391-754d1c5558ce' and witsid = '11062409';
