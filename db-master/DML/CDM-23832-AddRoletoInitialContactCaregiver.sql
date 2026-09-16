/*
   Issue Description: CDM-23832
   Category/ Module  : Adding role - Initial Contact Caregiver to Person
   Root cause: Response timer didn't stop
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

INSERT INTO cjams.intakeservicerequestactor
( actorid, intakeservicerequestpersontypekey, rapersontypekey, insertedby,
insertedon, updatedby, updatedon, expirationdate, "timestamp",
intakeserviceid, routingaddressid, employeetypeid,
employeetypename, medicaideligibility, blockgranteligibility,
livingarrangementtypekey, guardianname, guardianinfo, ramentalhealth,
ramentalretarted, ramentalretartedtype, refusessn, refusedob, activeflag, 
reported, isprimary, personid, old_id, ismaltreator, rcprimaryroletypekey, ncpspriorhistoryflag, householdnumber, ssnverifytypekey,
rchandicapflag, rchomelessflag, lvgarrangementtypekey, livingprefixtypekey, lvgfirstname, lvgmiddlename, lvglastname, 
lvgsuffixtypekey, lvgrelationshiptypekey, lvgcomments, rchouseholdflag, rcchildflag, nonparticipatingflag, householdheadflag,
rcinsertedon, rcinsertedby, rcupdatedon, rcupdatedby, rcactiveflag, livingwith, rcreporteranonymousflag, rcreporternoletterflag,
clientflag, rcexpungementflag, rcdatavalidflag, rcclientmergeid, arclientid, arsummaryid, altrespclientid, participatingchildflag,
aractiveflag, screeningpersonid, prexpungementflag, prdatavalidflag, prinsertedby, prupdatedby, practiveflag, referralclientid, 
caseclientid, crexpungementflag, crdatavalidflag, crinsertedby, crupdatedby, sphouseholdmemberflag, spchildflag, spreporteranonymousflag,
spreporternoletterflag, spexpungementflag, fetalalcoholspctrmdisordflag, drugexposednewbornflag, probationsearchconductedflag,
sexoffenderregisteredflag, otherdrugs, unknownreporterflag, spproviderid, fk_id, isvictim, servicecaseid, fk_cl_id, intakenumber,
isheadofhousehold, etl_userid, etl_load_date, objectid, objecttype)
VALUES('48f1fed1-e574-4971-97c7-ad22431213e7', 'ICC', NULL, '8f5b3881-770a-489b-871c-73b74ace3481', 
'2022-03-09 23:11:19.231', 'edc6e303-cb43-49ce-b246-87d46656f8a0', '2022-05-23 10:14:15.402',
NULL, NULL, 'cae5ded3-85b4-48ce-a8c1-f364efdc1752', NULL, NULL, NULL, NULL, 
NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, true, false, 'd0707183-3dcd-419d-bbce-e95fb113cbea',
NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL,
NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, 'CDM-23832', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL, NULL, 
NULL, NULL, NULL, '4f1875a8-79a4-4021-9dab-c306dfc188bd', NULL, 'I221010250618', true, NULL, NULL, NULL, NULL);

select * from cjams.cpsresponsetimerupdate('cae5ded3-85b4-48ce-a8c1-f364efdc1752', '379e9591-69e1-4eca-b64d-c77ff0bbab7e'); 
