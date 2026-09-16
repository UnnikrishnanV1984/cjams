/*
  Issue Description:  CDM-39975
   Category/ Module  :  Decision
   Root cause: Data fix to  Expunge the Cases 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2129005'::character varying,
		null::date
	) ;