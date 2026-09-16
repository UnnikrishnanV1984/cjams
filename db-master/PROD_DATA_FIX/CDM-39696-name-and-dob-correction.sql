/*

   Issue Description: CDM-39696-User requested to corret the name and dob
    
    Latees Walker- is incorrect 
    The correct name should be Lateef Walker
 
 
        Latees Walker- is incorrect 
        The correct name should be Lateef Walker
        
        The incorrect date of birth is 10-25-2023
        The correct  date of birth should be 11-25-1977

   Category/ Module  : Person

   Root cause: User requestred to correct then name and dob 

   Fix provided :Datafix for name and dob  correction

   Code fix ticket#:

   Reason why no related code fix: 

   Status of the code fix if already submitted and expected prod fix date: 

   Backup before update/ delete:
   */


update person
 set firstname = 'Lateef',
 dob  ='1977-11-25 00:00:00.000',
 updatedby ='CDM-39696',updatedon =now() 
where personid ='2f42df46-24b2-4517-a97d-11f664a063fa';


INSERT INTO cjams.personauditlog
(personauditlogid,
 personid,
 personjson, 
 typekey, 
 insertedon,
  insertedby, updatedby, updatedon, activeflag, old_id)
VALUES(gen_random_uuid(), 
'2f42df46-24b2-4517-a97d-11f664a063fa',
 '{"Lastname":"Walker","Firstname":"Lateef","Middlename":"","prefix":"","nameSuffix":"","primarylanguage":"ENG","secondarylanguage":null,"Dob":"11/25/1977","dateofdeath":null,"isapproxdod":0,"isapproxdob":0,"isdobunknown":null,"safehavenbabyflag":"false","everbeenadoptedflag":null,"intercountryadoption":null,"priorlegalguardianship":null,"cferesourcehomechild":false,"age":null,"gendertypekey":"M","religiontypekey":null,"maritalstatustypekey":null,"SSN":"","ssnverified":null,"actorid":null,"intakeservicerequestid":null,"ethnicgrouptypekey":"X","occupation":null,"stateid":null,"source":null,"potentialSOR":"","eDLHistory":"","dMH":"","Race":[{"racetypekey":"BA"}],"Address":"","address1":"","Zip":"","City":"","State":null,"County":null,"DangerousAddressReason":"","tribalassociation":null,"icwastatusinquiry":"NO","icwaeligibleformembership":null,"icwatribename":null,"icwaunderdefinition":"UNKNOWN","icwanotification":null,"icwatribelegalnotice":null,"height":null,"heightft":null,"heightin":null,"weight":null,"weightpnd":null,"weightound":null,"tattoo":"","haircolortypekey":null,"hairtexturetypekey":"","eyecolortypekey":"","physicalbuildtypekey":"","skintonetypekey":"","hairtextureotherdesc":"","haircolorotherdesc":"","isglasses":null,"PhyMark":"","dangerousselfreason":"","ismentalimpairReason":"","DangerousWorkerReason":"","ismentalillnessReason":"","dangerousself":2,"Dangerousworker":2,"ismentalimpair":2,"ismentalillness":2,"personid":"2f42df46-24b2-4517-a97d-11f664a063fa","roletype":"other","drugexposednewbornflag":0,"sexoffenderregisteredflag":false,"probationsearchconductedflag":0,"otherdrugs":null,"drugexposedtypekey":"","needs":null,"strengths":null,"livingsituationkey":null,"licensedfacilitykey":null,"otherlicensedfacility":null,"livingsituationdesc":null,"livingarrangementkey":null,"livingarrangementdesc":null,"otherreligion":null,"alienregistrationtext":null,"alienstatustypekey":null,"citizenalenageflag":null,"isqualifiedalien":null,"verificationremarks":null,"primarycitizenship":"","secondarycitizenship":"","nationality":"","astatus":null,"arnumber":"","householdflag":null,"roles":["TES","ICC","AM"],"spouseaddress1":null,"spouseAddress2":null,"spousecity":null,"spousestate":null,"spousezipcode":null,"spousecounty":null,"spousehomenumber":null,"spouseofficenumber":null,"spouseofficeextension":null,"spouseprefix":null,"spousefirstname":null,"spouselastname":null,"spousemiddlename":null,"spousesuffix":null,"numberofchildren":null,"maritalcomments":"","maritalstartdate":null,"maritalenddate":null,"marriageplace":"","divorceplace":null,"aname":false,"preadptdate":null,"preplacementguardianshipdate":null,"userphoto":"","employername":"","clienttitle":"","isheadofhousehold":false,"biologicalmothermarriedsw":null,"clientflag":1,"birthmatchflag":null,"notificationdate":null,"birthmatchupdateflag":null,"deselectreason":null,"substanceexposednewbornflag":0,"substanceexposednewbornsourceid":null,"substanceexposednewbornsourcetypekey":null,"substanceexposednewborntimetamp":null,"substanceclasses":null,"othersubstances":null,"initialresponse":null,"initialresponseupdatedby":null,"initialresponseupdatedon":null,"unknownperson":null,"objectid":"9620cc1a-f79f-4075-a672-dd8b64ee85da","objecttype":"servicerequest","personroleid":"e2d7809c-ca3f-473d-a6f6-2fe2a9cd7e77","ishousehold":2,"iscollateralcontact":0,"personRole":[{"personroletypeid":"761df406-cb28-4100-bb41-c1bd10ca2b54","personroleid":"e2d7809c-ca3f-473d-a6f6-2fe2a9cd7e77","roletype":"ICC","isprimary":1},{"personroletypeid":"b43b14b6-4643-42b1-9d59-5aaa5fad3a04","personroleid":"e2d7809c-ca3f-473d-a6f6-2fe2a9cd7e77","roletype":"TES","isprimary":0},{"personroletypeid":"16f68c74-e825-48e4-9b61-36de2dd14287","personroleid":"e2d7809c-ca3f-473d-a6f6-2fe2a9cd7e77","roletype":"AM","isprimary":0}],"alias":[],"cisclientid":"562066982","caseInfo":{"objectType":"Case","objectNumber":"241022424432"},"intakenumber":null,"qpid":null,"qptype":null}',
 'old', 
 now(), 
 'CDM-39696', 
 'CDM-39696',
  now(), 
  1, 
  NULL);
