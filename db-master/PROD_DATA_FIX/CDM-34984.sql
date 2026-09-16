/*
 * CDM-34984 - duplicate removal
 * Customer Email ID:briana.stern3@maryland.gov
 * Customer Name:Briana Stern
 * Focus Area:Child Removal
 * Description - 231030038016:Duplicate removal entered in CJAMS. Supervisor and worker unable to complete action to delete duplicate. 
 * remove those two duplicate removal which under review status.
 * CJAMS PID # 3440559 (Shaniah Mensah)
 * 
 */

select activeflag, * from intakeservreqchildremoval where intakeservreqchildremovalid in ('e9ab9ecf-3208-4728-b730-0e9433d4ba71','04b98cf4-59be-430a-b5cf-2d8ebf56d454');
UPDATE cjams.intakeservreqchildremoval
SET activeflag=0, updatedby='CDM-34984', updatedon=now() 
WHERE intakeservreqchildremovalid in ('e9ab9ecf-3208-4728-b730-0e9433d4ba71','04b98cf4-59be-430a-b5cf-2d8ebf56d454');

select activeflag, * from intakeservreqchildremoval_history where intakeservreqchildremovalid in ('e9ab9ecf-3208-4728-b730-0e9433d4ba71','04b98cf4-59be-430a-b5cf-2d8ebf56d454');
UPDATE cjams.intakeservreqchildremoval_history
SET activeflag=0, updatedby='CDM-34984', updatedon=now() 
WHERE intakeservreqchildremovalid in ('e9ab9ecf-3208-4728-b730-0e9433d4ba71','04b98cf4-59be-430a-b5cf-2d8ebf56d454');

select activeflag, * from routing where objectid in ('e9ab9ecf-3208-4728-b730-0e9433d4ba71','04b98cf4-59be-430a-b5cf-2d8ebf56d454');
UPDATE cjams.routing
SET activeflag=0, updatedby='CDM-34984', updatedon=now() 
WHERE objectid in ('e9ab9ecf-3208-4728-b730-0e9433d4ba71','04b98cf4-59be-430a-b5cf-2d8ebf56d454');
