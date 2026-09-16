/*
 * CDM-35002 - Datafix Needed to Add Previous CPA Home
 * Customer Email ID:frank.mcgough1@maryland.gov
 * Customer Name:Frank McGough
 * Focus Area:Placement
 * Description - 3294890:Datafix is needed for placements for both Lyric and Khrystian; worker did not enter the original CPA Home for placement, 
 * and caseworkers are unable to add backdated CPA homes. CPA Home ID 6005798 needs to be added to placement beginning on 10/19/22 for both children; 
 * CPA entry on 10/19/22 and exit on 12/14/22.
 */
 
DELETE FROM cjams.placementcpahomes WHERE altproviderid = 6005798 and placementid in ('79605a20-eff7-41a7-a26d-3e2b7b693aa1', '5ebc2d23-8df6-4f02-b241-32a8cd802b5b') and updateuserid='CDM-35002';
select updateuserid, altproviderid, * from placementcpahomes where placementid = '79605a20-eff7-41a7-a26d-3e2b7b693aa1'; -- 5057992
INSERT INTO cjams.placementcpahomes
(placementid, entrydt, entrytm, exitdt, exittm, exittypecd, exitreasoncd, commentstx, createts, createuserid, updatets, updateuserid, activeflag, altproviderid, altplacementid, etl_userid, etl_load_date)
VALUES('79605a20-eff7-41a7-a26d-3e2b7b693aa1'::uuid, '2022-10-19 18:35:00.000', '2022-10-19 18:35:00.000', '2022-12-14 15:55:00.000', '2022-12-14 15:55:00.000', NULL, NULL, NULL, '2022-12-21 09:07:30.239', '517e02e8-540d-40cc-9a15-41db2ab8f83f', '2023-10-24 16:06:06.602', 'CDM-35002', 1, 6005798, 1575680, NULL, NULL);
select updateuserid, altproviderid, * from placementcpahomes where placementid = '5ebc2d23-8df6-4f02-b241-32a8cd802b5b'; -- 5057992
INSERT INTO cjams.placementcpahomes
(placementid, entrydt, entrytm, exitdt, exittm, exittypecd, exitreasoncd, commentstx, createts, createuserid, updatets, updateuserid, activeflag, altproviderid, altplacementid, etl_userid, etl_load_date)
VALUES('5ebc2d23-8df6-4f02-b241-32a8cd802b5b'::uuid, '2022-10-19 18:35:00.000', '2022-10-19 18:35:00.000', '2022-12-14 15:55:00.000', '2022-12-14 15:55:00.000', NULL, NULL, NULL, '2022-12-21 09:13:41.088', '517e02e8-540d-40cc-9a15-41db2ab8f83f', '2023-10-24 16:12:36.220', 'CDM-35002', 1, 6005798, 1575681, NULL, NULL);
