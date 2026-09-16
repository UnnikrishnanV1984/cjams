-- CDM-5948 - Service case and intake request does not have persons involved in sync
-- Adding intakeserviceid to the persons in intake so that the persons appear in household section


update actor set intakeserviceid = '05cf7515-f844-4458-aace-91de8c30710b', updatedby = 'CDM-5948', updatedon = now() where actorid in ('d4307837-7845-4996-ba9f-794fb16278fa','d969c90b-be93-409c-9337-cc3a4bd9d5f0','eeee9cb9-6889-4363-99c4-cd3685575116') and activeflag =1;
update intakeservicerequestactor set intakeserviceid = '05cf7515-f844-4458-aace-91de8c30710b', updatedby = 'CDM-5948', updatedon = now() where intakeservicerequestactorid in ('4e98b7e9-d3dc-465a-b809-e454f88a42ca','00fc09ee-38c4-4082-a244-4b3b84cd4228','66fa80b2-dd0e-4ee0-8c42-6e02be78695b') and activeflag = 1;