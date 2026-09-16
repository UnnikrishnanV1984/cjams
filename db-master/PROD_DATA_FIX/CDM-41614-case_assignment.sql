/*
   Issue Description: CDM-41614
   Category/ Module  : case assignment
   Root cause: user requeseted to add case assignment. case Andrews, Dayle #241022181347 to be assigned to Jeanne Baxter (200001330) for an appeal. The supervisor of the CPS unit, Tara Newcomer, is no longer with our Dept
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


--select isrouted,routedusersid,intakeserviceid,* from cjams.intakeservicerequest where servicerequestnumber = '241022181347';
-- intakeserviceid = e7392dd4-37ab-4fe9-a66f-55158715f8e7
-- routeduserid = f8119e72-d822-42c1-a5a3-81a46bed2d29: Mila Choei
-- routeduseridnew = 22f78177-19c0-4bb2-a921-c133de3590cd : Jeanne Baxter


update routing 
set 
	eventcode = 'APPL', --Event set to appeal
	routingstatustypeid = 15, --Status set to review
	updatedby = 'CDM-41614',
	updatedon = now(),
	tosecurityusersid = '22f78177-19c0-4bb2-a921-c133de3590cd'
	where objectid = 'e7392dd4-37ab-4fe9-a66f-55158715f8e7'
	and activeflag = 1;
	


/*
update cjams.intakeservicerequest set isrouted = true, routedon = now(), 
routedusersid = 'f8119e72-d822-42c1-a5a3-81a46bed2d29', updatedon = now(), 
updatedby = 'CDM-41614' 
where servicerequestnumber  = '241022181347';
*/



-- adding assignments
--select * from caseassignment where objectid = 'e7392dd4-37ab-4fe9-a66f-55158715f8e7'


INSERT INTO cjams.caseassignment
( caseassignmentid,
eventidno_fk,
eventdttmkey_fk,
fromworkeridno, 
fromsupervisoridno,
fromofficecode,
toworkeridno,
tosupervisoridno,
toofficecode,
caseassigncode, 
effectivedate,
effectivetime,
frombizunitidno,
tobizunitidno,
old_id,
foldergroupindc, 
cmfldrgrpasgnkey, 
insertedby,
updatedby, 
insertedon, 
updatedon, 
objecttypekey, 
objectid,
responsibilitytypekey,
activeflag, 
startdate, 
enddate, 
fromteamid, toteamid, 
remarks,
statustypekey, 
fromldssid, 
toldssid, 
assignmenttype, 
fk_id, 
assigndate, 
isrestricted, assigndescription, summary, isnew, expungementflag, entityopendate, etl_userid, etl_load_date, servicetype)
values
( gen_random_uuid (),
'f8119e72-d822-42c1-a5a3-81a46bed2d29'::uuid,
NULL, 
'5e46d48e-82ff-45dc-9b4d-e68edb67cafc',
NULL,
NULL,
'22f78177-19c0-4bb2-a921-c133de3590cd', 
NULL,
NULL, 
NULL,
'2024-05-20 09:36:15',
'2024-05-20 09:36:15', 
NULL,
NULL,
NULL,
NULL,
NULL,
'CDM-41614', 
'CDM-41614', 
now(), 
now(), 
'servicerequest',
'e7392dd4-37ab-4fe9-a66f-55158715f8e7'::uuid,
NULL,
1,
'2024-05-20 09:36:15',
NULL,
'b8d4d6d4-bd06-4087-b38a-b085abb266db'::uuid, '13235932-5e81-4427-a9d0-affbc6001410'::uuid,
NULL, 
NULL,
'f5214cb2-953e-41a9-a4ad-71341501e2ad'::uuid,
'f5214cb2-953e-41a9-a4ad-71341501e2ad'::uuid, 
'W',
NULL,
'2024-05-20 00:00:00', 
NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);



