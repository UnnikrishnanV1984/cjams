/*
   Issue Description: CDM-16954
   Category/ Module  : Approval removal
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix:  
   
*/

update routing  set activeflag = 0 , updatedby ='CDM-16954',updatedon = now() 
	where routingid in ('acf934b3-515e-4393-97ed-6486fc40dbc3',
						'8c426a38-8a65-47e9-b799-b66aee7795d8',
						'6fe47ed6-63cb-4624-884a-f7ba8e6c0a63',
						'fe7d0d45-daac-4b5c-afbd-044f8065841c',
						'60213950-9531-4d13-a725-902474aba41c',
						'f896fb0d-3f46-4b52-a688-6fc21936dc54',
						'b8b0e854-ae34-4579-b280-0774c5f1ae15',
						'd35ab254-51e8-4b25-9f16-9c65daf19773',
						'ac3f6a90-8124-485a-bcd6-133c96e3ddf6');