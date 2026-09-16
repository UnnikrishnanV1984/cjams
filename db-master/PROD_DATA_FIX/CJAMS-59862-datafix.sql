-- CJAMS-59862 Incident date needs to be changed

/*
-- Issue Description: 
	CPS-IR : CPS-IR case # 251023010887 
    user requested to modify the incident date to the case start date, 03/07/2025 to 01/25/2025

-- Category/ Module: Persons
-- Root cause: :CPS-IR : CPS-IR case # 251023010887 
    user requested to modify the incident date to the case start date, 03/07/2025 to 01/25/2025
-- Resolution: Data fix has been made to modify the incident date to the case start date, 03/07/2025 to 01/25/2025
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

 
update investigationallegation 
  set incidentdate ='2025-01-25 00:00:00',
      updatedby ='CJAMS-59862',
      updatedon =now() 
where investigationallegationid = '7fa96fd6-2492-4166-9613-d669aa2b4fd7';