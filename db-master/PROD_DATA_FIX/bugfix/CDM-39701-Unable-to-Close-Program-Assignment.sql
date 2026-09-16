/*
   Issue Description: CDM-39701
   Category/ Module  :Incorrect program assignment and service case.
   Root cause:   a CPS case for this date and this program assignment should be removed for the 3 clients listed in this case 231030219432
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update personprogramarea set activeflag=0, updatedby='CDM-39701',updatedon=now()
where personprogramid ='995c7de3-1c42-4729-80a1-82769f937391' and personid='f73f2c77-3b11-4511-8beb-3155cbec0d1e';

update personprogramarea set activeflag=0, updatedby='CDM-39701',updatedon=now()
where personprogramid ='f8f3bda8-37f2-4a5b-bb9a-9e61d1119f95' and personid='c672fa36-dbc4-4b8d-880f-0770b90dfe4b';

update personprogramarea set activeflag=0, updatedby='CDM-39701',updatedon=now()
where personprogramid ='e80b83f0-42ff-4e84-b3b3-41dce4a5fa33' and personid='9d8848ee-e9b5-46d1-9ed3-92db4da88c4e';
