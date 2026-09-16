/*
   Issue Description: CDM-34439
   Category/ Module  : Approval Inbox
   Root cause: user wants to delete quick add person delete request
   Pull request# for code fix:
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix
*/

UPDATE cjams.routing
SET  activeflag=0, updatedby='CDM-34439', updatedon=now()
WHERE routingid='f810c4f0-8cf7-47cd-b362-a5ff9f70e499' and eventcode='QPDR' and objectid='9ee94cae-d3d8-4254-8910-11f6269c12f5';

update quickperson set activeflag = 0, deletestatus = 'A', updatedon = now(), updatedby = 'CDM-34439' 
where quickpersonid = '9ee94cae-d3d8-4254-8910-11f6269c12f5' and caseid = 'ed6d60c0-c9f5-478c-b9d6-a7939ff60973';
	