-- CDM-35343 - Finding ModificationRequest
/* Issue Description:CW2180611:Please modify this indicated neglect finding to Unsubstantiated neglect. 

-- Case ID: CW2180611 - 8f982370-468f-4b03-8924-a649dbe572b7/CW2180611

-- Category/ Module: Investigation Findings

-- Root cause: It was given as Indicated and was told to update to Unsubstantiated
-- Fix Provided: Datafix has been updated to Unsubstantiated from Indicated Service case # CW2180611
-- Pull request# N/A
*/


-- update tb_conv_inv_finding set investigation_finding_cd = 'Unsubstantiated' where referral_id='CW2180611';


select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2180611'::character varying,
		null::date
 	) ;