 -- To update the VPA signed information from child Removal CDM-7655
  update intakeservreqchildremoval set isbothparentssigned = 2,parent1id = 1050616, parent2comments = 'he refused.' ,updatedby = 'Data fix as per CDM-7655', updatedon = now() where removalid = 181254 and intakeservreqchildremovalid = '4f6a4f7c-1ad8-4ba6-8fff-c19aa024c280';
              
  -- To Remove Duplicate adoption cases CDM-7603
  update adoptionapplicabilityinfo set activeflag = 0, updatedby = 'Data fix as per CDM-7603' , updatedon = now() where adoptionapplicabilityid not in ('6cc5e370-7374-435e-bd31-815d70411fa2') and clientid = 4343401 and activeflag = 1;
