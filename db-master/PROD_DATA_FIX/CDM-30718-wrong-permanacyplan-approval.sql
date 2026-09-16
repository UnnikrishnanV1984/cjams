/*
   Issue Description: CDM-30733
   Category/ Module  : Permanencyplan 
   Root cause: update the wrong caseworker name
   Pull request# for code fix: 8918
   Reason why no related code fix: 
    requested a data fix to resolve
*/
     update 	routing 
set 	fromsecurityusersid = 'e9ff2da6-3f06-4123-9788-acc6117867e0',
     tosecurityusersid = '0df3e7ac-4476-4dde-bf04-af2c7063d102',
		updatedby = 'CDM-30718',
		updatedon = now()
where 	routingid = '5f92f775-b36c-4d9e-aff7-55b068f94301';

update permanencyplanhistory set insertedby = 'e9ff2da6-3f06-4123-9788-acc6117867e0',updatedby ='CDM-30718',updatedon = now() where permanencyplanid ='8a37013b-a6f2-45b1-873b-eabd91c523ae';