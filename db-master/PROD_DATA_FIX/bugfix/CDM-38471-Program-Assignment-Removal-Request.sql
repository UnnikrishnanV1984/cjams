/* 
    Issue Description: CDM-38471 Please remove CIS # 30122432 program assignment from CJAMS Investigation # CW2287498. 
    Assistant Deputy Director, Stephanie Cooke has approved this request
   Category/ Module  : Expungement Request
   Root cause: Data fix for expunging the case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    void the rejected provider placement from backend
*/



select referral_id, maltreatment_type_cd, investigation_finding_cd 
	from tb_conv_inv_finding 
where referral_id  = 'CW2287498' ;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
   (   'IR'::character varying,
       'CW2287498'::character varying,
       null::date
   ) ;
