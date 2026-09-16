/*
Issue Description: CJAMS-60839 251023028995Please change drop-down selection for Contact with 
                   Alleged Victim to:Alleged Victim UnavailableAttempted Face to Face3-4 Attempts
Category/Module: Overdue Reason
Root cause: 251023028995Please change drop-down selection for Contact with 
Alleged Victim to:Alleged Victim UnavailableAttempted Face to Face3-4 Attempts
Fix provided: Data fix has been done to update the overdue reason as follows 
                "Alleged Victim to:Alleged Victim UnavailableAttempted Face to Face3-4 Attempts"
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: Data fix needed to correct the user entry error
*/


update cpsresponsetimeractions
set cpsresponsetimerreason1 = 'VAVU',
    cpsresponsetimerreason2 = 'VAFF',
    cpsresponsetimerreason3 = 'V34F',
    updatedon = now(),
    updatedby = 'CJAMS-60839'
where cpsresponsetimeractionsid = '6bdd0881-b1ab-4820-a82e-c570aeb0e51b'
and intakeserviceid = 'a5123052-0fb1-4a3f-b534-9d64463e4af1'
and activeflag = 1;