-- CDM-28389 -  Wrong County
/*
-- Issue Description: 
  3119432:This is not a Kent County case, showed up on my approvals.

-- Category/ Module: Gap Review Case 
-- Root cause: User Request
-- Pull request# TBD
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

UPDATE cjams.routing
SET fromsecurityusersid='5fcfe6be-fe4d-41f2-8428-13e399f4a81f', tosecurityusersid='3ca8e63d-f885-445b-aab9-24456e91ad4a', 
teamid='b50f2419-42ba-4ab6-84ab-5172917d2d77', updatedby='CDM-28389', updatedon=now(), insertedby = '5fcfe6be-fe4d-41f2-8428-13e399f4a81f'
WHERE routingstatustypeid=15 and eventcode='GAYR' and objectid='4f077d81-fc1d-4fcb-88b5-8b9eeb8d7072' and activeflag = 1;
