 /*

   Issue Description: CDM-39604 Migrated case error - Datafix needed


   Category/ Module  :  Permanency Plan

   Root cause:Incorrect permanency plan end dated. The plan with the active GAP should not have an end date

   Fix provided :Data fix to remove the permanency plan enddate

   Code fix ticket#:

   Reason why no related code fix: 

   Status of the code fix if already submitted and expected prod fix date: 

   Backup before update/ delete:INSERT INTO cjams.permanencyplan
(enddate, permanencyplanid, intakeservicerequestactorid, intakeserviceid, projecteddate, achieveddate, establisheddate, caseworkername, remarks, reviseddate, effectivedate, insertedon, insertedby, updatedon, updatedby, activeflag, old_id, primarypermanencytype, concurrentpermanencytype, primaryarrangetype, concurrentarrangetype, resourcename, address1, address2, state, city, countyid, country, zipcode, primaryrelativename, primarynonrelativename, primaryprovidercode, ispriresourceidentified, concurrentrelativename, concurrentnonrelativename, concurrentprovidercode, isconresourceidentified, fk_id, primaryproviderid, primarylivingrelativename, primarylivingnonrelativename, primarynoresourceflag, primarylegalstatustypekey, secondaryproviderid, secondarylivingrelativename, secondarynonrelativename, secondarynoresourceflag, scndrylegalstatustypekey, approvalstatustypekey, datavalidsflag, clientmergeid, servicecaseid, concurrentcomments, placementid, permplanquestdata, enddate, reason, parentname, etl_userid, etl_load_date, courtorderreceived, parent2name, actualdata, permanencyplanremainssame, permanencyplanremainssamedate, reviewdate)
VALUES('2013-10-23 00:00:00.000', 'cf2e6997-876a-402c-b6dc-54595ed0ce5b'::uuid, 'b9291617-9fc1-4c6c-8752-44000942e09d'::uuid, '328ddcf2-218a-485f-93b6-57ab45e78edb'::uuid, '2013-12-16 00:00:00.000', '2013-10-23 00:00:00.000', '2013-08-16 00:00:00.000', NULL, 'NA', NULL, '2013-09-20 14:57:31.000', '2013-09-20 14:57:31.000', 'CPL029301', '2013-11-04 10:06:32.000', 'CPL029301', 1, '176041', 'Guardianship', 'GUARDR', 'OTHR', 'OTHR', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '3476607', 5055783, '', NULL, 0, '1752', NULL, 'Shantrella York', NULL, 0, '1752', '3047', NULL, NULL, '96795c6b-e7cd-43ad-9927-a22ed3cd72d4'::uuid, 'NA', NULL, NULL, '2013-10-23 00:00:00.000', NULL, NULL, 'Data Migration', '2020-04-18', NULL, NULL, NULL, NULL, NULL, NULL);


*/


update permanencyplan  set enddate  = null ,
updatedby ='CDM-39604',updatedon  =now() 
where permanencyplanid  ='cf2e6997-876a-402c-b6dc-54595ed0ce5b';