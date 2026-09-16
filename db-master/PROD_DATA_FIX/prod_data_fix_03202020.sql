--CDM 36

update intakeservreqchildremoval 
set primarycaregiveradd = '11817 Patrick Road, Hagerstown, Md 21740',
seccaregiveradd = '11817 Patrick Road, Hagerstown, Md 21740',
ischildaddressasprimaryaddress = 1, 
primarycaregiveractorid = '09ea6403-5a64-47dd-bd7d-42c0a5fcf82c',
updatedon = now()
where personid in ('70b94c07-cb76-4c6d-9bca-0e9f633fcb17',
'aa0c6ad4-330c-49fd-b28d-291ef8884363',
'66ee4a3d-2b3b-4a5b-afae-c248b3e20cac') 
and servicecaseid = '6f9cbd50-97a0-469e-b714-a1a871eae8b9';