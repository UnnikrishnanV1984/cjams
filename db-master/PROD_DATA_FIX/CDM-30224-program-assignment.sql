/*
   Issue Description: CDM-30224
   Category/ Module  : program assignment
   Root cause: user wants to  update start date
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do only data fix
*/

update personprogramarea 
set startdate = '2022-12-25 00:00:00',
updatedby = 'CDM-30224',
updatedon = now()
where personprogramid ='39b5f3c5-1053-4972-9b6c-a000566c3972';