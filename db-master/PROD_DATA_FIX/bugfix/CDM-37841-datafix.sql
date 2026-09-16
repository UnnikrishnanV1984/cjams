/*
   Issue Description: CDM-37841
   Category/ Module  :Incorrect program assignment and service case.
   Root cause:   a CPS case for this date and this program assignment should be removed for the 5 clients listed in this case. 241030292855 
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update personprogramarea set activeflag=0, updatedby='CDM-37841',updatedon=now()
where personprogramid ='b8fd5821-4503-4fb4-a0a1-a21c25666fc6' and personid='5002a57c-1ef2-4f03-a228-2b17f1908999';

update personprogramarea set activeflag=0, updatedby='CDM-37841',updatedon=now()
where personprogramid ='4d66bab4-c571-43a3-aaed-a7c422cca53b' and personid='31a69437-b749-4558-8880-ce7fb34cb15a';

update personprogramarea set activeflag=0, updatedby='CDM-37841',updatedon=now()
where personprogramid ='13cc0ccb-bfe7-488d-96d6-3af9e019ea2b' and personid='469e439c-a0ba-428e-80c0-dd268b8a6ac3';

update personprogramarea set activeflag=0, updatedby='CDM-37841',updatedon=now()
where personprogramid ='f7a13066-c285-483c-98a1-c00f389a4bf5' and personid='5091c14b-f8d1-4e9d-b489-127f11980b32';

update personprogramarea set activeflag=0, updatedby='CDM-37841',updatedon=now()
where personprogramid ='619e6c1d-a2c2-4fac-ada6-ca68ad933b71' and personid='4d199562-5cc8-446e-89c9-2acc70dd537e';