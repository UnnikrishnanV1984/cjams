/* 
    Issue Description: CDM-38108
   Category/ Module  : Rate Begin Date
   Root cause: change the Rate Start Date, although this GAP request has been approved. The date needs to be changed to 12/21/23. 
   Please advise on ways that you can assist, as this directly impacts provider placements.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    void the rejected provider placement from backend
*/

update gapagreementrate 
set startdate='2023-12-21 00:00:00', updatedby='CDM-38108', updatedon=now() 
where gapagreementrateid = 'ef52a8f6-94d7-45b8-a87f-a6b58e61dacd' and gapagreementid = 'fd4a845c-4ee0-470b-b21d-902aac53d108';

update gapratesrevision
set ratestartdate='2023-12-21 00:00:00', updatedby='CDM-38108',updatedon=now(), approvaldate = now()
where gaprateid in ('ef52a8f6-94d7-45b8-a87f-a6b58e61dacd');