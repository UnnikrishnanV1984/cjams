/*
   Issue Description: CDM-37335
   Category/ Module  : User Profile Phone Number
   Root cause: User requested to change the worker phone number from 301-247-1899 with 301-997-6216
   Fix Privided: 
*/

select phonenumber ,* from cjams.userprofilephonenumber where userprofilephonenumberid  = 'e86392b5-ef0a-4a08-8cba-4c485120a314';


update cjams.userprofilephonenumber set phonenumber ='301-997-6216', updatedby ='CDM-37335', updatedon = now()
where userprofilephonenumberid ='e86392b5-ef0a-4a08-8cba-4c485120a314';