/*
 * CJAMS-66755 - User requested to delete case from approval inbox
 * Customer Email ID: christineb.whitworth@maryland.gov
 * Customer Name: Christine B. Whitworth
 * Focus Area: Services: Youth Transition Plan
 * Root cause:Case is still displaying even after approval and user requested to delete it
 * Fix Provided: Deleted the requested case from approval inbox
*/

update routing
set activeflag =0, updatedby='CJAMS-66755', updatedon=now()
where servicerequestnumber='241030401060' and eventcode='YTP' and routingid='6d8a8667-4c48-48dd-a44a-15313c588772';
