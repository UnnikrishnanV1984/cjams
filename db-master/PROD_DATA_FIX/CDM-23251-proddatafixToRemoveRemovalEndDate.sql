/*
   Issue Description: CDM-23251
   Category/ Module  : Prod data fix to update End Date
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

-- 2022-05-26
update personprogramarea set enddate = null, updatedon = now(), updatedby = 'CDM-23251'
where personprogramid = 'd0dd0099-1004-47fb-b825-33224553d3b6';

-- 2022-05-26 09:30:00.000	ADPFIN
update intakeservreqchildremoval set exitdate = null, removalexitreason = null, updatedby = 'CDM-23251', updatedon = now()  
where intakeservreqchildremovalid = 'f87e245c-812f-40da-b6a8-fca19f8f6c80';