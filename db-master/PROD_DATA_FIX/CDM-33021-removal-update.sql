/*
   Issue Description: CDM-33021
   Category/ Module  : Prod data fix toupdate removal details
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update intakeservreqchildremoval set vpaenddate ='2025-07-31 00:00:00',isbothparentssigned = 2,parent1id ='3329208',volrelinquishment = 0,updatedby ='CDM-33021',updatedon =now() where intakeservreqchildremovalid ='d1e2783c-19e2-451b-9e9b-b1f533e27bed' ;
