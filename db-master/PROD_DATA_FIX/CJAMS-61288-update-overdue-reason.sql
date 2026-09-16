/*
Issue Description:CJAMS-61288 251023018545:251023082665:This case has an unknown victim that has not been identified during the investigation process and therefore contact with alleged victim has not been completed - it has, however, been attempted 5 times. When attempting to log this in the "Over Due Reason", information is selected but I do not have the ability to update or submit the attempts in CJAMs. The only box I can select is "Cancel". A photo of the screen has been attached. 
Category/Module: Overdue Reason
Root cause: As per system design, the LRR (Overdue Reason) can not be edited/updated once it has been saved & approved.
            In this case, the the LRR (Overdue Reason) is approved on 07/11/2025. 
            Data fix needed to update the overdue reason as follows
            contact with Alleged Victim
                Alleged victim Unavailable
                Attempted Face to Face
                5 or more Attempts
Fix provided: Data fix has been done to update the overdue reason as follows 
                Alleged victim unavailable > Attempted face to face > 5 or more attempts
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A 
Reason why no related code fix:   As per system design, the LRR (Overdue Reason) can not be edited/updated once it has been saved & approved.
*/

update cpsresponsetimeractions
set cpsresponsetimerreason1 = 'VAVU',
    cpsresponsetimerreason2 = 'VAFF',
    cpsresponsetimerreason3 = 'V5MF',
    updatedon = now(),
    updatedby = 'CJAMS-61288'
where cpsresponsetimeractionsid = '3b3a46b0-de69-416b-b2e8-4e6b8be152d4'
and intakeserviceid = '79768dc2-57e5-49c0-8297-2ef15ad4bb62';