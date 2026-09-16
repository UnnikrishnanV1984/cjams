
update crbreferencevalues set activeflag = 1;
update crbreferencevalues set referencetype = description where description = 'educationtype';
update crbreferencevalues set chessiecode = '12761' where cjamscode = 'CDVP' and referencetype = 'removaltype'; 


insert into crbreferencevalues values (64,'NYD','2701',null,'removaltype',1);
insert into crbreferencevalues values (65,'PA','4330',null,'removalreasontype',1);
insert into crbreferencevalues values (66,'SA','4331',null,'removalreasontype',1);
insert into crbreferencevalues values (67,'HG','4332',null,'removalreasontype',1);
insert into crbreferencevalues values (68,'AAC','4333',null,'removalreasontype',1);
insert into crbreferencevalues values (69,'DAC','4334',null,'removalreasontype',1);
insert into crbreferencevalues values (70,'CD','4335',null,'removalreasontype',1);
insert into crbreferencevalues values (71,'CBP','4336',null,'removalreasontype',1);
insert into crbreferencevalues values (72,'ADT','4337',null,'removalreasontype',1);
insert into crbreferencevalues values (73,'IDH','4338',null,'removalreasontype',1);
insert into crbreferencevalues values (74,'RLQ','278',null,'removalreasontype',1);
insert into crbreferencevalues values (75,'AAP','279',null,'removalreasontype',1);
insert into crbreferencevalues values (76,'CIIO','280',null,'removalreasontype',1);
insert into crbreferencevalues values (77,'DP','281',null,'removalreasontype',1);
insert into crbreferencevalues values (78,'DAP','282',null,'removalreasontype',1);
insert into crbreferencevalues values (79,'IP','283',null,'removalreasontype',1);
