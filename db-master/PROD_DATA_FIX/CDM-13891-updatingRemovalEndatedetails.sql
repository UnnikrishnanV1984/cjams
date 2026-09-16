update personprogramarea set enddate = null, updatedon = now() where personprogramid = '57bfe437-cc3c-46ad-823b-a95dd15a534a';
update placement set enddatetime = null, endtime = null, updatedon = now(), updatedby = 'CDM-13891' where placementid = 'c971efa9-4599-4dd1-8410-caf0cf8abc00' and activeflag = 1;
update placementrevision set exitdate = null, exittime = null, updatedon = now(), updatedby = 'CDM-13891' where placementid = 'c971efa9-4599-4dd1-8410-caf0cf8abc00' and activeflag = 1;
update intakeservreqchildremoval set exitdate = null, updatedon = now(), updatedby = 'CDM-13891' where removalid = '200096';
