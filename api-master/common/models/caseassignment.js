'use strict';
var server = require('../../server/server');
const util = require('../utils/utils');
var app = require('../../server/server');
var ds = app.dataSources.hcuewelfare;
var config = require('../../server/config.json');

module.exports = function(Caseassignment) {
	
    Caseassignment.remoteMethod('getworkload', {
        http: {
            path: '/getworkload',
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

    Caseassignment.getworkload =(request)=> {
        var servicecaseid = request.where.servicecaseid;
        const iscaseexpunged = request.where.iscaseexpunged ?? 0;
        var sql = 'select * from getworkload($1,$2,$3)';

		return util.executeDBQuery(sql, [servicecaseid,request.where.isExpungementSuperUser,iscaseexpunged])
		.then(datas => datas)
		.catch(err => util.logError(err));
    };

    Caseassignment.remoteMethod('getworkloadassignments', {
        http: {
            path: '/getworkloadassignments',
            verb: 'get'
        },
        accepts : [ 
        {
            arg : 'filter',
            type : 'object',
            http : {source : 'query'}
        }, {
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  } ],  
        returns: {
            type : 'object',
            root : true
        } 
    });

    function checkworkloadassignmentsData(request, reqctx) {
        const secuserid =util.getSecurityDetails(request, reqctx).securityuserid;
        return {
            securityuserid: request.where.userid?request.where.userid:secuserid,
            servicecasenumber: request.where.servicecasenumber?request.where.servicecasenumber:null,
            teamid: request.where.teamid?request.where.teamid:null,
            toworkerid: request.where.toworkerid?request.where.toworkerid:null,
            countycode: request.where.countycode?request.where.countycode:null,
            startdate: request.where.startdate?request.where.startdate:null,
            enddate: request.where.enddate?request.where.enddate:null,
            statuscode: request.where.statuscode?request.where.statuscode:null,
            localdeptid: request.where.localdeptid?request.where.localdeptid:null,
            casetype: request.where.casetype?request.where.casetype:null,
            sortcolumn: request.where.sortcolumn?request.where.sortcolumn:null,
            sortorder: request.where.sortorder?request.where.sortorder:null,
        };
    }

    Caseassignment.getworkloadassignments =(request, reqctx)=> {
        var pageno = request.page;
        var pagesize = request.limit;
        var cwdata = checkworkloadassignmentsData(request, reqctx);
        var securityuserid = cwdata.securityuserid;
        var servicecasenumber = cwdata.servicecasenumber;
        var teamid = cwdata.teamid;
        var toworkerid = cwdata.toworkerid;
        var countycode = cwdata.countycode;
        var startdate = cwdata.startdate;
        var enddate = cwdata.enddate;
        var statuscode = cwdata.statuscode;
        var localdeptid = cwdata.localdeptid;
        var casetype = cwdata.casetype;
        var sortcolumn = cwdata.sortcolumn;
        var sortorder = cwdata.sortorder;
        var Totalcount = 0;

        var sql = 'select * from getworkloadassignments($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)';
            if (request.where.isexport ===1)
            {
                sql =`select servicecasenumber,actiontype,legalguardian,localdepartment,teamname,assignedby,assignedto,
                responsibilitytypekey,startdate,enddate,statustypekey,cjamspid from getworkloadassignments($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)`;
            }

        return util.executeSecondaryNodeDBQuery(sql, [securityuserid,servicecasenumber,teamid,toworkerid,countycode,startdate,enddate,
                statuscode,localdeptid,pageno,pagesize,casetype,sortcolumn,sortorder])
        .then(data => {
            if (data!=null && data.length > 0) {
                Totalcount = data[0].totalcount;
            }
              var result;
              result = {
                'data': data,
                'count': Totalcount
              }; 
            return result;
        })
        .then(datas => {
            return datas;
        })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
    };

    Caseassignment.remoteMethod('getworkloadassignmentsummary', {
        http: {
            path: '/getworkloadassignmentsummary',
            verb: 'get'
        },
        accepts : [ 
        {
            arg : 'filter',
            type : 'object',
            http : {source : 'query'}
        }, {
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  } ],  
        returns: {
            type : 'object',
            root : true
        } 
    });

     Caseassignment.getworkloadassignmentsummary =(request, reqctx)=> {       
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}   
        var pageno = request.page;
        var pagesize = request.limit;
        var securityuserid = (request.securityuserid?request.securityuserid: _securityusersid);
        var servicecasenumber = request.where.servicecasenumber?request.where.servicecasenumber:null;
        var teamid = request.where.teamid?request.where.teamid:null;
        var toworkerid = request.where.toworkerid?request.where.toworkerid:null;
        var countycode = request.where.countycode?request.where.countycode:null;
        var isclosed = request.where.isclosed?request.where.isclosed:null;
        var startdate = request.where.startdate?request.where.startdate:null;
        var enddate = request.where.enddate?request.where.enddate:null;
        var filtertype = request.where.filtertype?request.where.filtertype:null;

        var sql = 'select * from getworkloadassignmentsummary($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11)';        
		return util.executeDBQuery(sql, [securityuserid,servicecasenumber,teamid,toworkerid,countycode,isclosed,startdate,enddate,pageno,pagesize,filtertype]).then((data)=>{
            return data && data.length ? data[0] : null;
        }).catch((err)=>{
            LOGGER.error('>>>>ERROR:', err);
            util.logError(err);
            throw err;
        });
    };

    Caseassignment.remoteMethod('validateprogramarea', {
        http: {
            path: '/validateprogramarea',
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

    Caseassignment.validateprogramarea =(request)=> { 
        var sql = 'select * from validateprogramarea($1,$2)';        
		return util.executeSecondaryNodeDBQuery(sql, [request.where.personid,request.where.servicecaseid]).then((data)=>{
            return data && data.length ? data[0] : null;
        }).catch((err)=>{  // NOSONAR
             LOGGER.error('>>>>ERROR:', err);
            util.logError(err);
            throw err;
        });
    };


    Caseassignment.remoteMethod('getresponsibilitychild', {
        http: {
            path: '/getresponsibilitychild',
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

    Caseassignment.getresponsibilitychild =(request)=> {
        var caseid = request.where.caseid;
        var sql = 'select * from getresponsibilitychild($1)';
        
		return util.executeSecondaryNodeDBQuery(sql, [caseid]).then((data)=>{
            return data;
        }).catch((err)=>{  // NOSONAR
             LOGGER.error('>>>>ERROR:', err);
            util.logError(err);
            throw err;
        });
    };


    Caseassignment.remoteMethod('getassignmentstatus', {
        http: {
            path: '/getassignmentstatus',
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

    Caseassignment.getassignmentstatus =(request)=> {
        var adoptioncaseid = request.where.adoptioncaseid;
        var sql = 'select * from getassignmentstatus($1)';
        
		return util.executeSecondaryNodeDBQuery(sql, [adoptioncaseid]).then((data)=>{
            return data;
        }).catch((err)=>{   // NOSONAR
             LOGGER.error('>>>>ERROR:', err);
            util.logError(err);
            throw err;
        });
    };
    Caseassignment.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Caseassignment.observe('access', (ctx, next) => util.access(ctx, next));
    Caseassignment.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};