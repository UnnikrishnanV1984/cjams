/*
Issue Description: 3274730:There is a Rejected placement for PID 200824970. I cannot fix this placement as any date/time entered results in the Error message Overlapping times/dates with another placement. This has been sitting since 2022. The worker is now unable to add a new/correct placement because of this. Can it be deleted via data fix so we can enter the new placement ASAP???
Root cause: Data fix to upadted the activeflag.
Fix provided :yes,write db query
Code fix ticket#: CDM-39108
Reason why no related code fix: Status of the code fix already submitted
Status of the code fix if already submitted and expected prod fix date: N/A
Backup before update/ delete:
*/

--Placement Table
update cjams.placement
set activeflag = 0,
updatedby = 'CDM-39108',
updatedon = now()
where placementid = 'd2e6efba-c5db-4b75-8def-fe7f6b3c0599';

--Routing Table
update cjams.routing 
set activeflag = 0,
updatedby = 'CDM-39108',
updatedon = now()
where objectid = 'd2e6efba-c5db-4b75-8def-fe7f6b3c0599';

--Placementrevision Table
update cjams.placementrevision 
set activeflag = 0,
updatedby = 'CDM-39108',
updatedon = now()
where placementid = 'd2e6efba-c5db-4b75-8def-fe7f6b3c0599';

--Livingarrangement Table
update cjams.livingarrangement 
set activeflag = 0,
updatedby = 'CDM-39108',
updatedon = now()
where placementid = 'd2e6efba-c5db-4b75-8def-fe7f6b3c0599';