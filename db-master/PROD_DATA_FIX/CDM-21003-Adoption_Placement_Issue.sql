-- Placement
select alternateid, startdatetime, starttime, enddatetime, enddatetime, exitreasontypekey, exittypekey, isvoided, updatedby, updatedon 
from cjams.placement 
where placementid in (
'0302ad6d-7fef-4940-a417-3dc54038c721'
)
and activeflag  = 1 ;

/*
INSERT INTO cjams.placement
(placementid, providerid, intakeserviceid, intakeservicerequestactorid, startdatetime, enddatetime, remarks, statustypekey, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, exitreasontypekey, placementadmissionclassificationkey, placementadmissiontypekey, parentorg, addate, adtime, releasedate, detainer, placementadmissionauthorizationtypekey, placementprimaryadmissionreasontypekey, placementprimaryapprovedalttypekey, jlocation, jcounty, fieldworker, certifiedad, resourceworker, county, isprovidertyperesidential, isoperatedbydjs, lrstatus, cop, istempplacement, actvwrkrfldrtypecode, actvwrkrfldridno, admissionauthcode, admissioncriteriacode, detentionalternativecode, detentionalternativeindc, homecountycode, orgidno, placecaseidno, placementsummarykey, placestatuscode, plcmntsmrykeyold, portedtohttmstamp, releasecategorycode, releasetonametext, removalreasoncode, removaltime, servicemastercode, servicetypecode, unitkey, whereaboutscode, admissiontime, emankletidno, emfmdidno, eventdttmkey, eventidno, placementdate, projectedreleasedate, servicemsatercode, exittypekey, isvoided, voidreasontypekey, voidremarks, voiddate, intakeservreqchildremovalid, servicecaseid, placementtypekey, service_id, comarrate_id, starttime, endtime, providersentdate, providerdesc, responseacceptedkey, rejectreasonkey, isssaapproval, ifcapprovaldate, alternateid, altproviderid, intakenumber, personid, providerorganizationid, contractprogramid, facilityid, medicaidpaidflag, entrytime, otherservices, exittime, overunderflag, approvalstatustypekey, placementstructureid, voidflag, exittypetypekey, courtorderedflag, icpcapprovedflag, shortlistid, paymentheaderid, placementchangedate, fiscalcategorytypekey, ratestructureid, conversionflag, origplacementid, datavalidflag, voidapprovalstatustypekey, voidapprovaldate, tfcifcconversionflag, caseid, fk_id, releasenotetext, clientmergeid, ischildplacedoutside, etl_userid, etl_load_date, islapsesinplacement, typeoflapses, ischangepreadoptive, justification)
VALUES('0302ad6d-7fef-4940-a417-3dc54038c721'::uuid, 'e77edd4b-e8cf-4a48-b359-5d9455be33b0'::uuid, 'ce534ed3-31c4-4620-bba4-b4f147346e8e'::uuid, 'b5c70ad3-8a3e-4d7a-aa7d-8d86f12c26aa'::uuid, '2019-10-04 00:00:00.000', '2022-02-14 00:00:00.000', NULL, NULL, 1, '2019-10-09 13:09:43.000', 'KHE345606', '2019-10-09 13:09:43.000', 'finance', '2022-03-01 17:44:15.621', '337263', 'PLCCAF', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PLCC', 0, NULL, NULL, NULL, '67cd2f3c-2a6a-41ec-8bbe-bd3dcf28d44c'::uuid, '9723b356-0a61-40f1-be1a-643fcbe26f0a'::uuid, 'PRPL', 10, 10, 'Thu Jan 01 09:00:00 ', '08:45', NULL, NULL, '4612', NULL, NULL, NULL, 337263, 5087812, NULL, '27fb4c9f-c3e3-48d1-b998-2b803410c2bd'::uuid, NULL, NULL, NULL, 0, '09:00:00', NULL, NULL, '0', '3047', 10, NULL, NULL, 0, 0, NULL, 3149113, NULL, '7173 ', 10, 0, NULL, 0, NULL, '2022-02-16', '0', '9723b356-0a61-40f1-be1a-643fcbe26f0a'::uuid, '196927', NULL, NULL, NULL, 'Data Migration', '2020-04-18', NULL, NULL, NULL, NULL);
*/

select * from  cjams.placement p where personid ='27fb4c9f-c3e3-48d1-b998-2b803410c2bd' order by updatedon  desc;

update cjams.placement  
set enddatetime = null, 
	endtime = null, 
	exitreasontypekey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-21003'
where placementid in ('0302ad6d-7fef-4940-a417-3dc54038c721')
	and activeflag  = 1 ;

-- Placement Revision
select * --exitdate, exittime, exitreasontypkey, exittypekey, updatedby , updatedon  
	from cjams.placementrevision  
where placementid in ('0302ad6d-7fef-4940-a417-3dc54038c721')
	and ( exitdate is not null or exittime is not null ) ;


update cjams.placementrevision  
set exitdate = null, 
	exittime = null, 
	exitreasontypkey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-21003'
where placementid in ('0302ad6d-7fef-4940-a417-3dc54038c721')
	and ( exitdate is not null or exittime is not null ) ;


	
-- Update Removal
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where removalid in (196927)
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	updatedby = 'CDM-21003',
	updatedon = now()
where removalid in (196927)
	and activeflag = 1 ;
	
-- Update OOH
select * --programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea where personid ='27fb4c9f-c3e3-48d1-b998-2b803410c2bd' order by enddate  desc;

select * --programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid in ('d0f93e91-17bb-4d3c-9a47-8842a9b932b6')
	and activeflag = 1 ;


update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-21003',
	updatedon = now()
where personprogramid in ('d0f93e91-17bb-4d3c-9a47-8842a9b932b6')
	and activeflag = 1 ;
	
-- Legal Custodies are Active in this case
/*
select fromdate, todate, updatedby, updatedon
	from legalcustody 
where legalcustodyid = ??
	and activeflag = 1;

update cjams.legalcustody 
set todate = Null, 
	updatedby = 'CDM-21003',
	updatedon = now()
where legalcustodyid = ?? 
	and activeflag = 1;
*/
	
-- Update Eligibility
select * from cjams.tb_client_eligibility tce 
where case_id ='3203720';

select *--client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where eligibility_id in ( 169371)
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-21003',
	update_ts = now()
where eligibility_id in ( 169371)
	and delete_sw = 'N' ;
	


-- Call to generate missing Placement Vlaidations
select al_sqlcode, as_mess  
from cjams.sp_placement_validation_datafix(current_date, current_date, 'CDM-21003'::character varying ) ;