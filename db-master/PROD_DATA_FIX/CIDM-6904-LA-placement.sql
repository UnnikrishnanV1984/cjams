/*
 Issue Description:CIDM-6904
 Category/ Module:LA is approved in placement table and not approve if we look from person card
 Root cause: update
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
 */

 update routing set activeflag =1,updatedby='CIDM-6904',updatedon = now() where routingid='06de0973-3f86-46f9-b55e-77a0225d1d2d' and objectid = '2197bd07-f756-4f32-84b2-58676c854ae9':: CHARACTER VARYING;