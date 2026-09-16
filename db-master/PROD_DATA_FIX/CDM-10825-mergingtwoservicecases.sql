-- CDM-10825

update actor set servicecaseid = '12f3ab6e-1065-41ef-9991-a2f51e0940b6', updatedby = 'CDM-10825', updatedon = now()
where servicecaseid = 'b399410e-acd8-485c-a859-b9a6c336ddd6';

update intakeservicerequestactor set servicecaseid = '12f3ab6e-1065-41ef-9991-a2f51e0940b6', updatedby = 'CDM-10825', updatedon = now()
where servicecaseid = 'b399410e-acd8-485c-a859-b9a6c336ddd6';

update personrole set servicecaseid = '12f3ab6e-1065-41ef-9991-a2f51e0940b6', updatedby = 'CDM-10825', updatedon = now()
where servicecaseid = 'b399410e-acd8-485c-a859-b9a6c336ddd6';

update progressnote set servicecaseid = '12f3ab6e-1065-41ef-9991-a2f51e0940b6', updatedby = 'CDM-10825', updatedon = now()
where servicecaseid = 'b399410e-acd8-485c-a859-b9a6c336ddd6';

update Intakeservreqchildremoval set servicecaseid = '12f3ab6e-1065-41ef-9991-a2f51e0940b6', updatedby = 'CDM-10825', updatedon = now()
where servicecaseid = 'b399410e-acd8-485c-a859-b9a6c336ddd6';

update placement set servicecaseid = '12f3ab6e-1065-41ef-9991-a2f51e0940b6', updatedby = 'CDM-10825', updatedon = now()
where servicecaseid = 'b399410e-acd8-485c-a859-b9a6c336ddd6';

update permanencyplan set servicecaseid = '12f3ab6e-1065-41ef-9991-a2f51e0940b6', updatedby = 'CDM-10825', updatedon = now()
where servicecaseid = 'b399410e-acd8-485c-a859-b9a6c336ddd6';

update tb_Service_log set case_id = 3280122, update_user_id = 'CDM-10825', update_ts = now()
where case_id = 202101905463;

update snapshothist set objectid = '12f3ab6e-1065-41ef-9991-a2f51e0940b6', updatedby = 'CDM-10825', updatedon = now()
where objectid = 'b399410e-acd8-485c-a859-b9a6c336ddd6';

update servicecase set activeflag = 0, updatedby = 'CDM-10825', updatedon = now()
where servicecaseid = 'b399410e-acd8-485c-a859-b9a6c336ddd6';

update progressnote set entitytypeid = '12f3ab6e-1065-41ef-9991-a2f51e0940b6', updatedby = 'CDM-10825', updatedon = now()
where servicecaseid = '12f3ab6e-1065-41ef-9991-a2f51e0940b6' or entitytypeid in ('b399410e-acd8-485c-a859-b9a6c336ddd6');