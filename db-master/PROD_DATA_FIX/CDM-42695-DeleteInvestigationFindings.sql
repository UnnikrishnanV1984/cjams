/*
  Issue Description:  CDM-42695
   Category/ Module  :  Investigation Change Pathway
   Root cause: After change pathway, old investigation finding records not deleted.
   Fix Provided: Datafix has been promoted to delete the old investigation findings.
    Pull request# N/A 
    Is Code fix Required?: No
    Code fix ticket#: CIDM-9358
    Reason why no related code fix: N/A
    Regression Impacts: Investigation Findings
*/


update cjams.investigationallegationmaltreators
set 
    activeflag = 0, 
    updatedby='CDM-42695', 
    updatedon=now()
where 
    investigationallegationmaltreatorsid in 
    ('14ead07d-8c2b-49b1-acc1-84248f339e83', '3ed804c3-a0dc-4f16-a7a0-44227c44ea34'); 
