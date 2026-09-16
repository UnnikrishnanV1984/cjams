/*
   Issue Description: CDM-37036 - Child's name disappeared on the Safe C in IR 241021716334
   Category/ Module  : Case / Assessment
   Root cause: In assessment submissiondata, child details are mission in all_childs_json filed which acts as dropdown data 
				for child name field. Since the name is missing in dropdown, there is no match and field is showing empty
   Fix Provided: Data fix to include missing child details. Not updating audit columns as they are used in application 
*/
update  cjams.assessment 
	set submissiondata = jsonb_set(submissiondata:: jsonb, '{all_childs_json}', '[{"age": "8 Yrs", "name": " Luis F Esteban-Flores ", "cjamspid": "202154135"}, {"age": "5 Yrs", "name": " Meylis  Vanegas Flores ", "cjamspid": "202689638"}]')
where assessmentid =  '48839dae-8762-4728-80c5-e8f6ded94cbd';