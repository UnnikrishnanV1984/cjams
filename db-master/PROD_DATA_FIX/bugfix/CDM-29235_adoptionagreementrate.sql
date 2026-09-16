/*
   Issue Description: CDM-29235
   Category/ Module  : Adoption Agreement rate 
   Root cause: user requested to update the rate
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update adoptionagreementrate 
set paymentamout =  1008.00, updatedon = now(), updatedby = 'CDM-29235'
where adoptionagreementrateid in ('da67169a-e1dc-424c-ad4e-f74abd84ef72','a6f69787-5c73-485e-adb5-310fadf5eb8a');

-- Datafix to trigger Under/Over 
select approvalstatustypekey, approvaldate, startdate, enddate, paymentamout, activeflag, updatedby, updatedon 
	from adoptionagreementraterevision 
where adoptionagreementrateid in ('da67169a-e1dc-424c-ad4e-f74abd84ef72','a6f69787-5c73-485e-adb5-310fadf5eb8a');

update adoptionagreementraterevision 
set paymentamout = 1008.00,
	approvaldate = now(),
	updatedby = 'CDM-29235',
	updatedon = now()
where adoptionagreementrateid in ('da67169a-e1dc-424c-ad4e-f74abd84ef72','a6f69787-5c73-485e-adb5-310fadf5eb8a');
