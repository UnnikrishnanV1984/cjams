-- CDM-38765 - CPA Home Datafixes Needed
/*
-- Issue Description: 
   User Request to add CPA Homes under the provider placements to fix the AFCARS compliance errors
   
-- Category/ Module: Placement (Case Management) 
-- Root cause: User Error, CPA Homes are not selected on the Child Placement screen by the caseworkers. 
-- Fix provided: Datafix has been promoted to add the missing CPA Homes under the provider placements (CDM-38765)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

delete from placementcpahomes where createuserid = 'CDM-38765' ;

-- Insert Open CPA Homes
INSERT INTO cjams.placementcpahomes VALUES (cjams.gen_random_uuid(), (select placementid from placement where alternateid = 1572137) , '2022-05-11 00:00:00.000', '2022-05-11 00:00:00.000', '2022-06-13 23:59:00.000', '2022-06-13 23:59:00.000' , 'CIPS', NULL, 'AFCARS Cleanup', now(), 'CDM-38765', now(), 'CDM-38765', 1, 6005050, 1572137, NULL, NULL);
INSERT INTO cjams.placementcpahomes VALUES (cjams.gen_random_uuid(), (select placementid from placement where alternateid = 1687792) , '2023-06-25 00:00:00.000', '2023-06-25 00:00:00.000', '2023-08-08 23:59:00.000', '2023-08-08 23:59:00.000' , 'CIPS', NULL, 'AFCARS Cleanup', now(), 'CDM-38765', now(), 'CDM-38765', 1, 6051872, 1687792, NULL, NULL);
INSERT INTO cjams.placementcpahomes VALUES (cjams.gen_random_uuid(), (select placementid from placement where alternateid = 1664283) , '2023-05-11 00:00:00.000', '2023-05-11 00:00:00.000', NULL, NULL , NULL, NULL, 'AFCARS Cleanup', now(), 'CDM-38765', now(), 'CDM-38765', 1, 6034203, 1664283, NULL, NULL);
INSERT INTO cjams.placementcpahomes VALUES (cjams.gen_random_uuid(), (select placementid from placement where alternateid = 1571877) , '2022-04-25 00:00:00.000', '2022-04-25 00:00:00.000', '2022-05-02 23:59:00.000', '2022-05-02 23:59:00.000' , 'CIPS', NULL, 'AFCARS Cleanup', now(), 'CDM-38765', now(), 'CDM-38765', 1, 5072017, 1571877, NULL, NULL);
INSERT INTO cjams.placementcpahomes VALUES (cjams.gen_random_uuid(), (select placementid from placement where alternateid = 1572616) , '2022-06-10 00:00:00.000', '2022-06-10 00:00:00.000', '2022-07-15 23:59:00.000', '2022-07-15 23:59:00.000' , 'CIPS', NULL, 'AFCARS Cleanup', now(), 'CDM-38765', now(), 'CDM-38765', 1, 5072017, 1572616, NULL, NULL);
INSERT INTO cjams.placementcpahomes VALUES (cjams.gen_random_uuid(), (select placementid from placement where alternateid = 1572756) , '2022-06-10 00:00:00.000', '2022-06-10 00:00:00.000', '2022-07-15 23:59:00.000', '2022-07-15 23:59:00.000' , 'CIPS', NULL, 'AFCARS Cleanup', now(), 'CDM-38765', now(), 'CDM-38765', 1, 5072017, 1572756, NULL, NULL);
INSERT INTO cjams.placementcpahomes VALUES (cjams.gen_random_uuid(), (select placementid from placement where alternateid = 1568912) , '2021-12-20 00:00:00.000', '2021-12-20 00:00:00.000', NULL, NULL , NULL, NULL, 'AFCARS Cleanup', now(), 'CDM-38765', now(), 'CDM-38765', 1, 6054912, 1568912, NULL, NULL);
INSERT INTO cjams.placementcpahomes VALUES (cjams.gen_random_uuid(), (select placementid from placement where alternateid = 1569391) , '2022-01-18 00:00:00.000', '2022-01-18 00:00:00.000', '2022-12-09 23:59:00.000', '2022-12-09 23:59:00.000' , 'CIPS', NULL, 'AFCARS Cleanup', now(), 'CDM-38765', now(), 'CDM-38765', 1, 5093257, 1569391, NULL, NULL);
INSERT INTO cjams.placementcpahomes VALUES (cjams.gen_random_uuid(), (select placementid from placement where alternateid = 1573924) , '2022-08-04 00:00:00.000', '2022-08-04 00:00:00.000', '2023-03-31 23:59:00.000', '2023-03-31 23:59:00.000' , 'CIPS', NULL, 'AFCARS Cleanup', now(), 'CDM-38765', now(), 'CDM-38765', 1, 5072017, 1573924, NULL, NULL);
INSERT INTO cjams.placementcpahomes VALUES (cjams.gen_random_uuid(), (select placementid from placement where alternateid = 1679784) , '2023-06-09 00:00:00.000', '2023-06-09 00:00:00.000', NULL, NULL , NULL, NULL, 'AFCARS Cleanup', now(), 'CDM-38765', now(), 'CDM-38765', 1, 6055893, 1679784, NULL, NULL);
INSERT INTO cjams.placementcpahomes VALUES (cjams.gen_random_uuid(), (select placementid from placement where alternateid = 1677254) , '2023-06-05 00:00:00.000', '2023-06-05 00:00:00.000', NULL, NULL , NULL, NULL, 'AFCARS Cleanup', now(), 'CDM-38765', now(), 'CDM-38765', 1, 6006897, 1677254, NULL, NULL);
INSERT INTO cjams.placementcpahomes VALUES (cjams.gen_random_uuid(), (select placementid from placement where alternateid = 1677255) , '2023-06-05 00:00:00.000', '2023-06-05 00:00:00.000', NULL, NULL , NULL, NULL, 'AFCARS Cleanup', now(), 'CDM-38765', now(), 'CDM-38765', 1, 6006897, 1677255, NULL, NULL);
INSERT INTO cjams.placementcpahomes VALUES (cjams.gen_random_uuid(), (select placementid from placement where alternateid = 1677256) , '2023-06-05 00:00:00.000', '2023-06-05 00:00:00.000', NULL, NULL , NULL, NULL, 'AFCARS Cleanup', now(), 'CDM-38765', now(), 'CDM-38765', 1, 6006897, 1677256, NULL, NULL);
INSERT INTO cjams.placementcpahomes VALUES (cjams.gen_random_uuid(), (select placementid from placement where alternateid = 1694952) , '2023-06-24 00:00:00.000', '2023-06-24 00:00:00.000', '2023-12-07 23:59:00.000', '2023-12-07 23:59:00.000' , 'CIPS', NULL, 'AFCARS Cleanup', now(), 'CDM-38765', now(), 'CDM-38765', 1, 6123085, 1694952, NULL, NULL);
INSERT INTO cjams.placementcpahomes VALUES (cjams.gen_random_uuid(), (select placementid from placement where alternateid = 1631957) , '2023-03-09 00:00:00.000', '2023-03-09 00:00:00.000', '2023-04-20 23:59:00.000', '2023-04-20 23:59:00.000' , 'CIPS', NULL, 'AFCARS Cleanup', now(), 'CDM-38765', now(), 'CDM-38765', 1, 6031739, 1631957, NULL, NULL);
INSERT INTO cjams.placementcpahomes VALUES (cjams.gen_random_uuid(), (select placementid from placement where alternateid = 1557542) , '2020-09-08 00:00:00.000', '2020-09-08 00:00:00.000', '2021-04-28 23:59:00.000', '2021-04-28 23:59:00.000' , 'CIPS', NULL, 'AFCARS Cleanup', now(), 'CDM-38765', now(), 'CDM-38765', 1, 6094824, 1557542, NULL, NULL);
INSERT INTO cjams.placementcpahomes VALUES (cjams.gen_random_uuid(), (select placementid from placement where alternateid = 1557520) , '2020-09-08 00:00:00.000', '2020-09-08 00:00:00.000', '2021-04-08 23:59:00.000', '2021-04-08 23:59:00.000' , 'CIPS', NULL, 'AFCARS Cleanup', now(), 'CDM-38765', now(), 'CDM-38765', 1, 6094825, 1557520, NULL, NULL);
INSERT INTO cjams.placementcpahomes VALUES (cjams.gen_random_uuid(), (select placementid from placement where alternateid = 1561037) , '2021-02-25 00:00:00.000', '2021-02-25 00:00:00.000', '2021-04-28 23:59:00.000', '2021-04-28 23:59:00.000' , 'CIPS', NULL, 'AFCARS Cleanup', now(), 'CDM-38765', now(), 'CDM-38765', 1, 6094826, 1561037, NULL, NULL);
INSERT INTO cjams.placementcpahomes VALUES (cjams.gen_random_uuid(), (select placementid from placement where alternateid = 1637537) , '2023-03-23 00:00:00.000', '2023-03-23 00:00:00.000', '2023-05-25 23:59:00.000', '2023-05-25 23:59:00.000' , 'CIPS', NULL, 'AFCARS Cleanup', now(), 'CDM-38765', now(), 'CDM-38765', 1, 6031739, 1637537, NULL, NULL);
INSERT INTO cjams.placementcpahomes VALUES (cjams.gen_random_uuid(), (select placementid from placement where alternateid = 1559340) , '2021-08-21 00:00:00.000', '2021-08-21 00:00:00.000', '2021-04-21 23:59:00.000', '2021-04-21 23:59:00.000' , 'CIPS', NULL, 'AFCARS Cleanup', now(), 'CDM-38765', now(), 'CDM-38765', 1, 5061700, 1559340, NULL, NULL);
INSERT INTO cjams.placementcpahomes VALUES (cjams.gen_random_uuid(), (select placementid from placement where alternateid = 1574268) , '2022-08-03 00:00:00.000', '2022-08-03 00:00:00.000', '2023-05-05 23:59:00.000', '2023-05-05 23:59:00.000' , 'CIPS', NULL, 'AFCARS Cleanup', now(), 'CDM-38765', now(), 'CDM-38765', 1, 6006897, 1574268, NULL, NULL);
INSERT INTO cjams.placementcpahomes VALUES (cjams.gen_random_uuid(), (select placementid from placement where alternateid = 1570180) , '2022-01-26 00:00:00.000', '2022-01-26 00:00:00.000', '2022-04-01 23:59:00.000', '2022-04-01 23:59:00.000' , 'CIPS', NULL, 'AFCARS Cleanup', now(), 'CDM-38765', now(), 'CDM-38765', 1, 6006896, 1570180, NULL, NULL);
INSERT INTO cjams.placementcpahomes VALUES (cjams.gen_random_uuid(), (select placementid from placement where alternateid = 1571775) , '2022-04-01 00:00:00.000', '2022-04-01 00:00:00.000', '2023-04-30 23:59:00.000', '2023-04-30 23:59:00.000' , 'CIPS', NULL, 'AFCARS Cleanup', now(), 'CDM-38765', now(), 'CDM-38765', 1, 6006896, 1571775, NULL, NULL);
INSERT INTO cjams.placementcpahomes VALUES (cjams.gen_random_uuid(), (select placementid from placement where alternateid = 1680016) , '2023-05-26 00:00:00.000', '2023-05-26 00:00:00.000', '2023-06-21 23:59:00.000', '2023-06-21 23:59:00.000' , 'CIPS', NULL, 'AFCARS Cleanup', now(), 'CDM-38765', now(), 'CDM-38765', 1, 5027293, 1680016, NULL, NULL);
INSERT INTO cjams.placementcpahomes VALUES (cjams.gen_random_uuid(), (select placementid from placement where alternateid = 1573704) , '2022-07-28 00:00:00.000', '2022-07-28 00:00:00.000', '2022-01-14 23:59:00.000', '2022-01-14 23:59:00.000' , 'CIPS', NULL, 'AFCARS Cleanup', now(), 'CDM-38765', now(), 'CDM-38765', 1, 6043015, 1573704, NULL, NULL);
INSERT INTO cjams.placementcpahomes VALUES (cjams.gen_random_uuid(), (select placementid from placement where alternateid = 1573703) , '2022-07-28 00:00:00.000', '2022-07-28 00:00:00.000', '2023-01-14 23:59:00.000', '2023-01-14 23:59:00.000' , 'CIPS', NULL, 'AFCARS Cleanup', now(), 'CDM-38765', now(), 'CDM-38765', 1, 6043015, 1573703, NULL, NULL);
INSERT INTO cjams.placementcpahomes VALUES (cjams.gen_random_uuid(), (select placementid from placement where alternateid = 1603715) , '2023-01-24 00:00:00.000', '2023-01-24 00:00:00.000', '2023-02-15 23:59:00.000', '2023-02-15 23:59:00.000' , 'CIPS', NULL, 'AFCARS Cleanup', now(), 'CDM-38765', now(), 'CDM-38765', 1, 5069767, 1603715, NULL, NULL);
INSERT INTO cjams.placementcpahomes VALUES (cjams.gen_random_uuid(), (select placementid from placement where alternateid = 1576873) , '2022-09-09 00:00:00.000', '2022-09-09 00:00:00.000', '2023-01-20 23:59:00.000', '2023-01-20 23:59:00.000' , 'CIPS', NULL, 'AFCARS Cleanup', now(), 'CDM-38765', now(), 'CDM-38765', 1, 5084027, 1576873, NULL, NULL);
INSERT INTO cjams.placementcpahomes VALUES (cjams.gen_random_uuid(), (select placementid from placement where alternateid = 1603748) , '2022-12-07 00:00:00.000', '2022-12-07 00:00:00.000', '2024-02-09 23:59:00.000', '2024-02-09 23:59:00.000' , 'CIPS', NULL, 'AFCARS Cleanup', now(), 'CDM-38765', now(), 'CDM-38765', 1, 5042410, 1603748, NULL, NULL);


-- Updates 
update placementcpahomes
set entrydt = '2022-12-07 00:00:00.000', 
	entrytm = '2022-12-07 00:00:00.000',
	updatets = now(), 
	updateuserid = 'CDM-38765'
where placementcpahomeid = '4aa61acb-12d9-4d11-8ef5-c0fa3113b487'
	and activeflag = 1 ;
