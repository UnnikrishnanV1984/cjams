/*	
	Issue Description: CDM-22747
   Category/ Module  : Edited placement details in assessment
   Root cause: user wants to edit tthe placement details in assessment
   Pull request# for datafix: 6028
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE assessment set 
    updatedby = 'CDM-22747',
	updatedon = now(),
    submissiondata = jsonb_set(submissiondata::jsonb, '{placementlivingarrangement}', '"Hearts and Homes for Youth,Inc - Helen Smith"')
	where assessmentid = '793c76d6-7156-45a2-98f3-250defee2b45' and activeflag = '1';
	
UPDATE assessment set 
updatedby = 'CDM-22747',
	updatedon = now(),
  submissiondata = jsonb_set(submissiondata::jsonb, '{providername}', '"Hearts and Homes for Youth,Inc - Helen Smith"') 
where assessmentid = '793c76d6-7156-45a2-98f3-250defee2b45' and activeflag = '1';

UPDATE assessment set 
updatedby = 'CDM-22747',
	updatedon = now(),
  submissiondata = jsonb_set(submissiondata::jsonb, '{adr_street_tx}', '"635"') 
where assessmentid = '793c76d6-7156-45a2-98f3-250defee2b45' and activeflag = '1';

UPDATE assessment set 
updatedby = 'CDM-22747',
	updatedon = now(),
  submissiondata = jsonb_set(submissiondata::jsonb, '{adr_street_nm}', '"Maryland Ave"') 
where assessmentid = '793c76d6-7156-45a2-98f3-250defee2b45' and activeflag = '1';

UPDATE assessment set 
updatedby = 'CDM-22747',
	updatedon = now(),
  submissiondata = jsonb_set(submissiondata::jsonb, '{adr_city_nm}', '"Rockville"') 
where assessmentid = '793c76d6-7156-45a2-98f3-250defee2b45' and activeflag = '1';

UPDATE assessment set 
updatedby = 'CDM-22747',
	updatedon = now(),
  submissiondata = jsonb_set(submissiondata::jsonb, '{adr_state_cd}', '"MD"') 
where assessmentid = '793c76d6-7156-45a2-98f3-250defee2b45' and activeflag = '1';

UPDATE assessment set 
updatedby = 'CDM-22747',
	updatedon = now(),
  submissiondata = jsonb_set(submissiondata::jsonb, '{adr_street_suffix_cd}', '"AVE"') 
where assessmentid = '793c76d6-7156-45a2-98f3-250defee2b45' and activeflag = '1';
UPDATE assessment set 
updatedby = 'CDM-22747',
	updatedon = now(),
  submissiondata = jsonb_set(submissiondata::jsonb, '{adr_zip5_no}', '"20850"') 
where assessmentid = '793c76d6-7156-45a2-98f3-250defee2b45' and activeflag = '1';

UPDATE assessment set 
updatedby = 'CDM-22747',
	updatedon = now(),
  submissiondata = jsonb_set(submissiondata::jsonb, '{address}', '"635 Maryland Ave Rockville Md 20850"')
where assessmentid = '793c76d6-7156-45a2-98f3-250defee2b45' and activeflag = '1';
	
UPDATE assessment set 
    updatedby = 'CDM-22747',
	updatedon = now(),
    submissiondata = jsonb_set(submissiondata::jsonb, '{childs_info_json}', '"[{\"childname\":\"AMIAH SMITH\",\"clientid\":\"200011962\",\"age\":18,\"dob\":\"2004-03-02\",\"providerInfo\":{\"provider_id\":6005162,\"phonenumber\":null,\"adr_street_no\":null,\"adr_street_tx\":\"635\",\"adr_street_nm\":\"Maryland\",\"adr_city_nm\":\"Rockville\",\"adr_state_cd\":\"MD\",\"adr_street_suffix_cd\":\"AVE\",\"adr_box_no\":null,\"adr_zip5_no\":20850,\"provider_category_cd\":\"3274\",\"providername\":\"Hearts and Homes for Youth,Inc - Helen Smith\",\"address\":\"635 Maryland Ave Rockville Md 20850\"},\"hasActivePlacement\":true,\"placementDetails\":{\"ischildplacedoutside\":null,\"servicecaseid\":\"f1f2cfbb-5ec5-4cfe-b28e-f66ec96b1b23\",\"servicecasenumber\":\"2020021902215\",\"intakeservreqchildremovalid\":\"7500c1fb-08a4-4dd8-93ed-4163ff2caad1\",\"intakeservicerequestactorid\":\"a0ca71d9-e77e-41e8-89ab-f4cd972fe32d\",\"providerid\":null,\"contractprogramid\":50002360,\"programname\":\"Group Home-635 Maryland AVE. (#50002360)\",\"remarks\":\" \",\"approvalstatustypekey\":null,\"old_id\":null,\"service_id\":167,\"ratestructureid\":null,\"startdate\":\"2022-05-09T00:00:00\",\"starttime\":\"2022-05-09 17:00\",\"enddate\":null,\"justification\":null,\"endtime\":null,\"placementtypekey\":\"PRPL\",\"providersentdate\":\"2022-05-10T18:20:04.181\",\"providerdesc\":null,\"responseacceptedkey\":\"4612\",\"rejectreasonkey\":null,\"isssaapproval\":0,\"ifcapprovaldate\":null,\"placementid\":\"5f8c30eb-6b33-476f-b350-1acdacc8bd01\",\"livingarrangementtypekey\":\"32944\",\"runawayreported\":null,\"runawayreportnumber\":null,\"livingarrangementtype\":null,\"personid\":\"146d3c84-217c-4276-80f6-99128957253e\",\"primarycaregiver\":\"Hearts and Homes for Youth,Inc - Helen Smith\",\"caregiverclientid\":null,\"secondarycaregiver\":null,\"partnerid\":null,\"primaryrelationship\":null,\"livingstartdate\":\"2022-05-09T00:00:00\",\"livingenddate\":null,\"contactphone\":null,\"workphone\":null,\"address1\":\"  \",\"address2\":\"Maryland AVE\",\"cityname\":\"Rockville\",\"countytypekey\":\"1429\",\"statetypekey\":\"MD\",\"zipcode\":20850,\"isvoided\":0,\"exittypekey\":null,\"voiddate\":null,\"alternateid\":1571874,\"ischangepreadoptive\":null,\"placementrevision\":[{\"status\":\"Approved\",\"justification\":null,\"placementrevisionid\":\"3cb5ba47-1ca4-43e4-bb96-a51f20bc8093\",\"placementid\":\"5f8c30eb-6b33-476f-b350-1acdacc8bd01\",\"transactiondate\":\"2022-05-10T00:00:00\",\"entrydate\":\"2022-05-09T00:00:00\",\"entrytime\":\"2022-05-09 17:00\",\"exitdate\":null,\"exittime\":null,\"exittypetypkey\":null,\"exitreasontypkey\":null,\"exitexplanation\":\"\",\"approvalstatustypkey\":\"3045\",\"approvaldate\":null,\"insertedon\":\"2022-05-10T14:20:37.48348\",\"activeflag\":0,\"alternateid\":1153934,\"voidreasontypekey\":null,\"voidremarks\":null,\"enddate\":null,\"endtime\":null,\"exittypekey\":null,\"remarks\":\" \",\"isvoided\":0,\"fullname\":\"Alecia Richards\",\"placement_id\":1571874,\"provider_id\":6005162,\"providername\":\"Hearts and Homes for Youth,Inc - Helen Smith\",\"requestedby\":\"Alecia Richards\",\"approvedby\":\"Lisa Late\",\"requesteddate\":\"2022-05-10T14:20:37.48348\",\"approveddate\":\"2022-05-10T14:48:11.268077\",\"ischangepreadoptive\":null}],\"exitreasontypedescription\":null,\"exitreasontypekey\":null,\"exittypedescription\":null,\"voidreasontypekey\":null,\"voidreasontypedescription\":null,\"voidremarks\":null,\"county\":null,\"rejectreason\":null,\"responseaccepted\":\"Yes\",\"placementstructuredesc\":\"Therapeutic Group Homes\",\"comarratedesc\":null,\"statename\":\"Maryland\",\"providerdetails\":{\"provider_id\":6005162,\"phonenumber\":null,\"adr_street_no\":null,\"adr_street_tx\":\"635\",\"adr_street_nm\":\"Maryland\",\"adr_city_nm\":\"Rockville\",\"adr_state_cd\":\"MD\",\"adr_street_suffix_cd\":\"AVE\",\"adr_box_no\":null,\"adr_zip5_no\":20850,\"provider_category_cd\":\"3274\",\"providername\":\"Hearts and Homes for Youth,Inc - Helen Smith\",\"address\":\"635 Maryland Ave Rockville Md 20850\"},\"routingstatus\":\"Approved\",\"revisionupdate\":null,\"reason\":\"\",\"cpahomerevision\":[]}}]"')
	where assessmentid = '793c76d6-7156-45a2-98f3-250defee2b45' and activeflag = '1';