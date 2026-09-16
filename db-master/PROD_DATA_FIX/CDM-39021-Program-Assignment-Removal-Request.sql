/*
Issue Description: CDM-39021: CW2213716:Please remove CIS #467013993 program assignment from CJAMS investigation # CW2213716. Assistant Deputy Director, Stephanie Cooke has approved this request.
Category/ Module : Expungement Request
Root cause: Data fix for expunging the case
Fix provided :yes, write Db query
Code fix ticket#:CDM-39021
Reason why no related code fix: Status of the code fix  already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR

Backup before update/ delete:Query:
*/

select vl_sqlcode, vs_err_message

from cjams.expungcaserequest

( 'IR'::character varying,

'CW2213716'::character varying,

null::date

) ;