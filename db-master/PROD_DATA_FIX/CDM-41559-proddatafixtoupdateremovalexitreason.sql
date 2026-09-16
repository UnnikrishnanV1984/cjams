/*
   Issue Description: CDM-41559
   Category/ Module  : Prod data fix to update removal details
   Root cause: Exitdate time stamp is causing an issue in loading events
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update intakeservreqchildremoval
set volrelinquishment = 0,
removaltypekey='CDVP',
vpabegindate  = '2021-09-09 16:13:02',
vpaenddate = '2022-03-08 16:13:02',
agencysigneddate = '2021-09-09 16:13:02',
isbothparentssigned = 2,
parent1id = 1734923, 
vpaparentssigneddate = '2021-09-09 16:13:02',
parent2comments = 'Single parent adoption',
updatedon  = now(),
updatedby  = 'CDM-41559'
where intakeservreqchildremovalid  = '2ba7cc85-a35a-4189-ace1-c9f3a153cae6';
