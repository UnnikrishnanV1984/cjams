-- CJAMS-59864  Incident date needs to be changed

/*
-- Issue Description: 
	CPS-IR : 241022963311 case start date is 12/06/2024, user is asked to modify the 
    maltreatment date of incident prior to the case start date, 12/6/2024 to 06/01/2022.

-- Category/ Module: Persons
-- Root cause: :CPS-IR : 241022963311 case start date is 12/06/2024, user is asked to modify the 
      maltreatment date of incident prior to the case start date, 12/6/2024 to 06/01/2022.
-- Resolution: Data fix has been made to 241022963311 case start date is 12/06/2024, modified to  06/01/2022.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update investigationallegation 
set incidentdate ='2022-06-01 00:00:00',
updatedby ='CJAMS-59864',
updatedon =now() 
where investigationallegationid = '6d36347e-757a-4798-a74d-a1da227c4542';