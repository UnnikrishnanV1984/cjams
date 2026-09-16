/* Issue Description:CDM-14124 - Removal case assignment from routing table
   Category/ Module  :  remove case assignment
   Root cause: unable to reproduce this
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 

*/

update routing set activeflag=0, updatedby='CDM-14124', updatedon =now() where routingid='19330ea1-748b-4a6f-bf54-3a352c6a6dc9' and objectid= '5491c079-64dd-45f3-a5bb-0247e9dbd99a' and routingstatustypeid=2;

