/*
   Issue Description: CIDM-9419
   Category/ Module  : Prod data fix to update legal date_agency_lost_legal_responsibility
   Root cause: Exitdate time stamp is causing an issue in loading events
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


	 -- 2024-07-07 04:00:00
	 update tb_foster_care_judicial set date_agency_lost_legal_responsibility = null, isiveagencyresponsibleforplacementandcare = 'YES' , update_ts = now() 
	 where client_id = '2387846' AND removal_id = '252306' and period_type = 'R1';