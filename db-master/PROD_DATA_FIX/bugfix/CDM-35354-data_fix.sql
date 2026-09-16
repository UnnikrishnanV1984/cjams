/*
   Issue Description: CDM-35354
   Category/ Module  : Child Welfare
   Root cause:Client Name on Funding Request is incorrect
   Pull request# for code fix: 
   Reason why no related code fix:  
   Status of the code fix if already submitted and expected prod fix date: 
*/

select 
  cjamspid, 
  firstname,
  middlename,
  lastname, 
  dob, 
  ssnno,
  clientflag,
  cisclientid,
  personid,
  activeflag,
  updatedby,
  updatedon
from person
where personid = '59be6a92-1f36-44d0-80a8-63ae51010194' and activeflag = 1;

-- Generate new cjamspid   
update person
set cjamspid = nextval('sequence_for_alpha_numerics'::regclass),
   updatedby = 'CDM-35354', 
   updatedon = now()
where personid = '59be6a92-1f36-44d0-80a8-63ae51010194' and activeflag = 1;
-- Client Name displayed as Patricia Garret in the PDF of Purchase Auth # 2698015 replaced by ANDREW CRABTREE.