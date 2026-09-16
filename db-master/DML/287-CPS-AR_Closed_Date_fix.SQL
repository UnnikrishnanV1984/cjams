update intakeservicerequestdispositioncode set statusdate = a.invfindingdate
   from (select inv.invfindingdate,id.old_id from intakeservicerequestdispositioncode id
          inner join investigation inv on id.old_id = inv.old_id
  where id.servicerequesttypeconfigiddispostionid = 'd69ef21e-dce1-4cd4-bda3-76255fc92db3'
        and inv.cpsresponsetypekey = 102::character varying) a
        where intakeservicerequestdispositioncode.old_id = a.old_id;