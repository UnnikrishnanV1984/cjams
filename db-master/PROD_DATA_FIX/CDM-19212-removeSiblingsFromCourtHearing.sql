
/*
   Issue Description: CDM-19212
   Customer Email ID: shara.hayden@maryland.gov
   Category/ Module  : Removing siblings from Hearing Court Details
   Root cause: user requeseted to remove siblings from court hearing who have permancy
   
*/
  
    
update hearingclients  set activeflag = 0 , updatedby ='CDM-16622', updatedon = now()     
   where hearingclientid in (
        '99b55cb3-779e-4519-9d76-fe674a19d73a', '11ca9898-5586-4a57-984a-0186414750ba', 
	    'd10cda4a-911a-48b8-b6cc-7411363fc77e', 'db2bc073-77f4-4225-8b9d-e8dd46f432d5',
	    'e499a9fc-27e8-45e8-8a27-73c15fe586cb', '8a486e7b-e95f-40b8-bbb4-14fa26266ea8'
    )
    
  