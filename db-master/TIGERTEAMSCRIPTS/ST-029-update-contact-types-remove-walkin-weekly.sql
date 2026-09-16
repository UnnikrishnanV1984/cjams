--D-20183/Laurie wants 'Weekly Visits'/'Walk-in' disabled 
update progressnotetype set activeflag = 0 where  progressnotetypekey='Weekly Visits' 
and progressnotetypeid = 'a260a2a4-4f26-4007-8257-a68d11d27d93';
update progressnotetype set activeflag = 0 where  progressnotetypekey='Walk-in' 
and progressnotetypeid = '3d2bda30-f612-4351-9075-d88ab1726109';


update progressnotetypeconfig set activeflag = 0 where  progressnotetypekey='Walk-in'
and progressnotetypeconfigid in ( '98afa46c-97fe-43e2-840f-88b8fe2ede23','599aee1d-2147-482c-a5c3-d699d82797cd');
update progressnotetypeconfig set activeflag = 0 where  progressnotetypekey='Weekly Visits'
and progressnotetypeconfigid in ( 'd750cc32-5141-423c-9fd2-13562f491ddf');
