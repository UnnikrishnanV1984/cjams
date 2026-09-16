/*
   Issue Description: CDM-35243
   Category/ Module  : Expungement Request
   Root cause: The Department does not have the closed record for this investigation
   Pull request# for data fix : Updated the investigation_finding_cd as ruled out to close the case.
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



-- expunge this investigation. The Department does not have the closed record for this investigation.
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2261213'::character varying,
		null::date
	); 