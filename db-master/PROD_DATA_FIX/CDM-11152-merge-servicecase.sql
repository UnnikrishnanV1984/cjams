select * from createservicecase('f33b8325-0be2-45d0-ab4d-38564b5b2384', '4bded10b-f470-4e0f-8845-9b47500f2d2b', 0, '299210ac-c6df-4985-a02b-bdeda0cdad67');

update actor set servicecaseid = '4bded10b-f470-4e0f-8845-9b47500f2d2b', updatedby = 'CDM-11152', updatedon = now()
where servicecaseid = '51964ced-c1d2-40d7-a3a9-b02ffecd0d7f';

update intakeservicerequestactor set servicecaseid = '4bded10b-f470-4e0f-8845-9b47500f2d2b', updatedby = 'CDM-11152', updatedon = now()
where servicecaseid = '51964ced-c1d2-40d7-a3a9-b02ffecd0d7f';

update personrole set servicecaseid = '4bded10b-f470-4e0f-8845-9b47500f2d2b', updatedby = 'CDM-11152', updatedon = now()
where servicecaseid = '51964ced-c1d2-40d7-a3a9-b02ffecd0d7f';

update progressnote set servicecaseid = '4bded10b-f470-4e0f-8845-9b47500f2d2b', updatedby = 'CDM-11152', updatedon = now()
where servicecaseid = '51964ced-c1d2-40d7-a3a9-b02ffecd0d7f';

update Intakeservreqchildremoval set servicecaseid = '4bded10b-f470-4e0f-8845-9b47500f2d2b', updatedby = 'CDM-11152', updatedon = now()
where servicecaseid = '51964ced-c1d2-40d7-a3a9-b02ffecd0d7f';

update placement set servicecaseid = '4bded10b-f470-4e0f-8845-9b47500f2d2b', updatedby = 'CDM-11152', updatedon = now()
where servicecaseid = '51964ced-c1d2-40d7-a3a9-b02ffecd0d7f';

update permanencyplan set servicecaseid = '4bded10b-f470-4e0f-8845-9b47500f2d2b', updatedby = 'CDM-11152', updatedon = now()
where servicecaseid = '51964ced-c1d2-40d7-a3a9-b02ffecd0d7f';

update tb_Service_log set case_id = 3291240, update_user_id = 'CDM-11152', update_ts = now()
where case_id = 202107006534;

update snapshothist set objectid = '4bded10b-f470-4e0f-8845-9b47500f2d2b', updatedby = 'CDM-11152', updatedon = now()
where objectid = '51964ced-c1d2-40d7-a3a9-b02ffecd0d7f';

update servicecase set activeflag = 0, updatedby = 'CDM-11152', updatedon = now()
where servicecaseid = '51964ced-c1d2-40d7-a3a9-b02ffecd0d7f';

update progressnote set entitytypeid = '4bded10b-f470-4e0f-8845-9b47500f2d2b', updatedby = 'CDM-11152', updatedon = now()
where servicecaseid = '4bded10b-f470-4e0f-8845-9b47500f2d2b' or entitytypeid in ('643a1396-b037-40be-b611-67ee2b91a1c7', '51964ced-c1d2-40d7-a3a9-b02ffecd0d7f');

update caseassignment set objectid = '4bded10b-f470-4e0f-8845-9b47500f2d2b', updatedby = 'CDM-11152', updatedon = now() 
where objectid = '51964ced-c1d2-40d7-a3a9-b02ffecd0d7f';

update assessment set objectid = '4bded10b-f470-4e0f-8845-9b47500f2d2b', updatedby = 'CDM-11152', updatedon = now() 
where objectid = '51964ced-c1d2-40d7-a3a9-b02ffecd0d7f';

