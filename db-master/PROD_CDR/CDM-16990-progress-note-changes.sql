update 
cjams.progressnote 
set 
progressnotetypeid = 'a1f78e9f-ea8d-4f0b-8df5-7d4c0eda21cc',
updatedby = 'CDM-16990',
updatedon = now()
where 
progressnoteid = '5f6fa1bc-8ac6-4208-89ce-8e41b6ffe1c0';

update 
cjams.contactparticipant 
set
activeflag = 0,
updatedby = 'CDM-16990',
updatedon = now()
where 
progressnoteid = '5f6fa1bc-8ac6-4208-89ce-8e41b6ffe1c0';