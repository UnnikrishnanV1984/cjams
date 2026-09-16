/* 
    Issue Description: CDM-39238
  Category/ Module  : Case Timeline
  Root cause: User request to rexpunge the case
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: 
  Backup before update/ delete: 
*/


select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
    (
        'IR'::character varying,
        'CW2185295'::character varying,
        null::date
    );
