/*
 * CDM-33929 - casehead not appearing on dashboard
 * Customer Email ID:julie.boyd@montgomerycountymd.gov
 * Customer Name:Julie Boyd
 * Focus Area:Persons: Household
 * Description - Dashboard:From the Workload screen, there is no head of household populating for case #231040155645. 
 * If the case is opened, the HOH is listed. 
 * the HOH name is appeared on the Global Search but It's not appearing under the Workload screen.
 * 
 */

--select * from getworkloadassignments('b3b22c73-2132-4a64-bfff-7f353dea75a1',null,'f8348f64-e5d4-4ee9-8cf4-2fe3627446fb',null,null,null,null,'open','f6ab02d5-c386-4659-8810-687fc191a967',1,20,null,'startdate','desc')
--select objecttypekey ,* from caseassignment where caseassignmentid in ('0d9c35ce-8284-4aa0-8641-de2c0bb27ec1','172e2162-f6dd-4565-81a4-1af58151d211','8a674bc5-b475-473a-a64d-ca9d99944ad6'); -- 2023-08-29 00:00:00.000

UPDATE cjams.caseassignment
SET objecttypekey='adoptioncase', updatedby='CDM-33929', updatedon=now() 
where caseassignmentid in  ('0d9c35ce-8284-4aa0-8641-de2c0bb27ec1','172e2162-f6dd-4565-81a4-1af58151d211');
