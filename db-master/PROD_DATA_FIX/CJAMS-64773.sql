/*
Issue: CJAMS-64773 
Incorrect DOB on person card for and cannot be changed due to closed CPS case with no history

Category/Module: Person profile
Root cause: The person and parent, Cody Shrout, had a typo on the DOB entered and a data fix is needed to correct as we are unable to edit the closed CPS record. 
			The correct DOB should be 07/10/2002.
Fix provided:  Data fix has been done to update the person DOB as requested
Data/Code fix ticket#: CJAMS-64773
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error.
*/

update cjams.person
	set dob  ='2002-07-10 00:00:00.000',
		updatedby ='CJAMS-64773',
		updatedon =now() 
	where personid ='295b99ab-ad24-4320-9461-bbe1aa95f9a4';


INSERT INTO cjams.personauditlog
	(personauditlogid,
	personid,
	personjson, 
	typekey, 
	insertedon, insertedby, updatedby, updatedon, activeflag, old_id)
VALUES(gen_random_uuid(), 
	'295b99ab-ad24-4320-9461-bbe1aa95f9a4',
	'{"Lastname":"Shrout","Firstname":"Cody","Middlename":"","prefix":"","nameSuffix":"","primarylanguage":"ENG","secondarylanguage":null,"Dob":"2002-07-10","dateofdeath":null,"isapproxdod":0,"isapproxdob":0,"isdobunknown":null,"safehavenbabyflag":"false","everbeenadoptedflag":0,"intercountryadoption":null,"priorlegalguardianship":0,"cferesourcehomechild":null,"age":null,"gendertypekey":"M","othergendertypekey":null,"religiontypekey":null,"maritalstatustypekey":"SG","SSN":"","ssnverified":null,"mdm_id":null,"actorid":null,"intakeservicerequestid":null,"ethnicgrouptypekey":"X","source":null,"potentialSOR":"","eDLHistory":"","dMH":"","Race":[{"racetypekey":"WH"}],"DangerousAddressReason":"","tribalassociation":null,"icwastatusinquiry":"NO","icwaeligibleformembership":null,"icwatribename":null,"icwaunderdefinition":"NO","icwanotification":null,"icwatribelegalnotice":null,"height":null,"heightft":null,"heightin":null,"weight":null,"weightpnd":null,"weightound":null,"tattoo":"","haircolortypekey":"","hairtexturetypekey":"","eyecolortypekey":"","physicalbuildtypekey":"","skintonetypekey":"","hairtextureotherdesc":"","haircolorotherdesc":"","isglasses":null,"PhyMark":"","dangerousselfreason":"","ismentalimpairReason":"","DangerousWorkerReason":"","ismentalillnessReason":"","dangerousself":0,"Dangerousworker":0,"ismentalimpair":0,"ismentalillness":0,"personid":null,"roletype":"other","drugexposednewbornflag":0,"sexoffenderregisteredflag":true,"probationsearchconductedflag":1,"otherdrugs":"","drugexposedtypekey":"","needs":null,"strengths":null,"livingsituationkey":null,"licensedfacilitykey":null,"otherlicensedfacility":null,"livingsituationdesc":null,"livingarrangementkey":null,"livingarrangementdesc":null,"otherreligion":null,"alienregistrationtext":null,"alienstatustypekey":null,"citizenalenageflag":null,"isqualifiedalien":null,"verificationremarks":null,"primarycitizenship":null,"secondarycitizenship":null,"nationality":null,"astatus":null,"arnumber":null,"householdflag":null,"roles":["PARENT"],"spouseaddress1":null,"spouseAddress2":null,"spousecity":null,"spousestate":null,"spousezipcode":null,"spousecounty":null,"spousehomenumber":null,"spouseofficenumber":null,"spouseofficeextension":null,"spouseprefix":null,"spousefirstname":null,"spouselastname":null,"spousemiddlename":null,"spousesuffix":null,"numberofchildren":null,"maritalcomments":null,"maritalstartdate":null,"maritalenddate":null,"marriageplace":null,"divorceplace":null,"aname":false,"preadptdate":null,"preplacementguardianshipdate":null,"userphoto":"","employername":"","clienttitle":"","isheadofhousehold":false,"biologicalmothermarriedsw":null,"clientflag":1,"birthmatchflag":null,"notificationdate":null,"birthmatchupdateflag":null,"deselectreason":null,"substanceexposednewbornflag":0,"substanceexposednewbornsourceid":null,"substanceexposednewbornsourcetypekey":null,"substanceexposednewborntimetamp":null,"substanceclasses":null,"othersubstances":null,"initialresponse":null,"initialresponseupdatedby":null,"initialresponseupdatedon":null,"unknownperson":null,"objectid":"7b209cec-0312-45a6-8aa5-3f5c96e0b2d6","objecttype":"servicerequest","ishousehold":2,"iscollateralcontact":0,"personRole":[{"personroletypeid":null,"personroleid":null,"roletype":"PARENT","isprimary":1}],"alias":[],"sdmpersonapprovalflag":null,"maritalstatus":{"statustypekey":"SG","marriageplace":null,"divorceplace":null,"maritalstartdate":null,"maritalenddate":null,"childrenno":null,"maritalcomments":null,"spouseprefix":null,"spousefirstname":null,"spousemiddlename":null,"spouselastname":null,"spousesuffix":null,"spousehomenumber":null,"spouseofficenumber":null,"spouseofficeextension":null,"spouseaddress1":null,"spouseAddress2":null,"spousecity":null,"spousestate":null,"spousecounty":null,"spousezipcode":null},"caseInfo":{"objectType":"Case","objectNumber":"251023139399"},"intakenumber":null,"qpid":null,"qptype":null}',
	'old', 
	now(), 'CJAMS-64773', 'CJAMS-64773', now(), 1, NULL);