/*
   Issue Description: CDM-42557
   Category/ Module  : Case assignments 
   Root cause: user wants to remove case assignment due to duplicate case assignment
    Fix Provided: Datafix has been promoted to update the flags.
    Pull request# N/A 
    Is Code fix Required?: Yes
    Code fix ticket#: CIDM-9795 - But developer couldn't repro the issue.
    Reason why no related code fix: 
    Regression Impacts: Assignment and Intake case assignment dashboard
*/

update caseassignment CA 	
	set activeflag = 0, updatedon = now(), updatedby ='CDM-42557'
WHERE 
    CA.objectid = '6838c20e-fcbb-4096-b0db-536eff43b4fe'
	and caseassignmentid = '2f5ba714-f133-4269-bac8-1c6803978123'
	and activeflag = 1;

update routing 
    set activeflag =0,updatedon = now(), updatedby ='CDM-42557'
where 
    servicerequestnumber='241022945619' 
    and routingid = 'd97650cd-2a5e-4706-b344-ece1b4190863'
    and activeflag = 1;