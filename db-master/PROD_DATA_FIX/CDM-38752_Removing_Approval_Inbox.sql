 /*

   Issue Description: Service plans from multiple cases submitted for approval in April 2024.
                      Have supervisor approval but are still appearing in Inbox as if pending approval. 
                      Clicking hyperlink to approval service plan shows they were already approved. 
                      Need to remove all review and approval request under "Jennifer Neff".

   Category/ Module  :  Approval Inbox

   Root cause: User request

   Fix provided : Updated the routing table for eight cases that were assigned to Jennifer Neff to soft delete.

   Code fix ticket#:

   Reason why no related code fix: 

   Status of the code fix if already submitted and expected prod fix date: 

   Backup before update/ delete:

*/


update routing
set activeflag = 0, updatedby = 'CDM-38752', updatedon = now()
where servicerequestnumber in ('231030219897','231030227995','231030196474','231030196474','221030013412','211030008307')
and tosecurityusersid = 'f2ecd2cb-0e6b-41e8-8593-f3ab5f59085f' and activeflag = 1;

update routing
set activeflag = 0, updatedby = 'CDM-38752', updatedon = now()
where routingid = '254303cd-c91c-4150-a8e3-0ac180e46da6'
and tosecurityusersid = 'f2ecd2cb-0e6b-41e8-8593-f3ab5f59085f' and activeflag = 1; -- For case# 3289635

update routing
set activeflag = 0, updatedby = 'CDM-38752', updatedon = now()
where routingid = 'ea451e74-b6ef-47f5-a066-8c0160d370f4'
and tosecurityusersid = 'f2ecd2cb-0e6b-41e8-8593-f3ab5f59085f' and activeflag = 1; -- For case# 211020169286 (IR)