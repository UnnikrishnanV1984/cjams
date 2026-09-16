/*
   Issue Description: CDM-16762
   Category/ Module  :  Updating Removal Information
   Root cause: Intake has been removed as per the user request
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- bd18c682-000e-44a5-9c4c-f56e9af8ea9c
update intakeservreqchildremoval set primarycaregiveractorid = '96e78125-d168-472f-8642-4fa07c73406f', updatedby = 'CDM-16762',updatedon = now() where removalid = '251071';
