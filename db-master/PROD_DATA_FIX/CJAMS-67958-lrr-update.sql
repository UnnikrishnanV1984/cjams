/*
Category/Module: Overdue Reason
Root cause:Data Entry error and user requested to update the overdue reason for Contact with Alleged Victim Completed : Child out of the jurisdiction / ROA pending - In-state but other LDSS was unable to see alleged victim within mandate / Anne Arundel
Fix provided: Data fix to update the over due reason as Contact with Alleged Victim Completed : Child out of the jurisdiction / ROA pending - In-state but other LDSS was unable to see alleged victim within mandate / Anne Arundel
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: User error
*/

select cpsresponsetimerreason1 ,cpsresponsetimerreason2 ,cpsresponsetimerreason3 ,* from cpsresponsetimeractions c where intakeserviceid ='ca54679e-a333-4c67-ba35-9dea7d8f5127';

update cpsresponsetimeractions
set cpsresponsetimerreason1 = 'VCOJ',
    cpsresponsetimerreason2 = 'VRIJ',
    cpsresponsetimerreason3 = 'VAAJ',
    updatedon = now(),
    updatedby = 'CJAMS-67958'
where cpsresponsetimeractionsid = '764d4bcd-56b7-4c67-ae80-c035f1a9072f'
and intakeserviceid = 'ca54679e-a333-4c67-ba35-9dea7d8f5127';