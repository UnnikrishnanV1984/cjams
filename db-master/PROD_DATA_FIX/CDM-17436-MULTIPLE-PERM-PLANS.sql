/*
   Issue Description: CDM-17436
      Category/ Module  :  permanency plan 
   Root cause: multiple permanency plans
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update permanencyplan
	set activeflag = 0, updatedby = 'CDM-17436', updatedon = now() 
	where permanencyplanid in ('9ffe1240-3664-45f1-a97b-241de0bb960b',
								'3c3ac5d8-dfc0-42df-87d9-196251f220d5',
								'f5b80fd6-76f0-422a-84a2-90afed929391',
								'2f160b05-b271-40b3-bc0b-34ab8e3d19f3',
								'9df036fd-1dd7-4e61-bce2-86acc6fcc0dd',
								'f76e7611-09b0-4cab-95cc-88a5d7500a8e',
								'87179c5e-b6fd-4319-9d81-db5e91713fd9');

update routing
	set activeflag = 0, updatedby = 'CDM-17436', updatedon = now() 
	where objectid in ('9ffe1240-3664-45f1-a97b-241de0bb960b',
								'3c3ac5d8-dfc0-42df-87d9-196251f220d5',
								'f5b80fd6-76f0-422a-84a2-90afed929391',
								'2f160b05-b271-40b3-bc0b-34ab8e3d19f3',
								'9df036fd-1dd7-4e61-bce2-86acc6fcc0dd',
								'f76e7611-09b0-4cab-95cc-88a5d7500a8e',
								'87179c5e-b6fd-4319-9d81-db5e91713fd9');