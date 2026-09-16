/*
 * CDM-33828 - removal episode
 * Customer Email ID:lisa.connor@maryland.gov
 * Customer Name:Lisa Connor
 * Description - 3275764:petition was created but episode date will not migrate to the curt order--Tyjiera McCoy 2403876
 * Root Cause: In intakeservreqcourtorder table intakeservicerequesthearingid='c7526656-5e60-482e-b97e-8ae8ead2f012'is not available. Hence data is not populating.
 * Fix: Deleted data from intakeservicerequestcourthearing table for intakeservicerequestcourthearingid='c7526656-5e60-482e-b97e-8ae8ead2f012';
 */

select * from gethearingdetails_v2('servicecase', '695e69ef-af14-4a94-b42a-e6eedff03338');
select * from getservicecasecourtorder('695e69ef-af14-4a94-b42a-e6eedff03338'); -- d49f94cf-34ef-426f-91f9-1a7ab8178d09

select * from cjams.intakeservreqcourtorder
WHERE intakeservicerequesthearingid='d49f94cf-34ef-426f-91f9-1a7ab8178d09';-- available
select * from cjams.intakeservreqcourtorder
WHERE intakeservicerequesthearingid='c7526656-5e60-482e-b97e-8ae8ead2f012';-- not available

select activeflag, * from intakeservicerequestcourthearing where intakeservicerequestcourthearingid = 'c7526656-5e60-482e-b97e-8ae8ead2f012';
UPDATE cjams.intakeservicerequestcourthearing
SET activeflag=0, updatedby='CDM-33828', updatedon=now() 
WHERE intakeservicerequestcourthearingid='c7526656-5e60-482e-b97e-8ae8ead2f012'; 