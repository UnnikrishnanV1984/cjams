/*
Issue Description: 
Category/ Module : Bug
Root cause: Expunge case
Fix provided: Yes, write Db query 
Code fix ticket#: CDM-43049
Reason why no related code fix: Status of the code fix  already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2071749'::character varying,
		null::date
	) ;