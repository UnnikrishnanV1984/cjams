/*
   Issue Description: CDM-23440
        end date: 2022-03-03 10:30:49, personid = 'c7dafb5f-ffdd-4a4d-bd8f-98bd80a0238d' personprogramid = '3e99a3a9-7b83-4865-819b-436e8afb6931'
   Category/ Module  : Need to remove end date for program assignemnt
   Root cause: user wants to remove the records
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update personprogramarea ppa set ppa.enddate = null, ppa.updatedby = 'CDM-23440', ppa.updatedon = now()
where ppa.personid = 'c7dafb5f-ffdd-4a4d-bd8f-98bd80a0238d' AND ppa.activeflag =1 and ppa.sourcetype = 'CW' 
and ppa.personprogramid = '3e99a3a9-7b83-4865-819b-436e8afb6931';