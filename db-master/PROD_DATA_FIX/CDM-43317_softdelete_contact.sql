/*
-- CDM-43317 
-- Issue Description: 
 Soft delete the contact
-- Customer Email ID: anthonia.ogbuka@maryland.gov
-- Root cause:User Request 
-- Fix Provided: Data fix to set active flag to zero to soft delete the contact
-- Pull request#: N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
UPDATE progressnote
SET activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-43317'
WHERE progressnoteid = '2e8ed4d4-223c-43fa-99d0-7270439a03e4';


UPDATE progressnotedetail
SET activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-43317'
WHERE progressnoteid = '2e8ed4d4-223c-43fa-99d0-7270439a03e4';

/*
select * from contactparticipant WHERE progressnoteid = '2e8ed4d4-223c-43fa-99d0-7270439a03e4' and activeflag = 1;
*/

update contactparticipant
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-43317'
WHERE progressnoteid = '2e8ed4d4-223c-43fa-99d0-7270439a03e4';