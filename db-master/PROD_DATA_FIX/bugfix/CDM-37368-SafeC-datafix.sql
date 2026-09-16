/*
   Issue Description: CDM-37368 - Child's name disappeared on the Safe C in IR 241030263141
   Category/ Module  : Assessments: SAFE-C
   Root cause: In assessment submissiondata, child details are missing in all_childs_json filed which acts as dropdown data 
				for child name field. Since the name is missing in dropdown, there is no match and field is showing empty
   Fix Provided: Data fix to include missing child details. Not updating audit columns as they are used in application 
*/

update  cjams.assessment 
	set submissiondata = jsonb_set(submissiondata:: jsonb, '{all_childs_json}', '[{"age": "16 Yrs", "name": " DASHON TYLIK MATTHEWS ", "cjamspid": "3880846"},{"age": "1 Month(s)", "name": "Ahmir Matthews", "cjamspid": "202736420"}]')
where assessmentid =  '7fb3bfb6-f088-48c6-a733-e9e4214a2ce9' and objectid ='01c99ebd-07f7-499a-a456-e276e0dc1dcf';

update  cjams.assessment 
	set submissiondata = jsonb_set(submissiondata:: jsonb, '{all_childs_json}', '[{"age": "16 Yrs", "name": " DASHON TYLIK MATTHEWS ", "cjamspid": "3880846"},{"age": "1 Month(s)", "name": "Ahmir Matthews", "cjamspid": "202736420"}]')
where assessmentid =  '182b6f60-c37c-42e2-884a-330b747a9b79' and objectid ='01c99ebd-07f7-499a-a456-e276e0dc1dcf';

update  cjams.assessment 
	set submissiondata = jsonb_set(submissiondata:: jsonb, '{all_childs_json}', '[{"age": "16 Yrs", "name": " DASHON TYLIK MATTHEWS ", "cjamspid": "3880846"},{"age": "1 Month(s)", "name": "Ahmir Matthews", "cjamspid": "202736420"}]')
where assessmentid =  '883aff12-6405-4e97-9be3-420b495e6f72' and objectid ='01c99ebd-07f7-499a-a456-e276e0dc1dcf';

update  cjams.assessment 
	set submissiondata = jsonb_set(submissiondata:: jsonb, '{all_childs_json}', '[{"age": "11 Day(s)", "name": "Ahmir Matthews", "cjamspid": "202736420"},{"age": "16 Yrs", "name": " DASHON TYLIK MATTHEWS ", "cjamspid": "3880846"}]')
where assessmentid =  '9788e5de-e9de-4f7c-b1af-de203c56f55f' and objectid ='01c99ebd-07f7-499a-a456-e276e0dc1dcf';

