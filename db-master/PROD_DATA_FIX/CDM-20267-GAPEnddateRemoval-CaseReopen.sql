/*
   Issue Description: CDM-20267
   Category/ Module  : Case status and GAP end date
   Root cause: user wants to remove date and case sttaus open.
   Pull request# for code fix: 4784
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
	
update servicecasedisposition set activeflag  = 0, updatedby = 'CDM-20267', updatedon  = now()
where servicecasedispositionid = '911dab47-07f7-4166-b652-0884af57a6ac';

UPDATE servicecase SET statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-20267',updatedon = now() 
WHERE servicecaseid = '69745a51-4156-4fae-9478-7d0d083ec14c';

update personprogramarea set enddate = null, updatedby = 'CDM-20267', updatedon = now()
where personprogramid in ('e2218627-b303-401e-b620-b12aee8772ba', '73c7bfab-e780-4d9e-acb1-0b43d56ff2b9', '2c16733a-316d-40fd-98f1-ed1057ba406a');
