'use strict';
const LOGGER = require("log4js").getLogger("tb_placement");
const util = require('../utils/utils');
var app = require('../../server/server');
const referralreviewnofitymsg = 'Referral Review';
const routingintakesql = 'select * from routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12)';

module.exports = function(Tb_placement) {
       
    Tb_placement.remoteMethod('fostercarereferaladd', {
        http: {
                path: '/fostercarereferaladd',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}},{
              arg: 'reqctx',
              type: 'object',
              http: {source: 'context'}
            } ],
        returns: {
            type : 'string',
            root : true
        }
    });

    Tb_placement.fostercarereferaladd = function(request,reqctx)
    { let suserid = undefined;
      if(reqctx?.req?.headers?.securityusersid){
        suserid = reqctx.req.headers.securityusersid
      }
      const  securityuserid = request.securityuserid ? request.securityuserid : suserid;
        var responseJson = {};
        let gplacementdetails;
        request.create_user_id = securityuserid;
        request.update_user_id = securityuserid;
        return Tb_placement.create(request)
        .then(res => {
            gplacementdetails = res;

            responseJson = res.providerdetails;
            responseJson.placement_id = res.placement_id;
            responseJson.provider_id = res.provider_id;
            responseJson.contract_program_id = res.contract_program_id;
            responseJson.provider_organization_id = res.provider_organization_id;
            responseJson.rate_structure_id = res.rate_structure_id;
            responseJson.create_user_id = securityuserid;
            responseJson.update_user_id = securityuserid;
            return app.models.Tb_placement_providers.create(responseJson)
            .then(resprovider =>{
                gplacementdetails.providerdetails = resprovider;
                const sql ="select * from fostercarevacancyupdate($1,$2)";
                return util.executeDBQuery(sql,[gplacementdetails.provider_id,gplacementdetails.contract_program_id]);
            }).then(data => {
              var status = 34;
              var nofitymsg = referralreviewnofitymsg;
              var routeddescription = referralreviewnofitymsg;
              var comments = referralreviewnofitymsg;
              var sql = routingintakesql;
              return util.executeDBQuery(sql, [request.intakeserviceid, securityuserid, 'PLAREF', status, comments, '', false, false, false,
                                         nofitymsg, routeddescription, request.intakeserviceid])
                .then(result => gplacementdetails)
                .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
            });

        });
    };

    Tb_placement.remoteMethod('fostercarereferallist', {
        accepts: {
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'query',
      },
      required: true,
    },
      http: {
            verb: 'get',
        },
        returns: {
            type: 'Object',
            root: true,
        },
    });

    Tb_placement.fostercarereferallist = (request) => {
      if(request.where.objectid !== undefined && request.where.objectid !== null) {
          return Tb_placement.servicecaseplacementlist(request);
      } else {
          return Tb_placement.defaultfostercarereferallist(request);
      }
    }

    Tb_placement.servicecaseplacementlist=(request)=>{
      const pageno = request.page;
      const pagesize = request.limit;
      var sql= 'select * from servicecaseplacementlist($1,$2,$3)';
      return util.executeDBQuery(sql,[request.where.objectid, pageno, pagesize])
  .then(data => data)
  .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

  };

    Tb_placement.defaultfostercarereferallist=(request)=>{
        const pageno = request.page;
        const pagesize = request.limit;
        var totalcount = 0;
        //D-07665 Start
        var personid = '';
        if(request.where.personid !== undefined){
          personid = request.where.personid;
        }

        var sql= 'select * from fostercarereferallist($1,$2,$3,$4)';
        //D-07665 End
        return util.executeDBQuery(sql,[request.where.casenumber, pageno, pagesize,personid])
        .then(data => {
              if (data!==null && data.length>0) {
                totalcount= data[0].totalcount;}
              var result;
              result = {
                  'data' : data,
                  'count' : totalcount
              };
              return result;
        })
    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

    };

    Tb_placement.remoteMethod('fostercarereflistforvalidation', {
      accepts:[ {
    arg: 'filter',
    type: 'Object',
    http: {
      source: 'query',
    },
    required: true,
  },{
    arg: 'reqctx',
    type: 'object',
    http: {source: 'context'}
  }],
    http: {
          verb: 'get',
      },
      returns: {
          type: 'Object',
          root: true,
      },
  });

  Tb_placement.fostercarereflistforvalidation=(request,reqctx)=>{
    let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    }
    const securityuserid = request.securityuserid ? request.securityuserid : suserid;
      const pageno = request.page;
      const pagesize = request.limit;
      var input = request.where;
      var sql= 'select * from fostercarereferallistforvalidation($1,$2,$3,$4,$5,$6,$7,$8,$9)';
      return util.executeDBQuery(sql,[securityuserid,pageno, pagesize,request.where.sortorder,request.where.sortcolumn,input.validationstatus,
                                           input.client_id,input.roletypekey,input.cwid?input.cwid:null])
  .then(data => formatResponse(data))
  .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

  };

  Tb_placement.remoteMethod('addplacement', {
        http: {
          path: '/addplacement/:id',
          verb: 'patch',
        },
        accepts: [
          {
            arg: 'id',
            type: 'data',
            required: true,
            http: {source: 'path'},
          },
          {
            arg: 'data',
            type: 'object',
            http: {source: 'body'},
          },{
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          }],
        returns: {
          type: 'string',
          root: true,
        },
    });

    Tb_placement.addplacement = function(id, request,reqctx)    {
      let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    }
    const securityuserid = request.securityuserid ? request.securityuserid : suserid;
         const currentDate = new Date().toLocaleString();
        const sql = `update tb_placement set  medicaid_paid_sw = $1::bpchar , court_ordered_sw = $2::bpchar,
                     icpc_approved_sw=$3::bpchar,entry_dt=$4,entry_tm=$5,update_ts=$6,update_user_id=$7 where placement_id = $8`;
        return util.executeDBQuery(sql, [request.medicaid_paid_sw,request.court_ordered_sw,request.icpc_approved_sw,
                                            request.entry_dt,request.entry_tm,currentDate,securityuserid,id])
          .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

    Tb_placement.remoteMethod('exitplacement', {
      http: {
        path: '/exitplacement/:id',
        verb: 'patch',
      },
      accepts: [
        {
          arg: 'id',
          type: 'data',
          required: true,
          http: {source: 'path'},
        },
        {
          arg: 'data',
          type: 'object',
          http: {source: 'body'},
        },{
          arg: 'reqctx',
          type: 'object',
          http: {source: 'context'}
        }],
      returns: {
        type: 'string',
        root: true,
      },
  });

  Tb_placement.exitplacement = function(id, request,reqctx)    {
    let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    }
    const securityuserid = request.securityuserid ? request.securityuserid : suserid;
    const currentDate = new Date().toLocaleString();
    const sql = `update tb_placement set  exit_type_cd = $1, exit_reason_cd = $2, exit_explanation_tx = $3, exit_dt = $4, 
                 exit_tm = $5, update_ts = $6, update_user_id = $7 where placement_id = $8`;
      return util.executeDBQuery(sql, [request.exit_type_cd,request.exit_reason_cd,request.exit_explanation_tx,request.exit_dt,
                                          request.exit_tm,currentDate,securityuserid,id])
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
  };


  Tb_placement.placementexit = function (request,reqctx) {
    let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    }
    const securityuserid = request.securityuserid ? request.securityuserid : suserid;
    const currentDate = new Date().toLocaleString();

    return app.models.Tb_placement_revision.create({
      placement_id: request.placement_id,
      entry_dt: request.entry_dt,
      entry_tm: request.entry_tm,
      exit_type_cd: request.exit_type_cd,
      exit_reason_cd: request.exit_reason_cd,
      exit_explanation_tx: request.exit_explanation_tx,
      exit_dt: request.exit_dt,
      exit_tm: request.exit_tm,
      delete_sw: request.delete_sw,
      create_ts: currentDate,
      create_user_id: securityuserid,
      update_ts: currentDate,
      update_user_id: securityuserid,

    }).then(resp => {
      var status = 15;
      var nofitymsg = 'Placement Exit for Review';
      var comments = 'Placement Exit for Review'
      var sql = routingintakesql;
      return util.executeDBQuery(sql, [request.placement_id, securityuserid, 'PLTR', status, comments, '', false, false, false,
                                   nofitymsg, '', request.intakeserviceid])
        .then(data => data[0].routingintake);
    }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
  };

  Tb_placement.remoteMethod('placementexit', {
    http: {
      path: '/placementexit',
      verb: 'post'
    },
    accepts: [{
      arg: 'data', type: 'object',
      http: { source: 'body' }
    },{
      arg: 'reqctx',
      type: 'object',
      http: {source: 'context'}
    }],
    returns: {
      type: 'string',
      root: true
    }
  });

    Tb_placement.remoteMethod('removeplacement', {
      http: {
        path: '/removeplacement/:id',
        verb: 'post',
      },
      accepts: [
        {
          arg: 'id',
          type: 'data',
          required: true,
          http: {source: 'path'},
        },
        {
          arg: 'data',
          type: 'object',
          http: {source: 'body'},
        }],
      returns: {
        type: 'string',
        root: true,
      },
  });

  Tb_placement.removeplacement = (id, request) => {
    let gRemovalid;
    return Tb_placement.findById(id)
    .then(res => {
      const result = JSON.parse(JSON.stringify(res));

      if(!result.exit_dt){
        return app.models.Tb_removal.create(request);
      }else{
        return "Placement was already removed.";}
    })
    .then(res => {
      const result = JSON.parse(JSON.stringify(res));
      let exit_dt = new Date().toLocaleString();

      if(result.removal_id) {
        gRemovalid = result.removal_id;
        exit_dt = request.removal_dt;
        return Tb_placement.updateAll({placement_id: id}, {
          removal_id: result.removal_id,
          exit_dt: exit_dt
        });
      }
      else{
        return res;}
    })
    .then(res => {
      if(res.count){
        return {removal_id: gRemovalid};
      }else{
        return res;}
    })
    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
};

    Tb_placement.remoteMethod('approverejectedplacement', {
        http: {
          path: '/approverejectedplacement/:id',
          verb: 'patch',
        },
        accepts: [
          {
            arg: 'id',
            type: 'data',
            required: true,
            http: {source: 'path'},
          },
          {
            arg: 'data',
            type: 'object',
            http: {source: 'body'},
          },{
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          }],
        returns: {
          type: 'string',
          root: true,
        },
    });

    Tb_placement.approverejectedplacement = function(id, request,reqctx)    {
      let suserid = undefined;
    if(reqctx?.req?.headers?.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    }
    const securityuserid = (request && request.securityuserid?request.securityuserid: suserid);
         const currentDate = new Date().toLocaleString();
        const sql = "update tb_placement set  approval_status_cd = $1 , update_ts=$2,update_user_id=$3 where placement_id = $4";
        return util.executeDBQuery(sql, [request.approval_status_cd,currentDate,securityuserid,id])
          .then(data => {
            var statusid = 35;
            return util.executeDBQuery(routingintakesql, [request.objectid, securityuserid, 'PLAREF',statusid, request.comments, '', false, false, false,
                                         request.notifymsg, request.routeddescription, request.objectid])
              .then(_data => _data[0].routingintake);
          })
          .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };
    
    Tb_placement.remoteMethod('placementchildhistorylist', {
      accepts: {
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'query',
      },
      required: true,
    },
      http: {
            verb: 'get',
        },
        returns: {
            type: 'Object',
            root: true,
        },
    });

    Tb_placement.placementchildhistorylist=(request)=>{
        const pageno = request.page;
        const pagesize = request.limit;
        var sql= 'select * from placementchildhistorylist($1,$2,$3)';
        return util.executeDBQuery(sql,[request.where.cjamspid, pageno, pagesize])
    .then(data => formatResponse(data))
    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

    Tb_placement.remoteMethod('cpahomeplacementlist', {
        accepts: {
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'query',
      },
      required: true,
    },
      http: {
            verb: 'get',
        },
        returns: {
            type: 'Object',
            root: true,
        },
    });

    Tb_placement.cpahomeplacementlist=(request)=>{
        const pageno = request.page;
        const pagesize = request.limit;
        var sql= 'select * from cpahomeplacementlist($1,$2,$3,$4)';
        return util.executeDBQuery(sql,[request.where.casenumber,request.where.placement_id, pageno, pagesize])
    .then(data => formatResponse(data))
    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

    function formatResponse(data){
      let result = {};
      let totalcount = 0;
      if (data!==null && data.length>0) {
        totalcount= data[0].totalcount;
      }
      result = {
          'data' : data,
          'count' : totalcount
      };
      return result;
    }

    Tb_placement.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Tb_placement.observe('access', (ctx, next) => util.access(ctx, next));
    Tb_placement.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}
