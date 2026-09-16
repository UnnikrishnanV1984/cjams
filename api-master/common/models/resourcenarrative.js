'use strict';
const LOGGER = require("log4js").getLogger("resourcenarrative");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Resourcenarrative) {

    Resourcenarrative.addupdate= function(request) {

      return Resourcenarrative.find({where:{resourceid:request.resourceid}})
			.then(res => {
			if(res.length === 0){
        return Resourcenarrative.create({resourceid:request.resourceid,
        narrative: JSON.stringify(request)});
			}else if(res.length > 0){
				return Resourcenarrative.updateAll({resourceid:request.resourceid},{narrative:JSON.stringify(request)});
			}
			}).catch(err => err);
		}



  Resourcenarrative.list = data => {

    const resourcekey = data.where.resourcekey;

    let gResources;
    return app.models.Resource.find({
        fields: ['id', 'parentid','resourceid'],
        where: {resourceid:resourcekey},
        include: {
          relation: 'resourcenarrative',
          scope: {
            where: { activeflag: true },
            fields: ['resourceid', 'narrative'],
          }
        }

    })
    .then(data1 => {
        gResources = JSON.parse(JSON.stringify(data1));
        gResources[0].resourcenarrative[0].narrative = (JSON.parse(gResources[0].resourcenarrative[0].narrative));
     return gResources;
      })
    .catch(err => util.logError(err));
};



Resourcenarrative.delete = (id) => {

  var sql = 'UPDATE resourcenarrative SET activeflag=0 WHERE resourceid=\''+id+'\'';

  return util.executeDBQuery(sql, [])
    .then(data => {
      return data;
    })
    .catch(err => {
      LOGGER.error('>>>>ERROR:', err);
      throw err;
    });
}

	Resourcenarrative.remoteMethod(
			'addupdate',
				    {
				      http: {
				      		path: '/addupdate',
				      		verb: 'post'
				      },
				     accepts : [ {arg : 'data',type : 'object',
				     		http : {source : 'body'}} ],
				      returns: {
				    	  type : 'object',
							root : true
				      }
				     }
    );

    Resourcenarrative.remoteMethod('list', {
      http: {
        path: '/list',
        verb: 'get'
      },
      accepts : [ {
        arg: 'filter',
        type: 'Object',
        required: true,
        http: {source: 'query'}
      } ],
      returns: {
        type : 'Object',
        root : true
      }
    });



  Resourcenarrative.remoteMethod('delete', {
    accepts:
      {
        arg: 'id',
        type: 'string',
        required: true,
        http: { source: 'path' }
      },
    http: { "verb": "delete", "path": "/delete/:id" },
    returns: {
      type: 'Object',
      root: true
    }
  });


  Resourcenarrative.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Resourcenarrative.observe('access', (ctx, next) => util.access(ctx, next));
  Resourcenarrative.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
