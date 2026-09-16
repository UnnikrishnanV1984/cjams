/*
   Issue Description: CJAMS-62629
   Category/ Module  : User requested to do a data fix to update the 2nd dropdown for alleged victim and 
   ICC as "Family was contacted but unable to meet within mandate".
   Root cause: User requested to do a data fix to update the 2nd dropdown for alleged victim and 
   ICC as "Family was contacted but unable to meet within mandate".
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/

update cpsresponsetimeractions
set cpsresponsetimerreason2 = 'VFCM',
    cpsresponsetimerreason8 = 'CFMN',
    updatedon = now(),
    updatedby = 'CCJAMS-62629'
where cpsresponsetimeractionsid = 'cbbc4343-fd8e-4da7-bcab-fcec4c590a28'
and intakeserviceid = '3d791a96-5226-41a7-a2a9-77aa0b391757';