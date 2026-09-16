/*
Issue Description: The CPA home for James and Olivia Clemonts, 14327 Driftwood Road, Bowie, Maryland. was not added when the Mentor Maryland placement was open. We need this CPA home added with a start date of March 24 2023 and end date of September 12 2023
Category/ Module :BUG
Root cause: Data Entry error
Fix provided: Yes, write DB query.
Code fix ticket#: CDM-39962
Reason why no related code fix: Status of the code fix already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Create new record in placementcpahomes
insert into placementcpahomes
(placementcpahomeid, placementid, entrydt, entrytm, exitdt, exittm, exittypecd, exitreasoncd, commentstx, createts, createuserid, updatets,
updateuserid, activeflag, altproviderid, altplacementid, etl_userid, etl_load_date)
values (gen_random_uuid(), 'bdf756b5-981f-4a49-b13b-1aff3b2a4fa2', '2023-03-24 20:30:00', '2023-03-24 20:30:00', '2023-09-12 15:50:00', 
'2023-09-12 15:50:00', 'CIPS', NULL, '', now(), 'CDM-39962', now(), 'CDM-39962', 1, 6055444, 1638909, null, NULL);