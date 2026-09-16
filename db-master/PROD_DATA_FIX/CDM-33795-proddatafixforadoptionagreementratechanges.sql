/*
   Issue Description: CDM-33795
   Category/ Module  : Prod data fix for adoption break the link
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update adoptioncaseagreement set providerid = '5020886', parent1providerid = '5020886', updatedby = 'CDM-33795', updatedon = now() 
 where adoptionagreementid = '0a0f1183-2764-4f0d-8a40-f0e187a32457';

update adoptioncaserevision
set provider_id = 5020886,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-33795'
where adoptionagreementid = '0a0f1183-2764-4f0d-8a40-f0e187a32457'
and approvaldate is not null and adoptionagreementrateid = 'aa35b705-dff6-43a9-9009-6ed9ec6e789e' and activeflag = 1 ;

update adoptioncaseagreementrate
set provider_id = 5020886,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-27478'
where adoptionagreementrateid = 'aa35b705-dff6-43a9-9009-6ed9ec6e789e' and activeflag = 1 ;


update tb_payment_status set delete_sw = 'Y', update_user_id = 'CDM-33795', update_ts = now()
where payment_status_id  = '3572801' and payment_id = '3610005' and delete_sw = 'N';

update tb_payment_detail set delete_sw = 'Y', update_user_id = 'CDM-33795', update_ts = now()
where payment_detail_id = '4847327' and payment_id = '3610005' and delete_sw = 'N';

update tb_payment_header set delete_sw = 'Y', update_user_id = 'CDM-33795', update_ts = now()
where payment_id = '3610005' and delete_sw = 'N';