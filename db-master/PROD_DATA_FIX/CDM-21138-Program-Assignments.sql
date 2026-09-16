/*
   Issue Description: CDM-21138
   Category/ Module  : Program assignment
   Root cause: user wants to change updated by in PA
   Pull request# for code fix: 7006
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update personprogramarea set updatedby = '30af9b82-e4d5-441f-8ede-a19af5447151' , updatedon =  now()
where personprogramid = '1913533d-781a-4822-b5f3-d2fdbaae8c45';