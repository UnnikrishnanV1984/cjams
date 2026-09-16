/*
   Issue Description: CJAMS-65452Subsidy suspension request was submitted in error. It has been approved and cannot be deleted. Provider is not able to be paid. Please delete the subsidy suspension
   Category/ Module  : Adoption payment suspension
   Root cause:User created a payment suspension by mistake and data fix is need to remove the suspended date
              and continue the payments.
   Fix Provided: Data fix has been done to remove the incorrect suspension and trigger payment.  
   Data/Code fix ticket#: CJAMS-65452
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: User error 
*/


update adoptioncasesuspensionrevision
set activeflag=0,
    updatedby = 'CJAMS-65452',
    updatedon = now()
where adoptionsuspensionid in ('2eada43b-2c71-401b-a47e-6682d313d974','d6ce6be9-d077-4839-8264-d14b64f9e647')
and activeflag=1;

update routing
set activeflag=0,
    updatedby = 'CJAMS-65452',
    updatedon = now()
where objectid in ('2eada43b-2c71-401b-a47e-6682d313d974','d6ce6be9-d077-4839-8264-d14b64f9e647')
and activeflag=1;


update adoptioncasesuspension
set activeflag=0,
    updatedby = 'CJAMS-65452',
    updatedon = now()
where adoptionsuspensionid in ('2eada43b-2c71-401b-a47e-6682d313d974','d6ce6be9-d077-4839-8264-d14b64f9e647')
and activeflag=1;

update adoptioncaseagreementrate
set updatedon = now(),
    updatedby = 'CJAMS-65452'
where adoptionagreementrateid in ('27293eab-972c-49b6-bbb4-567c18d4726f','cb153ffb-4ee1-4c03-b454-8cd07d5539b1')
and activeflag = 1;
