/* Issue Description:CJAMS-67454
   Category/ Module  :  Services
   Root cause: Connected with user and we need to changed the Start date of service plan as 01/08/2026 instead of 04/10/2026 in all the places including Service plan, Service plan version, Service plan In home documents, Goals objectives Action start date
   Resolution: Provided data fix .
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 

*/

update serviceplan
set effectivedate='2026-01-08 00:00:00', updatedon=now(), updatedby='CJAMS-67454'
where serviceplanid='131e2149-114d-4c31-bd5d-98661b1230c6' and activeflag=1; 


update serviceplanaction  
set startdate='2026-01-08 00:00:00', updatedon=now(), updatedby='CJAMS-67454'
where serviceplanactionid='5a3a4c2b-cfe6-472f-8c4c-fff738f35a7c' and activeflag=1;



update serviceplanaction  
set startdate='2026-01-08 00:00:00', updatedon=now(), updatedby='CJAMS-67454'
where serviceplanactionid='3fda14ac-b253-4384-a0dc-50bc95e95fff' and activeflag=1;

update serviceplanaction  
set startdate='2026-01-08 00:00:00', updatedon=now(), updatedby='CJAMS-67454'
where serviceplanactionid='de081554-0d75-48d5-a089-7afb94e7cef5' and activeflag=1;

update serviceplanaction  
set startdate='2026-01-08 00:00:00', updatedon=now(), updatedby='CJAMS-67454'
where serviceplanactionid='f462f350-21c1-4ee9-ba66-238e968e9e94' and activeflag=1;



update snapshothist
set snapshotdata='{"status":null,"enddate":null,"isReady":true,"objectid":"1980df17-f061-4b78-bfb2-fbd72ad7c593","splangoal":[{"status":"In Progress","autoflag":0,"goalname":"The continuity of family relationships and connections is preserved for youth","activeflag":1,"splangoalid":"56130ae3-2b87-4d0c-aac6-0afd7593ab44","serviceplanid":"131e2149-114d-4c31-bd5d-98661b1230c6","splanobjective":[{"needs":null,"status":"In Progress","autoflag":0,"comments":"Hailey isolates herself from her family and although the family is working with FFT she is not willing to particiapte. ","strengths":null,"activeflag":1,"splangoalid":"56130ae3-2b87-4d0c-aac6-0afd7593ab44","objectivename":"To work on rebuilding a realtionship with Hailey between all family members ","splanobjectiveid":"e23ad161-017a-4291-ad35-7a6ec4f07dc8","serviceplanaction":[{"status":"In Progress","enddate":"2026-06-12T12:00:00.000Z","planfor":null,"autoflag":null,"comments":"Hailey is still attending FFT and needs to continue working on her realtionship with her family. ","plantype":null,"startdate":"2026-01-08T10:00:00.000Z","activeflag":1,"goalreason":"","splanobjectiveid":"e23ad161-017a-4291-ad35-7a6ec4f07dc8","personresponsible":"ERICA A ALBERT ,HAILEY HYDE ,GEOFFREY PHILLIP SAMPSON ","serviceplanoutcome":"","serviceplanactionid":"5a3a4c2b-cfe6-472f-8c4c-fff738f35a7c","approvalstatustypekey":null,"serviceplanactionname":"All family members continue to participate. ","serviceplanpersoninvolved":[{"person":{"suffix":null,"lastname":"SAMPSON","personid":"4bd29d67-8dcb-49d8-a030-2e3454d11478","firstname":"GEOFFREY","activeflag":1,"middlename":"PHILLIP"},"activeflag":1,"personinvolved":"4bd29d67-8dcb-49d8-a030-2e3454d11478","serviceplanactionid":"5a3a4c2b-cfe6-472f-8c4c-fff738f35a7c","serviceplanpersoninvolvedid":"48641a03-eb2f-47cb-9479-2bf9d9d16bc0"},{"person":{"suffix":null,"lastname":"HYDE","personid":"f330cf1b-7186-4a40-bc56-9c825b1ee34d","firstname":"HAILEY","activeflag":1,"middlename":""},"activeflag":1,"personinvolved":"f330cf1b-7186-4a40-bc56-9c825b1ee34d","serviceplanactionid":"5a3a4c2b-cfe6-472f-8c4c-fff738f35a7c","serviceplanpersoninvolvedid":"4e7dff4a-203d-4f36-ac39-a27eeeb03ef8"},{"person":{"suffix":null,"lastname":"ALBERT","personid":"5b4a6d9a-30f6-435f-9544-7af2eedabc52","firstname":"ERICA","activeflag":1,"middlename":"A"},"activeflag":1,"personinvolved":"5b4a6d9a-30f6-435f-9544-7af2eedabc52","serviceplanactionid":"5a3a4c2b-cfe6-472f-8c4c-fff738f35a7c","serviceplanpersoninvolvedid":"5061696b-81fc-46d0-b136-3ece1237eaae"}]}],"approvalstatustypekey":null}],"approvalstatustypekey":null},{"status":"In Progress","autoflag":null,"goalname":"Families have enhanced capacity to provide for their youths needs","activeflag":1,"splangoalid":"62d9f2db-63ac-428b-bd31-8846e31a3af5","serviceplanid":"131e2149-114d-4c31-bd5d-98661b1230c6","splanobjective":[{"needs":null,"status":"In Progress","autoflag":null,"comments":"Continue to work on the cleanliness of the home and ensuring there is a clean space and area to cook that does not have any bug rements. And a safe clean space to store food that bugs do not have access to get into. ","strengths":null,"activeflag":1,"splangoalid":"62d9f2db-63ac-428b-bd31-8846e31a3af5","objectivename":"Ensure there is a clean cooking enviorment and food for Hailey and Geoffrey ","splanobjectiveid":"48e568f6-3624-403b-a400-3c143472e71a","serviceplanaction":[{"status":"In Progress","enddate":"2026-06-12T08:00:00.000Z","planfor":null,"autoflag":null,"comments":"The family will continue to clean out the home and specifically clean the dead roaches from around the kitchen and cooking tools area to ensure that there is no safety risk. And that food is stored in containers/ areas to include the fridge that the roaches can not get too. ","plantype":null,"startdate":"2026-01-08T10:00:00.000Z","activeflag":1,"goalreason":null,"splanobjectiveid":"48e568f6-3624-403b-a400-3c143472e71a","personresponsible":"ERICA A ALBERT ,HAILEY HYDE ,GEOFFREY PHILLIP SAMPSON ","serviceplanoutcome":null,"serviceplanactionid":"3fda14ac-b253-4384-a0dc-50bc95e95fff","approvalstatustypekey":null,"serviceplanactionname":"Contiue to clean and clear out any bug (roach) rements from the kitchen after they are dead.  ","serviceplanpersoninvolved":[{"person":{"suffix":null,"lastname":"HYDE","personid":"f330cf1b-7186-4a40-bc56-9c825b1ee34d","firstname":"HAILEY","activeflag":1,"middlename":""},"activeflag":1,"personinvolved":"f330cf1b-7186-4a40-bc56-9c825b1ee34d","serviceplanactionid":"3fda14ac-b253-4384-a0dc-50bc95e95fff","serviceplanpersoninvolvedid":"857eb44c-1d7e-492b-b92a-622febeeb569"},{"person":{"suffix":null,"lastname":"ALBERT","personid":"5b4a6d9a-30f6-435f-9544-7af2eedabc52","firstname":"ERICA","activeflag":1,"middlename":"A"},"activeflag":1,"personinvolved":"5b4a6d9a-30f6-435f-9544-7af2eedabc52","serviceplanactionid":"3fda14ac-b253-4384-a0dc-50bc95e95fff","serviceplanpersoninvolvedid":"b1255d44-d4cb-4d09-bfc2-2bb2752827a5"},{"person":{"suffix":null,"lastname":"SAMPSON","personid":"4bd29d67-8dcb-49d8-a030-2e3454d11478","firstname":"GEOFFREY","activeflag":1,"middlename":"PHILLIP"},"activeflag":1,"personinvolved":"4bd29d67-8dcb-49d8-a030-2e3454d11478","serviceplanactionid":"3fda14ac-b253-4384-a0dc-50bc95e95fff","serviceplanpersoninvolvedid":"c24bdd02-4f9b-40e5-9d1d-7a5d644ec987"}]}],"approvalstatustypekey":null}],"approvalstatustypekey":null}],"updatedon":"04/15/2026 11:54:30","activeflag":1,"insertedon":"04/15/2026 11:32:31","approvaldate":null,"numberofdays":null,"candidatesObj":{"candidates":[],"candidatestraditional":[]},"effectivedate":"2026-01-08T10:00:00.000ZT10:00:00.000Z","legalGuardian":"ERICA A ALBERT ","objecttypekey":null,"serviceplanid":"131e2149-114d-4c31-bd5d-98661b1230c6","targetenddate":"2026-06-12T04:00:00.000Z","childrenHeader":"HAILEY HYDE , GEOFFREY PHILLIP SAMPSON ","involvedpersons":[{"id":"4457520","ebp":{"noadditionalinfo":"YNE","isebpreferralmade":"No"},"name":"GEOFFREY PHILLIP SAMPSON ","comment":null,"disabledit":false,"imminentrisks":["NONE"],"enablelivinginink":null,"previousriskreasonids":[],"livingininformalkinship":null}],"personsinvolved":[{"age":"40 Yrs","dcn":null,"dob":"1985-07-22T04:00:00.000Z","mdm":"Y","ssn":"219170423","city":"Columbia","race":[{"racetypekey":"WH"}],"email":null,"needs":null,"prefx":null,"roles":[{"typedescription":"Parent","intakeservicerequestactorid":"dab550be-d9fb-4340-9e8d-3021798fc90c","intakeservicerequestpersontypekey":"PARENT"}],"state":"MD","county":null,"gender":"Female","height":null,"issafe":null,"suffix":null,"weight":null,"actorid":"2e736947-4fbf-47f7-ab7f-3bf604395b9f","address":"8852 SPIRAL CUT ","zipcode":"21045","addendum":null,"address2":"APT DG18","cjamspid":"4457190","fullname":"ERICA A ALBERT","lastname":"ALBERT","personid":"5b4a6d9a-30f6-435f-9544-7af2eedabc52","religion":null,"reported":null,"rolename":"","aliasname":null,"assistpid":"448038024","dangerous":[{"updatedon":"2025-12-15T12:12:55.842298","dangertoself":2,"isdangertoworker":2}],"emergency":null,"firstname":"ERICA","isalleged":null,"isglasses":false,"refusedob":null,"refusessn":null,"removalid":null,"strengths":null,"userphoto":"","userroles":"Parent","workphone":"3016625722","clientflag":1,"ethinicity":"X","fourerelid":1001,"middlename":"A","schoolname":null,"totalcount":"8","clienttitle":null,"dateofdeath":null,"incidentage":"40 Yrs","is_mdm_sync":null,"isapproxdod":0,"ishousehold":1,"isplacement":1,"phonenumber":"6674479302","priorscount":null,"programarea":[{"objectid":"5e056997-f64a-4aa0-8576-ad0f98398891","programkey":"CPS","programname":"CPS","subprogramkey":"IR","subprogramname":"Investigative Response"},{"objectid":"6c70ab3a-2571-469c-9fc0-af7a61c82069","programkey":"CPS","programname":"CPS","subprogramkey":"IR","subprogramname":"Investigative Response"}],"racetypekey":null,"removaldate":null,"rolehistory":[{"comments":"Initial contact caregiver Role is Added","username":"Emmett Woodard","updatedby":"7861919c-a69d-4876-b749-8f488c6fe015","updatedon":"2024-09-19T13:46:11.353705"},{"comments":"Initial contact caregiver Role is Added","username":"Emmett Woodard","updatedby":"7861919c-a69d-4876-b749-8f488c6fe015","updatedon":"2024-07-29T11:34:29.897169"},{"comments":"Initial contact caregiver Role is Added","username":"Angela Singleton","updatedby":"a1c7b418-7b96-4cc8-9a5f-fbbc22d48f01","updatedon":"2024-02-08T09:40:21.65732"},{"comments":"Initial contact caregiver Role is Added","username":"Whitney Daggett","updatedby":"0a1e168e-f60b-4ac1-be97-d816660b50b2","updatedon":"2022-09-08T12:33:46.770728"},{"comments":"Initial contact caregiver Role is Added","username":"Sarah Wise","updatedby":"c0bf846d-fa4e-421f-a33d-4ecb43b09ff7","updatedon":"2022-05-02T15:09:18.40511"}],"ageat14years":"1999-07-22T04:00:00.000Z","ageat26years":"2011-07-22T04:00:00.000Z","caseheadname":null,"employername":null,"relationship":"Biological Mother","dangeraddress":false,"icwatribename":null,"senstatusflag":null,"servicecaseid":"1980df17-f061-4b78-bfb2-fbd72ad7c593","statustypekey":"ASSGN","cfe_diff_dates":[{"end_dt":"2024-03-31","start_dt":"2021-10-01"}],"eyecolortypekey":null,"hospitaldetails":null,"intakeserviceid":"4a1b7cfa-d955-4d32-94a2-0c7acf5673f5","preadoptiondate":null,"primarylanguage":null,"skintonetypekey":null,"haircolortypekey":null,"isbioadoptedflag":null,"isqualifiedalien":0,"medicalcondition":null,"sennotifications":null,"adoptionremovalid":null,"birthmatchdetails":null,"icwastatusinquiry":"NO","isheadofhousehold":true,"primarylanguageid":"ENG","relationshiparray":[{"firstname":"HAILEY","updatedon":"2026-01-08T16:24:03","description":"Paternal Grandparent","primaryuserid":"f330cf1b-7186-4a40-bc56-9c825b1ee34d","secondaryuserid":"9b1736e0-4bdb-48bc-b11b-b7a076d03d72"},{"firstname":"Monique","updatedon":"2026-01-08T16:23:54","description":"Paternal GrandChild","primaryuserid":"9b1736e0-4bdb-48bc-b11b-b7a076d03d72","secondaryuserid":"f330cf1b-7186-4a40-bc56-9c825b1ee34d"},{"firstname":"ERICA","updatedon":"2025-12-30T09:51:40.391429","description":"No Relation","primaryuserid":"5b4a6d9a-30f6-435f-9544-7af2eedabc52","secondaryuserid":"9b1736e0-4bdb-48bc-b11b-b7a076d03d72"},{"firstname":"GEOFFREY","updatedon":"2025-12-30T09:51:40.391429","description":"Biological Mother","primaryuserid":"4bd29d67-8dcb-49d8-a030-2e3454d11478","secondaryuserid":"5b4a6d9a-30f6-435f-9544-7af2eedabc52"},{"firstname":"Monique","updatedon":"2025-12-30T09:51:40.391429","description":"Paternal GrandChild","primaryuserid":"9b1736e0-4bdb-48bc-b11b-b7a076d03d72","secondaryuserid":"4bd29d67-8dcb-49d8-a030-2e3454d11478"},{"firstname":"GEOFFREY","updatedon":"2025-12-30T09:51:40.391429","description":"Paternal Grandparent","primaryuserid":"4bd29d67-8dcb-49d8-a030-2e3454d11478","secondaryuserid":"9b1736e0-4bdb-48bc-b11b-b7a076d03d72"},{"firstname":"Monique","updatedon":"2025-12-05T14:22:00","description":"No Relation","primaryuserid":"9b1736e0-4bdb-48bc-b11b-b7a076d03d72","secondaryuserid":"5b4a6d9a-30f6-435f-9544-7af2eedabc52"},{"firstname":"HAILEY","updatedon":"2025-12-05T14:19:38","description":"Biological Mother","primaryuserid":"f330cf1b-7186-4a40-bc56-9c825b1ee34d","secondaryuserid":"5b4a6d9a-30f6-435f-9544-7af2eedabc52"},{"firstname":"ERICA","updatedon":"2025-12-05T14:19:30","description":"Biological Child","primaryuserid":"5b4a6d9a-30f6-435f-9544-7af2eedabc52","secondaryuserid":"f330cf1b-7186-4a40-bc56-9c825b1ee34d"},{"firstname":"ERICA","updatedon":"2025-12-05T14:19:00","description":"Biological Child","primaryuserid":"5b4a6d9a-30f6-435f-9544-7af2eedabc52","secondaryuserid":"4bd29d67-8dcb-49d8-a030-2e3454d11478"},{"firstname":"GEOFFREY","updatedon":"2025-12-05T14:18:24","description":"Half Sister","primaryuserid":"4bd29d67-8dcb-49d8-a030-2e3454d11478","secondaryuserid":"f330cf1b-7186-4a40-bc56-9c825b1ee34d"},{"firstname":"HAILEY","updatedon":"2025-07-16T21:13:32.34507","description":"Biological Father","primaryuserid":"f330cf1b-7186-4a40-bc56-9c825b1ee34d","secondaryuserid":"62e4e93e-cb40-4b99-b0fb-0500405010a0"},{"firstname":"JAMES","updatedon":"2025-07-16T21:13:32.34507","description":"Adoptive Parent","primaryuserid":"62e4e93e-cb40-4b99-b0fb-0500405010a0","secondaryuserid":"b200ab57-c889-4036-a823-2bb6ab108035"},{"firstname":"JAMES","updatedon":"2025-07-16T21:13:32.34507","description":"Adoptive Parent","primaryuserid":"62e4e93e-cb40-4b99-b0fb-0500405010a0","secondaryuserid":"ca24abeb-4ab6-4673-a25c-307d8a37dccb"},{"firstname":"GEOFFREY","updatedon":"2025-07-16T21:13:32.34507","description":"Biological Sister","primaryuserid":"4bd29d67-8dcb-49d8-a030-2e3454d11478","secondaryuserid":"f330cf1b-7186-4a40-bc56-9c825b1ee34d"},{"firstname":"JAMES","updatedon":"2025-07-16T21:13:32.34507","description":"Biological Child","primaryuserid":"62e4e93e-cb40-4b99-b0fb-0500405010a0","secondaryuserid":"f330cf1b-7186-4a40-bc56-9c825b1ee34d"},{"firstname":"JAMES","updatedon":"2025-07-16T21:13:32.34507","description":"Neighbor","primaryuserid":"62e4e93e-cb40-4b99-b0fb-0500405010a0","secondaryuserid":"fa22772f-b3a8-4e5a-881b-f35569bffab0"},{"firstname":"JAMES","updatedon":"2025-07-16T21:13:32.34507","description":"No Relation","primaryuserid":"62e4e93e-cb40-4b99-b0fb-0500405010a0","secondaryuserid":"00a297e1-1147-49db-8b7e-7708db904067"},{"firstname":"HAILEY","updatedon":"2025-07-16T21:13:32.34507","description":"No Relation","primaryuserid":"f330cf1b-7186-4a40-bc56-9c825b1ee34d","secondaryuserid":"fa22772f-b3a8-4e5a-881b-f35569bffab0"},{"firstname":"HAILEY","updatedon":"2025-07-16T21:13:32.34507","description":"No Relation","primaryuserid":"f330cf1b-7186-4a40-bc56-9c825b1ee34d","secondaryuserid":"00a297e1-1147-49db-8b7e-7708db904067"},{"firstname":"JAMES","updatedon":"2025-07-16T21:13:32.34507","description":"Biological Brother","primaryuserid":"62e4e93e-cb40-4b99-b0fb-0500405010a0","secondaryuserid":"0a7fb98a-16e3-4cea-8ea2-91fc3e242436"},{"firstname":"JAMES","updatedon":"2025-07-16T21:13:32.34507","description":"No Relation","primaryuserid":"62e4e93e-cb40-4b99-b0fb-0500405010a0","secondaryuserid":"4bd29d67-8dcb-49d8-a030-2e3454d11478"},{"firstname":"HAILEY","updatedon":"2025-07-16T21:13:32.34507","description":"Biological Brother","primaryuserid":"f330cf1b-7186-4a40-bc56-9c825b1ee34d","secondaryuserid":"4bd29d67-8dcb-49d8-a030-2e3454d11478"},{"firstname":"HAILEY","updatedon":"2025-07-16T21:13:32.34507","description":"Half Brother","primaryuserid":"f330cf1b-7186-4a40-bc56-9c825b1ee34d","secondaryuserid":"4bd29d67-8dcb-49d8-a030-2e3454d11478"},{"firstname":"JAMES","updatedon":"2025-07-16T21:13:32.34507","description":"Girlfriend-EX","primaryuserid":"62e4e93e-cb40-4b99-b0fb-0500405010a0","secondaryuserid":"5b4a6d9a-30f6-435f-9544-7af2eedabc52"},{"firstname":"JAMES","updatedon":"2025-07-16T21:13:32.34507","description":"No Relation","primaryuserid":"62e4e93e-cb40-4b99-b0fb-0500405010a0","secondaryuserid":"5b4a6d9a-30f6-435f-9544-7af2eedabc52"},{"firstname":"GEOFFREY","updatedon":"2025-07-16T21:13:32.34507","description":"No Relation","primaryuserid":"4bd29d67-8dcb-49d8-a030-2e3454d11478","secondaryuserid":"62e4e93e-cb40-4b99-b0fb-0500405010a0"},{"firstname":"ERICA","updatedon":"2025-07-16T21:13:32.34507","description":"Boyfriend-Ex","primaryuserid":"5b4a6d9a-30f6-435f-9544-7af2eedabc52","secondaryuserid":"62e4e93e-cb40-4b99-b0fb-0500405010a0"},{"firstname":"ERICA","updatedon":"2025-07-16T21:13:32.34507","description":"No Relation","primaryuserid":"5b4a6d9a-30f6-435f-9544-7af2eedabc52","secondaryuserid":"62e4e93e-cb40-4b99-b0fb-0500405010a0"}],"secondarylanguage":null,"alienstatustypekey":null,"citizenalenageflag":null,"haircolorotherdesc":null,"hairtexturetypekey":null,"iveadoptiondetails":null,"medicalinformation":null,"nationalitytypekey":"99","everbeenadoptedflag":null,"iscollateralcontact":0,"secondarylanguageid":null,"verificationremarks":null,"cferesourcehomechild":false,"hairtextureotherdesc":null,"intercountryadoption":null,"maritalstatustypekey":"SG","physicalbuildtypekey":null,"removaldtforcaseplan":null,"alienregistrationtext":"","medicationinformation":null,"seccitizenshiptypekey":"","drugexposednewbornflag":0,"priorlegalguardianship":null,"gapdeterminationdetails":null,"ivedeterminationdetails":null,"activeremovalservicecase":null,"dobtdiffwithincidentdate":14738,"programareabyservicecase":null,"biologicalmothermarriedsw":0,"icwaeligibleformembership":null,"primarycitizenshiptypekey":"","sexoffenderregisteredflag":null,"iveadoptionrejecteddetails":null,"intakeservicerequestactorid":"dab550be-d9fb-4340-9e8d-3021798fc90c","otherprimarylanguagetypekey":null,"fetalalcoholspctrmdisordflag":null,"preplacementguardianshipdate":null,"probationsearchconductedflag":null,"gaprejecteddeterminationdetails":null,"iverejecteddeterminationdetails":null},{"age":"18 Yrs","dcn":null,"dob":"2008-03-31T04:00:00.000Z","mdm":"Y","ssn":"771707000","city":"Columbia","race":[{"racetypekey":"WH"}],"email":null,"needs":null,"prefx":null,"roles":[{"typedescription":"Alleged Victim","intakeservicerequestactorid":"a640fae3-b7d8-4e2a-981f-b440a6eba6aa","intakeservicerequestpersontypekey":"AV"},{"typedescription":"Child","intakeservicerequestactorid":"6b474387-7103-4942-9b6a-7afee82527e8","intakeservicerequestpersontypekey":"CHILD"}],"state":"MD","county":null,"gender":"Female","height":null,"issafe":1,"suffix":null,"weight":null,"actorid":"31e3946c-98a8-4326-996f-260cd814ebe5","address":"8852 SPIRAL CUT ","zipcode":"21045","addendum":null,"address2":"APT D","cjamspid":"4457191","fullname":"HAILEY  HYDE","lastname":"HYDE","personid":"f330cf1b-7186-4a40-bc56-9c825b1ee34d","religion":null,"reported":null,"rolename":"","aliasname":null,"assistpid":"448038025","dangerous":[{"updatedon":"2025-12-15T12:12:55.842298","dangertoself":2,"isdangertoworker":2}],"emergency":null,"firstname":"HAILEY","isalleged":null,"isglasses":false,"refusedob":null,"refusessn":null,"removalid":null,"strengths":null,"userphoto":"","userroles":"Alleged Victim, Child","workphone":null,"clientflag":1,"ethinicity":"X","fourerelid":1001,"middlename":"","schoolname":null,"totalcount":"8","clienttitle":null,"dateofdeath":null,"incidentage":"17 Yrs","is_mdm_sync":null,"isapproxdod":0,"ishousehold":1,"isplacement":1,"phonenumber":null,"priorscount":null,"programarea":null,"racetypekey":null,"removaldate":null,"rolehistory":[],"ageat14years":"2022-03-31T04:00:00.000Z","ageat26years":"2034-03-31T04:00:00.000Z","caseheadname":null,"employername":null,"relationship":"Biological Brother","dangeraddress":null,"icwatribename":null,"senstatusflag":null,"servicecaseid":"1980df17-f061-4b78-bfb2-fbd72ad7c593","statustypekey":"ASSGN","cfe_diff_dates":[{"end_dt":"2024-03-31","start_dt":"2021-10-01"}],"eyecolortypekey":null,"hospitaldetails":null,"intakeserviceid":"4a1b7cfa-d955-4d32-94a2-0c7acf5673f5","preadoptiondate":null,"primarylanguage":null,"skintonetypekey":null,"haircolortypekey":null,"isbioadoptedflag":null,"isqualifiedalien":0,"medicalcondition":null,"sennotifications":null,"adoptionremovalid":null,"birthmatchdetails":null,"icwastatusinquiry":"NO","isheadofhousehold":false,"primarylanguageid":"ENG","relationshiparray":[{"firstname":"HAILEY","updatedon":"2026-01-08T16:24:03","description":"Paternal Grandparent","primaryuserid":"f330cf1b-7186-4a40-bc56-9c825b1ee34d","secondaryuserid":"9b1736e0-4bdb-48bc-b11b-b7a076d03d72"},{"firstname":"Monique","updatedon":"2026-01-08T16:23:54","description":"Paternal GrandChild","primaryuserid":"9b1736e0-4bdb-48bc-b11b-b7a076d03d72","secondaryuserid":"f330cf1b-7186-4a40-bc56-9c825b1ee34d"},{"firstname":"ERICA","updatedon":"2025-12-30T09:51:40.391429","description":"No Relation","primaryuserid":"5b4a6d9a-30f6-435f-9544-7af2eedabc52","secondaryuserid":"9b1736e0-4bdb-48bc-b11b-b7a076d03d72"},{"firstname":"GEOFFREY","updatedon":"2025-12-30T09:51:40.391429","description":"Biological Mother","primaryuserid":"4bd29d67-8dcb-49d8-a030-2e3454d11478","secondaryuserid":"5b4a6d9a-30f6-435f-9544-7af2eedabc52"},{"firstname":"Monique","updatedon":"2025-12-30T09:51:40.391429","description":"Paternal GrandChild","primaryuserid":"9b1736e0-4bdb-48bc-b11b-b7a076d03d72","secondaryuserid":"4bd29d67-8dcb-49d8-a030-2e3454d11478"},{"firstname":"GEOFFREY","updatedon":"2025-12-30T09:51:40.391429","description":"Paternal Grandparent","primaryuserid":"4bd29d67-8dcb-49d8-a030-2e3454d11478","secondaryuserid":"9b1736e0-4bdb-48bc-b11b-b7a076d03d72"},{"firstname":"Monique","updatedon":"2025-12-05T14:22:00","description":"No Relation","primaryuserid":"9b1736e0-4bdb-48bc-b11b-b7a076d03d72","secondaryuserid":"5b4a6d9a-30f6-435f-9544-7af2eedabc52"},{"firstname":"HAILEY","updatedon":"2025-12-05T14:19:38","description":"Biological Mother","primaryuserid":"f330cf1b-7186-4a40-bc56-9c825b1ee34d","secondaryuserid":"5b4a6d9a-30f6-435f-9544-7af2eedabc52"},{"firstname":"ERICA","updatedon":"2025-12-05T14:19:30","description":"Biological Child","primaryuserid":"5b4a6d9a-30f6-435f-9544-7af2eedabc52","secondaryuserid":"f330cf1b-7186-4a40-bc56-9c825b1ee34d"},{"firstname":"ERICA","updatedon":"2025-12-05T14:19:00","description":"Biological Child","primaryuserid":"5b4a6d9a-30f6-435f-9544-7af2eedabc52","secondaryuserid":"4bd29d67-8dcb-49d8-a030-2e3454d11478"},{"firstname":"GEOFFREY","updatedon":"2025-12-05T14:18:24","description":"Half Sister","primaryuserid":"4bd29d67-8dcb-49d8-a030-2e3454d11478","secondaryuserid":"f330cf1b-7186-4a40-bc56-9c825b1ee34d"},{"firstname":"HAILEY","updatedon":"2025-07-16T21:13:32.34507","description":"Biological Father","primaryuserid":"f330cf1b-7186-4a40-bc56-9c825b1ee34d","secondaryuserid":"62e4e93e-cb40-4b99-b0fb-0500405010a0"},{"firstname":"JAMES","updatedon":"2025-07-16T21:13:32.34507","description":"Adoptive Parent","primaryuserid":"62e4e93e-cb40-4b99-b0fb-0500405010a0","secondaryuserid":"b200ab57-c889-4036-a823-2bb6ab108035"},{"firstname":"JAMES","updatedon":"2025-07-16T21:13:32.34507","description":"Adoptive Parent","primaryuserid":"62e4e93e-cb40-4b99-b0fb-0500405010a0","secondaryuserid":"ca24abeb-4ab6-4673-a25c-307d8a37dccb"},{"firstname":"GEOFFREY","updatedon":"2025-07-16T21:13:32.34507","description":"Biological Sister","primaryuserid":"4bd29d67-8dcb-49d8-a030-2e3454d11478","secondaryuserid":"f330cf1b-7186-4a40-bc56-9c825b1ee34d"},{"firstname":"JAMES","updatedon":"2025-07-16T21:13:32.34507","description":"Biological Child","primaryuserid":"62e4e93e-cb40-4b99-b0fb-0500405010a0","secondaryuserid":"f330cf1b-7186-4a40-bc56-9c825b1ee34d"},{"firstname":"JAMES","updatedon":"2025-07-16T21:13:32.34507","description":"Neighbor","primaryuserid":"62e4e93e-cb40-4b99-b0fb-0500405010a0","secondaryuserid":"fa22772f-b3a8-4e5a-881b-f35569bffab0"},{"firstname":"JAMES","updatedon":"2025-07-16T21:13:32.34507","description":"No Relation","primaryuserid":"62e4e93e-cb40-4b99-b0fb-0500405010a0","secondaryuserid":"00a297e1-1147-49db-8b7e-7708db904067"},{"firstname":"HAILEY","updatedon":"2025-07-16T21:13:32.34507","description":"No Relation","primaryuserid":"f330cf1b-7186-4a40-bc56-9c825b1ee34d","secondaryuserid":"fa22772f-b3a8-4e5a-881b-f35569bffab0"},{"firstname":"HAILEY","updatedon":"2025-07-16T21:13:32.34507","description":"No Relation","primaryuserid":"f330cf1b-7186-4a40-bc56-9c825b1ee34d","secondaryuserid":"00a297e1-1147-49db-8b7e-7708db904067"},{"firstname":"JAMES","updatedon":"2025-07-16T21:13:32.34507","description":"Biological Brother","primaryuserid":"62e4e93e-cb40-4b99-b0fb-0500405010a0","secondaryuserid":"0a7fb98a-16e3-4cea-8ea2-91fc3e242436"},{"firstname":"JAMES","updatedon":"2025-07-16T21:13:32.34507","description":"No Relation","primaryuserid":"62e4e93e-cb40-4b99-b0fb-0500405010a0","secondaryuserid":"4bd29d67-8dcb-49d8-a030-2e3454d11478"},{"firstname":"HAILEY","updatedon":"2025-07-16T21:13:32.34507","description":"Biological Brother","primaryuserid":"f330cf1b-7186-4a40-bc56-9c825b1ee34d","secondaryuserid":"4bd29d67-8dcb-49d8-a030-2e3454d11478"},{"firstname":"HAILEY","updatedon":"2025-07-16T21:13:32.34507","description":"Half Brother","primaryuserid":"f330cf1b-7186-4a40-bc56-9c825b1ee34d","secondaryuserid":"4bd29d67-8dcb-49d8-a030-2e3454d11478"},{"firstname":"JAMES","updatedon":"2025-07-16T21:13:32.34507","description":"Girlfriend-EX","primaryuserid":"62e4e93e-cb40-4b99-b0fb-0500405010a0","secondaryuserid":"5b4a6d9a-30f6-435f-9544-7af2eedabc52"},{"firstname":"JAMES","updatedon":"2025-07-16T21:13:32.34507","description":"No Relation","primaryuserid":"62e4e93e-cb40-4b99-b0fb-0500405010a0","secondaryuserid":"5b4a6d9a-30f6-435f-9544-7af2eedabc52"},{"firstname":"GEOFFREY","updatedon":"2025-07-16T21:13:32.34507","description":"No Relation","primaryuserid":"4bd29d67-8dcb-49d8-a030-2e3454d11478","secondaryuserid":"62e4e93e-cb40-4b99-b0fb-0500405010a0"},{"firstname":"ERICA","updatedon":"2025-07-16T21:13:32.34507","description":"Boyfriend-Ex","primaryuserid":"5b4a6d9a-30f6-435f-9544-7af2eedabc52","secondaryuserid":"62e4e93e-cb40-4b99-b0fb-0500405010a0"},{"firstname":"ERICA","updatedon":"2025-07-16T21:13:32.34507","description":"No Relation","primaryuserid":"5b4a6d9a-30f6-435f-9544-7af2eedabc52","secondaryuserid":"62e4e93e-cb40-4b99-b0fb-0500405010a0"}],"secondarylanguage":null,"alienstatustypekey":null,"citizenalenageflag":null,"haircolorotherdesc":null,"hairtexturetypekey":null,"iveadoptiondetails":null,"medicalinformation":null,"nationalitytypekey":"99","everbeenadoptedflag":0,"iscollateralcontact":0,"secondarylanguageid":null,"verificationremarks":null,"cferesourcehomechild":false,"hairtextureotherdesc":null,"intercountryadoption":0,"maritalstatustypekey":"SG","physicalbuildtypekey":null,"removaldtforcaseplan":null,"alienregistrationtext":"","medicationinformation":null,"seccitizenshiptypekey":"","drugexposednewbornflag":0,"priorlegalguardianship":0,"gapdeterminationdetails":null,"ivedeterminationdetails":null,"activeremovalservicecase":null,"dobtdiffwithincidentdate":6450,"programareabyservicecase":null,"biologicalmothermarriedsw":2,"icwaeligibleformembership":null,"primarycitizenshiptypekey":"","sexoffenderregisteredflag":null,"iveadoptionrejecteddetails":null,"intakeservicerequestactorid":"6b474387-7103-4942-9b6a-7afee82527e8","otherprimarylanguagetypekey":null,"fetalalcoholspctrmdisordflag":null,"preplacementguardianshipdate":null,"probationsearchconductedflag":null,"gaprejecteddeterminationdetails":null,"iverejecteddeterminationdetails":null},{"age":"12 Yrs","dcn":null,"dob":"2014-02-04T05:00:00.000Z","mdm":"Y","ssn":"834299556","city":"Columbia","race":[{"racetypekey":"WH"}],"email":null,"needs":null,"prefx":null,"roles":[{"typedescription":"Child","intakeservicerequestactorid":"1166e6e8-ac3b-44ee-8462-33e73a671a56","intakeservicerequestpersontypekey":"CHILD"}],"state":"MD","county":null,"gender":"Male","height":null,"issafe":1,"suffix":null,"weight":null,"actorid":"0b8f632d-dffd-4b2c-bde4-2ac4e9fc1307","address":"8852 SPIRAL CUT APT D","zipcode":"21045","addendum":null,"address2":"","cjamspid":"4457520","fullname":"GEOFFREY PHILLIP SAMPSON","lastname":"SAMPSON","personid":"4bd29d67-8dcb-49d8-a030-2e3454d11478","religion":null,"reported":null,"rolename":"","aliasname":null,"assistpid":"473052828","dangerous":[{"updatedon":"2025-12-15T12:12:55.842298","dangertoself":2,"isdangertoworker":2}],"emergency":null,"firstname":"GEOFFREY","isalleged":null,"isglasses":false,"refusedob":null,"refusessn":null,"removalid":null,"strengths":null,"userphoto":"","userroles":"Child","workphone":null,"clientflag":1,"ethinicity":"X","fourerelid":1001,"middlename":"PHILLIP","schoolname":null,"totalcount":"8","clienttitle":null,"dateofdeath":null,"incidentage":"11 Yrs","is_mdm_sync":null,"isapproxdod":0,"ishousehold":1,"isplacement":1,"phonenumber":null,"priorscount":null,"programarea":[{"objectid":"6c70ab3a-2571-469c-9fc0-af7a61c82069","programkey":"CPS","programname":"CPS","subprogramkey":"IR","subprogramname":"Investigative Response"}],"racetypekey":null,"removaldate":null,"rolehistory":[],"ageat14years":"2028-02-04T05:00:00.000Z","ageat26years":"2040-02-04T05:00:00.000Z","caseheadname":null,"employername":null,"relationship":"Child","dangeraddress":false,"icwatribename":null,"senstatusflag":null,"servicecaseid":"1980df17-f061-4b78-bfb2-fbd72ad7c593","statustypekey":"ASSGN","cfe_diff_dates":[{"end_dt":"2024-03-31","start_dt":"2021-10-01"}],"eyecolortypekey":null,"hospitaldetails":null,"intakeserviceid":"4a1b7cfa-d955-4d32-94a2-0c7acf5673f5","preadoptiondate":null,"primarylanguage":null,"skintonetypekey":null,"haircolortypekey":null,"isbioadoptedflag":null,"isqualifiedalien":0,"medicalcondition":null,"sennotifications":null,"adoptionremovalid":null,"birthmatchdetails":null,"icwastatusinquiry":"NO","isheadofhousehold":false,"primarylanguageid":"ENG","relationshiparray":[{"firstname":"HAILEY","updatedon":"2026-01-08T16:24:03","description":"Paternal Grandparent","primaryuserid":"f330cf1b-7186-4a40-bc56-9c825b1ee34d","secondaryuserid":"9b1736e0-4bdb-48bc-b11b-b7a076d03d72"},{"firstname":"Monique","updatedon":"2026-01-08T16:23:54","description":"Paternal GrandChild","primaryuserid":"9b1736e0-4bdb-48bc-b11b-b7a076d03d72","secondaryuserid":"f330cf1b-7186-4a40-bc56-9c825b1ee34d"},{"firstname":"ERICA","updatedon":"2025-12-30T09:51:40.391429","description":"No Relation","primaryuserid":"5b4a6d9a-30f6-435f-9544-7af2eedabc52","secondaryuserid":"9b1736e0-4bdb-48bc-b11b-b7a076d03d72"},{"firstname":"GEOFFREY","updatedon":"2025-12-30T09:51:40.391429","description":"Biological Mother","primaryuserid":"4bd29d67-8dcb-49d8-a030-2e3454d11478","secondaryuserid":"5b4a6d9a-30f6-435f-9544-7af2eedabc52"},{"firstname":"Monique","updatedon":"2025-12-30T09:51:40.391429","description":"Paternal GrandChild","primaryuserid":"9b1736e0-4bdb-48bc-b11b-b7a076d03d72","secondaryuserid":"4bd29d67-8dcb-49d8-a030-2e3454d11478"},{"firstname":"GEOFFREY","updatedon":"2025-12-30T09:51:40.391429","description":"Paternal Grandparent","primaryuserid":"4bd29d67-8dcb-49d8-a030-2e3454d11478","secondaryuserid":"9b1736e0-4bdb-48bc-b11b-b7a076d03d72"},{"firstname":"Monique","updatedon":"2025-12-05T14:22:00","description":"No Relation","primaryuserid":"9b1736e0-4bdb-48bc-b11b-b7a076d03d72","secondaryuserid":"5b4a6d9a-30f6-435f-9544-7af2eedabc52"},{"firstname":"HAILEY","updatedon":"2025-12-05T14:19:38","description":"Biological Mother","primaryuserid":"f330cf1b-7186-4a40-bc56-9c825b1ee34d","secondaryuserid":"5b4a6d9a-30f6-435f-9544-7af2eedabc52"},{"firstname":"ERICA","updatedon":"2025-12-05T14:19:30","description":"Biological Child","primaryuserid":"5b4a6d9a-30f6-435f-9544-7af2eedabc52","secondaryuserid":"f330cf1b-7186-4a40-bc56-9c825b1ee34d"},{"firstname":"ERICA","updatedon":"2025-12-05T14:19:00","description":"Biological Child","primaryuserid":"5b4a6d9a-30f6-435f-9544-7af2eedabc52","secondaryuserid":"4bd29d67-8dcb-49d8-a030-2e3454d11478"},{"firstname":"GEOFFREY","updatedon":"2025-12-05T14:18:24","description":"Half Sister","primaryuserid":"4bd29d67-8dcb-49d8-a030-2e3454d11478","secondaryuserid":"f330cf1b-7186-4a40-bc56-9c825b1ee34d"},{"firstname":"HAILEY","updatedon":"2025-07-16T21:13:32.34507","description":"Biological Father","primaryuserid":"f330cf1b-7186-4a40-bc56-9c825b1ee34d","secondaryuserid":"62e4e93e-cb40-4b99-b0fb-0500405010a0"},{"firstname":"JAMES","updatedon":"2025-07-16T21:13:32.34507","description":"Adoptive Parent","primaryuserid":"62e4e93e-cb40-4b99-b0fb-0500405010a0","secondaryuserid":"b200ab57-c889-4036-a823-2bb6ab108035"},{"firstname":"JAMES","updatedon":"2025-07-16T21:13:32.34507","description":"Adoptive Parent","primaryuserid":"62e4e93e-cb40-4b99-b0fb-0500405010a0","secondaryuserid":"ca24abeb-4ab6-4673-a25c-307d8a37dccb"},{"firstname":"GEOFFREY","updatedon":"2025-07-16T21:13:32.34507","description":"Biological Sister","primaryuserid":"4bd29d67-8dcb-49d8-a030-2e3454d11478","secondaryuserid":"f330cf1b-7186-4a40-bc56-9c825b1ee34d"},{"firstname":"JAMES","updatedon":"2025-07-16T21:13:32.34507","description":"Biological Child","primaryuserid":"62e4e93e-cb40-4b99-b0fb-0500405010a0","secondaryuserid":"f330cf1b-7186-4a40-bc56-9c825b1ee34d"},{"firstname":"JAMES","updatedon":"2025-07-16T21:13:32.34507","description":"Neighbor","primaryuserid":"62e4e93e-cb40-4b99-b0fb-0500405010a0","secondaryuserid":"fa22772f-b3a8-4e5a-881b-f35569bffab0"},{"firstname":"JAMES","updatedon":"2025-07-16T21:13:32.34507","description":"No Relation","primaryuserid":"62e4e93e-cb40-4b99-b0fb-0500405010a0","secondaryuserid":"00a297e1-1147-49db-8b7e-7708db904067"},{"firstname":"HAILEY","updatedon":"2025-07-16T21:13:32.34507","description":"No Relation","primaryuserid":"f330cf1b-7186-4a40-bc56-9c825b1ee34d","secondaryuserid":"fa22772f-b3a8-4e5a-881b-f35569bffab0"},{"firstname":"HAILEY","updatedon":"2025-07-16T21:13:32.34507","description":"No Relation","primaryuserid":"f330cf1b-7186-4a40-bc56-9c825b1ee34d","secondaryuserid":"00a297e1-1147-49db-8b7e-7708db904067"},{"firstname":"JAMES","updatedon":"2025-07-16T21:13:32.34507","description":"Biological Brother","primaryuserid":"62e4e93e-cb40-4b99-b0fb-0500405010a0","secondaryuserid":"0a7fb98a-16e3-4cea-8ea2-91fc3e242436"},{"firstname":"JAMES","updatedon":"2025-07-16T21:13:32.34507","description":"No Relation","primaryuserid":"62e4e93e-cb40-4b99-b0fb-0500405010a0","secondaryuserid":"4bd29d67-8dcb-49d8-a030-2e3454d11478"},{"firstname":"HAILEY","updatedon":"2025-07-16T21:13:32.34507","description":"Biological Brother","primaryuserid":"f330cf1b-7186-4a40-bc56-9c825b1ee34d","secondaryuserid":"4bd29d67-8dcb-49d8-a030-2e3454d11478"},{"firstname":"HAILEY","updatedon":"2025-07-16T21:13:32.34507","description":"Half Brother","primaryuserid":"f330cf1b-7186-4a40-bc56-9c825b1ee34d","secondaryuserid":"4bd29d67-8dcb-49d8-a030-2e3454d11478"},{"firstname":"JAMES","updatedon":"2025-07-16T21:13:32.34507","description":"Girlfriend-EX","primaryuserid":"62e4e93e-cb40-4b99-b0fb-0500405010a0","secondaryuserid":"5b4a6d9a-30f6-435f-9544-7af2eedabc52"},{"firstname":"JAMES","updatedon":"2025-07-16T21:13:32.34507","description":"No Relation","primaryuserid":"62e4e93e-cb40-4b99-b0fb-0500405010a0","secondaryuserid":"5b4a6d9a-30f6-435f-9544-7af2eedabc52"},{"firstname":"GEOFFREY","updatedon":"2025-07-16T21:13:32.34507","description":"No Relation","primaryuserid":"4bd29d67-8dcb-49d8-a030-2e3454d11478","secondaryuserid":"62e4e93e-cb40-4b99-b0fb-0500405010a0"},{"firstname":"ERICA","updatedon":"2025-07-16T21:13:32.34507","description":"Boyfriend-Ex","primaryuserid":"5b4a6d9a-30f6-435f-9544-7af2eedabc52","secondaryuserid":"62e4e93e-cb40-4b99-b0fb-0500405010a0"},{"firstname":"ERICA","updatedon":"2025-07-16T21:13:32.34507","description":"No Relation","primaryuserid":"5b4a6d9a-30f6-435f-9544-7af2eedabc52","secondaryuserid":"62e4e93e-cb40-4b99-b0fb-0500405010a0"}],"secondarylanguage":null,"alienstatustypekey":null,"citizenalenageflag":null,"haircolorotherdesc":null,"hairtexturetypekey":null,"iveadoptiondetails":null,"medicalinformation":null,"nationalitytypekey":"99","everbeenadoptedflag":0,"iscollateralcontact":0,"secondarylanguageid":null,"verificationremarks":null,"cferesourcehomechild":false,"hairtextureotherdesc":null,"intercountryadoption":0,"maritalstatustypekey":"SG","physicalbuildtypekey":null,"removaldtforcaseplan":null,"alienregistrationtext":"","medicationinformation":null,"seccitizenshiptypekey":"","drugexposednewbornflag":0,"priorlegalguardianship":0,"gapdeterminationdetails":null,"ivedeterminationdetails":null,"activeremovalservicecase":null,"dobtdiffwithincidentdate":4314,"programareabyservicecase":null,"biologicalmothermarriedsw":2,"icwaeligibleformembership":null,"primarycitizenshiptypekey":"","sexoffenderregisteredflag":null,"iveadoptionrejecteddetails":null,"intakeservicerequestactorid":"1166e6e8-ac3b-44ee-8462-33e73a671a56","otherprimarylanguagetypekey":null,"fetalalcoholspctrmdisordflag":null,"preplacementguardianshipdate":null,"probationsearchconductedflag":null,"gaprejecteddeterminationdetails":null,"iverejecteddeterminationdetails":null}],"serviceplanname":"ALBERT Family Service plan","visitationplans":[],"serviceplancandidacy":{"candidates":[],"candidatestraditional":[]},"versionfilterenddate":"2026-06-12T04:00:00.000Z","approvalstatustypekey":null,"serviceplansignatures":null,"serviceplanvisitation":null,"versionfilterstartdate":"2026-01-08T10:00:00.000Z","serviceplanstatustypekey":null}',  updatedon=now(), updatedby='CJAMS-67454'
where id='96efee1d-e03d-4f4d-aa1f-5055af88c85a' and activeflag=1;

update snapshothist
set snapshotdata= '{
	"status": null,
	"enddate": null,
	"isReady": true,
	"objectid": "1980df17-f061-4b78-bfb2-fbd72ad7c593",
	"splangoal": [
		{
			"status": "In Progress",
			"autoflag": 0,
			"goalname": "The continuity of family relationships and connections is preserved for youth",
			"activeflag": 1,
			"splangoalid": "56130ae3-2b87-4d0c-aac6-0afd7593ab44",
			"serviceplanid": "131e2149-114d-4c31-bd5d-98661b1230c6",
			"splanobjective": [
				{
					"needs": null,
					"status": "In Progress",
					"autoflag": 0,
					"comments": "Hailey isolates herself from her family and although the family is working with FFT she is not willing to particiapte. ",
					"strengths": null,
					"activeflag": 1,
					"splangoalid": "56130ae3-2b87-4d0c-aac6-0afd7593ab44",
					"objectivename": "To work on rebuilding a realtionship with Hailey between all family members ",
					"splanobjectiveid": "e23ad161-017a-4291-ad35-7a6ec4f07dc8",
					"serviceplanaction": [
						{
							"status": "In Progress",
							"enddate": "2026-06-12T12:00:00.000Z",
							"planfor": null,
							"autoflag": null,
							"comments": "Hailey is still attending FFT and needs to continue working on her realtionship with her family. ",
							"plantype": null,
							"startdate": "2026-01-08T10:00:00.000Z",
							"activeflag": 1,
							"goalreason": "",
							"splanobjectiveid": "e23ad161-017a-4291-ad35-7a6ec4f07dc8",
							"personresponsible": "ERICA A ALBERT ,HAILEY HYDE ,GEOFFREY PHILLIP SAMPSON ",
							"serviceplanoutcome": "",
							"serviceplanactionid": "5a3a4c2b-cfe6-472f-8c4c-fff738f35a7c",
							"approvalstatustypekey": null,
							"serviceplanactionname": "All family members continue to participate. ",
							"serviceplanpersoninvolved": [
								{
									"person": {
										"suffix": null,
										"lastname": "SAMPSON",
										"personid": "4bd29d67-8dcb-49d8-a030-2e3454d11478",
										"firstname": "GEOFFREY",
										"activeflag": 1,
										"middlename": "PHILLIP"
									},
									"activeflag": 1,
									"personinvolved": "4bd29d67-8dcb-49d8-a030-2e3454d11478",
									"serviceplanactionid": "5a3a4c2b-cfe6-472f-8c4c-fff738f35a7c",
									"serviceplanpersoninvolvedid": "48641a03-eb2f-47cb-9479-2bf9d9d16bc0"
								},
								{
									"person": {
										"suffix": null,
										"lastname": "HYDE",
										"personid": "f330cf1b-7186-4a40-bc56-9c825b1ee34d",
										"firstname": "HAILEY",
										"activeflag": 1,
										"middlename": ""
									},
									"activeflag": 1,
									"personinvolved": "f330cf1b-7186-4a40-bc56-9c825b1ee34d",
									"serviceplanactionid": "5a3a4c2b-cfe6-472f-8c4c-fff738f35a7c",
									"serviceplanpersoninvolvedid": "4e7dff4a-203d-4f36-ac39-a27eeeb03ef8"
								},
								{
									"person": {
										"suffix": null,
										"lastname": "ALBERT",
										"personid": "5b4a6d9a-30f6-435f-9544-7af2eedabc52",
										"firstname": "ERICA",
										"activeflag": 1,
										"middlename": "A"
									},
									"activeflag": 1,
									"personinvolved": "5b4a6d9a-30f6-435f-9544-7af2eedabc52",
									"serviceplanactionid": "5a3a4c2b-cfe6-472f-8c4c-fff738f35a7c",
									"serviceplanpersoninvolvedid": "5061696b-81fc-46d0-b136-3ece1237eaae"
								}
							]
						}
					],
					"approvalstatustypekey": null
				}
			],
			"approvalstatustypekey": null
		},
		{
			"status": "In Progress",
			"autoflag": null,
			"goalname": "Families have enhanced capacity to provide for their youths needs",
			"activeflag": 1,
			"splangoalid": "62d9f2db-63ac-428b-bd31-8846e31a3af5",
			"serviceplanid": "131e2149-114d-4c31-bd5d-98661b1230c6",
			"splanobjective": [
				{
					"needs": null,
					"status": "In Progress",
					"autoflag": null,
					"comments": "Continue to work on the cleanliness of the home and ensuring there is a clean space and area to cook that does not have any bug rements. And a safe clean space to store food that bugs do not have access to get into. ",
					"strengths": null,
					"activeflag": 1,
					"splangoalid": "62d9f2db-63ac-428b-bd31-8846e31a3af5",
					"objectivename": "Ensure there is a clean cooking enviorment and food for Hailey and Geoffrey ",
					"splanobjectiveid": "48e568f6-3624-403b-a400-3c143472e71a",
					"serviceplanaction": [
						{
							"status": "In Progress",
							"enddate": "2026-06-12T08:00:00.000Z",
							"planfor": null,
							"autoflag": null,
							"comments": "The family will continue to clean out the home and specifically clean the dead roaches from around the kitchen and cooking tools area to ensure that there is no safety risk. And that food is stored in containers/ areas to include the fridge that the roaches can not get too. ",
							"plantype": null,
							"startdate": "2026-01-08T10:00:00.000Z",
							"activeflag": 1,
							"goalreason": null,
							"splanobjectiveid": "48e568f6-3624-403b-a400-3c143472e71a",
							"personresponsible": "ERICA A ALBERT ,HAILEY HYDE ,GEOFFREY PHILLIP SAMPSON ",
							"serviceplanoutcome": null,
							"serviceplanactionid": "3fda14ac-b253-4384-a0dc-50bc95e95fff",
							"approvalstatustypekey": null,
							"serviceplanactionname": "Contiue to clean and clear out any bug (roach) rements from the kitchen after they are dead.  ",
							"serviceplanpersoninvolved": [
								{
									"person": {
										"suffix": null,
										"lastname": "HYDE",
										"personid": "f330cf1b-7186-4a40-bc56-9c825b1ee34d",
										"firstname": "HAILEY",
										"activeflag": 1,
										"middlename": ""
									},
									"activeflag": 1,
									"personinvolved": "f330cf1b-7186-4a40-bc56-9c825b1ee34d",
									"serviceplanactionid": "3fda14ac-b253-4384-a0dc-50bc95e95fff",
									"serviceplanpersoninvolvedid": "857eb44c-1d7e-492b-b92a-622febeeb569"
								},
								{
									"person": {
										"suffix": null,
										"lastname": "ALBERT",
										"personid": "5b4a6d9a-30f6-435f-9544-7af2eedabc52",
										"firstname": "ERICA",
										"activeflag": 1,
										"middlename": "A"
									},
									"activeflag": 1,
									"personinvolved": "5b4a6d9a-30f6-435f-9544-7af2eedabc52",
									"serviceplanactionid": "3fda14ac-b253-4384-a0dc-50bc95e95fff",
									"serviceplanpersoninvolvedid": "b1255d44-d4cb-4d09-bfc2-2bb2752827a5"
								},
								{
									"person": {
										"suffix": null,
										"lastname": "SAMPSON",
										"personid": "4bd29d67-8dcb-49d8-a030-2e3454d11478",
										"firstname": "GEOFFREY",
										"activeflag": 1,
										"middlename": "PHILLIP"
									},
									"activeflag": 1,
									"personinvolved": "4bd29d67-8dcb-49d8-a030-2e3454d11478",
									"serviceplanactionid": "3fda14ac-b253-4384-a0dc-50bc95e95fff",
									"serviceplanpersoninvolvedid": "c24bdd02-4f9b-40e5-9d1d-7a5d644ec987"
								}
							]
						}
					],
					"approvalstatustypekey": null
				}
			],
			"approvalstatustypekey": null
		}
	],
	"updatedon": "04/15/2026 11:54:30",
	"activeflag": 1,
	"insertedon": "04/15/2026 11:32:31",
	"approvaldate": null,
	"numberofdays": null,
	"candidatesObj": {
		"candidates": [],
		"candidatestraditional": []
	},
	"effectivedate": "2026-01-08T10:00:00.000Z",
	"legalGuardian": "ERICA A ALBERT ",
	"objecttypekey": null,
	"serviceplanid": "131e2149-114d-4c31-bd5d-98661b1230c6",
	"targetenddate": "2026-06-12T04:00:00.000Z",
	"childrenHeader": "HAILEY HYDE , GEOFFREY PHILLIP SAMPSON ",
	"involvedpersons": [
		{
			"id": "4457520",
			"ebp": {
				"noadditionalinfo": "YNE",
				"isebpreferralmade": "No"
			},
			"name": "GEOFFREY PHILLIP SAMPSON ",
			"comment": null,
			"disabledit": false,
			"imminentrisks": [
				"NONE"
			],
			"enablelivinginink": null,
			"previousriskreasonids": [],
			"livingininformalkinship": null
		}
	],
	"personsinvolved": [
		{
			"age": "40 Yrs",
			"dcn": null,
			"dob": "1985-07-22T04:00:00.000Z",
			"mdm": "Y",
			"ssn": "219170423",
			"city": "Columbia",
			"race": [
				{
					"racetypekey": "WH"
				}
			],
			"email": null,
			"needs": null,
			"prefx": null,
			"roles": [
				{
					"typedescription": "Parent",
					"intakeservicerequestactorid": "dab550be-d9fb-4340-9e8d-3021798fc90c",
					"intakeservicerequestpersontypekey": "PARENT"
				}
			],
			"state": "MD",
			"county": null,
			"gender": "Female",
			"height": null,
			"issafe": null,
			"suffix": null,
			"weight": null,
			"actorid": "2e736947-4fbf-47f7-ab7f-3bf604395b9f",
			"address": "8852 SPIRAL CUT ",
			"zipcode": "21045",
			"addendum": null,
			"address2": "APT DG18",
			"cjamspid": "4457190",
			"fullname": "ERICA A ALBERT",
			"lastname": "ALBERT",
			"personid": "5b4a6d9a-30f6-435f-9544-7af2eedabc52",
			"religion": null,
			"reported": null,
			"rolename": "",
			"aliasname": null,
			"assistpid": "448038024",
			"dangerous": [
				{
					"updatedon": "2025-12-15T12:12:55.842298",
					"dangertoself": 2,
					"isdangertoworker": 2
				}
			],
			"emergency": null,
			"firstname": "ERICA",
			"isalleged": null,
			"isglasses": false,
			"refusedob": null,
			"refusessn": null,
			"removalid": null,
			"strengths": null,
			"userphoto": "",
			"userroles": "Parent",
			"workphone": "3016625722",
			"clientflag": 1,
			"ethinicity": "X",
			"fourerelid": 1001,
			"middlename": "A",
			"schoolname": null,
			"totalcount": "8",
			"clienttitle": null,
			"dateofdeath": null,
			"incidentage": "40 Yrs",
			"is_mdm_sync": null,
			"isapproxdod": 0,
			"ishousehold": 1,
			"isplacement": 1,
			"phonenumber": "6674479302",
			"priorscount": null,
			"programarea": [
				{
					"objectid": "5e056997-f64a-4aa0-8576-ad0f98398891",
					"programkey": "CPS",
					"programname": "CPS",
					"subprogramkey": "IR",
					"subprogramname": "Investigative Response"
				},
				{
					"objectid": "6c70ab3a-2571-469c-9fc0-af7a61c82069",
					"programkey": "CPS",
					"programname": "CPS",
					"subprogramkey": "IR",
					"subprogramname": "Investigative Response"
				}
			],
			"racetypekey": null,
			"removaldate": null,
			"rolehistory": [
				{
					"comments": "Initial contact caregiver Role is Added",
					"username": "Emmett Woodard",
					"updatedby": "7861919c-a69d-4876-b749-8f488c6fe015",
					"updatedon": "2024-09-19T13:46:11.353705"
				},
				{
					"comments": "Initial contact caregiver Role is Added",
					"username": "Emmett Woodard",
					"updatedby": "7861919c-a69d-4876-b749-8f488c6fe015",
					"updatedon": "2024-07-29T11:34:29.897169"
				},
				{
					"comments": "Initial contact caregiver Role is Added",
					"username": "Angela Singleton",
					"updatedby": "a1c7b418-7b96-4cc8-9a5f-fbbc22d48f01",
					"updatedon": "2024-02-08T09:40:21.65732"
				},
				{
					"comments": "Initial contact caregiver Role is Added",
					"username": "Whitney Daggett",
					"updatedby": "0a1e168e-f60b-4ac1-be97-d816660b50b2",
					"updatedon": "2022-09-08T12:33:46.770728"
				},
				{
					"comments": "Initial contact caregiver Role is Added",
					"username": "Sarah Wise",
					"updatedby": "c0bf846d-fa4e-421f-a33d-4ecb43b09ff7",
					"updatedon": "2022-05-02T15:09:18.40511"
				}
			],
			"ageat14years": "1999-07-22T04:00:00.000Z",
			"ageat26years": "2011-07-22T04:00:00.000Z",
			"caseheadname": null,
			"employername": null,
			"relationship": "Biological Mother",
			"dangeraddress": false,
			"icwatribename": null,
			"senstatusflag": null,
			"servicecaseid": "1980df17-f061-4b78-bfb2-fbd72ad7c593",
			"statustypekey": "ASSGN",
			"cfe_diff_dates": [
				{
					"end_dt": "2024-03-31",
					"start_dt": "2021-10-01"
				}
			],
			"eyecolortypekey": null,
			"hospitaldetails": null,
			"intakeserviceid": "4a1b7cfa-d955-4d32-94a2-0c7acf5673f5",
			"preadoptiondate": null,
			"primarylanguage": null,
			"skintonetypekey": null,
			"haircolortypekey": null,
			"isbioadoptedflag": null,
			"isqualifiedalien": 0,
			"medicalcondition": null,
			"sennotifications": null,
			"adoptionremovalid": null,
			"birthmatchdetails": null,
			"icwastatusinquiry": "NO",
			"isheadofhousehold": true,
			"primarylanguageid": "ENG",
			"relationshiparray": [
				{
					"firstname": "HAILEY",
					"updatedon": "2026-01-08T16:24:03",
					"description": "Paternal Grandparent",
					"primaryuserid": "f330cf1b-7186-4a40-bc56-9c825b1ee34d",
					"secondaryuserid": "9b1736e0-4bdb-48bc-b11b-b7a076d03d72"
				},
				{
					"firstname": "Monique",
					"updatedon": "2026-01-08T16:23:54",
					"description": "Paternal GrandChild",
					"primaryuserid": "9b1736e0-4bdb-48bc-b11b-b7a076d03d72",
					"secondaryuserid": "f330cf1b-7186-4a40-bc56-9c825b1ee34d"
				},
				{
					"firstname": "ERICA",
					"updatedon": "2025-12-30T09:51:40.391429",
					"description": "No Relation",
					"primaryuserid": "5b4a6d9a-30f6-435f-9544-7af2eedabc52",
					"secondaryuserid": "9b1736e0-4bdb-48bc-b11b-b7a076d03d72"
				},
				{
					"firstname": "GEOFFREY",
					"updatedon": "2025-12-30T09:51:40.391429",
					"description": "Biological Mother",
					"primaryuserid": "4bd29d67-8dcb-49d8-a030-2e3454d11478",
					"secondaryuserid": "5b4a6d9a-30f6-435f-9544-7af2eedabc52"
				},
				{
					"firstname": "Monique",
					"updatedon": "2025-12-30T09:51:40.391429",
					"description": "Paternal GrandChild",
					"primaryuserid": "9b1736e0-4bdb-48bc-b11b-b7a076d03d72",
					"secondaryuserid": "4bd29d67-8dcb-49d8-a030-2e3454d11478"
				},
				{
					"firstname": "GEOFFREY",
					"updatedon": "2025-12-30T09:51:40.391429",
					"description": "Paternal Grandparent",
					"primaryuserid": "4bd29d67-8dcb-49d8-a030-2e3454d11478",
					"secondaryuserid": "9b1736e0-4bdb-48bc-b11b-b7a076d03d72"
				},
				{
					"firstname": "Monique",
					"updatedon": "2025-12-05T14:22:00",
					"description": "No Relation",
					"primaryuserid": "9b1736e0-4bdb-48bc-b11b-b7a076d03d72",
					"secondaryuserid": "5b4a6d9a-30f6-435f-9544-7af2eedabc52"
				},
				{
					"firstname": "HAILEY",
					"updatedon": "2025-12-05T14:19:38",
					"description": "Biological Mother",
					"primaryuserid": "f330cf1b-7186-4a40-bc56-9c825b1ee34d",
					"secondaryuserid": "5b4a6d9a-30f6-435f-9544-7af2eedabc52"
				},
				{
					"firstname": "ERICA",
					"updatedon": "2025-12-05T14:19:30",
					"description": "Biological Child",
					"primaryuserid": "5b4a6d9a-30f6-435f-9544-7af2eedabc52",
					"secondaryuserid": "f330cf1b-7186-4a40-bc56-9c825b1ee34d"
				},
				{
					"firstname": "ERICA",
					"updatedon": "2025-12-05T14:19:00",
					"description": "Biological Child",
					"primaryuserid": "5b4a6d9a-30f6-435f-9544-7af2eedabc52",
					"secondaryuserid": "4bd29d67-8dcb-49d8-a030-2e3454d11478"
				},
				{
					"firstname": "GEOFFREY",
					"updatedon": "2025-12-05T14:18:24",
					"description": "Half Sister",
					"primaryuserid": "4bd29d67-8dcb-49d8-a030-2e3454d11478",
					"secondaryuserid": "f330cf1b-7186-4a40-bc56-9c825b1ee34d"
				},
				{
					"firstname": "HAILEY",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "Biological Father",
					"primaryuserid": "f330cf1b-7186-4a40-bc56-9c825b1ee34d",
					"secondaryuserid": "62e4e93e-cb40-4b99-b0fb-0500405010a0"
				},
				{
					"firstname": "JAMES",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "Adoptive Parent",
					"primaryuserid": "62e4e93e-cb40-4b99-b0fb-0500405010a0",
					"secondaryuserid": "b200ab57-c889-4036-a823-2bb6ab108035"
				},
				{
					"firstname": "JAMES",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "Adoptive Parent",
					"primaryuserid": "62e4e93e-cb40-4b99-b0fb-0500405010a0",
					"secondaryuserid": "ca24abeb-4ab6-4673-a25c-307d8a37dccb"
				},
				{
					"firstname": "GEOFFREY",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "Biological Sister",
					"primaryuserid": "4bd29d67-8dcb-49d8-a030-2e3454d11478",
					"secondaryuserid": "f330cf1b-7186-4a40-bc56-9c825b1ee34d"
				},
				{
					"firstname": "JAMES",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "Biological Child",
					"primaryuserid": "62e4e93e-cb40-4b99-b0fb-0500405010a0",
					"secondaryuserid": "f330cf1b-7186-4a40-bc56-9c825b1ee34d"
				},
				{
					"firstname": "JAMES",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "Neighbor",
					"primaryuserid": "62e4e93e-cb40-4b99-b0fb-0500405010a0",
					"secondaryuserid": "fa22772f-b3a8-4e5a-881b-f35569bffab0"
				},
				{
					"firstname": "JAMES",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "No Relation",
					"primaryuserid": "62e4e93e-cb40-4b99-b0fb-0500405010a0",
					"secondaryuserid": "00a297e1-1147-49db-8b7e-7708db904067"
				},
				{
					"firstname": "HAILEY",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "No Relation",
					"primaryuserid": "f330cf1b-7186-4a40-bc56-9c825b1ee34d",
					"secondaryuserid": "fa22772f-b3a8-4e5a-881b-f35569bffab0"
				},
				{
					"firstname": "HAILEY",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "No Relation",
					"primaryuserid": "f330cf1b-7186-4a40-bc56-9c825b1ee34d",
					"secondaryuserid": "00a297e1-1147-49db-8b7e-7708db904067"
				},
				{
					"firstname": "JAMES",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "Biological Brother",
					"primaryuserid": "62e4e93e-cb40-4b99-b0fb-0500405010a0",
					"secondaryuserid": "0a7fb98a-16e3-4cea-8ea2-91fc3e242436"
				},
				{
					"firstname": "JAMES",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "No Relation",
					"primaryuserid": "62e4e93e-cb40-4b99-b0fb-0500405010a0",
					"secondaryuserid": "4bd29d67-8dcb-49d8-a030-2e3454d11478"
				},
				{
					"firstname": "HAILEY",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "Biological Brother",
					"primaryuserid": "f330cf1b-7186-4a40-bc56-9c825b1ee34d",
					"secondaryuserid": "4bd29d67-8dcb-49d8-a030-2e3454d11478"
				},
				{
					"firstname": "HAILEY",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "Half Brother",
					"primaryuserid": "f330cf1b-7186-4a40-bc56-9c825b1ee34d",
					"secondaryuserid": "4bd29d67-8dcb-49d8-a030-2e3454d11478"
				},
				{
					"firstname": "JAMES",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "Girlfriend-EX",
					"primaryuserid": "62e4e93e-cb40-4b99-b0fb-0500405010a0",
					"secondaryuserid": "5b4a6d9a-30f6-435f-9544-7af2eedabc52"
				},
				{
					"firstname": "JAMES",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "No Relation",
					"primaryuserid": "62e4e93e-cb40-4b99-b0fb-0500405010a0",
					"secondaryuserid": "5b4a6d9a-30f6-435f-9544-7af2eedabc52"
				},
				{
					"firstname": "GEOFFREY",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "No Relation",
					"primaryuserid": "4bd29d67-8dcb-49d8-a030-2e3454d11478",
					"secondaryuserid": "62e4e93e-cb40-4b99-b0fb-0500405010a0"
				},
				{
					"firstname": "ERICA",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "Boyfriend-Ex",
					"primaryuserid": "5b4a6d9a-30f6-435f-9544-7af2eedabc52",
					"secondaryuserid": "62e4e93e-cb40-4b99-b0fb-0500405010a0"
				},
				{
					"firstname": "ERICA",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "No Relation",
					"primaryuserid": "5b4a6d9a-30f6-435f-9544-7af2eedabc52",
					"secondaryuserid": "62e4e93e-cb40-4b99-b0fb-0500405010a0"
				}
			],
			"secondarylanguage": null,
			"alienstatustypekey": null,
			"citizenalenageflag": null,
			"haircolorotherdesc": null,
			"hairtexturetypekey": null,
			"iveadoptiondetails": null,
			"medicalinformation": null,
			"nationalitytypekey": "99",
			"everbeenadoptedflag": null,
			"iscollateralcontact": 0,
			"secondarylanguageid": null,
			"verificationremarks": null,
			"cferesourcehomechild": false,
			"hairtextureotherdesc": null,
			"intercountryadoption": null,
			"maritalstatustypekey": "SG",
			"physicalbuildtypekey": null,
			"removaldtforcaseplan": null,
			"alienregistrationtext": "",
			"medicationinformation": null,
			"seccitizenshiptypekey": "",
			"drugexposednewbornflag": 0,
			"priorlegalguardianship": null,
			"gapdeterminationdetails": null,
			"ivedeterminationdetails": null,
			"activeremovalservicecase": null,
			"dobtdiffwithincidentdate": 14738,
			"programareabyservicecase": null,
			"biologicalmothermarriedsw": 0,
			"icwaeligibleformembership": null,
			"primarycitizenshiptypekey": "",
			"sexoffenderregisteredflag": null,
			"iveadoptionrejecteddetails": null,
			"intakeservicerequestactorid": "dab550be-d9fb-4340-9e8d-3021798fc90c",
			"otherprimarylanguagetypekey": null,
			"fetalalcoholspctrmdisordflag": null,
			"preplacementguardianshipdate": null,
			"probationsearchconductedflag": null,
			"gaprejecteddeterminationdetails": null,
			"iverejecteddeterminationdetails": null
		},
		{
			"age": "18 Yrs",
			"dcn": null,
			"dob": "2008-03-31T04:00:00.000Z",
			"mdm": "Y",
			"ssn": "771707000",
			"city": "Columbia",
			"race": [
				{
					"racetypekey": "WH"
				}
			],
			"email": null,
			"needs": null,
			"prefx": null,
			"roles": [
				{
					"typedescription": "Alleged Victim",
					"intakeservicerequestactorid": "a640fae3-b7d8-4e2a-981f-b440a6eba6aa",
					"intakeservicerequestpersontypekey": "AV"
				},
				{
					"typedescription": "Child",
					"intakeservicerequestactorid": "6b474387-7103-4942-9b6a-7afee82527e8",
					"intakeservicerequestpersontypekey": "CHILD"
				}
			],
			"state": "MD",
			"county": null,
			"gender": "Female",
			"height": null,
			"issafe": 1,
			"suffix": null,
			"weight": null,
			"actorid": "31e3946c-98a8-4326-996f-260cd814ebe5",
			"address": "8852 SPIRAL CUT ",
			"zipcode": "21045",
			"addendum": null,
			"address2": "APT D",
			"cjamspid": "4457191",
			"fullname": "HAILEY  HYDE",
			"lastname": "HYDE",
			"personid": "f330cf1b-7186-4a40-bc56-9c825b1ee34d",
			"religion": null,
			"reported": null,
			"rolename": "",
			"aliasname": null,
			"assistpid": "448038025",
			"dangerous": [
				{
					"updatedon": "2025-12-15T12:12:55.842298",
					"dangertoself": 2,
					"isdangertoworker": 2
				}
			],
			"emergency": null,
			"firstname": "HAILEY",
			"isalleged": null,
			"isglasses": false,
			"refusedob": null,
			"refusessn": null,
			"removalid": null,
			"strengths": null,
			"userphoto": "",
			"userroles": "Alleged Victim, Child",
			"workphone": null,
			"clientflag": 1,
			"ethinicity": "X",
			"fourerelid": 1001,
			"middlename": "",
			"schoolname": null,
			"totalcount": "8",
			"clienttitle": null,
			"dateofdeath": null,
			"incidentage": "17 Yrs",
			"is_mdm_sync": null,
			"isapproxdod": 0,
			"ishousehold": 1,
			"isplacement": 1,
			"phonenumber": null,
			"priorscount": null,
			"programarea": null,
			"racetypekey": null,
			"removaldate": null,
			"rolehistory": [],
			"ageat14years": "2022-03-31T04:00:00.000Z",
			"ageat26years": "2034-03-31T04:00:00.000Z",
			"caseheadname": null,
			"employername": null,
			"relationship": "Biological Brother",
			"dangeraddress": null,
			"icwatribename": null,
			"senstatusflag": null,
			"servicecaseid": "1980df17-f061-4b78-bfb2-fbd72ad7c593",
			"statustypekey": "ASSGN",
			"cfe_diff_dates": [
				{
					"end_dt": "2024-03-31",
					"start_dt": "2021-10-01"
				}
			],
			"eyecolortypekey": null,
			"hospitaldetails": null,
			"intakeserviceid": "4a1b7cfa-d955-4d32-94a2-0c7acf5673f5",
			"preadoptiondate": null,
			"primarylanguage": null,
			"skintonetypekey": null,
			"haircolortypekey": null,
			"isbioadoptedflag": null,
			"isqualifiedalien": 0,
			"medicalcondition": null,
			"sennotifications": null,
			"adoptionremovalid": null,
			"birthmatchdetails": null,
			"icwastatusinquiry": "NO",
			"isheadofhousehold": false,
			"primarylanguageid": "ENG",
			"relationshiparray": [
				{
					"firstname": "HAILEY",
					"updatedon": "2026-01-08T16:24:03",
					"description": "Paternal Grandparent",
					"primaryuserid": "f330cf1b-7186-4a40-bc56-9c825b1ee34d",
					"secondaryuserid": "9b1736e0-4bdb-48bc-b11b-b7a076d03d72"
				},
				{
					"firstname": "Monique",
					"updatedon": "2026-01-08T16:23:54",
					"description": "Paternal GrandChild",
					"primaryuserid": "9b1736e0-4bdb-48bc-b11b-b7a076d03d72",
					"secondaryuserid": "f330cf1b-7186-4a40-bc56-9c825b1ee34d"
				},
				{
					"firstname": "ERICA",
					"updatedon": "2025-12-30T09:51:40.391429",
					"description": "No Relation",
					"primaryuserid": "5b4a6d9a-30f6-435f-9544-7af2eedabc52",
					"secondaryuserid": "9b1736e0-4bdb-48bc-b11b-b7a076d03d72"
				},
				{
					"firstname": "GEOFFREY",
					"updatedon": "2025-12-30T09:51:40.391429",
					"description": "Biological Mother",
					"primaryuserid": "4bd29d67-8dcb-49d8-a030-2e3454d11478",
					"secondaryuserid": "5b4a6d9a-30f6-435f-9544-7af2eedabc52"
				},
				{
					"firstname": "Monique",
					"updatedon": "2025-12-30T09:51:40.391429",
					"description": "Paternal GrandChild",
					"primaryuserid": "9b1736e0-4bdb-48bc-b11b-b7a076d03d72",
					"secondaryuserid": "4bd29d67-8dcb-49d8-a030-2e3454d11478"
				},
				{
					"firstname": "GEOFFREY",
					"updatedon": "2025-12-30T09:51:40.391429",
					"description": "Paternal Grandparent",
					"primaryuserid": "4bd29d67-8dcb-49d8-a030-2e3454d11478",
					"secondaryuserid": "9b1736e0-4bdb-48bc-b11b-b7a076d03d72"
				},
				{
					"firstname": "Monique",
					"updatedon": "2025-12-05T14:22:00",
					"description": "No Relation",
					"primaryuserid": "9b1736e0-4bdb-48bc-b11b-b7a076d03d72",
					"secondaryuserid": "5b4a6d9a-30f6-435f-9544-7af2eedabc52"
				},
				{
					"firstname": "HAILEY",
					"updatedon": "2025-12-05T14:19:38",
					"description": "Biological Mother",
					"primaryuserid": "f330cf1b-7186-4a40-bc56-9c825b1ee34d",
					"secondaryuserid": "5b4a6d9a-30f6-435f-9544-7af2eedabc52"
				},
				{
					"firstname": "ERICA",
					"updatedon": "2025-12-05T14:19:30",
					"description": "Biological Child",
					"primaryuserid": "5b4a6d9a-30f6-435f-9544-7af2eedabc52",
					"secondaryuserid": "f330cf1b-7186-4a40-bc56-9c825b1ee34d"
				},
				{
					"firstname": "ERICA",
					"updatedon": "2025-12-05T14:19:00",
					"description": "Biological Child",
					"primaryuserid": "5b4a6d9a-30f6-435f-9544-7af2eedabc52",
					"secondaryuserid": "4bd29d67-8dcb-49d8-a030-2e3454d11478"
				},
				{
					"firstname": "GEOFFREY",
					"updatedon": "2025-12-05T14:18:24",
					"description": "Half Sister",
					"primaryuserid": "4bd29d67-8dcb-49d8-a030-2e3454d11478",
					"secondaryuserid": "f330cf1b-7186-4a40-bc56-9c825b1ee34d"
				},
				{
					"firstname": "HAILEY",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "Biological Father",
					"primaryuserid": "f330cf1b-7186-4a40-bc56-9c825b1ee34d",
					"secondaryuserid": "62e4e93e-cb40-4b99-b0fb-0500405010a0"
				},
				{
					"firstname": "JAMES",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "Adoptive Parent",
					"primaryuserid": "62e4e93e-cb40-4b99-b0fb-0500405010a0",
					"secondaryuserid": "b200ab57-c889-4036-a823-2bb6ab108035"
				},
				{
					"firstname": "JAMES",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "Adoptive Parent",
					"primaryuserid": "62e4e93e-cb40-4b99-b0fb-0500405010a0",
					"secondaryuserid": "ca24abeb-4ab6-4673-a25c-307d8a37dccb"
				},
				{
					"firstname": "GEOFFREY",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "Biological Sister",
					"primaryuserid": "4bd29d67-8dcb-49d8-a030-2e3454d11478",
					"secondaryuserid": "f330cf1b-7186-4a40-bc56-9c825b1ee34d"
				},
				{
					"firstname": "JAMES",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "Biological Child",
					"primaryuserid": "62e4e93e-cb40-4b99-b0fb-0500405010a0",
					"secondaryuserid": "f330cf1b-7186-4a40-bc56-9c825b1ee34d"
				},
				{
					"firstname": "JAMES",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "Neighbor",
					"primaryuserid": "62e4e93e-cb40-4b99-b0fb-0500405010a0",
					"secondaryuserid": "fa22772f-b3a8-4e5a-881b-f35569bffab0"
				},
				{
					"firstname": "JAMES",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "No Relation",
					"primaryuserid": "62e4e93e-cb40-4b99-b0fb-0500405010a0",
					"secondaryuserid": "00a297e1-1147-49db-8b7e-7708db904067"
				},
				{
					"firstname": "HAILEY",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "No Relation",
					"primaryuserid": "f330cf1b-7186-4a40-bc56-9c825b1ee34d",
					"secondaryuserid": "fa22772f-b3a8-4e5a-881b-f35569bffab0"
				},
				{
					"firstname": "HAILEY",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "No Relation",
					"primaryuserid": "f330cf1b-7186-4a40-bc56-9c825b1ee34d",
					"secondaryuserid": "00a297e1-1147-49db-8b7e-7708db904067"
				},
				{
					"firstname": "JAMES",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "Biological Brother",
					"primaryuserid": "62e4e93e-cb40-4b99-b0fb-0500405010a0",
					"secondaryuserid": "0a7fb98a-16e3-4cea-8ea2-91fc3e242436"
				},
				{
					"firstname": "JAMES",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "No Relation",
					"primaryuserid": "62e4e93e-cb40-4b99-b0fb-0500405010a0",
					"secondaryuserid": "4bd29d67-8dcb-49d8-a030-2e3454d11478"
				},
				{
					"firstname": "HAILEY",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "Biological Brother",
					"primaryuserid": "f330cf1b-7186-4a40-bc56-9c825b1ee34d",
					"secondaryuserid": "4bd29d67-8dcb-49d8-a030-2e3454d11478"
				},
				{
					"firstname": "HAILEY",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "Half Brother",
					"primaryuserid": "f330cf1b-7186-4a40-bc56-9c825b1ee34d",
					"secondaryuserid": "4bd29d67-8dcb-49d8-a030-2e3454d11478"
				},
				{
					"firstname": "JAMES",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "Girlfriend-EX",
					"primaryuserid": "62e4e93e-cb40-4b99-b0fb-0500405010a0",
					"secondaryuserid": "5b4a6d9a-30f6-435f-9544-7af2eedabc52"
				},
				{
					"firstname": "JAMES",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "No Relation",
					"primaryuserid": "62e4e93e-cb40-4b99-b0fb-0500405010a0",
					"secondaryuserid": "5b4a6d9a-30f6-435f-9544-7af2eedabc52"
				},
				{
					"firstname": "GEOFFREY",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "No Relation",
					"primaryuserid": "4bd29d67-8dcb-49d8-a030-2e3454d11478",
					"secondaryuserid": "62e4e93e-cb40-4b99-b0fb-0500405010a0"
				},
				{
					"firstname": "ERICA",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "Boyfriend-Ex",
					"primaryuserid": "5b4a6d9a-30f6-435f-9544-7af2eedabc52",
					"secondaryuserid": "62e4e93e-cb40-4b99-b0fb-0500405010a0"
				},
				{
					"firstname": "ERICA",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "No Relation",
					"primaryuserid": "5b4a6d9a-30f6-435f-9544-7af2eedabc52",
					"secondaryuserid": "62e4e93e-cb40-4b99-b0fb-0500405010a0"
				}
			],
			"secondarylanguage": null,
			"alienstatustypekey": null,
			"citizenalenageflag": null,
			"haircolorotherdesc": null,
			"hairtexturetypekey": null,
			"iveadoptiondetails": null,
			"medicalinformation": null,
			"nationalitytypekey": "99",
			"everbeenadoptedflag": 0,
			"iscollateralcontact": 0,
			"secondarylanguageid": null,
			"verificationremarks": null,
			"cferesourcehomechild": false,
			"hairtextureotherdesc": null,
			"intercountryadoption": 0,
			"maritalstatustypekey": "SG",
			"physicalbuildtypekey": null,
			"removaldtforcaseplan": null,
			"alienregistrationtext": "",
			"medicationinformation": null,
			"seccitizenshiptypekey": "",
			"drugexposednewbornflag": 0,
			"priorlegalguardianship": 0,
			"gapdeterminationdetails": null,
			"ivedeterminationdetails": null,
			"activeremovalservicecase": null,
			"dobtdiffwithincidentdate": 6450,
			"programareabyservicecase": null,
			"biologicalmothermarriedsw": 2,
			"icwaeligibleformembership": null,
			"primarycitizenshiptypekey": "",
			"sexoffenderregisteredflag": null,
			"iveadoptionrejecteddetails": null,
			"intakeservicerequestactorid": "6b474387-7103-4942-9b6a-7afee82527e8",
			"otherprimarylanguagetypekey": null,
			"fetalalcoholspctrmdisordflag": null,
			"preplacementguardianshipdate": null,
			"probationsearchconductedflag": null,
			"gaprejecteddeterminationdetails": null,
			"iverejecteddeterminationdetails": null
		},
		{
			"age": "12 Yrs",
			"dcn": null,
			"dob": "2014-02-04T05:00:00.000Z",
			"mdm": "Y",
			"ssn": "834299556",
			"city": "Columbia",
			"race": [
				{
					"racetypekey": "WH"
				}
			],
			"email": null,
			"needs": null,
			"prefx": null,
			"roles": [
				{
					"typedescription": "Child",
					"intakeservicerequestactorid": "1166e6e8-ac3b-44ee-8462-33e73a671a56",
					"intakeservicerequestpersontypekey": "CHILD"
				}
			],
			"state": "MD",
			"county": null,
			"gender": "Male",
			"height": null,
			"issafe": 1,
			"suffix": null,
			"weight": null,
			"actorid": "0b8f632d-dffd-4b2c-bde4-2ac4e9fc1307",
			"address": "8852 SPIRAL CUT APT D",
			"zipcode": "21045",
			"addendum": null,
			"address2": "",
			"cjamspid": "4457520",
			"fullname": "GEOFFREY PHILLIP SAMPSON",
			"lastname": "SAMPSON",
			"personid": "4bd29d67-8dcb-49d8-a030-2e3454d11478",
			"religion": null,
			"reported": null,
			"rolename": "",
			"aliasname": null,
			"assistpid": "473052828",
			"dangerous": [
				{
					"updatedon": "2025-12-15T12:12:55.842298",
					"dangertoself": 2,
					"isdangertoworker": 2
				}
			],
			"emergency": null,
			"firstname": "GEOFFREY",
			"isalleged": null,
			"isglasses": false,
			"refusedob": null,
			"refusessn": null,
			"removalid": null,
			"strengths": null,
			"userphoto": "",
			"userroles": "Child",
			"workphone": null,
			"clientflag": 1,
			"ethinicity": "X",
			"fourerelid": 1001,
			"middlename": "PHILLIP",
			"schoolname": null,
			"totalcount": "8",
			"clienttitle": null,
			"dateofdeath": null,
			"incidentage": "11 Yrs",
			"is_mdm_sync": null,
			"isapproxdod": 0,
			"ishousehold": 1,
			"isplacement": 1,
			"phonenumber": null,
			"priorscount": null,
			"programarea": [
				{
					"objectid": "6c70ab3a-2571-469c-9fc0-af7a61c82069",
					"programkey": "CPS",
					"programname": "CPS",
					"subprogramkey": "IR",
					"subprogramname": "Investigative Response"
				}
			],
			"racetypekey": null,
			"removaldate": null,
			"rolehistory": [],
			"ageat14years": "2028-02-04T05:00:00.000Z",
			"ageat26years": "2040-02-04T05:00:00.000Z",
			"caseheadname": null,
			"employername": null,
			"relationship": "Child",
			"dangeraddress": false,
			"icwatribename": null,
			"senstatusflag": null,
			"servicecaseid": "1980df17-f061-4b78-bfb2-fbd72ad7c593",
			"statustypekey": "ASSGN",
			"cfe_diff_dates": [
				{
					"end_dt": "2024-03-31",
					"start_dt": "2021-10-01"
				}
			],
			"eyecolortypekey": null,
			"hospitaldetails": null,
			"intakeserviceid": "4a1b7cfa-d955-4d32-94a2-0c7acf5673f5",
			"preadoptiondate": null,
			"primarylanguage": null,
			"skintonetypekey": null,
			"haircolortypekey": null,
			"isbioadoptedflag": null,
			"isqualifiedalien": 0,
			"medicalcondition": null,
			"sennotifications": null,
			"adoptionremovalid": null,
			"birthmatchdetails": null,
			"icwastatusinquiry": "NO",
			"isheadofhousehold": false,
			"primarylanguageid": "ENG",
			"relationshiparray": [
				{
					"firstname": "HAILEY",
					"updatedon": "2026-01-08T16:24:03",
					"description": "Paternal Grandparent",
					"primaryuserid": "f330cf1b-7186-4a40-bc56-9c825b1ee34d",
					"secondaryuserid": "9b1736e0-4bdb-48bc-b11b-b7a076d03d72"
				},
				{
					"firstname": "Monique",
					"updatedon": "2026-01-08T16:23:54",
					"description": "Paternal GrandChild",
					"primaryuserid": "9b1736e0-4bdb-48bc-b11b-b7a076d03d72",
					"secondaryuserid": "f330cf1b-7186-4a40-bc56-9c825b1ee34d"
				},
				{
					"firstname": "ERICA",
					"updatedon": "2025-12-30T09:51:40.391429",
					"description": "No Relation",
					"primaryuserid": "5b4a6d9a-30f6-435f-9544-7af2eedabc52",
					"secondaryuserid": "9b1736e0-4bdb-48bc-b11b-b7a076d03d72"
				},
				{
					"firstname": "GEOFFREY",
					"updatedon": "2025-12-30T09:51:40.391429",
					"description": "Biological Mother",
					"primaryuserid": "4bd29d67-8dcb-49d8-a030-2e3454d11478",
					"secondaryuserid": "5b4a6d9a-30f6-435f-9544-7af2eedabc52"
				},
				{
					"firstname": "Monique",
					"updatedon": "2025-12-30T09:51:40.391429",
					"description": "Paternal GrandChild",
					"primaryuserid": "9b1736e0-4bdb-48bc-b11b-b7a076d03d72",
					"secondaryuserid": "4bd29d67-8dcb-49d8-a030-2e3454d11478"
				},
				{
					"firstname": "GEOFFREY",
					"updatedon": "2025-12-30T09:51:40.391429",
					"description": "Paternal Grandparent",
					"primaryuserid": "4bd29d67-8dcb-49d8-a030-2e3454d11478",
					"secondaryuserid": "9b1736e0-4bdb-48bc-b11b-b7a076d03d72"
				},
				{
					"firstname": "Monique",
					"updatedon": "2025-12-05T14:22:00",
					"description": "No Relation",
					"primaryuserid": "9b1736e0-4bdb-48bc-b11b-b7a076d03d72",
					"secondaryuserid": "5b4a6d9a-30f6-435f-9544-7af2eedabc52"
				},
				{
					"firstname": "HAILEY",
					"updatedon": "2025-12-05T14:19:38",
					"description": "Biological Mother",
					"primaryuserid": "f330cf1b-7186-4a40-bc56-9c825b1ee34d",
					"secondaryuserid": "5b4a6d9a-30f6-435f-9544-7af2eedabc52"
				},
				{
					"firstname": "ERICA",
					"updatedon": "2025-12-05T14:19:30",
					"description": "Biological Child",
					"primaryuserid": "5b4a6d9a-30f6-435f-9544-7af2eedabc52",
					"secondaryuserid": "f330cf1b-7186-4a40-bc56-9c825b1ee34d"
				},
				{
					"firstname": "ERICA",
					"updatedon": "2025-12-05T14:19:00",
					"description": "Biological Child",
					"primaryuserid": "5b4a6d9a-30f6-435f-9544-7af2eedabc52",
					"secondaryuserid": "4bd29d67-8dcb-49d8-a030-2e3454d11478"
				},
				{
					"firstname": "GEOFFREY",
					"updatedon": "2025-12-05T14:18:24",
					"description": "Half Sister",
					"primaryuserid": "4bd29d67-8dcb-49d8-a030-2e3454d11478",
					"secondaryuserid": "f330cf1b-7186-4a40-bc56-9c825b1ee34d"
				},
				{
					"firstname": "HAILEY",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "Biological Father",
					"primaryuserid": "f330cf1b-7186-4a40-bc56-9c825b1ee34d",
					"secondaryuserid": "62e4e93e-cb40-4b99-b0fb-0500405010a0"
				},
				{
					"firstname": "JAMES",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "Adoptive Parent",
					"primaryuserid": "62e4e93e-cb40-4b99-b0fb-0500405010a0",
					"secondaryuserid": "b200ab57-c889-4036-a823-2bb6ab108035"
				},
				{
					"firstname": "JAMES",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "Adoptive Parent",
					"primaryuserid": "62e4e93e-cb40-4b99-b0fb-0500405010a0",
					"secondaryuserid": "ca24abeb-4ab6-4673-a25c-307d8a37dccb"
				},
				{
					"firstname": "GEOFFREY",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "Biological Sister",
					"primaryuserid": "4bd29d67-8dcb-49d8-a030-2e3454d11478",
					"secondaryuserid": "f330cf1b-7186-4a40-bc56-9c825b1ee34d"
				},
				{
					"firstname": "JAMES",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "Biological Child",
					"primaryuserid": "62e4e93e-cb40-4b99-b0fb-0500405010a0",
					"secondaryuserid": "f330cf1b-7186-4a40-bc56-9c825b1ee34d"
				},
				{
					"firstname": "JAMES",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "Neighbor",
					"primaryuserid": "62e4e93e-cb40-4b99-b0fb-0500405010a0",
					"secondaryuserid": "fa22772f-b3a8-4e5a-881b-f35569bffab0"
				},
				{
					"firstname": "JAMES",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "No Relation",
					"primaryuserid": "62e4e93e-cb40-4b99-b0fb-0500405010a0",
					"secondaryuserid": "00a297e1-1147-49db-8b7e-7708db904067"
				},
				{
					"firstname": "HAILEY",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "No Relation",
					"primaryuserid": "f330cf1b-7186-4a40-bc56-9c825b1ee34d",
					"secondaryuserid": "fa22772f-b3a8-4e5a-881b-f35569bffab0"
				},
				{
					"firstname": "HAILEY",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "No Relation",
					"primaryuserid": "f330cf1b-7186-4a40-bc56-9c825b1ee34d",
					"secondaryuserid": "00a297e1-1147-49db-8b7e-7708db904067"
				},
				{
					"firstname": "JAMES",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "Biological Brother",
					"primaryuserid": "62e4e93e-cb40-4b99-b0fb-0500405010a0",
					"secondaryuserid": "0a7fb98a-16e3-4cea-8ea2-91fc3e242436"
				},
				{
					"firstname": "JAMES",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "No Relation",
					"primaryuserid": "62e4e93e-cb40-4b99-b0fb-0500405010a0",
					"secondaryuserid": "4bd29d67-8dcb-49d8-a030-2e3454d11478"
				},
				{
					"firstname": "HAILEY",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "Biological Brother",
					"primaryuserid": "f330cf1b-7186-4a40-bc56-9c825b1ee34d",
					"secondaryuserid": "4bd29d67-8dcb-49d8-a030-2e3454d11478"
				},
				{
					"firstname": "HAILEY",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "Half Brother",
					"primaryuserid": "f330cf1b-7186-4a40-bc56-9c825b1ee34d",
					"secondaryuserid": "4bd29d67-8dcb-49d8-a030-2e3454d11478"
				},
				{
					"firstname": "JAMES",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "Girlfriend-EX",
					"primaryuserid": "62e4e93e-cb40-4b99-b0fb-0500405010a0",
					"secondaryuserid": "5b4a6d9a-30f6-435f-9544-7af2eedabc52"
				},
				{
					"firstname": "JAMES",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "No Relation",
					"primaryuserid": "62e4e93e-cb40-4b99-b0fb-0500405010a0",
					"secondaryuserid": "5b4a6d9a-30f6-435f-9544-7af2eedabc52"
				},
				{
					"firstname": "GEOFFREY",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "No Relation",
					"primaryuserid": "4bd29d67-8dcb-49d8-a030-2e3454d11478",
					"secondaryuserid": "62e4e93e-cb40-4b99-b0fb-0500405010a0"
				},
				{
					"firstname": "ERICA",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "Boyfriend-Ex",
					"primaryuserid": "5b4a6d9a-30f6-435f-9544-7af2eedabc52",
					"secondaryuserid": "62e4e93e-cb40-4b99-b0fb-0500405010a0"
				},
				{
					"firstname": "ERICA",
					"updatedon": "2025-07-16T21:13:32.34507",
					"description": "No Relation",
					"primaryuserid": "5b4a6d9a-30f6-435f-9544-7af2eedabc52",
					"secondaryuserid": "62e4e93e-cb40-4b99-b0fb-0500405010a0"
				}
			],
			"secondarylanguage": null,
			"alienstatustypekey": null,
			"citizenalenageflag": null,
			"haircolorotherdesc": null,
			"hairtexturetypekey": null,
			"iveadoptiondetails": null,
			"medicalinformation": null,
			"nationalitytypekey": "99",
			"everbeenadoptedflag": 0,
			"iscollateralcontact": 0,
			"secondarylanguageid": null,
			"verificationremarks": null,
			"cferesourcehomechild": false,
			"hairtextureotherdesc": null,
			"intercountryadoption": 0,
			"maritalstatustypekey": "SG",
			"physicalbuildtypekey": null,
			"removaldtforcaseplan": null,
			"alienregistrationtext": "",
			"medicationinformation": null,
			"seccitizenshiptypekey": "",
			"drugexposednewbornflag": 0,
			"priorlegalguardianship": 0,
			"gapdeterminationdetails": null,
			"ivedeterminationdetails": null,
			"activeremovalservicecase": null,
			"dobtdiffwithincidentdate": 4314,
			"programareabyservicecase": null,
			"biologicalmothermarriedsw": 2,
			"icwaeligibleformembership": null,
			"primarycitizenshiptypekey": "",
			"sexoffenderregisteredflag": null,
			"iveadoptionrejecteddetails": null,
			"intakeservicerequestactorid": "1166e6e8-ac3b-44ee-8462-33e73a671a56",
			"otherprimarylanguagetypekey": null,
			"fetalalcoholspctrmdisordflag": null,
			"preplacementguardianshipdate": null,
			"probationsearchconductedflag": null,
			"gaprejecteddeterminationdetails": null,
			"iverejecteddeterminationdetails": null
		}
	],
	"serviceplanname": "ALBERT Family Service plan",
	"visitationplans": [],
	"serviceplancandidacy": {
		"candidates": [],
		"candidatestraditional": []
	},
	"versionfilterenddate": "2026-06-12T04:00:00.000Z",
	"approvalstatustypekey": null,
	"serviceplansignatures": null,
	"serviceplanvisitation": null,
	"versionfilterstartdate": "2026-01-08T10:00:00.000Z",
	"serviceplanstatustypekey": null
}',  updatedon=now(), updatedby='CJAMS-67454'
where id='fb6bd561-0107-4b23-adc5-c49dddcecc78' and activeflag=1;
