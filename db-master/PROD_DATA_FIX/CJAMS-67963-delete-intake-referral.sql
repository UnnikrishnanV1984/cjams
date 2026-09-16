/*
   Issue Description: CJAMS-67963
   Root cause: User requested to delete the intake #I261013810258
   Fix Provided : Data fix is done to delete the intake #I261013810258
   Pull request# for code fix:  N/A
*/

select * from cw_transactions_dataclenup('INTKE', 'I261013810258', 'CJAMS-67963');