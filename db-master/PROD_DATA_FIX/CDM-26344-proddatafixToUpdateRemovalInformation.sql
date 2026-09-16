/*
   Issue Description: CDM-26344
   Category/ Module  : Prod data fix to update removal information
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
-- EHA						2022-04-14 00:00:00.000
update intakeservreqchildremoval set removaltypekey = 'CDVP',
vpabegindate = '2022-04-14 00:00:00.000' ,
vpastartdate = '2022-04-14 00:00:00.000',vpaenddate = '2022-10-10 00:00:00.000',
parent2signeddate = '2022-04-14 00:00:00.000', vpaparentssigneddate = '2022-04-14 00:00:00.000', 
agencysigneddate = '2022-04-14 00:00:00.000', updatedby = 'CDM-26344', updatedon = now() 
where removalid = '253847';