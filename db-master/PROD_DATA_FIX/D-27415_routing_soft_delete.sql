UPDATE routing 
SET activeflag = 0,
updatedon = now(),
updatedby = 'D-27415-admin'
WHERE routingid = '16678573-4862-4f73-8559-b1dca5a881a6' AND eventcode = 'YTP'
 AND objectid = '4caebe55-718d-4070-a152-b89e149226e2';
