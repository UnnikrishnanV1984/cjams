/*
   Issue Description: CDM-13432
   Category/ Module  : case merge 
   Root cause: user wants to merge case and delete
   Pull request# for code fix: 7191
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closed. Need to do data fix
*/
update actor set servicecaseid = '4372487d-a3c4-434b-a496-4961e46c66aa', updatedby = 'CDM-13432', updatedon = now()
where servicecaseid = '950c3637-852d-4fe3-9bed-df8e3b3a1e3c';

update intakeservicerequestactor set servicecaseid = '4372487d-a3c4-434b-a496-4961e46c66aa', updatedby = 'CDM-13432', updatedon = now()
where servicecaseid = '950c3637-852d-4fe3-9bed-df8e3b3a1e3c';

update personrole set servicecaseid = '4372487d-a3c4-434b-a496-4961e46c66aa', updatedby = 'CDM-13432', updatedon = now()
where servicecaseid = '950c3637-852d-4fe3-9bed-df8e3b3a1e3c';

update progressnote set servicecaseid = '4372487d-a3c4-434b-a496-4961e46c66aa', updatedby = 'CDM-13432', updatedon = now()
where servicecaseid = '950c3637-852d-4fe3-9bed-df8e3b3a1e3c';

update Intakeservreqchildremoval set servicecaseid = '4372487d-a3c4-434b-a496-4961e46c66aa', updatedby = 'CDM-13432', updatedon = now()
where servicecaseid = '950c3637-852d-4fe3-9bed-df8e3b3a1e3c';

update placement set servicecaseid = '4372487d-a3c4-434b-a496-4961e46c66aa', updatedby = 'CDM-13432', updatedon = now()
where servicecaseid = '950c3637-852d-4fe3-9bed-df8e3b3a1e3c';

update permanencyplan set servicecaseid = '4372487d-a3c4-434b-a496-4961e46c66aa', updatedby = 'CDM-13432', updatedon = now()
where servicecaseid = '950c3637-852d-4fe3-9bed-df8e3b3a1e3c';

update tb_Service_log set case_id = 3208474, update_user_id = 'CDM-13432', update_ts = now()
where case_id = 3278469;

update snapshothist set objectid = '4372487d-a3c4-434b-a496-4961e46c66aa', updatedby = 'CDM-13432', updatedon = now()
where objectid = '950c3637-852d-4fe3-9bed-df8e3b3a1e3c';

update servicecase set activeflag = 0, updatedby = 'CDM-13432', updatedon = now()
where servicecaseid = '950c3637-852d-4fe3-9bed-df8e3b3a1e3c';

update progressnote set entitytypeid = '4372487d-a3c4-434b-a496-4961e46c66aa', updatedby = 'CDM-13432', updatedon = now()
where servicecaseid = '4372487d-a3c4-434b-a496-4961e46c66aa' or entitytypeid in ('277f51a4-c68e-4d0d-85f4-0df7f5c0611f', '950c3637-852d-4fe3-9bed-df8e3b3a1e3c');

update intakeservicerequest set servicecaseid = '4372487d-a3c4-434b-a496-4961e46c66aa', updatedby = 'CDM-13432', updatedon = now()
where intakenumber = 'I202100155608';