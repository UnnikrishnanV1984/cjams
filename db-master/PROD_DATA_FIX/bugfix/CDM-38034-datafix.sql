/*
   Issue Description: CDM-38034
   Category/ Module  : System Alert message
   Root cause: Alert notification is not displaying the case number 
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update usernotification set objectcasenumber='241040298063', updatedon =now(), updatedby ='CDM-38034'
where usernotificationid = '4d13d3a1-2df3-4d81-bf91-a7df6ccacb7f';
update usernotification set objectcasenumber='241040297494', updatedon =now(), updatedby ='CDM-38034'
where usernotificationid = 'f6d5e2cf-869c-4171-81bc-ec71b73e59c4';