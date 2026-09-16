UPDATE cjams.intakeservicerequest
SET intakeservicerequestclassid = '3e026a57-247c-4203-82b7-62749c98ccc5',
actiontype = 'IR',
updatedon = now(),
updatedby = 'CDM-10095'
WHERE intakeserviceid = '84194cfb-9cd9-4215-9502-cfd46682dae1';

update intakeservicerequestsdm 
set isir = true,
updatedon = now(),
updatedby = 'CDM-10095'
where intakeserviceid = '84194cfb-9cd9-4215-9502-cfd46682dae1';

update cjams.personprogramarea
set subprogramkey = 'IR',
updatedon = now(),
updatedby = 'CDM-10095'
where personprogramid in ('b2b7e4eb-2e64-4424-97c5-07f760617641',
'04187195-2a47-44b5-ad35-9a131f0eda6a',
'b58cea30-53b8-4e4c-95b5-777dce3a371d',
'c0872671-0487-4e59-8b2b-f3bae8a84a83',
'ccb2250a-a12c-44aa-932d-f768de5a4fbb',
'9a773111-d4b4-44c6-a1bb-436dbd891a9e',
'14fd4c8b-14d1-494f-a47f-c0532b40d916',
'3612520e-5167-4d2b-aaa1-7a29c903e8d7',
'7f40b558-ad50-442f-9ef6-6593285a3d59',
'a5cec055-822e-4e08-b378-13ea88f828b0',
'1802e90d-5fc9-4595-850d-5a8873bb60f9',
'8fb61022-1cf7-4826-a3c1-3d8b41e6c3ab');