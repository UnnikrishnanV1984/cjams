-- CDM-23394-Duplicate contact entries
/*
   File Name: CDM-23394-progressnote-Duplicatecontactentries
-- Issue Description: 
   For the case number2221020213598:user entered one contact note, but when it saved, there were two identical notes.
   Customer Email ID: jessicam.jacobs@maryland.gov

-- Resolution: Updated the activeflag to zero in progressnote and progressnotedetail table

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/


update
	progressnote
set
	activeflag = 0,
	updatedby = 'CDM-23394',
	updatedon = now()
where
	progressnoteid = '993a32df-8612-4984-a5aa-8d9b0a7bfc71';

update
	progressnotedetail
set
	activeflag = 0,
	updatedby = 'CDM-23394',
	updatedon = now()
where
	progressnoteid = '993a32df-8612-4984-a5aa-8d9b0a7bfc71';