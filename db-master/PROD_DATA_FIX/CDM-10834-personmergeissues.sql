-- CDM-10834
update intakeservicerequestactor set personid = 'a15e5b45-ea7d-47d6-a091-209d2bd4ec2d', updatedby = 'CDM-10834', updatedon = now() where personid = 'dcd143d9-7d19-4db7-9741-22277d63fa92';
update actor set personid = 'a15e5b45-ea7d-47d6-a091-209d2bd4ec2d', updatedby = 'CDM-10834', updatedon = now() where personid = 'dcd143d9-7d19-4db7-9741-22277d63fa92';
update personrole set personid = 'a15e5b45-ea7d-47d6-a091-209d2bd4ec2d', updatedby = 'CDM-10834', updatedon = now() where personid = 'dcd143d9-7d19-4db7-9741-22277d63fa92';
update person set activeflag = 0, updatedby = 'CDM-10834', updatedon = now() where personid = 'dcd143d9-7d19-4db7-9741-22277d63fa92';

update intakeservicerequestactor set personid = 'd882100c-f38a-4629-a046-95b72e942e51', updatedby = 'CDM-10834', updatedon = now() where personid = 'a1645b17-5bcc-4449-aa39-752dd65cfddf';
update actor set personid = 'd882100c-f38a-4629-a046-95b72e942e51', updatedby = 'CDM-10834', updatedon = now() where personid = 'a1645b17-5bcc-4449-aa39-752dd65cfddf';
update personrole set personid = 'd882100c-f38a-4629-a046-95b72e942e51', updatedby = 'CDM-10834', updatedon = now() where personid = 'a1645b17-5bcc-4449-aa39-752dd65cfddf';
update person set activeflag = 0, updatedby = 'CDM-10834', updatedon = now() where personid = 'a1645b17-5bcc-4449-aa39-752dd65cfddf';