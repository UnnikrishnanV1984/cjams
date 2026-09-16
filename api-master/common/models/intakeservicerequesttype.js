'use strict';
const LOGGER = require("log4js").getLogger("intakeservicerequesttype");
const loopback = require('loopback');
const ds = loopback.createDataSource('memory');
let server = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(Intakeservicerequesttype) {

	var totalCount;
	Intakeservicerequesttype.listdastatus = function (data) {
		var sql = 'select * from listdastatus($1,$2)';
		return util.executeSecondaryNodeDBQuery(sql, [data.where.datypeid,data.where.dasubtypeid])
			.then(_data => {
				LOGGER.debug("data", _data);
				return _data;
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	};


	Intakeservicerequesttype.listdadisposition = function (data) {
		var sql = 'select * from listdadisposition($1,$2)';
		return util.executeSecondaryNodeDBQuery(sql, [data.where.servicereqtypeid,data.where.servicereqconfigid])
			.then(data1 => {
				LOGGER.debug("data", data1);
				return data1;
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	};

	Intakeservicerequesttype.delete = (id) => {

		var sql = 'UPDATE Intakeservicerequesttype SET activeflag=0 WHERE intakeservreqtypeid=\''+id+'\'';

		return util.executeDBQuery(sql, [])
			.then(data => {
				return data;
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	}


	/**
	 * Execute the Count - if count is zero don't execute the listing else
	 * return the list also *
	 */

Intakeservicerequesttype.list = function(request) {
	const nolimit = request.nolimit;
	const limit = request.limit;
	const skip = (request.page - 1) * request.limit;

    let intakeservreqtypekey = request.where.intakeservreqtypekey;
	let description = request.where.description;

	var searchobj =	{
		where:{},
			nolimit:nolimit,
			limit:limit,
			skip:skip
           }

			if (request.page !== 'undefined') {
				request.skip = (request.page - 1) * request.limit;
			}

			if(request.where.intakeservreqtypekey  !== undefined
				&& request.where.description !== undefined){

				const intakepattern ='/^'+intakeservreqtypekey+'/i';
				const despattern ='/^'+description+'/i';
				searchobj.where.intakeservreqtypekey ={regexp:intakepattern};
				searchobj.where.description = {regexp:despattern};

			}

			if(request.where.intakeservreqtypekey  !== undefined){

			const intakepattern ='/^'+intakeservreqtypekey+'/i';
			searchobj.where.intakeservreqtypekey ={regexp:intakepattern};

			}

			if(request.where.description  !== undefined){

			const despattern ='/^'+description+'/i';
			searchobj.where.description = {regexp:despattern};

			}

		 return Intakeservicerequesttype.find(searchobj)
		 .then(data => data)
		 .catch(err => err)
}


	Intakeservicerequesttype.beforeRemote('list', function(ctx, request, next) {

		if (JSON.parse(ctx.req.query.filter).page !== undefined && JSON.parse(ctx.req.query.filter).page === 1) {

			if  (JSON.parse(ctx.req.query.filter).where !== undefined) {

				if(JSON.parse(ctx.req.query.filter).where.intakeservreqtypekey!== undefined
				&& JSON.parse(ctx.req.query.filter).where.description!== undefined)
				{
					let intakeservreqtypekey = '/^'+(JSON.parse(ctx.req.query.filter).where.intakeservreqtypekey)+'/i';
					let description = '/^'+(JSON.parse(ctx.req.query.filter).where.description)+'/i';
					countIntakeservicerequesttype({
						and:[
							{intakeservreqtypekey:{regexp:intakeservreqtypekey},
							description:{regexp:description}}]
						   });
					

				}else if(JSON.parse(ctx.req.query.filter).where.intakeservreqtypekey!== undefined){

					let intakeservreqtypekey = '/^'+(JSON.parse(ctx.req.query.filter).where.intakeservreqtypekey)+'/i';
					countIntakeservicerequesttype({intakeservreqtypekey:{regexp:intakeservreqtypekey}});

				}else if(JSON.parse(ctx.req.query.filter).where.description!== undefined){

					let description = '/^'+(JSON.parse(ctx.req.query.filter).where.description)+'/i';
					countIntakeservicerequesttype({description:{regexp:description}});

				}else  {
					countIntakeservicerequesttype({
						archiveon : null
					});
		}

		}
	}

		next();
	});

	function countIntakeservicerequesttype(qryObj) {
		Intakeservicerequesttype.count(qryObj, function (err,count) {
			if (err) {
				LOGGER.debug(err + "err")
				throw err;
			}
			totalCount = count;
			LOGGER.debug(count);
		});
	}

	Intakeservicerequesttype.afterRemote('list',
			function(ctx, resultset, next) {

				if (ctx.result) {
					ctx.result = {
						'data' : resultset,
						'count' : totalCount
					};
				}
				next();
			});

	Intakeservicerequesttype.remoteMethod('list', {
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

	Intakeservicerequesttype.remoteMethod ('listdastatus', {
      		http: {
      			path: '/listdastatus',
      			verb: 'get'
      		},
      		accepts: {
      			arg: 'filter',
      			type: 'object',
      			required : true
      		},
      		returns: {
      			type: 'Object',
      			root : true
      		}
     });

	Intakeservicerequesttype.remoteMethod ('listdadisposition', {
      		http: {
      			path: '/listdadisposition',
      			verb: 'get'
      		},
      		accepts: {
      			arg: 'filter',
      			type: 'object',
      			required : true
      		},
      		returns: {
      			type: 'Object',
      			root : true
      		}
     });



	Intakeservicerequesttype.listactiontype =  function(data) {
		var inqString = "PAAC','PAAM','PAC','Proposal','PAT";
		var sql = 'SELECT * FROM  intakeservicerequesttype WHERE  intakeservreqtypekey IN ($1)';
		return util.executeDBQuery(sql, [inqString])
			.then(data2 => {
				LOGGER.debug( data2);
				return data2;
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});

	};


	Intakeservicerequesttype.remoteMethod ('listactiontype', {
  		http: {
  			path: '/listactiontype',
  			verb: 'get'
  		},
  		accepts: {
  			arg: 'filter',
  			type: 'Object',
  			http: {
  				source: 'body'
  			}
  		},
  		returns: {
  			type: 'Object',
  			root : true
  		}
 });

	Intakeservicerequesttype.patypelist = function(request) {

		return Intakeservicerequesttype.find({ where: {description:'Proposal'},
			 fields:[ 'intakeservreqtypekey','intakeservreqtypeid','description'],
			include: {
            	   relation: "servicerequestsubtype",
            	scope:{
            	   fields:[ 'description','intakeservreqtypeid','classkey']
            	}
              }
		});

	};

		Intakeservicerequesttype.remoteMethod('patypelist', {
			accepts : {
				arg : 'filter',
				type : 'Object',
				http : {
					source : 'query'
				},
				//required : true
			},
			http : {
				verb : 'get'
			},
			returns : {
			    	type : 'Object',
				root : true
			}
		});

		Intakeservicerequesttype.remoteMethod('add', {
			http : {
				path : '/add',
				verb : 'post'
			},
			accepts : [ {
				arg : 'data',
				type : 'object',
				http : {
					source : 'body'
				}
			} ],
			returns : {
				type : 'object',
				root : true
			}
		});

		Intakeservicerequesttype.add = function(data){
			return Intakeservicerequesttype.find({where:{intakeservreqtypekey:data.where.intakeservreqtypekey}})
			.then(res => {
			if(res.length === 0){
				return Intakeservicerequesttype.create(data.where);
			}else if(res.length > 0){
				return "Already Exist";
			}
			}).catch(err => err);
		}

		Intakeservicerequesttype.remoteMethod('delete', {
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

    Intakeservicerequesttype.reqtypelist = function(request) {

      const IntakeagencyreqtypeSearchObj = {
          fields: ['intakeagencyreqtypeid', 'intakeservreqtypeid'],
          include: {
              relation: 'intakeservicerequesttype',
              scope: {
                  fields: ['intakeservreqtypeid','description'],
                  order: 'description'
              }
          }
      };
      let agencyId = '';
      if(request.where && request.where.agencyid && request.where.agencyid !== 'all'){
          agencyId  = request.where.agencyid;

          IntakeagencyreqtypeSearchObj.where = {agencyid: agencyId};
      }

      return server.models.Intakeagencyrequesttype.find(IntakeagencyreqtypeSearchObj)
      .then(data => {
          const result = JSON.parse(JSON.stringify(data));
          let resources = result.map(x => x.intakeservicerequesttype).filter(x => x)
              .reduce((a,b) => a.concat(b), []);
          resources = resources.filter((thing, index, self) => self.findIndex(t => t.description === thing.description) === index);
          return resources;
      })
      .catch(err => util.logError(err));
  };

  Intakeservicerequesttype.remoteMethod('reqtypelist', {
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

		Intakeservicerequesttype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
		Intakeservicerequesttype.observe('access', (ctx, next) => util.access(ctx, next));
		Intakeservicerequesttype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));


};
