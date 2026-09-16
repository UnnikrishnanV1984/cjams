/*
   Issue Description: CJAMS-58277 Payment suspended in error
   Category/ Module  : Adoption payment suspension
   Root cause:User created a payment suspension by mistake and data fix is need to remove the suspended date
              and continue the payments.
   Fix Provided: Data fix has been done to remove the incorrect suspension and trigger payment.  
   Data/Code fix ticket#: CJAMS-58277
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: User error 
*/

update adoptioncasesuspensionrevision
set activeflag=0,
    updatedby = 'CJAMS-58277',
    updatedon = now()
where adoptionsuspensionid='d16eaeee-3d88-414e-9ec9-73d93d870ff1';

update routing
set activeflag=0,
    updatedby = 'CJAMS-58277',
    updatedon = now()
where objectid='d16eaeee-3d88-414e-9ec9-73d93d870ff1';

update adoptioncasesuspension
set activeflag=0,
    updatedby = 'CJAMS-58277',
    updatedon = now()
where adoptionsuspensionid='d16eaeee-3d88-414e-9ec9-73d93d870ff1';


update adoptioncaseagreementrate
set updatedon = now(),
    updatedby = 'CJAMS-58277'
where adoptionagreementrateid in ('ebc768f7-0dcd-4953-b71d-a451b75e261a','c30caf19-ead4-4872-815c-ab88238ed833')
and activeflag = 1;
    