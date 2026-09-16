Update userprofile set
supervisorid = '8cb570ed-39e2-4a95-8089-76f5951d3c33',
updatedby='CDM-875',
updatedon=now() where
securityusersid='1b93840a-a567-416b-8147-867b9376eedc' and
supervisorid = '6e0584d0-90b0-4d46-87ce-004e6b740419' and activeflag=1;
update usernotification set 
activeflag=0,
updatedby='CDM-952' where
usernotificationid ='7312f89c-9688-4983-9aee-b9ac1aac6faa'
and securityusersid='f156b6d0-67af-404f-bf79-d4fbd737716c' 
and activeflag=1;