/*
Issue Description:CJAMS-67416
Category/ Module:Application
Root cause: User requested to expunge the case
Fix provided: Data fix has been done to expunge the case 
Is code fix required: N 
Pull request# for code fix:
Reason why no related code fix:
Status of the code fix if already submitted and expected prod fix date:
Backup before update/ delete: 
*/


select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2261389'::character varying,
		null::date
	);

