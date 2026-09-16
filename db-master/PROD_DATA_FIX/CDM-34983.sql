/*
 * CDM-34983 - unable to delete duplicate removal
 * Customer Email ID:briana.stern3@maryland.gov
 * Customer Name:Briana Stern
 * Focus Area:Child Removal
 * Description - 231030038016:Duplicate removal entered in CJAMS. Supervisor and worker unable to complete action to delete duplicate.
 * Remove the duplicate removal which under review status.
 * CJAMS PID # 3439633
 * 
 */

select activeflag, * from intakeservreqchildremoval where intakeservreqchildremovalid in ('ad8cf637-8fbf-4c74-bdbc-d5f2bcaedb25');
UPDATE cjams.intakeservreqchildremoval
SET activeflag=0, updatedby='CDM-34983', updatedon=now() 
WHERE intakeservreqchildremovalid in ('ad8cf637-8fbf-4c74-bdbc-d5f2bcaedb25');

select activeflag, * from intakeservreqchildremoval_history where intakeservreqchildremovalid in ('ad8cf637-8fbf-4c74-bdbc-d5f2bcaedb25');
UPDATE cjams.intakeservreqchildremoval_history
SET activeflag=0, updatedby='CDM-34983', updatedon=now() 
WHERE intakeservreqchildremovalid in ('ad8cf637-8fbf-4c74-bdbc-d5f2bcaedb25');

select activeflag, * from routing where objectid in ('ad8cf637-8fbf-4c74-bdbc-d5f2bcaedb25');
UPDATE cjams.routing
SET activeflag=0, updatedby='CDM-34983', updatedon=now() 
WHERE objectid in ('ad8cf637-8fbf-4c74-bdbc-d5f2bcaedb25');
