'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');
const LOGGER = require("log4js").getLogger("Livingarrangement");
module.exports = function(Livingarrangement) {

    Livingarrangement.remoteMethod('addupdate', {
        http: {
                path: '/addupdate',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}},
                    {arg: 'req', type: 'object',
            http: { source: 'req'}} , {
                arg: 'reqctx',
                type: 'object',
                http: {source: 'context'}
              }],
        returns: {
            type : 'string',
            root : true
        }
    });
    
    Livingarrangement.addupdate = (request, reqctx) => {
		let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
        request.insertedby = (request && request.securityuserid?request.securityuserid: _securityusersid);
        request.updatedby = (request && request.securityuserid?request.securityuserid: _securityusersid);
        request.v_securityusersid = (request && request.securityuserid?request.securityuserid: _securityusersid);
        
        if (request.livingarrangementid !== undefined && request.livingarrangementid !== null) {
            return Livingarrangement.livingarrangementupdate(request);
        } else {
            
            return Livingarrangement.livingarrangementadd(request);
        }

    }

    Livingarrangement.livingarrangementadd = function(request,reqctx ) {
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		} 
        
        return app.models.Livingarrangement.create({
            livingarrangementtypekey:request.livingarrangementtypekey,
            personid:request.personid,
            livingstartdate:request.startdate,
            livingenddate:request.enddate,
            caregiverclientid:request.caregiverclientid,
            partnerid:request.partnerid,
            primarycaregiver:request.primarycaregiver,
            secondarycaregiver:request.secondarycaregiver,
            primaryrelationship:request.primaryrelationship,
            homephone:request.contactphone,
            workphone:request.workphone,
            streetname:request.add1,
            streettext:request.add2,
            cityname:request.cityname,
            countytypekey:request.countytypekey,
            statetypekey:request.statetypekey,
            zip5no:request.zipcode,
            livingcomment:request.remarks,
            insertedby: (request && request.v_securityusersid ? request.v_securityusersid : _securityusersid),
            updatedby: (request && request.v_securityusersid ? request.v_securityusersid : _securityusersid)  ,
            livingpriortoplacement:request.livingpriortoplacement
        }).catch(err => LOGGER.error(err));
    }

    Livingarrangement.livingarrangementupdate = function(request) {

        var sql = `     with updated as (
                            update livingarrangement set activeflag = 0, updatedby = $16, updatedon = now() where  personid = $1 and placementid is null 
                            RETURNING *
                        )
                        update livingarrangement 
                        set livingenddate = $2, caregiverclientid = $3, partnerid = $4,
                            primarycaregiver = $5, secondarycaregiver = $6, primaryrelationship = $7, homephone = $8, workphone = $9, streetname  = $10, 
                            streettext = $11, cityname = $12, countytypekey = $13, statetypekey = $14, zip5no = $15, updatedby = $16, activeflag = 1,
                            livingarrangementtypekey = $17, livingstartdate = $18, livingcomment = $19, livingpriortoplacement = $20 
                        where livingid = $1; `

                return util.executeDBQuery(sql, [
                        request.livingarrangementid,
                        request.enddate,
                        request.caregiverclientid,
                        request.partnerid,
                        request.primarycaregiver,
                        request.secondarycaregiver,
                        request.primaryrelationship,
                        request.contactphone,
                        request.workphone,
                        request.add1,
                        request.add2,
                        request.cityname,
                        request.countytypekey,
                        request.statetypekey,
                        request.zipcode,
                        request.v_securityusersid,
                        request.livingarrangementtypekey,
                        request.startdate,
                        request.remarks,
                        request.livingpriortoplacement])
                    .then(data => data)
                    .catch(err => {
                        LOGGER.error('>>>>ERROR:', err);
                        throw err;
                    });
    }

    /**Livingarrangement list */
    Livingarrangement.remoteMethod('list', {
        http: {
            path: '/list',
            verb: 'get'
        },
        accepts : [ 
        {
            arg : 'filter',
            type : 'object',
            http : {source : 'query'}
        } ],  
        returns: {
            type : 'object',
            root : true
        } 
    });

    Livingarrangement.list =(request)=> {

        var sql = ` select la.livingid
                            , la.livingarrangementtypekey
                            , la.livingpriortoplacement
                            , rv.value_text livingarrangementtype
                            , la.livingenddate
                            , la.livingstartdate
                            , la.caregiverclientid
                            , la.livingcomment as remarks
                            , concat(p1.firstname, ' ', p1.lastname) as primarycaregivername
                            , la.partnerid  
                            , concat(p2.firstname, ' ', p2.lastname) as secondarycaregivername
                    from livingarrangement la
                    inner join referencevalues rv on rv.activeflag =  1 and la.livingarrangementtypekey = rv.ref_key and referencetypeid = 76
                    left join person p1 on p1.personid = la.caregiverclientid 
                    left join person p2 on p2.personid = la.partnerid 
                    where la.personid = $1 and la.placementid is null and la.activeflag = 1
                    order by la.livingstartdate desc; `;
		
		return util.executeSecondaryNodeDBQuery(sql, [request.where.personid])
		.then(data => data)
		.catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
    };

    Livingarrangement.remoteMethod('delete', {
        http: { 
                path: '/delete/:id',
                verb: 'delete'
        },
        accepts:{
                arg: 'id',
                type: 'string',
                required: true,
                http: { source: 'path' }
        },
        returns: {
            type: 'Object',
            root: true
        }
    });

    Livingarrangement.delete = (id) => {
        var sql = 'update livingarrangement set activeflag = 0 WHERE livingid = $1';
        var params = [id];

        return util.executeDBQuery(sql, params)
            .then(data => {
                return data;
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
    };


    Livingarrangement.livingarrangementadd = function(request) {
        
        return app.models.Livingarrangement.create({
            livingarrangementtypekey:request.livingarrangementtypekey,
            personid:request.personid,
            livingstartdate:request.startdate,
            livingenddate:request.enddate,
            caregiverclientid:request.caregiverclientid,
            partnerid:request.partnerid,
            primarycaregiver:request.primarycaregiver,
            secondarycaregiver:request.secondarycaregiver,
            primaryrelationship:request.primaryrelationship,
            homephone:request.contactphone,
            workphone:request.workphone,
            streetname:request.add1,
            streettext:request.add2,
            cityname:request.cityname,
            countytypekey:request.countytypekey,
            statetypekey:request.statetypekey,
            zip5no:request.zipcode,
            livingcomment:request.remarks,
            insertedby: (request && request.v_securityusersid ? request.v_securityusersid : _securityusersid),
            updatedby: (request && request.v_securityusersid ? request.v_securityusersid : _securityusersid)  
        }).catch(err => LOGGER.error(err));
    }



    /**Livingarrangement list */
    Livingarrangement.remoteMethod('list', {
        http: {
            path: '/list',
            verb: 'get'
        },
        accepts : [ 
        {
            arg : 'filter',
            type : 'object',
            http : {source : 'query'}
        } ],  
        returns: {
            type : 'object',
            root : true
        } 
    });

    Livingarrangement.list =(request)=> {

        var sql = ` select la.livingid
                            , la.livingarrangementtypekey
                            , la.livingpriortoplacement
                            , rv.value_text livingarrangementtype
                            , la.livingenddate
                            , la.livingstartdate
                            , la.caregiverclientid
                            , la.livingcomment as remarks
                            , concat(p1.firstname, ' ', p1.lastname) as primarycaregivername
                            , la.partnerid  
                            , concat(p2.firstname, ' ', p2.lastname) as secondarycaregivername
                    from livingarrangement la
                    inner join referencevalues rv on rv.activeflag =  1 and la.livingarrangementtypekey = rv.ref_key and referencetypeid = 76
                    left join person p1 on p1.personid = la.caregiverclientid 
                    left join person p2 on p2.personid = la.partnerid 
                    where la.personid = $1 and la.placementid is null and la.activeflag = 1
                    order by la.livingstartdate desc; `;

		return util.executeDBQuery(sql, [request.where.personid])
		.then(data => data)
		.catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
    };

    Livingarrangement.remoteMethod('delete', {
        http: { 
                path: '/delete/:id',
                verb: 'delete'
        },
        accepts:{
                arg: 'id',
                type: 'string',
                required: true,
                http: { source: 'path' }
        },
        returns: {
            type: 'Object',
            root: true
        }
    });

    Livingarrangement.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Livingarrangement.observe('access', (ctx, next) => util.access(ctx, next));
    Livingarrangement.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}