update serviceplan set 
	serviceplancandidacy = 
		'{
   			 "candidates": [
        		{
           		 "id": "2581397",
           		 "name": "Isabella Madison Fowler",
           		 "candidacy": "0"
      		  }
   		 ]
		}',
	updatedon = now(),
	updatedby = 'CDM-11700'
	where serviceplanid in ('a2e47aef-b880-4080-a6e9-6345983a0733', 'e36ca890-f50c-41f5-bcc3-e99fc1a294fb');
	
	