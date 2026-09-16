/*
   Issue Description: CDM-37318 - Child's name disappeared on the Safe C in IR 241021895841
   Category/ Module  : Case / Assessment
   Root cause: In assessment submissiondata, child details are mission in all_childs_json filed which acts as dropdown data 
				for child name field. Since the name is missing in dropdown, there is no match and field is showing empty
   Fix Provided: Data fix to include missing child details. Not updating audit columns as they are used in application 
*/

select * from cjams.assessment 
where assessmentid =  '192c1428-96ed-4dfc-a560-3fcecbb98051';

update  cjams.assessment 
	set submissiondata = jsonb_set(submissiondata:: jsonb, '{all_childs_json}',
	'[{"age": "16 Yrs", "name": " Joselin Lara Moreno ", "cjamspid": "202798439"}, 
	  {"age": "11 Yrs", "name": " Axel Amaya Lara ", "cjamspid": "202796326"}, 
      {"age": "7 Yrs", "name": " Sofia V Amaya Lara ", "cjamspid": "202796325"}]'),
      updatedby = 'CDM-37318', updatedon = now()
where assessmentid =  '192c1428-96ed-4dfc-a560-3fcecbb98051';
