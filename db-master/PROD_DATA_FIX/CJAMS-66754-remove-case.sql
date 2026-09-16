/*
 * CJAMS-66754 - User requested to delete case from approval inbox
 * Customer Email ID: desiree.cabotaje@maryland.gov
 * Customer Name: Desiree Cabotaje
 * Focus Area: Services: Permanency Plan
 * Root cause:Case is still displaying even after approval and user requested to delete it
 * Fix Provided: Deleted the requested case from approval inbox
*/

update routing
set activeflag =0, updatedby='CJAMS-66754', updatedon=now()
where servicerequestnumber='221030016468' and eventcode='PPLR' and routingid='453423af-8e37-4354-bba9-8c1cd4e28f50';