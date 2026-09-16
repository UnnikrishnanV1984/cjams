/*
   Issue Description: CDM-39656 Need placement for youth. 231030243291:I need to correct a placement for Tahani, her old placement needed to be voided and a new one needs to be done for the same dates
   Category/ Module  : Placement
   Root cause: Data fix needed to correct the placement for Tahani her old placement needed to be voided and a new one needs to be done for the same dates.
   Fix provided : Data fix has been provided  to do the following fixes.
                  Case# 231030243291, Client ID: 202424547 (Tahani Mojumder)
                  1. Remove the draft Child removal record  
                  2. Remove the Child Removal End-date (03/28/2024)
                  3. Remove two review edit placement records
   Pull request# for code fix: N/A
   Reason why no related code fix: N/A 
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/



delete from placementrevision where placementrevisionid in ('e9ec6b20-2577-4154-954f-650510159fa4','50602bc8-d478-40d2-a254-d7cb33dddb95');

-- INSERT INTO cjams.placementrevision
-- (activeflag, placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status, primaryrelationship, leastrestrictiveplacement, transferagency, otherpublicagency)
-- VALUES(0, '50602bc8-d478-40d2-a254-d7cb33dddb95', '71876637-5e90-4fcb-8431-eabca20eeb12', '2024-06-14 00:00:00.000', '2023-12-13 00:00:00.000', '18:00', NULL, NULL, NULL, NULL, '', '3045', '2024-06-14 00:00:00.000', '1', '2024-06-14 15:42:43.618', '7476006c-1958-4c31-9f15-f9e6ad15dbb9', '2024-06-14 15:42:43.618', '7476006c-1958-4c31-9f15-f9e6ad15dbb9', 0, 2057833, 'WKER', 'Change in provider placement division', NULL, NULL, NULL, NULL, 1, '2024-06-14 19:42:42.960', '7476006c-1958-4c31-9f15-f9e6ad15dbb9', '2024-06-14 15:42:43.618', NULL, NULL, NULL, NULL, NULL, NULL, 'Review', NULL, 'Shelter Order Withdrawn.  Youth returned to parents homes', NULL, NULL)


-- INSERT INTO cjams.placementrevision
-- (activeflag, placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status, primaryrelationship, leastrestrictiveplacement, transferagency, otherpublicagency)
-- VALUES(1, 'e9ec6b20-2577-4154-954f-650510159fa4', '71876637-5e90-4fcb-8431-eabca20eeb12', '2024-06-14 00:00:00.000', '2023-12-13 00:00:00.000', '18:00', NULL, NULL, NULL, NULL, '', '3045', NULL, '1', '2024-06-14 16:24:03.412', '7476006c-1958-4c31-9f15-f9e6ad15dbb9', '2024-06-14 16:24:03.412', '7476006c-1958-4c31-9f15-f9e6ad15dbb9', 1, 2058135, 'WKER', 'Change placement type', NULL, NULL, NULL, NULL, 1, '2024-06-14 20:24:02.737', '7476006c-1958-4c31-9f15-f9e6ad15dbb9', '2024-06-14 16:24:03.412', NULL, NULL, NULL, NULL, NULL, NULL, 'Review', NULL, 'Shelter Order Withdrawn.  Youth returned to parents homes', NULL, NULL);

update intakeservreqchildremoval set activeflag = 0 , updatedby = 'CDM-39656', updatedon = now() where intakeservreqchildremovalid = '8e4d7307-9686-4039-836b-df4c30db5459' and activeflag = 1;

update intakeservreqchildremoval set exitdate = null , updatedby = 'CDM-39656', updatedon = now() where intakeservreqchildremovalid = '5f663f82-8b21-498e-896a-e4fd989d0814' and activeflag = 1;

update personprogramarea set enddate = null, updatedby = 'CDM-39656', updatedon = now() where personprogramid = '978c0da1-f610-424d-a599-91e8287f1f9e';

update tb_client_eligibility set end_dt  = null, update_user_id = 'CDM-39656', update_ts = now()  where removal_id = 297031;

update intakeservreqchildremoval_history set activeflag=0 , updatedby = 'CDM-39656', updatedon = now() where intakeservreqchildremovalid = '8e4d7307-9686-4039-836b-df4c30db5459';
