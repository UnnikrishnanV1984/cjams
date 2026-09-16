ALTER TABLE cjams.person 
add column if not exists hairtextureotherdesc varchar(500) null,
add column if not exists haircolorotherdesc varchar(500) null,
add column if not exists isglasses boolean null;