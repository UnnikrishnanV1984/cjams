-- FUNCTION: getfinancecses( uuid);

-- DROP FUNCTION getfinancecses( uuid);
DROP FUNCTION IF EXISTS cjams.getfinancecses(personid uuid);
CREATE OR REPLACE FUNCTION cjams.getfinancecses(personid uuid)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------
-- Revisions:
-- Parshal Chitrakar - 12/10/2024 - Finance CSES - data are not listed in UI
------------------------------------------------------------------------------------------------

DECLARE
    
    v_personid uuid;
	v_result json;

	
BEGIN
    
    v_personid := personid :: uuid;

SELECT to_json(pso) into v_result FROM 
(
select 
cp.csesclientparentid,  
cp.cisparentclientid,              
cp.cisclientid,              
cp.personid,                 
rtk.description as "parrelationshiptype",   
cp.parlastname,              
cp.parfirstname,             
cp.parmiddlename,            
cp.parsuffix,                
cp.parssn,                   
cp.pargendertypekey,         
cp.pardob,
cp.parlegalesttypekey as "paternityestablishment",
cp.parlegalestdate as "establishdate",                   
rt.typedescription as "parracetype",           
cp.parlastaddressline1,      
cp.parlastaddressline2,      
cp.parlastaddresscity,       
cp.parlastaddressstate,      
cp.parlastaddresszip,        
cp.parlastphonenumber,       
cp.parlastaddressdate,       
cp.pardateofdeath,           
cp.parcuremp1name,           
cp.parcuremp1addressline1,   
cp.parcuremp1addressline2,   
cp.parcuremp1addresscity,    
cp.parcuremp1addressstate,   
cp.parcuremp1addresszip,     
cp.parcuremp1phoneno,        
cp.parcuremp1startdate,      
cp.parcuremp1enddate,        
cp.parcuremp2name,           
cp.parcuremp2addressline1,   
cp.parcuremp2addressline2,   
cp.parcuremp2addresscity,    
cp.parcuremp2addressstate,   
cp.parcuremp2addresszip,     
cp.parcuremp2phoneno,        
cp.parcuremp2startdate,      
cp.parcuremp2enddate,        
cp.parmedinsuranceflag,      
cp.parmilitarystartdate,     
cp.parmilitaryenddate,       
cp.parmilitarybranchtypekey, 
cp.parsoflag,                
cp.parsonumber,              
cp.parsolastpayamount,       
cp.parsolastpaydate,         
cp.parsolastpaymethodtypekey,             
(select to_json(cso)
from (select 
       socounty,
       sostate,    
       sodate as "sorderdate",
       sostatusdate,
       sonumber,
       sostatustypekey,
       sopaymentamount,
       sopaymentfreqtypekey  
    from csesclientsupportorder so 
    where so.personid = cp.personid 
        and so.sonumber = cp.parsonumber 
        and so.activeflag = 1
	    order by so.insertedon  desc
    	limit 1
    ) cso) as supportorder
from csesclientparent cp 
join racetype rt on rt.racetypekey = cp.parracetypekey and rt.activeflag = 1
join relationshiptype rtk on rtk.relationshiptypekey = cp.parrelationshiptypekey
where cp.personid = v_personid and cp.activeflag = 1   
order by cp.insertedon  desc limit 1
		
	) pso;
	
RETURN v_result;

END;



$function$
;
