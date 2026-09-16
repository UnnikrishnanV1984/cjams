/*
 * CDM-40390 - Finding Modification Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Customer Name:Andrea Clark
 * Focus Area:Decision
 * Description - The records for Case #s CW2265954 and CW2245604 were requested pursuant to a background clearance application for CIS #030747542 ,
  but could not be located. Please modify the findings to Ruled Out and immediately expunge.
  Please make sure the investigations are also removed from R360. 
 * Attached is the agency's settlement notice regarding modifying this finding. 
 * 
 */

update tb_conv_inv_finding
set investigation_finding_cd='Ruled Out'
where referral_id='CW2245604' and inv_finding_id=221545;

update tb_conv_inv_finding
set investigation_finding_cd='Ruled Out'
where referral_id='CW2265954' and inv_finding_id=241895;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2265954'::character varying,
		null::date
 	) ;


select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2245604'::character varying,
		null::date
 	) ;
