/*
Issue: CJAMS-59267 
251022988353:The alleged maltreator's name and DOB is incorrect. The alleged maltreator is Da'Shown Rawl; DOB 7/17/94.

Category/Module: Person profile
Root cause: The alleged maltreator's name and DOB is incorrect. The alleged maltreator is Da'Shown Rawl; DOB 7/17/94..
Fix provided:  Data fix has been done to update the person DOB & First name as requested
Data/Code fix ticket#: CJAMS-59267
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error.
*/

update cjams.person
	set dob  ='1994-07-17 00:00:00.000',
		firstname = 'Da''Shown',
		updatedby ='CJAMS-59267',
		updatedon =now() 
	where personid ='23c9854d-1612-4186-b4b1-0e1c89b2a91c';


INSERT INTO cjams.personauditlog
	(personauditlogid,
	personid,
	personjson, 
	typekey, 
	insertedon, insertedby, updatedby, updatedon, activeflag, old_id)
VALUES(gen_random_uuid(), 
	'23c9854d-1612-4186-b4b1-0e1c89b2a91c',
	'{"Lastname":"Rawl","Firstname":"Da''Shown","Middlename":"","prefix":"","nameSuffix":"","primarylanguage":"ENG","secondarylanguage":null,"Dob":"1994-07-17","dateofdeath":null,"isapproxdod":0,"isapproxdob":1,"isdobunknown":null,"safehavenbabyflag":"false","everbeenadoptedflag":null,"intercountryadoption":null,"priorlegalguardianship":null,"cferesourcehomechild":false,"age":null,"gendertypekey":"M","othergendertypekey":null,"religiontypekey":null,"maritalstatustypekey":"SG","SSN":"","ssnverified":null,"actorid":null,"intakeservicerequestid":null,"ethnicgrouptypekey":"X","occupation":null,"stateid":null,"source":null,"potentialSOR":"","eDLHistory":"","dMH":"","Race":[{"racetypekey":"BA"}],"Address":"","address1":"","Zip":"","City":"","State":null,"County":null,"DangerousAddressReason":"","tribalassociation":null,"icwastatusinquiry":null,"icwaeligibleformembership":null,"icwatribename":null,"icwaunderdefinition":null,"icwanotification":null,"icwatribelegalnotice":null,"height":null,"heightft":null,"heightin":null,"weight":null,"weightpnd":null,"weightound":null,"tattoo":"","haircolortypekey":null,"hairtexturetypekey":"","eyecolortypekey":"","physicalbuildtypekey":"","skintonetypekey":"","hairtextureotherdesc":"","haircolorotherdesc":"","isglasses":null,"PhyMark":"","dangerousselfreason":"","ismentalimpairReason":"","DangerousWorkerReason":"","ismentalillnessReason":"","dangerousself":2,"Dangerousworker":2,"ismentalimpair":2,"ismentalillness":2,"personid":"23c9854d-1612-4186-b4b1-0e1c89b2a91c","roletype":"other","drugexposednewbornflag":0,"sexoffenderregisteredflag":true,"probationsearchconductedflag":1,"otherdrugs":"","drugexposedtypekey":"","needs":null,"strengths":null,"livingsituationkey":null,"licensedfacilitykey":null,"otherlicensedfacility":null,"livingsituationdesc":null,"livingarrangementkey":null,"livingarrangementdesc":null,"otherreligion":null,"alienregistrationtext":null,"alienstatustypekey":null,"citizenalenageflag":null,"isqualifiedalien":null,"verificationremarks":null,"primarycitizenship":"","secondarycitizenship":"","nationality":"","astatus":null,"arnumber":"","householdflag":null,"roles":["AM","OTHADNH"],"spouseaddress1":null,"spouseAddress2":null,"spousecity":null,"spousestate":null,"spousezipcode":null,"spousecounty":null,"spousehomenumber":null,"spouseofficenumber":null,"spouseofficeextension":null,"spouseprefix":null,"spousefirstname":null,"spouselastname":null,"spousemiddlename":null,"spousesuffix":null,"numberofchildren":null,"maritalcomments":"","maritalstartdate":null,"maritalenddate":null,"marriageplace":"","divorceplace":"","aname":false,"preadptdate":null,"preplacementguardianshipdate":null,"userphoto":"","employername":"","clienttitle":"","isheadofhousehold":false,"biologicalmothermarriedsw":null,"clientflag":1,"birthmatchflag":null,"notificationdate":null,"birthmatchupdateflag":null,"deselectreason":null,"substanceexposednewbornflag":0,"substanceexposednewbornsourceid":null,"substanceexposednewbornsourcetypekey":null,"substanceexposednewborntimetamp":null,"substanceclasses":null,"othersubstances":null,"initialresponse":null,"initialresponseupdatedby":null,"initialresponseupdatedon":null,"unknownperson":null,"objectid":"d9c04f4f-1826-4093-9c61-7dd3ffdfb78d","objecttype":"servicerequest","personroleid":"642d1525-1664-4c15-8bc5-e31253a3561c","ishousehold":2,"iscollateralcontact":0,"personRole":[{"personroletypeid":"a0c16f8c-d8f6-426f-b3d0-983a93312aa1","personroleid":"642d1525-1664-4c15-8bc5-e31253a3561c","roletype":"AM","isprimary":1},{"personroletypeid":"1f3670e4-e6f0-4942-a3cc-f716eb7de6c0","personroleid":"642d1525-1664-4c15-8bc5-e31253a3561c","roletype":"OTHADNH","isprimary":0}],"alias":[],"cisclientid":"523071903","maritalstatus":{"statustypekey":"SG","marriageplace":"","divorceplace":"","maritalstartdate":null,"maritalenddate":null,"childrenno":null,"maritalcomments":"","spouseprefix":null,"spousefirstname":null,"spousemiddlename":null,"spouselastname":null,"spousesuffix":null,"spousehomenumber":null,"spouseofficenumber":null,"spouseofficeextension":null,"spouseaddress1":null,"spouseAddress2":null,"spousecity":null,"spousestate":null,"spousecounty":null,"spousezipcode":null},"caseInfo":{"objectType":"Case","objectNumber":"251022988353"},"intakenumber":null,"qpid":null,"qptype":null}',
	'old', 
	now(), 'CJAMS-59267', 'CJAMS-59267', now(), 1, NULL);