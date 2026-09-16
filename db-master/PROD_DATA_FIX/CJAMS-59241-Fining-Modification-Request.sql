/*
 * CJAMS-59241 - Finding Modification Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Customer Name:Andrea Clark
 * Focus Area:Decision
 * Root cause: Modified this indicated neglect finding to ruled out neglect
 * Description - CW2255125:Please modify this indicated finding to ruled out and expunge from the system.
 * The closed record has been reviewed and the department is modifying the finding to ruled out. 
 * Assistant Deputy Director, Stephanie Cooke has approved this modification request.
 */
update tb_conv_inv_finding
set investigation_finding_cd = 'Ruled Out'
where inv_finding_id=231066 and  referral_id = 'CW2255125';

--select investigationfindingtypekey,* from investigationfinding where personid = 'a6beb39f-c7c8-44d9-82f4-31e3f6a34a22';--873b68de-e58d-42a7-bcbf-628f138940c5

update  investigationfinding 
set investigationfindingtypekey = 'RO',
	updatedby = 'CJAMS-59241',
	updatedon = now()
where personid = 'a6beb39f-c7c8-44d9-82f4-31e3f6a34a22'
	and investigationfindingid= '873b68de-e58d-42a7-bcbf-628f138940c5';
	

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2255125'::character varying,
		null::date
	) ;