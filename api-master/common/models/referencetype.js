'use strict';
const LOGGER = require("log4js").getLogger("referencetype");
var app = require('../../server/server');
const util = require('../utils/utils');
// Short term private caching solution. shared/distributed cache is better for this application, redis or memcached
// It will take a long time to get state to setup the shared cache so this will do for now.
// Because this is a short term fix, I intentionally did not setup a cache service.
const NodeCache = require( "node-cache" );
const ttlSeconds = 24 * 60 *60 * 1; // cache for 3 mins: keep short because it's specific to a search criteria. No need to persist for very long.
const searchCache = new NodeCache({ stdTTL: ttlSeconds, checkperiod: ttlSeconds * 0.2, useClones: true });

module.exports = function(Referencetype) {

    Referencetype.remoteMethod('gettypes', {
        accepts : {
            arg : 'filter',
            type : 'Object',
            http : {
                source : 'query'
            },
            required : true
        },
        http : {
            verb : 'get'
        },
        returns : {
            type : 'string',
            root : true
        }
    });
    
    Referencetype.gettypes = (request) =>{
        if (request.ismultiple !==undefined && request.ismultiple !==null && request.ismultiple ===1)
        {
            return Referencetype.getmultipletypes (request);
        }
        else
        {
            if(new Date().getHours()===6) {
                searchCache.flushAll();
            }
            const keyObject = JSON.parse(JSON.stringify(request.where)); // deep copy
            delete keyObject.sortorder;
            delete keyObject.sortcolumn;
            const key = JSON.stringify(keyObject);
            return new Promise((resolve, reject) => {
                searchCache.get(key, function (err, value) {

                    if (!err && value) {
                        resolve(value);
                    } else {
                        Referencetype.getsingletypes (request)
                        .then(result => {
                           resolve(result);
                        })
                        .catch(err1 => {
                            LOGGER.error('>>>>ERROR:', err1);
                            reject(err1);
                        });


                    }
                 });
            });
        }

    }
    Referencetype.getsingletypes = (request) =>{
        return new Promise((resolve, reject) => {
         Referencetype.find({
            where:request.where,
            fields:['referencetypeid'],
            include:{
                relation:'referencevalues',

                scope:{
                    nolimit:true,
                    order: request.order ||  'description',
                    where : {
                        and: [
                          {activeflag : 1},
                          {parenttypeid: request.where.parenttypeid},  
                          {parentkey: request.where.parentkey},
                          { or: [{teamtypekey : null}, {teamtypekey : 'CW'}] },
                        ]
                    },
                    fields:[ 'ref_key','referencetypeid','description','value_text','activeflag', 'displayorder','parentkey']
                }
            }
        }).then(data =>{
            var response =[];
            var result = JSON.parse(JSON.stringify(data));
            if(result!=null && result.length>0) {response = result[0].referencevalues;}
            resolve(response);
             
        })
       }).then(data => data)
        .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
    
    }

    Referencetype.remoteMethod('allvaluesbyreferenceid', {
        accepts : {
            arg : 'filter',
            type : 'Object',
            http : {
                source : 'query'
            },
            required : true
        },
        http : {
            path: '/allvaluesbyreferenceid',
            verb : 'get'
        },
        returns : {
            type : 'string',
            root : true
        }
    });
    Referencetype.allvaluesbyreferenceid = (request) => {
        
        const sql = "select activeflag, description, ref_key, displayorder, parentkey, referencetypeid, teamtypekey, value_text from referencevalues where referencetypeid = $1 order by displayorder ";
        var referencetypeid = request.where.referencetypeid;

        return util.executeSecondaryNodeDBQuery(sql, [referencetypeid])
        .then(data => {
            return data;
        })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
    };


    Referencetype.getmultipletypes = (request) => {
        const sql = "select * from gettypevalues ($1)";

        return util.executeSecondaryNodeDBQuery(sql, [JSON.stringify(request.where)])
            .then(data => {
                return data;
            })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
    };

    

    Referencetype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Referencetype.observe('access', (ctx, next) => util.access(ctx, next));
    Referencetype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}