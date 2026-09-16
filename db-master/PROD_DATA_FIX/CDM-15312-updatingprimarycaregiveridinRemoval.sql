
/*
   Issue Description: CDM-15312
   Category/ Module  :  updating primary caregiver 
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- 0a9feabb-ad79-4700-8094-50de9828b638
update intakeservreqchildremoval set primarycaregiveractorid = '6d96d712-09eb-40a3-a6bf-40b5e8e1ea98', updatedby = 'CDM-15312', updatedon = now() where intakeservreqchildremovalid = '08577829-b458-4bb1-a223-bf5919a7b8b3';
