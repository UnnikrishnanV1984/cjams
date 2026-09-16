
/*
   Issue Description: CDM-18439
   Category/ Module  :  Removal 
   Root cause: user requeseted to add person to child removal
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/




update intakeservreqchildremoval 
set updatedby = 'CDM-18785', updatedon = now(), activeflag = 0
where intakeservreqchildremovalid = 'c74d0ed5-afe4-4e16-afa8-cb4a78ebee94';

update intakeservreqchildremoval 
set updatedby = 'CDM-18785', updatedon = now(), servicecaseid ='8266f291-52b6-4526-9671-304b0754b4e2'
where intakeservreqchildremovalid in ('8c7b5f2d-ba91-4611-a646-78e9504b51cc','a26802b4-7830-4569-bbdf-7491178c38ca','2beaa52a-7347-4c1a-a221-81178cdf6e00');

update routing set activeflag =0, updatedby = 'CDM-18785', updatedon = now() where routingid = '306961f9-483b-4407-9e0a-04fdd969bf68';
update routing set activeflag =0, updatedby = 'CDM-18785', updatedon = now() where routingid = '1a8777e8-1640-4d4d-bba2-1eee464ebb7c';