/*
 * CDM-33794 - Old Approvals Needing to be deleted
 * Customer Email ID:holly.santoro@maryland.gov
 * Customer Name:Holly Santoro
 * Focus Area:Services: Other
 * Description - Dashboard:Please delete these from my approval box. They are all old and I am unable to approve. 
 * Please remove below cases from the user pending approval dashboard as requested.
 * 3302120 - Guardianship Disclosure Review
 * 3301497 - Purchase Authorization
 * 3259293 - Case Plan 2 Review
 * 3227216 - Case Plan 2 Review
 * 
 */

select activeflag, routingstatustypeid, remarks,  *
    from routing 
where objectid = '4df7bb38-0219-4744-a804-a983e6ef1666' and activeflag  =1 and routingstatustypeid  =15 
order by insertedon desc;
	
UPDATE cjams.routing
SET activeflag=0, updatedby='CDM-33794', updatedon=now() 
WHERE routingid='a94fa777-d4b3-4094-beb5-94d888db95c2';

select activeflag, routingstatustypeid, remarks,  *
    from routing 
where objectid = '1751519' and activeflag  =1 and routingstatustypeid  =15 
order by insertedon desc;
	
UPDATE cjams.routing
SET activeflag=0, updatedby='CDM-33794', updatedon=now() 
WHERE routingid='1b9d4360-d27d-4d7d-b4c8-34685032be03';

select activeflag, routingstatustypeid, remarks,  *
    from routing 
where objectid = '856ccab1-4312-494e-ac22-cd67bc8a4d5d' and activeflag  =1 and routingstatustypeid  =15 
order by insertedon desc;
	
UPDATE cjams.routing
SET activeflag=0, updatedby='CDM-33794', updatedon=now() 
WHERE routingid='07758cc9-99e3-4fbe-8033-4712fa339d20';

select activeflag, routingstatustypeid, remarks,  *
    from routing 
where objectid = '0a10eda1-bdd3-47b5-b35e-6b3ae2fdc82b' and activeflag  =1 and routingstatustypeid  =15 
order by insertedon desc;
	
UPDATE cjams.routing
SET activeflag=0, updatedby='CDM-33794', updatedon=now() 
WHERE routingid='8f3e30e2-7f0c-4133-97b6-1b9b026ed1e9'; 