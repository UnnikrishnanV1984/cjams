 /*
  Issue Description: CIDM-3908 -- Rollback the data fixes for Gendertype field especially for 88 "Invalid"
   Category/ Module  :  Person profile
   Root cause: reveritng back the gendertype key for 88
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/
update cjams.person set gendertypekey='88',updatedby = 'CIDM-3908', updatedon = now()
where 
cjamspid in (
1987138,
10737244,
200138296,
200138554,
200138565,
200142560,
200145233,
200145972,
200146226,
200147457,
200159932,
200177855,
200179153,
200244855,
200302595,
200308822,
200310650,
200566985,
200639236,
200650371,
200655071,
200656651,
200658992,
200662224,
200665874,
200769864,
200771001,
200772294,
200778399,
200785590,
200790947
);
