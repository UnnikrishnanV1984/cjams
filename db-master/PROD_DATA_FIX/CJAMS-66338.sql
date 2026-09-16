
/*
Issue: Erroneous payment triggered - CJAMS-66338
Category/Module: GAP
Root Cause: 1. Need to update the GAP agreement & subsidy rate start date from 06/01/2011 to 05/18/2011.
            2. Need to update the Child Removal & OOH program end date from 06/01/2011 to 05/18/2011
            3. Need to update the GAP program assignment start date from 06/10/2011 to 05/18/2011 for Cecilia Sterret (PID # 3041664)
Fix Provided (Data Fix Only): 1. Data fixed to update the GAP agreement & subsidy rate start date from 06/01/2011 to 05/18/2011.
                            2. Updated the Child Removal & OOH program end date from 06/01/2011 to 05/18/2011
                            3. Updated the GAP program assignment start date from 06/10/2011 to 05/18/2011 for Cecilia Sterret (PID # 3041664)
Data/Code fix ticket#: CJAMS-66338
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/
--Data fix to update the GAP agreement start date from 06/01/2011 to 05/18/2011.
update gapagreement
set startdate='2011-05-18 00:00:00',
updatedby = 'CJAMS-66338',
updatedon = now()
where gapagreementid='9c653e19-c634-4b30-b79b-811531fedf07'
and activeflag = 1;

--Data fix to update the subsidy rate start date from 06/01/2011 to 05/18/2011.
update gapagreementrate
set startdate='2011-05-18 00:00:00',
updatedby = 'CJAMS-66338',
updatedon = now()
where gapagreementrateid = '0b2f9aac-bbf2-4899-8006-26374a7561a4'
and activeflag = 1;

--Data fix to update the Child Removal & OOH program end date from 06/01/2011 to 05/18/2011
update cjams.personprogramarea 
set enddate='2011-05-18 00:00:00',
updatedby = 'CJAMS-66338',
updatedon = now()
where personprogramid='4f8c7ead-d1aa-4bd9-930f-ab8e4f1f570e';

--Data fix to update the GAP program assignment start date from 06/10/2011 to 05/18/2011 for Cecilia Sterret (PID # 3041664)
update cjams.personprogramarea 
set startdate='2011-05-18 00:00:00',
updatedby = 'CJAMS-66338',
updatedon = now()
where personprogramid='930cd933-812b-4aef-b7ce-ae6e64123809';

update tb_client_eligibility
set end_dt='2011-05-18 00:00:00',
update_ts=now(),
update_user_id='CJAMS-66338'
where client_id='3041664' and case_id='3186076' and eligibility_id='113747';

update intakeservreqchildremoval
set exitdate ='2011-05-18 00:00:00',
updatedby = 'CJAMS-66338',
updatedon = now()
where intakeservreqchildremovalid ='17500511-94bc-444e-9f58-90d86729eca0' and activeflag =1;

INSERT INTO intakeservreqchildremoval_history (
intakeservreqchildremovalhistoryid, modifieddata, rowtype, intakeservreqchildremovalid, intakeserviceid, fathername, mothername, rmvdfrmpersonname, removalreasontypeid, removaladd1, removaladd2, removalzip, removalstatecd, removalcity, activeflag, insertedby, insertedon, updatedby, updatedon, agencytypekey, old_id, intakeservicerequestactorid, rmvdfrmisractorid, removaldate, parent2signeddate, primarycaregiverid, vpaparentssigneddate, vpadsssigneddate, dateoffindingctwdecision, childphysicaladdressafterremoval, nameofsubjectctwfinding, clientidofsubjectctwfinding, courtorderdelaytimeframe, reasonableeffortsnotnecessaryduetoemergentcircumstances, whoisresponsibleforplacementandcare, ctwdecision, relationshipofsubjectctwfinding, specifiedrelativedatechildlastlivedwith, specifiedrelativephysicaladdress, specifiedrelativename, specifiedrelativeclientid, specifiedrelativerelationshipid, sheltergranted, courtorderdelayremoval, magistrateorjudgename, typeofvpa, eavpaagreementflag, vpabegindate, ctwsanctioningchildremoval, childphysicalremovaldate, petitionfiledate, dateofremovalcourthearing, judgesigned, hearingdate, physicalremovalafterdetermination, removalcourtorderdate, childphysicalremovaladdress, specifiedrelativephysicaladdressafterremoval, dateofreasonableeffortscourthearing, reasonableeffortsmade, issafehavenbaby, returndate, childremovedfromtypekey, familystructuretypekey, comments, vpastartdate, vpaenddate, childrelativelastdate, approvalstatustypekey, caseid, nocaregivercustodyflag, origremovalid, datavalidflag, clientmergeid, removaltime, returntime, removaltransts, returntransts, afcarseditapplyflag, parentssigntypekey, parent2comments, fk1_id, agencysigneddate, isbothparentssigned, childfactorsentry, removaltypekey, primarycaregiveractorid, vpachildsigneddate, vpayouthsigneddate, vpaguardiansigneddate, removalreasontypekey, removalid, exitdate, seccaregiveractorid, seccaregiveradd, primarycaregiveradd, isverifiedreporteradd, isverifiedcaregiver1add, isverifiedcaregiver2add, relativeactorid, isdisability, servicecaseid, assessmentid, personid, ischildphysicalremovaladdressverified, isuploadedmanually, isshelterauthcompleted, ischildaddressasprimaryaddress, removalexitreason, parent1id, parent2id, guardianid, volrelinquishment, etl_userid, etl_load_date, actualdata, removalcircumstances, transferagency, otherpublicagency, locationofadoption, justification, environmentatremovalkey, childremovalluggage, luggageprovided, placementdisposableortrashbag, luggagecomments, luggageupdatedby, luggageupdatedon, showcontactpage
) VALUES (
gen_random_uuid(), -- 1: intakeservreqchildremovalhistoryid
'{"status": "Updated", "data": [ {"key": "comments","data_type": "text", "new_value": "The child removal exit date was updated with the datafix ticket CJAMS-66338.","display_name": "Comments"}]}'::json, -- 2: modifieddata
'HISTORY', -- 3: rowtype
'17500511-94bc-444e-9f58-90d86729eca0', -- 4: intakeservreqchildremovalid
'989d46e0-5164-4808-a8de-c6dfd262969d', -- 5: intakeserviceid
'AMBER TAYLOR', -- 6: fathername
NULL, -- 7: mothername
'Mother (Biological)', -- 8: rmvdfrmpersonname
NULL, -- 9: removalreasontypeid
'9100 FRANKLIN SQUARE DR STE 108 Edgewood MD 21237', -- 10: removaladd1
NULL, -- 11: removaladd2
NULL, -- 12: removalzip
NULL, -- 13: removalstatecd
NULL, -- 14: removalcity
1, -- 15: activeflag
'AHE792612', -- 16: insertedby
'2010-05-11 12:04:37.000'::timestamp, -- 17: insertedon
'CJAMS-66338', -- 18: updatedby
now(), -- 19: updatedon
NULL, -- 20: agencytypekey
'128797', -- 21: old_id
'd2128ff2-d60c-4732-8409-e8990560b409', -- 22: intakeservicerequestactorid
NULL, -- 23: rmvdfrmisractorid
'2010-05-03'::date, -- 24: removaldate
NULL, -- 25: parent2signeddate
'3016756', -- 26: primarycaregiverid
NULL, -- 27: vpaparentssigneddate
NULL, -- 28: vpadsssigneddate
NULL, -- 29: dateoffindingctwdecision
NULL, -- 30: childphysicaladdressafterremoval
NULL, -- 31: nameofsubjectctwfinding
NULL, -- 32: clientidofsubjectctwfinding
NULL, -- 33: courtorderdelaytimeframe
NULL, -- 34: reasonableeffortsnotnecessaryduetoemergentcircumstances
NULL, -- 35: whoisresponsibleforplacementandcare
NULL, -- 36: ctwdecision
NULL, -- 37: relationshipofsubjectctwfinding
NULL, -- 38: specifiedrelativedatechildlastlivedwith
NULL, -- 39: specifiedrelativephysicaladdress
NULL, -- 40: specifiedrelativename
NULL, -- 41: specifiedrelativeclientid
NULL, -- 42: specifiedrelativerelationshipid
NULL, -- 43: sheltergranted
NULL, -- 44: courtorderdelayremoval
NULL, -- 45: magistrateorjudgename
NULL, -- 46: typeofvpa
NULL, -- 47: eavpaagreementflag
NULL, -- 48: vpabegindate
NULL, -- 49: ctwsanctioningchildremoval
NULL, -- 50: childphysicalremovaldate
NULL, -- 51: petitionfiledate
NULL, -- 52: dateofremovalcourthearing
NULL, -- 53: judgesigned
NULL, -- 54: hearingdate
NULL, -- 55: physicalremovalafterdetermination
NULL, -- 56: removalcourtorderdate
NULL, -- 57: childphysicalremovaladdress
NULL, -- 58: specifiedrelativephysicaladdressafterremoval
NULL, -- 59: dateofreasonableeffortscourthearing
NULL, -- 60: reasonableeffortsmade
NULL, -- 61: issafehavenbaby
'2011-06-01'::date, -- 62: returndate
'Mother (Biological)', -- 63: childremovedfromtypekey
'293', -- 64: familystructuretypekey
NULL, -- 65: comments
NULL, -- 66: vpastartdate
NULL, -- 67: vpaenddate
NULL, -- 68: childrelativelastdate
NULL, -- 69: approvalstatustypekey
NULL, -- 70: caseid
0, -- 71: nocaregivercustodyflag
NULL, -- 72: origremovalid
0, -- 73: datavalidflag
NULL, -- 74: clientmergeid
'2010-05-03 11:00:00.000'::timestamp, -- 75: removaltime
'2011-06-01 08:00:00.000'::timestamp, -- 76: returntime
'2010-05-11'::date, -- 77: removaltransts
'2011-06-07'::date, -- 78: returntransts
1, -- 79: afcarseditapplyflag
NULL, -- 80: parentssigntypekey
NULL, -- 81: parent2comments
NULL, -- 82: fk1_id
NULL, -- 83: agencysigneddate
1, -- 84: isbothparentssigned
NULL, -- 85: childfactorsentry
'JD', -- 86: removaltypekey
'ce6af5f1-cd1a-49b4-869d-6560ec10eb4e', -- 87: primarycaregiveractorid
NULL, -- 88: vpachildsigneddate
NULL, -- 89: vpayouthsigneddate
NULL, -- 90: vpaguardiansigneddate
NULL, -- 91: removalreasontypekey
NULL, -- 92: removalid
'2011-05-18'::date, -- 93: exitdate
NULL, -- 94: seccaregiveractorid
NULL, -- 95: seccaregiveradd
'9100 FRANKLIN SQUARE DR STE 108 Edgewood MD 21237', -- 96: primarycaregiveradd
NULL, -- 97: isverifiedreporteradd
1, -- 98: isverifiedcaregiver1add
NULL, -- 99: isverifiedcaregiver2add
NULL, -- 100: relativeactorid
NULL, -- 101: isdisability
NULL, -- 102: servicecaseid
NULL, -- 103: assessmentid
NULL, -- 104: personid
0, -- 105: ischildphysicalremovaladdressverified
NULL, -- 106: isuploadedmanually
NULL, -- 107: isshelterauthcompleted
NULL, -- 108: ischildaddressasprimaryaddress
NULL, -- 109: removalexitreason
null, -- 110: parent1id
NULL, -- 111: parent2id
NULL, -- 112: guardianid
NULL, -- 113: volrelinquishment
'Data Migration', -- 114: etl_userid
'2020-07-25'::date, -- 115: etl_load_date
NULL, -- 116: actualdata
NULL, -- 117: removalcircumstances
NULL, -- 118: transferagency
NULL, -- 119: otherpublicagency
NULL, -- 120: locationofadoption
NULL, -- 121: justification
NULL, -- 122: environmentatremovalkey
NULL, -- 123: childremovalluggage
NULL, -- 124: luggageprovided
NULL, -- 125: placementdisposableortrashbag
NULL, -- 126: luggagecomments
NULL, -- 127: luggageupdatedby
NULL, -- 128: luggageupdatedon
NULL -- 129: showcontactpage
);