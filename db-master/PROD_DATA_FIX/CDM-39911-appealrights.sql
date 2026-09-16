
/*
Issue Description: CW2096998:Appeals coordinator needs appeal rights to be able to change finding in old case from 1998- has admin approval to do so
Category/ Module : Expungement
Root cause: removal the case and update investigation Ruled Out.
Fix provided: Yes, write Db query 
Code fix ticket#: CDM-39911
Reason why no related code fix: Status of the code fix  already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update tb_conv_inv_finding
 set investigation_finding_cd = 'Ruled Out',
     etl_userid  = 'CDM-39911',
     etl_load_date = now()
 where referral_id  = 'CW2096998' ;    
 
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
   (   'IR'::character varying,
       'CW2096998'::character varying,
       null::date
   ) ;