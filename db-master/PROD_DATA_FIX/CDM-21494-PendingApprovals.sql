
	/*
   Issue Description: CDM-21494
   Category/ Module  : approval inbox 
   Root cause: user wants remove the records which are approved but shown as pending
   Pull request# for code fix: 5160
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/

update routing set activeflag = 0, updatedon = now(), updatedby = 'CDM-21494' 
where routingid = 'b7559bc2-a2a1-4e4e-a5df-d979288d4157';

update routing set activeflag = 0, updatedon = now(), updatedby = 'CDM-21494' 
where routingid = '7f7c4101-862d-4ddc-8eac-10789a15eced';

update routing set activeflag = 0, updatedon = now(), updatedby = 'CDM-21494' 
where routingid = '0adc657b-5051-40ea-a467-6e44d938b273';