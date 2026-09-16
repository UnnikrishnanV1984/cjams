'use strict';
const LOGGER = require("log4js").getLogger("personeducation");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function (Personeducation) {

    Personeducation.list = request => {
        let gPersonEdn = [];
        const personid = request.where.personid;
        return Personeducation.find({
                where: {
                    personid: personid
                },
                include: [{
                    relation: 'educationtype',
                    scope: {
                        fields: ['educationtypekey', 'typedescription']
                    }
                }, {
                    relation: 'county',
                    scope: {
                        fields: ['countyid', 'countyname']
                    }
                }, {
                    relation: 'lastgrade',
                    scope: {
                        fields: ['gradetypekey', 'typedescription']
                    }
                }, {
                    relation: 'currentgrade',
                    scope: {
                        fields: ['gradetypekey', 'typedescription']
                    }
                }, {
                    relation: 'school',
                    scope: {
                        fields: ['schoolid', 'educationtypekey', 'schoolname', 'address', 'city', 'zipcode', 'phonenumber']
                    }
                }]
            })
            .then(data => {
                gPersonEdn = JSON.parse(JSON.stringify(data));
                const prs = gPersonEdn.map(x => findStateByCode(x));
                return Promise.all(prs);
            })
            .then(data => data)
            .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
    };

    function findStateByCode(personEdn) {
        return app.models.State.find({
                where: {
                    stateabbr: personEdn.statecode
                },
                fields: ['statename']
            })
            .then(res => {
                const data = JSON.parse(JSON.stringify(res));
                if (data.length > 0){
                    personEdn.statename = data[0].statename;}
                return personEdn;
            })
            //.then(data => data)
            .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
    }

    Personeducation.remoteMethod('list', {
        http: {
            path: '/list',
            verb: 'get'
        },
        accepts: [{
            arg: 'filter',
            type: 'object',
            http: {
                source: 'query'
            }
        }],
        returns: {
            type: 'object',
            root: true
        }
    });

    Personeducation.remoteMethod('addupdate', {
        http: {
            path: '/addupdate',
            verb: 'post'
        },
        accepts: [{
            arg: 'data',
            type: 'object',
            http: {
                source: 'body'
            }
        }, {
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  }],
        returns: {
            type: 'string',
            root: true
        }
    });

    Personeducation.addupdate = function (request, reqctx) {
        let _securityusersid = undefined;
		if(reqctx?.req?.headers?.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
        var securityuserid = request.securityuserid ? request.securityuserid : _securityusersid;
        const securityusersid = request.securityusersid ? request.securityusersid : _securityusersid;
        var edu = request.personEducation;
        var edutest = request.personEducationTesting;
        var eduaccomp = request.personAccomplishment;
        var personid = request.personid;
        var education = {};
        var objectid = null;
        var objecttype = null;
        education['personeducation'] = edu;
        education['personeducationtesting'] = edutest;
        education['personaccomplishment'] = eduaccomp;
        if( edu.length>0) {
            objectid = education['personeducation'][0].objectid
            objecttype = education['personeducation'][0].objecttype
        }
        var datafinal = {};
        datafinal['education'] = education;
        var sql = "select * from addupdateeducation($1,$2,$3,$4,$5)"
        const insertedon = new Date().toLocaleString();
        return util.executeDBQuery(sql, [personid, JSON.stringify(edu), JSON.stringify(edutest), JSON.stringify(eduaccomp), securityuserid])
            .then(data => {
                util.auditLogSave(personid,'PED',datafinal);
                app.models.Auditlog.create({
                    logtypekey:'IN035',
                    intakeserviceid:null,
                    servicerequestnumber:null,
                    referenceid:null,
                    description:'Education  modified',
                    isnew :false,
                    isedit:true,
                    isdelete:true,
                    insertedby: securityusersid,
                    updatedby: securityusersid,
                    insertedon:insertedon,
                    updatedon:insertedon,
                    metadata:null,
                    ipaddress:null,
                    old_id:null,
                    modifieddata:null,
                    objectid:objectid,
                    objecttype:objecttype

                }).catch(_err => LOGGER.error(_err));
                return data;
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
    };

    Personeducation.personeducationdelete = (id,reqctx) => {
        let suserid=undefined;
        if(reqctx && reqctx.req &&reqctx.req.headers){
          suserid=reqctx.req.headers.securityusersid
        }

        var sql = 'update personeducation set updatedby = $1, updatedon = now(), activeflag = 0 WHERE personeducationid =\'' + id + '\'';
        var params = [suserid];

        return util.executeDBQuery(sql, params)
            .then(data => {
                return data;
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
    };

    Personeducation.remoteMethod('personeducationdelete', {
        http: {
            path: '/personeducationdelete/:id',
            verb: 'delete'
        },
        accepts:[ {
            arg: 'id',
            type: 'string',
            required: true,
            http: {
                source: 'path'
            }
        },
        {
            arg: 'reqctx',
       type: 'object',
        http: {source: 'context'}
             }
    ],
        returns: {
            type: 'Object',
            root: true
        }
    });

    Personeducation.remoteMethod('getpersoneducation', {
        http: {
            path: '/educationlist',
            verb: 'get'
        },
        accepts: [{
            arg: 'filter',
            type: 'object',
            http: {
                source: 'query'
            }
        }],
        returns: {
            type: 'object',
            root: true
        }
    });

    Personeducation.getpersoneducation = function (request) {
        const personid = request.where.personid;
        var sql = 'select * from geteducationdetails($1)';
		return util.executeSecondaryNodeDBQuery(sql,[personid])
				.then(data => {
					var final = data[0];
					if (final && final.personEducation && final.personEducation.length > 0) {
						var placementids = [];
						final.personEducation.forEach(element => {
							if (element.bestdetermination && element.bestdetermination.bestDeterminationList && element.bestdetermination.bestDeterminationList.length > 0) {
								element.bestdetermination.bestDeterminationList.forEach(bestDetermination => {
									placementids.push(bestDetermination.placementid);
								});
							}
						});
						if (placementids.length > 0) {
							placementids = '{' + placementids.toString() + '}';
							var childsql = 'select * from getplacementdetailinfos($1)';
							return util.executeSecondaryNodeDBQuery(childsql,[placementids])
							.then(placementdetail => {
								return updatebestDetermination(placementdetail, final);
})
							.catch(err => {
									LOGGER.error('>>>>ERROR:', err);
							})
						} else {
							return final;
						}
					} else {
						return final;
					}
				})
				.then(function (value) {
					return value;
				})
				.catch(err => {
					util.logError(err)
					LOGGER.error(err)
				})
    };

		function updatebestDetermination(placementdetail, final){
			if (placementdetail.length > 0 && placementdetail[0].getplacementdetailinfos) {
				final.personEducation.forEach(element => {
					if (element.bestdetermination && element.bestdetermination.bestDeterminationList && element.bestdetermination.bestDeterminationList.length > 0) {
						element.bestdetermination.bestDeterminationList.forEach(bestDetermination => {
							var placementInfo = placementdetail[0].getplacementdetailinfos.find((p) => bestDetermination.placementid === p.placementid);
							if (placementInfo) {
								bestDetermination.placement_type = placementInfo.placement_type;
								bestDetermination.provider_id = placementInfo.provider_id;
								bestDetermination.provider_name = placementInfo.provider_name;
								bestDetermination.entry_date = placementInfo.entry_date;
								bestDetermination.exit_date = placementInfo.exit_date;
								bestDetermination.address = placementInfo.address;
								bestDetermination.placementstructuredesc = placementInfo.placementstructuredesc;
							}
						});
					}
				});
			}
			return final;
		}

    Personeducation.remoteMethod('getpersoneducationforassessment', {
        http: {
            path: '/educationlistforassessment',
            verb: 'get'
        },
        accepts: [{
            arg: 'filter',
            type: 'object',
            http: {
                source: 'query'
            }
        }],
        returns: {
            type: 'object',
            root: true
        }
    });

    Personeducation.geteducationplacements = function (personid) {

        var sql = 'select * from geteducationplacements($1)';
        return util.executeDBQuery(sql, [personid])
        .then(function (data) {
            return data[0];
        }).catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
    };

    Personeducation.remoteMethod('geteducationplacements', {
        http: {
          path: '/geteducationplacements/:id',
          verb: 'get'
        },
        accepts : [{
          arg: 'id',
          type: 'string',
          required: true,
          http: {source: 'path'}
       }],
        returns: {
          root :true,
          type: 'object'
        }
      });

    Personeducation.getpersoneducationforassessment = function (request) {
        const object_id = request.where.object_id;
            var sql = 'select * from geteducationdetailsforassessment($1)';
        return util.executeSecondaryNodeDBQuery(sql, [object_id])
        .then(function (value) {
            return value;
        }).catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
    };


    Personeducation.personeducationtestingdelete = (id) => {
        var sql = 'update personeducationtesting set activeflag = 0 WHERE personeducationtestingid =\'' + id + '\'';
        return util.executeDBQuery(sql, [])
            .then(_data => {
                return _data;
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
    };

    Personeducation.remoteMethod('personeducationtestingdelete', {
        http: {
            path: '/personeducationtestingdelete/:id',
            verb: 'delete'
        },
        accepts: {
            arg: 'id',
            type: 'string',
            required: true,
            http: {
                source: 'path'
            }
        },
        returns: {
            type: 'Object',
            root: true
        }
    });

    Personeducation.personaccomplishmentdelete = (id) => {
        var sql = 'update personaccomplishment set activeflag = 0 WHERE personaccomplishmentid =\'' + id + '\'';
        return util.executeDBQuery(sql, [])
            .then(data1 => {
                return data1;
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
    };

    Personeducation.remoteMethod('personaccomplishmentdelete', {
        http: {
            path: '/personaccomplishmentdelete/:id',
            verb: 'delete'
        },
        accepts: {
            arg: 'id',
            type: 'string',
            required: true,
            http: {
                source: 'path'
            }
        },
        returns: {
            type: 'Object',
            root: true
        }
    });


    Personeducation.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Personeducation.observe('access', (ctx, next) => util.access(ctx, next));
    Personeducation.observe('after save', (ctx, next) => util.aftersave(ctx, next,'PED',
    ctx.isNewInstance?ctx.instance.personid:ctx.data.personid));    
    Personeducation.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));

};