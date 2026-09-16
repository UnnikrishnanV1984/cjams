/*
   Issue Description: CDM-23690
   Category/ Module  : updating person in the program area
   Root cause: updating person in the program area
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update personprogramarea set updatedby = 'ef3032b3-2f5a-4b48-8b27-c33cf654abf6',
updatedon = now() where personprogramid = 'baee9100-6ba6-4688-937b-825f924b5623';