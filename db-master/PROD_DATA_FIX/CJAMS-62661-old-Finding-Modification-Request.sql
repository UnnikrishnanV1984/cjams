/*
 Issue Description: Please modify this indicated neglect finding to ruled out neglect and expunge from the system. Please ensure that this investigation is also removed from R360 for CIS # 489014449 (590087778CHESSIE348SS03N2C08/02/200610/10/2006PAD200). The team reviewed the closed record and determined that presently this case would be an AR and not an investigation. 
 The individual is seeking employment working with children.
-- Category/ Module: Investigation Finding 
-- Root cause: User wants to update investigation finding to Ruled Out and User requested to expunge the case 
-- Fix Provided: Datafix has been promoted to update the investigation finding and sql query provided to expunge the case
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS-IR CW2261486
/*
select * from investigationallegation i where investigationid = '17a1f197-450e-4bae-a5a4-d91ce641dcec';
select * from investigationallegationmaltreators where investigationallegationid = '80be4e10-f9ec-47d1-84c4-bae398fea02a'
*/

--blue ribbon update 
update investigationallegationmaltreators
set oahearingdecision = 'RO', 
	updatedon = now(),
	updatedby = 'CJAMS-62661'
where investigationallegationmaltreatorsid = '1e70a113-8ac5-4de4-a9cc-fb116f597500'
and investigationallegationid = '80be4e10-f9ec-47d1-84c4-bae398fea02a'
and activeflag =1;

-- CIS data update 
--select * from tb_conv_inv_finding where referral_id ='CW2261486'
--select * from investigationfinding i where investigationallegationid  ='80be4e10-f9ec-47d1-84c4-bae398fea02a'


update cjams.tb_conv_inv_finding
	SET investigation_finding_cd='Ruled Out'
where 
	inv_finding_id=237427 and 
	referral_id='CW2261486';

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2261486'::character varying,
		null::date
 	) ;