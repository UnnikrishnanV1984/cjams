/*
   Issue Description: CDM-18715
   Category/ Module  :  CW Child removal
   Root cause: user asked to remove the duplicate child removal
   Pull request# for code fix: 
   Reason why no related code fix: 
   user error duplicate contact 
*/

update intakeservreqchildremoval 
set updatedby = 'CDM-18715', updatedon = now(), activeflag = 0
where intakeservreqchildremovalid = '1404965e-3fb2-4b8b-ba35-459a9d2da289';

update routing 
set updatedby = 'CDM-18715', updatedon = now(), activeflag = 0
where objectid = '1404965e-3fb2-4b8b-ba35-459a9d2da289';

update placement 
set updatedby = 'CDM-18715', updatedon = now(), activeflag = 0
where intakeservreqchildremovalid = '1404965e-3fb2-4b8b-ba35-459a9d2da289';
