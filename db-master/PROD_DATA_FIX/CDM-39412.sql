/*
 * CDM-39412 - system generated suspension
 * Customer Email ID:alice.wilkerson@maryland.gov
 * 221030018624:the GAP case was completed, however, there is a system generated suspension that it appears that is stopping the payments from generating.
 * Focus Area:Payments
 * 
 */

--select * from gapsuspensionrevision where suspensionid='42988f15-938e-4e22-bd31-0eba62351515';
--INSERT INTO cjams.gapsuspensionrevision
--(gapsuspensionrevisionid, suspensionid, guardiansubsidyid, transactiondate, reasontypekey, startdate, enddate, suspensiondesc, approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, etl_userid, etl_load_date)
--VALUES('5ab3a787-a429-48eb-aedf-9242c4877318'::uuid, '42988f15-938e-4e22-bd31-0eba62351515'::uuid, '61957212-beca-4778-8002-1e368b16b95f'::uuid, '2024-04-23 12:01:43.903', 'COHP', '2022-10-23 00:00:00.000', NULL, 'Suspended due to active removal (system generated)', '3047', NULL, NULL, '2024-04-23 12:01:43.903', '832a15a1-1156-44c4-befa-0a4fc73460b5', '2024-04-23 12:01:43.903', '832a15a1-1156-44c4-befa-0a4fc73460b5', 0, 1019907, NULL, NULL);
--INSERT INTO cjams.gapsuspensionrevision
--(gapsuspensionrevisionid, suspensionid, guardiansubsidyid, transactiondate, reasontypekey, startdate, enddate, suspensiondesc, approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, etl_userid, etl_load_date)
--VALUES('da6475c5-acc9-4b25-be81-5d8815517130'::uuid, '42988f15-938e-4e22-bd31-0eba62351515'::uuid, '61957212-beca-4778-8002-1e368b16b95f'::uuid, NULL, 'COHP', '2024-03-25 04:00:00.000', '2024-03-25 04:00:00.000', 'Suspended due to active removal (system generated)', '3045', NULL, NULL, '2024-06-05 13:25:24.000', '3b57ab08-1f6c-478d-89a9-8333a59c87a9', '2024-06-05 13:25:24.000', NULL, 1, 1020567, NULL, NULL);
DELETE FROM cjams.gapsuspensionrevision
WHERE suspensionid='42988f15-938e-4e22-bd31-0eba62351515';
--select * from gapsuspension where gapsuspensionid='42988f15-938e-4e22-bd31-0eba62351515';
--INSERT INTO cjams.gapsuspension
--(gapsuspensionid, gapid, suspensionreasontypekey, startdate, enddate, notes, isdraft, suspensiondesc, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, otherreason, alternateid, approvalstatustypekey, etl_userid, etl_load_date)
--VALUES('42988f15-938e-4e22-bd31-0eba62351515'::uuid, '61957212-beca-4778-8002-1e368b16b95f'::uuid, 'COHP', '2022-10-23 00:00:00.000', NULL, 'System generated suspension', 0, 'Suspended due to active removal (system generated)', 1, '2022-10-23 00:00:00.000', '832a15a1-1156-44c4-befa-0a4fc73460b5', '2024-04-23 12:01:43.903', '832a15a1-1156-44c4-befa-0a4fc73460b5', '2024-04-23 12:01:43.903', NULL, NULL, 1016586, '3047', NULL, NULL);
DELETE FROM cjams.gapsuspension
WHERE gapsuspensionid='42988f15-938e-4e22-bd31-0eba62351515'::uuid;
--select approvaldate, updatedby, updatedon, * from cjams.gapratesrevision where gaprateid = '83be780f-30d7-4de1-a83e-d0ee1367e550' ;
update cjams.gapratesrevision 
set approvaldate = now(),
    updatedby = 'CDM-39412',
    updatedon = now()
where gaprateid = '83be780f-30d7-4de1-a83e-d0ee1367e550' ;
