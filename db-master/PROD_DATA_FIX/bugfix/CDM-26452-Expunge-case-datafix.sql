-- CDM-26452 - Expungement
/*
-- Issue Description: 
	User has updated the Finding as 'Unsubstantiated' and request to expunge the case #221020209282 and associated Intake #I221010267804
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: N/A
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- case #221020209282 and associated Intake #I221010267804

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
    (    'IR'::character varying,
        '221020209282'::character varying,
        null::date
    );