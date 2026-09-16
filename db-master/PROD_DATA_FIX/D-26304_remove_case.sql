--D-26304

update intakeservicerequest set activeflag = 0, updatedby = 'D-26304', updatedon = now() where servicerequestnumber = 'CW10189797';
update servicecase set activeflag = 0, updatedby = 'D-26304', updatedon = now() where servicecasenumber = 3301263;
update person set activeflag = 0, updatedby = 'D-26304', updatedon = now() where cjamspid = 10448906;