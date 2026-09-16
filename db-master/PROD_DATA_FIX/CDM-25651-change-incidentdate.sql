/*
   Issue Description: CDM-25651
   Category/ Module  :  MALTREATMENT ALLEGATION
   Root cause: user requeseted to change the incident date
   Pull request# for code fix: 6580
   Reason why no related code fix: user error
*/

update investigationallegation 
set incidentdate ='2014-01-01 00:00:00',
updatedby ='CDM-25651',
updatedon =now() 
where investigationallegationid = '6747394b-f8aa-4431-a20f-fab902298c8a';