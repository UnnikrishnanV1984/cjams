--D-23250: For snapshothist there is application data in Prod before go-live 2019-10-26. 
-- This is not chessie converted data, and should be truncated.
DELETE FROM snapshothist WHERE insertedon < '2019-10-27';