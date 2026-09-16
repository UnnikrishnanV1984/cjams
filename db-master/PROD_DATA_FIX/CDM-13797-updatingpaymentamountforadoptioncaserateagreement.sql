-- 401
update adoptioncaseagreementrate set paymentamout = 500, updatedby = 'CDM-13979',updatedon = now() where adoptionagreementrateid in ('572103b2-e22b-4686-a46c-51a522c1afcc','9615fd75-785b-4479-9459-1ad36697ab76');

update adoptioncaserevision set paymentamout = 500, updatedby = 'CDM-13979',updatedon = now(), approvaldate = now() where adoptionagreementrateid in ('572103b2-e22b-4686-a46c-51a522c1afcc','9615fd75-785b-4479-9459-1ad36697ab76') and activeflag = 1;
