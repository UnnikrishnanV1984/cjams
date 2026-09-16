'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Intakedocument) {

    Intakedocument.list = request => {
        let intakenumber = "";
        
        if(request.where) {
            intakenumber = request.where.intakenumber;
        }
        const skip = (request.page - 1) * request.limit;
		const limit = request.limit;
        
        const sql = "select * from listintakedocs($1, $2, $3)";

        return util.executeDBQuery(sql, [intakenumber, skip, limit])
        .then(resp => {
            const data = JSON.parse(JSON.stringify(resp));
            let totalCount = 0;
            if(data.length > 0)
                {totalCount = data[0].totalcount;}
            data.forEach(x => delete x.totalcount);
            return {totalcount:totalCount, data: data};
        })
        .catch(err =>util.logError(err));
    };

    Intakedocument.listhistory = request => {
        let intakedocid = util.emptyUUID;
        
        if(request.where) {
            intakedocid = request.where.intakedocumentid;
        }

        const skip = (request.page - 1) * request.limit;
		const limit = request.limit;
        
        const sql = "select * from listintakedochistory($1, $2, $3)";

        return util.executeDBQuery(sql, [intakedocid, skip, limit])
        .then(_resp => {
            const data = JSON.parse(JSON.stringify(_resp));
            let totalCount = 0;
            if(data.length > 0)
                {totalCount = data[0].totalcount;}
            data.forEach(x => delete x.totalcount);
            return {totalcount:totalCount, data: data};
        })
        .catch(err =>util.logError(err));
    };

    Intakedocument.add = data => {
        const intakeDoc = data;
        return Intakedocument.findOne({
            where: {and: [
                {intakenumber: data.intakenumber}, {documenttemplatekey: data.documenttemplatekey}
            ]},
            order: 'versionno desc',
            fields: 'versionno'
        })
        .then(_data => {
            let versionno = 1;
            
            if(_data && _data.versionno)
                {versionno = parseInt(_data.versionno) + 1;}
            
            intakeDoc.versionno = versionno;
            
            return Intakedocument.create(intakeDoc);
        })
        .then(_data => _data)
        .catch(err => util.logError(err));
    };

    //list remote method
	Intakedocument.remoteMethod('list', {
		accepts : {
			arg : 'filter',
			type : 'Object',
			http : {
				source : 'query'
			},
			required : true
		},
		http : {
            path: '/list',
			verb : 'get'
		},
		returns : {
			type : 'string',
			root : true
		}
    });

    //list history remote method
	Intakedocument.remoteMethod('listhistory', {
		accepts : {
			arg : 'filter',
			type : 'Object',
			http : {
				source : 'query'
			},
			required : true
		},
		http : {
            path: '/listhistory',
			verb : 'get'
		},
		returns : {
			type : 'string',
			root : true
		}
    });

    //add document
    Intakedocument.remoteMethod (
        'add',
        {
          http: {
                  path: '/add',
                  verb: 'post'
          },
          accepts: [{
                  arg: 'data',
                  type: 'Object',
                  http: {
                      source: 'body'
                  }}
    
          ],
          returns: {
                  arg: 'data',
                  type: 'Object'
          }
         });
    
    Intakedocument.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakedocument.observe('access', (ctx, next) => util.access(ctx, next));
    Intakedocument.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}
