/*
Issue Description:CJAMS-63292
Category/ Module:Application
Root cause: CIS Converted Investigation with No information about maltreator or the maltreatment/allegation. CJAMS is not expunging such CIS converted 
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
		'CW2254591'::character varying,
		null::date
	);

    select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2214815'::character varying,
		null::date
	);

        select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2214814'::character varying,
		null::date
	);
	
        select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2280755'::character varying,
		null::date
	);