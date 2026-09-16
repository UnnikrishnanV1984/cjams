/*

   Issue Description: User wants to  remove CIS # 498014161 program assignment from the following CJAMS investigations:CW2217278CW22172779CW2288137CW2238242CW2238243CW2217277

   Category/ Module  :  Expungement

   Root cause:User requestedto  remove CIS # 498014161 program assignment from the following CJAMS investigations:CW2217278CW22172779CW2288137CW2238242CW2238243CW2217277

   Fix provided :Data fix to expunge the cases 

   Code fix ticket#:

   Reason why no related code fix: 

   Status of the code fix if already submitted and expected prod fix date: 

   Backup before update/ delete:

*/

--CW2217278
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2217278'::character varying,
		null::date
	) ;
--CW2217279
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2217279'::character varying,
		null::date
	) ;
--CW2288137
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2288137'::character varying,
		null::date
	) ;
--CW2238242
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2238242'::character varying,
		null::date
	) ;
--CW2238243
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2238243'::character varying,
		null::date
	) ;
--CW2217277
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2217277'::character varying,
		null::date
	) ;



