UPDATE cjams.assessment
SET submissiondata = jsonb_set(submissiondata,'{ClientName}', '"GAVIN SHOEMAKER"')
        ,personid = '24623bd4-c1cb-4c73-9fee-4ac0a8a35cb0' 
WHERE assessmentid = 'd73f1db4-2f4e-4235-9895-5f4b404aede8'
and servicecaseid = 'cc436799-4d8b-45d8-8b80-b4d7054a9b35';

UPDATE cjams.assessment
SET submissiondata = jsonb_set(submissiondata,'{dob}', '"2008-05-18T05:00:00.000Z"') 
WHERE assessmentid = 'd73f1db4-2f4e-4235-9895-5f4b404aede8'
and servicecaseid = 'cc436799-4d8b-45d8-8b80-b4d7054a9b35';

UPDATE cjams.assessment
SET submissiondata = jsonb_set(submissiondata,'{clientid}', '2576775') 
WHERE assessmentid = 'd73f1db4-2f4e-4235-9895-5f4b404aede8'
and servicecaseid = 'cc436799-4d8b-45d8-8b80-b4d7054a9b35';

UPDATE cjams.assessment
SET submissiondata = jsonb_set(submissiondata, '{childs_info_json}','[{"childname":"CODY SHOEMAKER","clientid":"1286281","age":24,"dob":"1995-02-13","providerInfo":null,"hasActivePlacement":null,"placementDetails":{}}
	,{"childname":"SARA SHOEMAKER","clientid":"1250902","age":20,"dob":"1999-11-17","providerInfo":null,"hasActivePlacement":null,"placementDetails":{"ischildplacedoutside":null,"servicecaseid":null,"servicecasenumber":null,"intakeservreqchildremovalid":null,"intakeservicerequestactorid":null,"providerid":null,"contractprogramid":null,"remarks":null,"service_id":null,"ratestructureid":null,"startdate":"2017-09-28T00:00:00","starttime":null,"enddate":"2017-11-22T00:00:00","endtime":null,"placementtypekey":"LA","providersentdate":null,"providerdesc":null,"responseacceptedkey":null,"rejectreasonkey":null,"isssaapproval":null,"ifcapprovaldate":null,"placementid":"33096252-1d17-4762-a4a1-18ced711f727","livingarrangementtypekey":"TVH","livingarrangementtype":"Trial visit home","personid":"d552626f-8b5b-4826-82b3-aefbab91fbfd","livingfirstname":null,"livingstartdate":"2017-09-28T00:00:00","livingenddate":"2017-11-22T00:00:00","contactphone":"2402171557","address1":"11044","address2":"Lincoln","cityname":"Hagerstown","countytypekey":"e2c90cd0-a905-4cca-ad60-396ac2cfc41e","statetypekey":"MD","zipcode":21740,"isvoided":null,"exittypekey":null,"voiddate":null,"alternateid":1056242,"placementrevision":null,"exitreasontypedescription":null,"exitreasontypekey":null,"exittypedescription":null,"voidreasontypekey":null,"voidreasontypedescription":null,"voidremarks":null,"county":"Washington","rejectreason":null,"responseaccepted":null,"placementstructuredesc":null,"comarratedesc":null,"statename":"Maryland","providerdetails":null,"routingstatus":"Approved","revisionupdate":null,"reason":null}}]')
 
WHERE assessmentid = 'd73f1db4-2f4e-4235-9895-5f4b404aede8'
and servicecaseid = 'cc436799-4d8b-45d8-8b80-b4d7054a9b35';

UPDATE cjams.assessment
SET submissiondata = jsonb_set(submissiondata, '{childs_names_json}','"[\"CODY SHOEMAKER\",\"SARA SHOEMAKER\",\"GAVIN SHOEMAKER\"]"') 
WHERE assessmentid = 'd73f1db4-2f4e-4235-9895-5f4b404aede8'
and servicecaseid = 'cc436799-4d8b-45d8-8b80-b4d7054a9b35'; 
 

UPDATE cjams.assessment
SET submissiondata = jsonb_set(submissiondata, '{child_info_with_comma_json}','"[{\"seconename\":\"CODY SHOEMAKER\",\"seconeage\":24},{\"seconename\":\"SARA SHOEMAKER\",\"seconeage\":20},{\"seconename\":\"GAVIN SHOEMAKER\",\"seconeage\":11}]"')
,updatedby = 'admin-D24615'
,updatedon = now()
WHERE assessmentid = 'd73f1db4-2f4e-4235-9895-5f4b404aede8'
and servicecaseid = 'cc436799-4d8b-45d8-8b80-b4d7054a9b35'; 
 
 

UPDATE cjams.assessmentsubmission
SET datavalue = 'GAVIN SHOEMAKER' 
WHERE assessmentid = 'd73f1db4-2f4e-4235-9895-5f4b404aede8'
and datakey= 'ClientName'
and assessmentsubmissionid  = 'f0234ba2-a3d8-40fa-bf45-9cf0d0af344f';

UPDATE cjams.assessmentsubmission
SET datavalue = '2576775' 
WHERE assessmentid = 'd73f1db4-2f4e-4235-9895-5f4b404aede8'
and datakey= 'clientid'  
and assessmentsubmissionid = '714c37b2-4c15-43d2-9f4a-32fa33b22ac1';

UPDATE cjams.assessmentsubmission
SET datavalue = '2008-05-18T05:00:00.000Z' 
WHERE assessmentid = 'd73f1db4-2f4e-4235-9895-5f4b404aede8'
and datakey = 'dob'
and assessmentsubmissionid  = 'f6fe7c5a-afb5-4572-aa91-613d306f0d10';
 
UPDATE cjams.assessmentsubmission
SET datavalue = '[{"childname":"CODY SHOEMAKER","clientid":"1286281","age":24,"dob":"1995-02-13","providerInfo":null,"hasActivePlacement":null,"placementDetails":{}}
	,{"childname":"SARA SHOEMAKER","clientid":"1250902","age":20,"dob":"1999-11-17","providerInfo":null,"hasActivePlacement":null,"placementDetails":{"ischildplacedoutside":null,"servicecaseid":null,"servicecasenumber":null,"intakeservreqchildremovalid":null,"intakeservicerequestactorid":null,"providerid":null,"contractprogramid":null,"remarks":null,"service_id":null,"ratestructureid":null,"startdate":"2017-09-28T00:00:00","starttime":null,"enddate":"2017-11-22T00:00:00","endtime":null,"placementtypekey":"LA","providersentdate":null,"providerdesc":null,"responseacceptedkey":null,"rejectreasonkey":null,"isssaapproval":null,"ifcapprovaldate":null,"placementid":"33096252-1d17-4762-a4a1-18ced711f727","livingarrangementtypekey":"TVH","livingarrangementtype":"Trial visit home","personid":"d552626f-8b5b-4826-82b3-aefbab91fbfd","livingfirstname":null,"livingstartdate":"2017-09-28T00:00:00","livingenddate":"2017-11-22T00:00:00","contactphone":"2402171557","address1":"11044","address2":"Lincoln","cityname":"Hagerstown","countytypekey":"e2c90cd0-a905-4cca-ad60-396ac2cfc41e","statetypekey":"MD","zipcode":21740,"isvoided":null,"exittypekey":null,"voiddate":null,"alternateid":1056242,"placementrevision":null,"exitreasontypedescription":null,"exitreasontypekey":null,"exittypedescription":null,"voidreasontypekey":null,"voidreasontypedescription":null,"voidremarks":null,"county":"Washington","rejectreason":null,"responseaccepted":null,"placementstructuredesc":null,"comarratedesc":null,"statename":"Maryland","providerdetails":null,"routingstatus":"Approved","revisionupdate":null,"reason":null}}]'
 
WHERE assessmentid = 'd73f1db4-2f4e-4235-9895-5f4b404aede8'
and datakey= 'childs_info_json'
and activeflag= 1
and assessmentsubmissionid =  '3364ae9b-2fb5-4e2f-9f57-c4960e94b45c';
 
 
 
 
UPDATE cjams.assessmentsubmission
SET datavalue = '["CODY SHOEMAKER","SARA SHOEMAKER","GAVIN SHOEMAKER"]'
 
WHERE assessmentid = 'd73f1db4-2f4e-4235-9895-5f4b404aede8'
and datakey= 'childs_names_json'
and activeflag= 1
and assessmentsubmissionid =  'e5ac1392-61f0-4580-8c2a-435d3a72633c';

 


UPDATE cjams.assessmentsubmission
SET datavalue = '[{"seconename":"CODY SHOEMAKER","seconeage":24},{"seconename":"SARA SHOEMAKER","seconeage":20},{"seconename":"GAVIN SHOEMAKER","seconeage":11}]'
 ,updatedby = 'admin-D24615'
,updatedon = now()  
WHERE assessmentid = 'd73f1db4-2f4e-4235-9895-5f4b404aede8'
and datakey= 'child_info_with_comma_json'
and activeflag= 1
and assessmentsubmissionid =  '0b02f5c3-98b4-42bc-a600-b0ebcc5f4ea2';
update assessmentactor
 set intakeservicerequestactorid  = '10a9a34e-0b5f-413d-bcf7-c54d5326bfeb'
 ,updatedby = 'admin-D24615'
,updatedon = now()
 where 
assessmentactorid='7a286a7b-2658-468a-8a8e-eca314193198' 
and  assessmentid = 'd73f1db4-2f4e-4235-9895-5f4b404aede8' ;