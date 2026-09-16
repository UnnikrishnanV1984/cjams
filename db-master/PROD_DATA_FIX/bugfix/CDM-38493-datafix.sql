/* 
    Issue Description: CDM-38493
   Category/ Module  : Expungement Request
   Root cause: Data fix for expunging the case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    void the rejected provider placement from backend
*/

select referral_id, maltreatment_type_cd, investigation_finding_cd 
	from tb_conv_inv_finding 
where referral_id  = '211020166467' ;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'211020166467'::character varying,
		null::date
	) ;
	