/*
   Issue Description: CJAMS-58896 3306365:Subsidy suspension request was submitted in error. It has been approved and cannot be deleted. Provider is not able to be paid. Please delete the subsidy suspension
   Category/ Module  : Adoption payment suspension
   Root cause:User created a payment suspension by mistake and data fix is need to remove the suspended date
              and continue the payments.
   Fix Provided: Data fix has been done to remove the incorrect suspension and trigger payment.  
   Data/Code fix ticket#: CJAMS-58896
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: User error 
*/

update adoptioncasesuspensionrevision
set activeflag=0,
    updatedby = 'CJAMS-58896',
    updatedon = now()
where adoptionsuspensionid in ('2352a3a2-d496-4ec7-92e1-70170e5bdb35')
and activeflag=1;

update routing
set activeflag=0,
    updatedby = 'CJAMS-58896',
    updatedon = now()
where objectid in ('2352a3a2-d496-4ec7-92e1-70170e5bdb35')
and activeflag=1;


update adoptioncasesuspension
set activeflag=0,
    updatedby = 'CJAMS-58896',
    updatedon = now()
where adoptionsuspensionid in ('2352a3a2-d496-4ec7-92e1-70170e5bdb35')
and activeflag=1;



update adoptioncaseagreementrate
set updatedon = now(),
    updatedby = 'CJAMS-58896'
where adoptionagreementrateid in ('a52fb3c7-1dc9-4523-83b3-46aea9072577','0b3c421f-1d62-4c3a-89b2-b8af23b97bb6')
and activeflag = 1;