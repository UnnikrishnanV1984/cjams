/*
   Issue Description: CDM-13456
   Category/ Module  : incorrectly checking of Fatality
   Root cause:A subsequent intake report was taken on 5/15/21 that WAS a fatality, and the Child Fatality radial button was marked yes on the 5/15/21 report.
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/



update person set dateofdeath = null, updatedby = 'CDM-13456', updatedon = now() where personid = '57b73292-2b37-4d92-8417-4c94a7f3db7e';


update personauditlog set personjson = '{"Lastname":"Pitts","Firstname":"Zorii","Middlename":"","prefix":"","nameSuffix":"",
"primarylanguage":"ENG","secondarylanguage":null,"Dob":"2021-03-15","dateofdeath":null,"isapproxdod":0,"isapproxdob":0,
"isdobunknown":null,"safehavenbabyflag":"false","everbeenadoptedflag":0,"age":null,"gendertypekey":"M","religiontypekey":null,
"maritalstatustypekey":"SG","SSN":"","ssnverified":null,"mdm_id":null,"actorid":null,"intakeservicerequestid":null,
"ethnicgrouptypekey":null,"stateid":"MD","source":null,"potentialSOR":"","eDLHistory":"","dMH":"","Race":[],
"address1":"56 S Monastery Ave","Zip":"21229","City":"Baltimore","State":"MD","County":"7665ca54-5374-4174-be07-a687b811a82c",
"DangerousAddressReason":"","tribalassociation":null,"height":null,"heightft":null,"heightin":null,"weight":null,"weightpnd":null
,"weightound":null,"tattoo":"","haircolortypekey":"","hairtexturetypekey":"","eyecolortypekey":"","physicalbuildtypekey":"",
"skintonetypekey":"","hairtextureotherdesc":"","haircolorotherdesc":"","isglasses":null,"PhyMark":"","dangerousselfreason":"",
"ismentalimpairReason":"","DangerousWorkerReason":"","ismentalillnessReason":"","dangerousself":2,"Dangerousworker":2,
"ismentalimpair":2,"ismentalillness":2,"personid":null,"roletype":"household","drugexposednewbornflag":0,"sexoffenderregisteredflag":null,
"probationsearchconductedflag":0,"otherdrugs":"","drugexposedtypekey":"","needs":null,"strengths":null,"livingsituationkey":null,
"licensedfacilitykey":null,"otherlicensedfacility":null,"livingsituationdesc":null,"otherreligion":null,"alienregistrationtext":null,
"alienstatustypekey":null,"citizenalenageflag":null,"isqualifiedalien":null,"verificationremarks":null,"primarycitizenship":null,
"secondarycitizenship":null,"nationality":null,"astatus":null,"arnumber":null,"householdflag":null,"roles":["AV","CHILD"],
"spouseaddress1":null,"spouseAddress2":null,"spousecity":null,"spousestate":null,"spousezipcode":null,"spousecounty":null,
"spousehomenumber":null,"spouseofficenumber":null,"spouseofficeextension":null,"spouseprefix":null,"spousefirstname":null,
"spouselastname":null,"spousemiddlename":null,"spousesuffix":null,"numberofchildren":null,"maritalcomments":null,"maritalstartdate":null
,"maritalenddate":null,"marriageplace":null,"divorceplace":null,"aname":false,"preadptdate":null,"userphoto":"","employername":"",
"clienttitle":"","isheadofhousehold":false,"biologicalmothermarriedsw":2,"clientflag":1,"unknownperson":null,"objectid":"I202100448216",
"objecttype":"Intake","ishousehold":1,"iscollateralcontact":0,"personRole":[{"personroletypeid":null,"personroleid":null,
"roletype":"CHILD","isprimary":1},{"personroletypeid":null,"personroleid":null,"roletype":"AV","isprimary":0}],"alias":[],
"maritalstatus":{"statustypekey":"SG","marriageplace":null,"divorceplace":null,"maritalstartdate":null,"maritalenddate":null,
"childrenno":null,"maritalcomments":null,"spouseprefix":null,"spousefirstname":null,"spousemiddlename":null,"spouselastname":null,
"spousesuffix":null,"spousehomenumber":null,"spouseofficenumber":null,"spouseofficeextension":null,"spouseaddress1":null,
"spouseAddress2":null,"spousecity":null,"spousestate":null,"spousecounty":null,"spousezipcode":null},
"intakenumber":"I202100448216","caseInfo":{"objectType":"Intake","objectNumber":"I202100448216"}}', updatedby = 'CDM-13456', updatedon = now()
where personid = '57b73292-2b37-4d92-8417-4c94a7f3db7e';