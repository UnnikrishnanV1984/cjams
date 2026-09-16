/*
   Issue Description: CDM-19358
   Category/ Module  : Removal End date
   Root cause: Not allowing to user to end date
   Pull request# for code fix: 
   Reason why no related code fix: needs complete input to change code
   Status of the code fix if already submitted and expected prod fix date: 
*/
 
select * FROM Intakeservreqchildremoval  icr 
where intakeservreqchildremovalid in ('b97cd823-6578-4cd7-876b-d74d01222eac' );

update Intakeservreqchildremoval
set exitdate = '2021-10-01T00:00:00',updatedby = 'CDM-19358', updatedon = now()  
where intakeservreqchildremovalid in ('b97cd823-6578-4cd7-876b-d74d01222eac');