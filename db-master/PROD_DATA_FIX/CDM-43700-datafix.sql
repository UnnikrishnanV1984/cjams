/*
  Issue Description:  CDM-43700
   Category/ Module  :  Approval
   Root cause:User request to do a data fix to update the subsidy rate begin date as  '2025-01-26'
   Pull request# for code fix: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: NA
*/

update gapagreementrate 
set startdate = '2025-01-26',
updatedby = 'CDM-43700',
updatedon = now() 
where gapagreementrateid = '379e3ced-9a8e-4164-95f0-5812c05a74dc'
and gapagreementid = '03a204e7-59a3-45e7-a412-741055e30877'
and activeflag = 1;

update gapratesrevision
set ratestartdate = '2025-01-26',
updatedby = 'CDM-43700',
updatedon = now(),
approvaldate = now()
where gaprateid = '379e3ced-9a8e-4164-95f0-5812c05a74dc'
and activeflag = 1;
