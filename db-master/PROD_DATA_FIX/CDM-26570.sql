/*
  Issue Description: CDM-26570 cjams issue
   Category/ Module  :  user management
   Root cause: User is present in sailpoint and not in DB
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/
select * from cjams.createnewuser('carolyne.burton@maryland.gov', 'Carolyne', 'Burton', '', 'Carolyne Burton', 'CW', 'CJAMS_CWCASEWORKER', '1430', '1430_53', 'Substance Exposed Newborn 1', 'Baltimore','Towson', 'Towson', '', '410-853-3742', '1234', '1234', 'CPS Worker', '', 'toni.mayes@maryland.gov', '', 'add');
