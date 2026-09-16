/**
 * CDM-32722 - Disclosure Checklist
 * Customer Email ID:katherine.slavin1@maryland.gov
 * Focus Area:Permanency Plan
 * Description - 3281049:Disclosure checklist - still went to incorrect supervisor and from incorrect worker for Deasia Thomas and Eli Hoy 
 * Screen URL: https://cw.cjams.mdthink.maryland.gov/#/pages/case-worker/f7ee0aff-e618-4dcd-95f3-0a2ff1c2b67a/3281049/dsds-action/sc-permanency-plan/placement/adoption/planning/checklist
 */

--select routingid, * from routing where objectid = '45f7783a-9e5e-4bcd-8cd2-c2b027194884'; -- routingid = 39b1e5b7-7936-4b99-a19b-71fcae635d0c, teamid = '406c0f48-4048-490a-a834-3a00e8382e1b'
--select ref_key, value_text, * from referencevalues where ref_key = 'ADPR';
--select * from cjams.v_userprofile where securityusersid = '3dc5f025-9f68-4812-88e2-c7ef4fbde6c6'; -- Katie Skinner
--select * from cjams.v_userprofile where securityusersid = '527e483b-5108-4906-b2bb-6fdbc317f03e'; -- Stacie Parker
--select securityusersid, teamid, * from cjams.v_userprofile where email = 'katherine.slavin1@maryland.gov'; -- Katherine Slavin -- d8d2196c-7b3b-434b-8160-1c6eb29eed6e, teamid = 'da6e89a1-82e1-46f7-a90e-d41a3987591d'
--select securityusersid, * from cjams.v_userprofile where email = 'brenda.alwine@maryland.gov'; -- Brenda Alwine -- 330d12cd-f428-41b9-b332-36e53fe5f16a

select fromsecurityusersid, tosecurityusersid, teamid, updatedby, updatedon 
from routing 
where routingid = '39b1e5b7-7936-4b99-a19b-71fcae635d0c'
and objectid = '45f7783a-9e5e-4bcd-8cd2-c2b027194884';

UPDATE cjams.routing
SET fromsecurityusersid='d8d2196c-7b3b-434b-8160-1c6eb29eed6e', tosecurityusersid='330d12cd-f428-41b9-b332-36e53fe5f16a', teamid='da6e89a1-82e1-46f7-a90e-d41a3987591d', updatedby='CDM-32722', updatedon=now()
WHERE routingid = '39b1e5b7-7936-4b99-a19b-71fcae635d0c'
and objectid = '45f7783a-9e5e-4bcd-8cd2-c2b027194884';
