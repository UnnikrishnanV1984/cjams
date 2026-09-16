/*
 * CDM-34276 - Approved request remains in the Approval Inbox.
 * Customer Email ID:teresa.boston@maryland.gov
 * Focus Area: Approval Inbox
 * Description - 3272447:STEPHON PHILLIPS Case #3272447, request has been approved. Please remove the request from the Approval Inbox.
 */

UPDATE cjams.routing
SET  activeflag=0,  updatedby='CDM-34276', updatedon=now()
WHERE routingid='8dca093f-a9ce-4621-a98a-df2ffe11cf82'::uuid and eventcode='AARR' and servicerequestnumber='3272447';
