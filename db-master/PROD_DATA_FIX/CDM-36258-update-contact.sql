/*
 * CDM-36258 - Wrong client selected for Subject of Contact
 * Customer Email ID:christina.morton3@maryland.gov
 * Customer Name: Christina Morton
 * Focus Area:Assessments: Other
 * Description - 231030049354:incorrectly selected "Yessenia Hernandez-Sorto" instead of "Ashley Menjivar Hernandez" for this visit. 
 * Update and Replace the  person contacted : 231030049354, 
 * 
 */


select * from progressnote where progressnoteid = 'fc1230e3-644a-4d52-aae8-3acbccb32f82';


update progressnote set focusperson = jsonb_set(focusperson::jsonb, '{focuspersonjson}', 		 
			jsonb_set((focusperson->'focuspersonjson')::jsonb, '{0}', 
			(focusperson->'focuspersonjson'->0)::jsonb||('{"intakeservicerequestactorid":"d2415d0e-26a0-4e74-b5e6-56fb6e898b67","firstname":"Ashley","lastname": "Menjivar Hernandez"}')
			::jsonb)), updatedby = 'CDM-36258', updatedon = now()
where progressnoteid = 'fc1230e3-644a-4d52-aae8-3acbccb32f82';