--D-23125: For socialhistory, youthtransitionplan there is application data in Prod before go-live 2019-10-26. 
-- This is not chessie converted data, and should be truncated.
DELETE FROM socialhistory WHERE insertedon < '2019-10-27';

DELETE FROM youthtransitionplan WHERE insertedon < '2019-10-27';