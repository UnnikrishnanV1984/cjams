 CREATE OR REPLACE FUNCTION public.get_fiscal_category_code(reqobj json)                                                                        
  RETURNS TABLE(fiscal_category_desc character varying, fiscalcategorydesc character varying)                                                   
  LANGUAGE plpgsql                                                                                                                              
 AS $function$                                                                                                                                
 declare                                                                                                                                      
                                                                                                                                              
 v_age int;                                                                                                                                   
 v_ayear character varying(30);                                                                                                               
 v_array character varying[];                                                                                                                 
                                                                                                                                              
 BEGIN                                                                                                                                        
  v_age   := reqobj ->> 'age' ;                                                                                                               
                                                                                                                                              
 -- SELECT array_cat(ARRAY['a', 'b'], ARRAY['c', 'd'])                                                                                        
 --                                                                                                                                           
 --  SELECT  array_append(ARRAY[1],5113) ;                                                                                                    
 DROP table if exists public.temp_fiscal_cat;                                                                                                 
 CREATE TABLE temp_fiscal_cat(                                                                                                                
 fiscal_category_cd character varying                                                                                                         
 );                                                                                                                                           
                                                                                                                                              
  if(v_age <= 14 OR v_age > 18)                                                                                                               
  then                                                                                                                                        
  insert into temp_fiscal_cat values('5113');                                                                                                 
  raise notice '% array val :: ',v_age;                                                                                                       
 -- SELECT  array_append(ARRAY[v_array],'5113') ;                                                                                             
  end if;                                                                                                                                     
                                                                                                                                              
  if(v_age <= 18  OR v_age > 21)                                                                                                              
  then                                                                                                                                        
  insert into temp_fiscal_cat values('5114'),('5115'),('5116');                                                                               
 -- SELECT  array_cat(ARRAY[v_array],ARRAY['5114' , '5115' , '5116' ]) ;                                                                      
  end if;                                                                                                                                     
                                                                                                                                              
  if(v_age <= 16  OR v_age > 21)                                                                                                              
  then                                                                                                                                        
  insert into temp_fiscal_cat values('5118');                                                                                                 
 -- SELECT  array_append(ARRAY[v_array],'5118') ;                                                                                             
  end if;                                                                                                                                     
                                                                                                                                              
   if(v_age <= 18  OR v_age > 21)                                                                                                             
   then                                                                                                                                       
   insert into temp_fiscal_cat values('5117');                                                                                                
 -- SELECT  array_append(ARRAY[v_array],'5117') ;                                                                                             
  end if;                                                                                                                                     
                                                                                                                                              
 -- raise notice '% array val :: ',v_array;                                                                                                   
  return query                                                                                                                                
 SELECT  TRIM(tfm.fiscal_category_cd) :: character varying, tfm.fiscal_category_desc as fiscalCategoryDesc from tb_fiscal_category_master  tfm
 where TRIM(tfm.fiscal_category_cd)  in (select tfc.fiscal_category_cd from temp_fiscal_cat tfc);                                             
                                                                                                                                              
  END;                                                                                                                                        
                                                                                                                                              
                                                                                                                                              
 $function$                                                                                                                                     

