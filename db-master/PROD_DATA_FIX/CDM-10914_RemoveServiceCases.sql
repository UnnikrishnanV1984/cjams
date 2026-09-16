-- CDM-10914 - Remove service cases that got created in error

update servicecase set activeflag =0,updatedby = 'CDM-10914', updatedon = now() where servicecaseid in ('1fad9fa1-519c-4443-8e5e-487d13ed988b','73b65c5b-476e-4ed6-86af-bf7a14220c8d');
