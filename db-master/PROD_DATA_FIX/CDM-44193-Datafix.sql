/* 
    Issue Description: CDM-44193
   Category/ Module  : Finding Modification Request
   Root cause: :modified these indicated neglect finding to ruled out neglect and expunge from the system
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/


UPDATE cjams.tb_conv_inv_finding
SET investigation_finding_cd='Ruled Out' 
where inv_finding_id=205076 and referral_id='CW2229135';


select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2229135'::character varying,
		null::date
	);