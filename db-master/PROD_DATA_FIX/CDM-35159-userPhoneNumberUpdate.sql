/*
   Issue Description: CDM-35159
   Category/ Module  : User Profile Phone Number
   Root cause: User requested to change the worker phone number from 608-692-5531 with 410-562-8745
   Fix Privided: 
*/

update cjams.userprofilephonenumber set phonenumber ='410-562-8745', updatedby ='CDM-35159', updatedon = now()
where userprofilephonenumberid ='7cd190bf-3233-4079-a608-fb330ae44d98';