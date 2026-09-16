/*
 * CDM-35036 - error placement/removal/program assignment
 * Customer Email ID:vivian.mayo@maryland.gov
 * Customer Name:Vivian Mayo
 * Focus Area:Placement
 * Description - 231030202426:Hello,RE: Laniera Shuman, case number 3307729On 10/19/23, Laniera entered foster care with a kinship 
 * living arrangement. However, the living arrangement, removal and program assignments were entered into her duplicate 
 * case 231030202426 in error. Please remove/delete the erroneous living arrangement in the duplicate case 231030202426 that 
 * is end-dated 10/19/23 2:10 PM. Please remove/delete the erroneous program assignment in the duplicate case. (see attachment). 
 * Please remove/delete the erroneous removal in the duplicate case. (see attachment).
 * The correct living arrangement was entered into Laniera's correct case 3307729. It's start date is 10/19/23; 2:30 PM and no end-date. 
 * do the data fix for the following.
 * Case ID - 231030202426
 * CJAMS PID - 1880039
*/


--select activeflag, removalid, * from cjams.intakeservreqchildremoval where intakeservreqchildremovalid = '299646f3-1d15-46cb-b620-81f2aa7819bf';
UPDATE cjams.intakeservreqchildremoval
SET activeflag=0, updatedby='CDM-35036', updatedon=now() 
WHERE intakeservreqchildremovalid='299646f3-1d15-46cb-b620-81f2aa7819bf'::uuid;

--select activeflag ,* from cjams.personprogramarea where personprogramid = '95a75fbd-0438-4371-8dac-49f788d81906';
UPDATE cjams.personprogramarea
SET activeflag=0, updatedby='CDM-35036', updatedon=now() 
where personprogramid='95a75fbd-0438-4371-8dac-49f788d81906'::uuid;

--select * from cjams.tb_client_eligibility where removal_id ='290823';
--select activeflag ,* from placement where placementid = 'cdf45176-5cf5-4d24-8211-4aec0d2e4f82';
UPDATE cjams.placement
SET activeflag=0, updatedby='CDM-35036', updatedon=now() 
WHERE placementid='cdf45176-5cf5-4d24-8211-4aec0d2e4f82'::uuid;

--select * from tb_client_eligibility where removal_id = 290823;
update tb_client_eligibility
set end_dt = null,
    update_user_id = 'CDM-35036',
    update_ts = now()
where removal_id = 290823;

--select activeflag, * from routing where objectid = '299646f3-1d15-46cb-b620-81f2aa7819bf' and activeflag = 1;
UPDATE cjams.routing
SET activeflag=0, updatedby='CDM-35036', updatedon=now() 
WHERE routingid='cbef1bff-4073-4db0-86c6-da31c36bee71';

--select activeflag, * from intakeservreqchildremoval_history WHERE intakeservreqchildremovalid='299646f3-1d15-46cb-b620-81f2aa7819bf'::uuid and activeflag = 1;
UPDATE cjams.intakeservreqchildremoval_history
SET activeflag=0, updatedby='CDM-35036', updatedon=now() 
WHERE intakeservreqchildremovalid='299646f3-1d15-46cb-b620-81f2aa7819bf'::uuid and activeflag = 1;
