--CDM-186 Investigation case 2020050015833 and servicecase 3273121

update intakeservicerequestactor set servicecaseid = null, updatedby = 'CDM-186', updatedon = now()
WHERE intakeserviceid =  'd6a45f20-14b9-44eb-a4dc-58755c6f2f54' and servicecaseid = '17dd4b70-1ca2-48e8-83cc-d5dd36fda97a';

update actor set servicecaseid = null, updatedby = 'CDM-186', updatedon = now()
where intakeserviceid = 'd6a45f20-14b9-44eb-a4dc-58755c6f2f54' and servicecaseid = '17dd4b70-1ca2-48e8-83cc-d5dd36fda97a';

update servicecase set statustypekey='ASSGN', dispositioncode = 'Closed', startdate = '2018-10-01 00:00:00', enddate = '2018-11-29 00:00:00',
updatedby = 'CDM-186', updatedon = now() where servicecaseid = '17dd4b70-1ca2-48e8-83cc-d5dd36fda97a';

delete from servicecasedisposition where servicecasedispositionid = 'bc5390ab-5faf-48fc-8da4-32cdee5514be';

update routing set activeflag = 0 , updatedby = 'CDM-186', updatedon = now()
where objectid = '17dd4b70-1ca2-48e8-83cc-d5dd36fda97a' and eventcode = 'SRVC' and routingstatustypeid = 2 and activeflag = 1 ;

delete from servicecaserequest where servicecaseid = '17dd4b70-1ca2-48e8-83cc-d5dd36fda97a';

update intakeservicerequest set servicecaseid = null,  updatedby = 'CDM-186', updatedon = now()
WHERE intakeserviceid = 'd6a45f20-14b9-44eb-a4dc-58755c6f2f54' and servicecaseid = '17dd4b70-1ca2-48e8-83cc-d5dd36fda97a';

update assessment set servicecaseid = null,  updatedby = 'CDM-186', updatedon = now()
WHERE objectid =  'd6a45f20-14b9-44eb-a4dc-58755c6f2f54' and servicecaseid = '17dd4b70-1ca2-48e8-83cc-d5dd36fda97a';


--- program assignment update 2020027014891

update personprogramarea set enddate = '2020-03-17 16:09:52', datatransferflag = 'U', updatedon = now()
where personid in ('73ae696b-c094-45b1-980d-ec5318bbb6c0', '3b8915ac-2247-443d-85b7-02e204f46be2')
and entityid = '2020027014891' and programkey = 'CPS' and subprogramkey = 'IR' and activeflag = 1;
