/*
Issue Description: 231030157236:Placement/removal was closed in CJAMS but child's counsel filed exceptions so case remains open.
We need removal end date and placement end date deleted as we still need to work in service case.
Category/ Module: Placement and Person tables
Root cause: Removed an additional value
Fix provided :yes,write db query to revert
Code fix ticket#:CDM-38824
Reason why no related code fix: Status of the code fix already submitted
Status of the code fix if already submitted and expected prod fix date: N/A
Backup before update/ delete:
*/

--Reverting end date for Kerri Fallon

update placement
set
enddatetime = '2024-02-19 00:00:00.000',
endtime = '08:00',
updatedby = 'CDM-38824',
updatedon = now()
where placementid = '62f6d1f7-b23f-47c8-a5d2-2c89894d234a' and activeflag = 1;