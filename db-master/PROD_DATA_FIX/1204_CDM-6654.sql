update Investigationmaltreatment set activeflag=0,updatedby='CDM-6654',updatedon=now() where maltreatmentid in
('cbed1d43-0e83-4f8a-a604-08393db2217f','fa861080-fc6e-4cf6-b54e-3c75520c8347','df2a7344-4c41-4d04-a378-01872a9f578b');
update investigationmaltreatmentactor set activeflag=0,updatedby='CDM-6654',updatedon=now()  where maltreatmentid in
('cbed1d43-0e83-4f8a-a604-08393db2217f','fa861080-fc6e-4cf6-b54e-3c75520c8347','df2a7344-4c41-4d04-a378-01872a9f578b');