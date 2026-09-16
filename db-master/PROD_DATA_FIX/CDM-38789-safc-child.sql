/*
   Issue Description: CDM-38789- Child's name disappeared on the Safe C in IR 241021916237
   Category/ Module  : Assessments: SAFE-C
   Root cause: In assessment submissiondata, child details are missing in all_childs_json filed which acts as dropdown data 
				for child name field. Since the name is missing in dropdown, there is no match and field is showing empty
                This is because child role has been changed before the assessment approval
   Fix Provided: Data fix to include missing child details. Not updating audit columns as they are used in application 
*/

update  cjams.assessment 
	set submissiondata = jsonb_set(submissiondata:: jsonb, '{all_childs_json}', '[{"age": "16 Yrs","name": "DARNELL  BASS","cjamspid": "4055788"},{"age": "6 Month(s)", "name": " Wynter  Taylor ","cjamspid": "202817013"},{"age": "9 Yrs", "name": " JaNyah  Cornish ", "cjamspid": "202817011"},{"age": "8 Yrs","name": " Kayden  Warren ","cjamspid": "202817014"}]')
where assessmentid =  'd137f890-468c-4882-8445-2829b6e393b0' and objectid ='341c6c26-9471-43dc-8cac-7156e21ee5c0';

UPDATE cjams.assessmentactor
SET intakeservicerequestactorid='f6667a0c-d5c8-46e2-981f-c2bffcbc17a1'::uuid, updatedby='CDM-38789', updatedon=now()
WHERE assessmentactorid in ('bc40dcb1-93ee-4d3f-b3ba-a68f16106406', '40459ff4-0527-40aa-bf3f-2f218875f117') ;

UPDATE cjams.assessmentactor
SET intakeservicerequestactorid='89a15f1e-5884-47e7-b309-2e1ef771ca0d'::uuid, updatedby='CDM-38789', updatedon=now()
WHERE assessmentactorid in ('188efc4e-d138-4839-ace7-83d33a525337') ;