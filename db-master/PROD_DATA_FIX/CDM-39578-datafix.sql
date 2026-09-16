/* 
    Issue Description: CDM-39578
   Category/ Module  : Finding Modification Request
   Root cause: :Please modify these indicated neglect findings to ruled out neglect. 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/

update tb_conv_inv_finding
 set investigation_finding_cd = 'Ruled Out',
     etl_userid  = 'CDM-42946',
     etl_load_date = now()
 where referral_id  = 'CW2285800' ;    
 
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
   (   'IR'::character varying,
       'CW2285800'::character varying,
       null::date
   ) ;