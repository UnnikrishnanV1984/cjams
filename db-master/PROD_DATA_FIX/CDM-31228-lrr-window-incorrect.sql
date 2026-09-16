/*
   Issue Description: CDM-31228
   Category/ Module  :OverDue Reason  
   Root cause: overdue popup window few values not populating
   Pull request# for code fix: 
   Reason why no related code fix: 
    requested a data fix to resolve
*/
update cpsresponsetimeractions set allegedvictimcontact = 'false',cpsresponsetimerreason4= 'OWCR',cpsresponsetimerreason1 = 'VWCR',
cpsresponsetimerreason2 ='["VSSR"]' ,updatedby = '31228' ,updatedon =now()
where intakeserviceid ='ad65770b-4d7f-49c0-a481-d9715ca8daf5';

update cpsresponsetimeractions set allegedvictimcontact = 'false',
updatedby ='CDM-31228',updatedon =now() where intakeserviceid = 'a00f621a-eb3d-469c-934a-d4ccdeafb2e3';