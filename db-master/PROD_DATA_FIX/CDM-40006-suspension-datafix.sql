/*
  Issue Description:  CDM-40972
   Category/ Module  :  payments
   Root cause: Removing the active suspension and setting the approvaldate in suspensionrate
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update gapsuspension 
set activeflag =0,
updatedby ='CDM-40006', updatedon =now()
where gapsuspensionid ='3827ba7d-723a-4c23-811f-017a5abf9c2f'
and activeflag = 1
and enddate is null;

update gapratesrevision 
set approvaldate =now(),
updatedby ='CDM-40006', updatedon =now()
where gaprateid  in ('0cc1c0ff-c9d5-48fa-805a-2d6398cb0b57','5f54928a-3305-4fa5-9caf-ce82fe32cd68') and activeflag =1;