/*
Issue Description: Please deactivate userprofiles for 
erica.bowling@maryland.gov
erica.bowling3@maryland.gov
Category/ Module : Deactivation Request
Root cause: Data fix for deactivation
Fix provided :yes, write Db query
Code fix ticket#:CDM-39030
Reason why no related code fix: Status of the code fix  already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: code fix done, need to raise the PR
Backup before update/ delete:Query:
*/

select cjams.deactivateuser('erica.bowling@maryland.gov');

select cjams.deactivateuser('erica.bowling3@maryland.gov');