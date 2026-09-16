/*
   Issue Description: CDM-37573
   Category/ Module  :Placement
   Root cause: Unable to put in new placement due to old placement issues
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE cjams.placement
SET activeflag=0, updatedby='CDM-37573', updatedon=now()
WHERE placementid='10d69ece-d5d7-4225-a223-5c89192d6312'::uuid;

update routing set activeflag =0, updatedby='CDM-37573', updatedon=now()
where objectid='10d69ece-d5d7-4225-a223-5c89192d6312'
and routingid ='d51d7369-fd3b-4be5-ad71-2fb5cae2fc17';

update placementrevision set activeflag =0, updatedby='CDM-37573', updatedon=now()
where placementid ='10d69ece-d5d7-4225-a223-5c89192d6312'
and placementrevisionid = 'e50a1458-1e88-4c82-85d2-1718dcb64855';

UPDATE cjams.placement
SET activeflag=0, updatedby='CDM-37573', updatedon=now()
WHERE placementid='493f0107-cbbb-418b-a0aa-ef6e018a70ba'::uuid;

update routing set activeflag =0, updatedby='CDM-37573', updatedon=now()
where objectid='493f0107-cbbb-418b-a0aa-ef6e018a70ba'
and routingid ='1d931153-e030-4ef2-a5c6-9a6377c67257';

update placementrevision set activeflag =0, updatedby='CDM-37573', updatedon=now()
where placementid ='493f0107-cbbb-418b-a0aa-ef6e018a70ba'
and placementrevisionid = '22e3f42d-9ade-4795-bcbd-b8919faa4f1c';