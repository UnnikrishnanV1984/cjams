/*
   Issue Description: CDM-17935
      Category/ Module  : case close
   Root cause: USER ASKED TO REMOVE 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update servicecasedisposition 
	set activeflag = 0, 
		updatedby = 'CDM-17935',
		updatedon = now() 
	where servicecasedispositionid in ('0b87f713-5f92-4545-ba28-3ad6515c7200', 'ecb02e63-c9ea-428c-84dc-fb0cb716071d', 'a934d0d8-163d-4ca6-8008-77150c767cd0', '2f45a76e-eae4-473c-b3da-96ec0709a51f', '11ad3197-85ef-43bf-8feb-2c3b2a687bc7', '117373cd-992f-4bbc-aa80-9cc65d5a481a');

	update routing 
	set activeflag = 0,
		updatedby = 'CDM-17935',
		updatedon = now()
	where objectid in ('0b87f713-5f92-4545-ba28-3ad6515c7200', 'ecb02e63-c9ea-428c-84dc-fb0cb716071d', 'a934d0d8-163d-4ca6-8008-77150c767cd0', '2f45a76e-eae4-473c-b3da-96ec0709a51f', '11ad3197-85ef-43bf-8feb-2c3b2a687bc7', '117373cd-992f-4bbc-aa80-9cc65d5a481a');