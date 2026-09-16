/*
   Issue Description: CDM-16888
   Category/ Module  :  Child removal/PA
   Root cause: user asked to end date the PA and child removal for client id : 4353956, 4353959 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservreqchildremoval 
set exitdate = '2021-06-04 00:00:00', 
    removalexitreason = 'RUF', 
    updatedon = now(),
    updatedby = 'CDM-16888'
where intakeservreqchildremovalid in ('16385bd3-bcdb-4a8c-b089-84eb1509c5b7', 'e5838466-52a9-46ec-a5b7-e9aec86e98bf');

-- 2021-07-20 14:22:19
UPDATE personprogramarea 
SET enddate = '2021-06-04 14:22:19', 
    updatedby = 'CDM-16888', 
    updatedon = now() 
WHERE personprogramid in ('c1543f19-2ad0-4e2f-95fc-c286c32605a5', '23f3c4a6-582b-42eb-841b-c89884e83353');