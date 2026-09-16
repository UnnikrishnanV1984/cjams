/*
 *   Issue Description: CDM-8258 -Case 20200257034547 Decision Need Data Fix to move this case back to Open Status
   Category/ Module  : Investigation disposition
   Root cause: User asked to reopen it
   Pull request# for code fix: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date: NA
 * Back up before deleting
 * INSERT INTO cjams.intakeservicerequestdispositioncode
(intakeservicerequestdispositioncodeid, intakeserviceid, insertedby, insertedon, updatedby, updatedon, "timestamp", statusdate, description, expirationdate, effectivedate, activeflag, intakeserreqstatustypeid, servicerequesttypeconfigiddispostionid, dateofsubpoena, subpoenareason, lastfacetofacedate, seenwithin, dateseen, reviewcomments, reasonfordelay, old_id, closingcodetypekey, servicerequestdispositionsubtypeconfigid, servicerequestdispositionsubtypenotes, approvalid, approvalnaturetypekey, entitytypetypekey, additionalkey, entitykeyid1, entitykeyid2, requestdate, actiondueddate, approvestaffid, approvalstatustypekey, denialreasontypekey, requestorcomments, approvalcomments, currentstatustypekey, forwardcountytypekey, forwardunitid, administratorid, datavalidflag, clientmergeid, etl_userid, etl_load_date, adultassignedsecurityid)
VALUES('aca0a6fd-f113-4a7f-9ac4-59ce04c9e9a0', 'fd465132-1cb3-46e5-b93a-ccc64af2efc5', '9ca9a597-fd93-43e7-b5e7-1b32d4a8c56f', '2020-11-09 18:33:21.000', '9ca9a597-fd93-43e7-b5e7-1b32d4a8c56f', '2020-11-10 15:32:56.699', NULL, '2020-11-10 15:32:56.699', NULL, NULL, '2020-11-09 18:33:21.000', 1, '7995cecb-062d-406c-8ea9-b1da4b1877d8', 'd90db0d3-f665-49db-b3ad-0edb468bc02d', NULL, NULL, NULL, NULL, '2020-11-09 23:32:51.747', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/

delete from intakeservicerequestdispositioncode   where intakeserviceid='fd465132-1cb3-46e5-b93a-ccc64af2efc5'
and intakeservicerequestdispositioncodeid='aca0a6fd-f113-4a7f-9ac4-59ce04c9e9a0';

update routing set activeflag=0,updatedby='CDM-8258',updatedon=now() where objectid='aca0a6fd-f113-4a7f-9ac4-59ce04c9e9a0' and routingid in ('1b384708-c8a7-40e4-afa1-b8faf92a8c72',
'6767fb2a-f87c-4af4-a361-f03c1277dabd');