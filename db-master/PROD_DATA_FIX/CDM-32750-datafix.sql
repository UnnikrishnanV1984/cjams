/*
  Issue Description:  CDM-32750
   Category/ Module  : Case Timeline
   Root cause: User request to Data fix to expunge the cases
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2272446'::character varying,
		null::date
	) ;


    select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2272447'::character varying,
		null::date
	) ;