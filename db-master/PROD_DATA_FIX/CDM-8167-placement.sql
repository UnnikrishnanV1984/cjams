

update cjams.placement set enddatetime = '2020-02-18 00:00:00', endtime = '15:02' where  placementid = '49379748-98b5-458c-8896-fdf2a2c494cd';


update cjams.placementrevision
set transactiondate = '2020-02-18 00:00:00', exittime = '15:02' , approvaldate = '2020-02-18 00:00:00'
where placementrevisionid in ('29a3346b-a781-4af4-8cb7-25c6f656d72e');


update cjams.placementrevision
set transactiondate = '2020-02-18 00:00:00', exitdate = '2020-02-18 00:00:00', exittime = '15:02' , requesteddate = '2020-02-18 00:00:00', approveddate = '2020-02-18 00:00:00'
where placementrevisionid in ('977ba772-5a01-4523-9d52-7892e8fbc8ff');


