/*
   Issue Description: CDM-39116
   Category/ Module  : Assignments
   Root cause: Case # 241022096717 is showing twice under "My IR Cases" on my Dashboard.
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update caseassignment set activeflag=0
where caseassignmentid='fb63c892-acc4-4ad2-aba2-d05c2c57a3fc'
and objectid='226485f9-a71f-400a-a9d3-543d7bc29467';


update routing set activeflag=0 where routingid='437fa6eb-378a-4459-94e1-8caacac4a2ee'
and objectid='226485f9-a71f-400a-a9d3-543d7bc29467';
