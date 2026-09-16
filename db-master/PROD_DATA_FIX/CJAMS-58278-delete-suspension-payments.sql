/*
   Issue Description: CJAMS-58278 Payment suspended in error
   Category/ Module  : Adoption payment suspension
   Root cause:User created a payment suspension by mistake and data fix is need to remove the suspended date
              and continue the payments.
   Fix Provided: Data fix has been done to remove the incorrect suspension and trigger payment.  
   Data/Code fix ticket#: CJAMS-58278
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: User error 
*/

update adoptioncasesuspensionrevision
set activeflag=0,
    updatedby = 'CJAMS-58278',
    updatedon = now()
where adoptionsuspensionid in ('bf88ec09-bca9-4d49-93d4-1abccfc89395','d16eaeee-3d88-414e-9ec9-73d93d870ff1')
and activeflag=1;

update routing
set activeflag=0,
    updatedby = 'CJAMS-58278',
    updatedon = now()
where objectid in ('bf88ec09-bca9-4d49-93d4-1abccfc89395','d16eaeee-3d88-414e-9ec9-73d93d870ff1')
and activeflag=1;


update adoptioncasesuspension
set activeflag=0,
    updatedby = 'CJAMS-58278',
    updatedon = now()
where adoptionsuspensionid in ('bf88ec09-bca9-4d49-93d4-1abccfc89395', 'd16eaeee-3d88-414e-9ec9-73d93d870ff1')
and activeflag=1;



update adoptioncaseagreementrate
set updatedon = now(),
    updatedby = 'CJAMS-58278'
where adoptionagreementrateid in ('efc8dd63-3fcb-490d-b5dc-b5aedf506da0','e521a7d5-a956-4dd7-926e-2e1c5454e840','c30caf19-ead4-4872-815c-ab88238ed833','ebc768f7-0dcd-4953-b71d-a451b75e261a')
and activeflag = 1;