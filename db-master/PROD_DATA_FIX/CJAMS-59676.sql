/*
Issue Description - CJAMS-59676
Category/ Module: Application
Root cause: CIS converted investigations are not being expunged as expected.
Fix provided: Data fix is required to expunge investigations CW2241338 and CW2241337 from the system and ensure that the investigations are removed from R360.
Is code fix required: N
Pull request# for code fix:
Reason why no related code fix: No related application code fix is required for this request.
Status of the code fix if already submitted and expected prod fix date:
Backup before update/delete:
*/

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2241338'::character varying,
		null::date
	);

    select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2241337'::character varying,
		null::date
	);