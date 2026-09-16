/*
 * CDM-34763 - Remove two pending MFIRA assessments
 * Customer Email ID:shanquel.saunders@maryland.gov
 * Customer Name:Shanquel Saunders
 * Focus Area:Assessments: MFIRA
 * Description - Dashboard:Hello,I would like to have the Heather R Huling-Rose and the Karim Allen MFIRA assessments removed from this list. 
 * Both of these cases have been closed for 3 years. 
 * Remove to MFIRA assessment review request from the Pending Approval dashboard.
 * Case # 20200262036035
 * Case # 20200182022923
 * 
 */		

select activeflag, routingid, routingstatustypeid, * from routing where objectid = 'bc6dd45c-12c7-4860-98b9-16703c82df8b';
UPDATE cjams.routing
SET activeflag=0, updatedby = 'CDM-34763', updatedon = now() 
WHERE routingid='12ce81b0-a9dd-4b58-b371-2a24c082ee8f' and routingstatustypeid=15 and objectid='bc6dd45c-12c7-4860-98b9-16703c82df8b';

select activeflag, routingid, routingstatustypeid, * from routing where objectid = '58f377c3-d433-4fa1-87fe-45b45e8d0a18';
UPDATE cjams.routing
SET activeflag=0, updatedby = 'CDM-34763', updatedon = now() 
WHERE routingid='bab91d9a-3e21-4bc6-bfad-30191b0cfbfa' and routingstatustypeid=15 and objectid='58f377c3-d433-4fa1-87fe-45b45e8d0a18';
