/*
   Issue Description: CDM-20400
   Category/ Module  : Add a new role to the person
   Root cause: user requeseted to add a new role
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

INSERT INTO cjams.intakeservicerequestactor
(actorid, intakeservicerequestpersontypekey, rapersontypekey, insertedby, insertedon, updatedby, updatedon, expirationdate, "timestamp", intakeserviceid, activeflag, reported, isprimary, personid, old_id, ismaltreator, rcprimaryroletypekey, ncpspriorhistoryflag, householdnumber, ssnverifytypekey, rchandicapflag, rchomelessflag, lvgarrangementtypekey, livingprefixtypekey, lvgfirstname, lvgmiddlename, lvglastname, lvgsuffixtypekey, lvgrelationshiptypekey, lvgcomments, rchouseholdflag, rcchildflag, nonparticipatingflag, householdheadflag, rcinsertedon, rcinsertedby, rcupdatedon, rcupdatedby, rcactiveflag, livingwith, rcreporteranonymousflag, rcreporternoletterflag, clientflag, rcexpungementflag, rcdatavalidflag, rcclientmergeid, arclientid, arsummaryid, altrespclientid, participatingchildflag, aractiveflag, screeningpersonid, prexpungementflag, prdatavalidflag, prinsertedby, prupdatedby, practiveflag, referralclientid, caseclientid, crexpungementflag, crdatavalidflag, crinsertedby, crupdatedby, sphouseholdmemberflag, spchildflag, spreporteranonymousflag, spreporternoletterflag, spexpungementflag, fetalalcoholspctrmdisordflag, drugexposednewbornflag, probationsearchconductedflag, sexoffenderregisteredflag, otherdrugs, unknownreporterflag, spproviderid, fk_id, isvictim, servicecaseid, fk_cl_id, intakenumber, isheadofhousehold, etl_userid, etl_load_date, objectid, objecttype)
VALUES('da8db377-9297-462e-bad0-61036043ddd3'::uuid, 'AV', NULL, 'CDM-20400', now(), 'CDM-20400', now(), NULL, NULL, '44d4c607-47b3-40b2-9ae1-3c8dcc80a0e9'::uuid, 1, true, true, '28a6afd4-2248-43e6-ba1f-50681119bbe4'::uuid, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, NULL);
