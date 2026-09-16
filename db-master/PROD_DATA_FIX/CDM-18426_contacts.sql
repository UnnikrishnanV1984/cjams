/* Issue Description:CDM-18426 Removal in wrong case
   Category/ Module  : Case Child Removal
   Root cause: Multiple cases for child, and entered in wrong case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 

*/
 
update cjams.progressnote 
set entitytypeid = '3653de5d-3a25-433c-8109-253954919bfe', updatedon = now(), updatedby = 'CDM-18426'
where entitytypeid IN ('cda95e07-f6ea-4b54-b592-1add59399fee') 
and servicecaseid = 'cda95e07-f6ea-4b54-b592-1add59399fee';

UPDATE cjams.meetingrecording 
set servicecaseid = '3653de5d-3a25-433c-8109-253954919bfe', updatedon = now(), updatedby = 'CDM-18426' 
where meetingrecordingid = '63ed3324-4cdf-45fa-946b-cb519a4306ee' 
and servicecaseid='cda95e07-f6ea-4b54-b592-1add59399fee';

UPDATE cjams.documentproperties 
set servicecaseid = '3653de5d-3a25-433c-8109-253954919bfe', updatedon = now(), updatedby = 'CDM-18426' 
where  servicecaseid='cda95e07-f6ea-4b54-b592-1add59399fee';

UPDATE cjams.assessment 
set servicecaseid = '3653de5d-3a25-433c-8109-253954919bfe', 
objectid = '3653de5d-3a25-433c-8109-253954919bfe', updatedon = now(), updatedby = 'CDM-18426' 
where  servicecaseid='cda95e07-f6ea-4b54-b592-1add59399fee';

UPDATE cjams.assessment 
set servicecaseid = '3653de5d-3a25-433c-8109-253954919bfe', 
objectid = '3653de5d-3a25-433c-8109-253954919bfe', updatedon = now(), updatedby = 'CDM-18426' 
where  servicecaseid='cda95e07-f6ea-4b54-b592-1add59399fee';

--adding the userid to display in assessments, otherwise it is blank with the cdm id.
UPDATE cjams.assessment 
set updatedby = '4c7c9ba7-11d3-4ee3-a419-1fbb9ea95ef8' 
where assessmentid  = '1e7a4d0d-247f-428a-aeef-a8c144e2510e';
UPDATE cjams.assessment 
set updatedby = '31384dc2-8003-4935-9d5b-464871645eb1' 
where assessmentid  = 'fd3d36f0-d22f-4cf1-82ad-808109b3f342';
