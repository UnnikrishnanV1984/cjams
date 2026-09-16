/*
   Issue Description: CDM-27430
   Category/ Module  : Subsidary Agreement date 
   Root cause: user wants to change the date for payments 
   Pull request# for code fix: 7364
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update adoptioncaseagreementrate 
set enddate = '2022-12-04 00:00:00', updatedby = 'CDM-27430', updatedon = now()
where adoptionagreementrateid = 'b578bb2c-13b0-4e6c-9427-68521a36cff3';

update adoptioncaserevision set enddate = '2022-12-04 00:00:00', approvaldate = now(), updatedby = 'CDM-27430', updatedon = now() 
where adoptionagreementrateid = 'b578bb2c-13b0-4e6c-9427-68521a36cff3'
and activeflag = 1;
