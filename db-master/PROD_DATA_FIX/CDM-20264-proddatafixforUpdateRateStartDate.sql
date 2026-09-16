
/*
   Issue Description: CDM-20264
   Category/ Module  : Updating Placement End date
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


-- 2022-12-17 10:00:00
update gapagreementrate set startdate = '2021-12-18 10:00:00', updatedon = now(), updatedby = 'CDM-20264' where gapagreementrateid = 'b117a65e-65e9-4e46-8044-c53712b63aac';
update gapratesrevision set ratestartdate = '2021-12-18 10:00:00',approvaldate =  now() , updatedon = now(), updatedby = 'CDM-20264' where gaprateid = 'b117a65e-65e9-4e46-8044-c53712b63aac' and activeflag = 1;
