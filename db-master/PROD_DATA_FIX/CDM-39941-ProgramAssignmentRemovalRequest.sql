/*
Issue Description: program assignment from CJAMS investigation # CW2261146, CW2261145, and CW2280368. The department does not have the closed records for the investigations.
Category/ Module :Expungement Request
Root cause: Data fix for expunging the cases
Fix provided: Yes, write DB query.
Code fix ticket#: CDM-39941
Reason why no related code fix: Status of the code fix already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
--CW2261146
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
   (   'IR'::character varying,
       'CW2261146'::character varying,
       null::date
   ) ;
   
--CW2261145
  select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
   (   'IR'::character varying,
       'CW2261145'::character varying,
       null::date
   ) ;
   
  --CW2280368
    select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
   (   'IR'::character varying,
       'CW2280368'::character varying,
       null::date
   ) ;