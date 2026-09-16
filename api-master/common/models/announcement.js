'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Announcement) {

     Announcement.add =(request, reqctx) =>{
      let _securityusersid = undefined;
      if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
        _securityusersid = reqctx.req.headers.securityusersid;
      }  
        let announcementres = {};
        var activeflag = 1;
        const isallusers = request.isallusers;
       return Announcement.create({
           details: request.details,
            activeflag: activeflag,
            isallusers: isallusers
       }).then(res =>{
             announcementres = res;
            request.announcementid  = res.announcementid;
            var userid = request.user;
            if(Array.isArray(userid) && !isallusers) {
                return Promise.all(
                    userid.map(element =>{
                        request.userid = element;
                        const isaccepted =0;
                      return app.models.Userannouncement.create({
                             announcementid:announcementres.announcementid,
                             userid:element,
                             activeflag:activeflag,
                             isaccepted:isaccepted
                      })

                    })
                );
             }
             else if (isallusers) {

                      const securityuserid = (request && request.securityuserid?request.securityuserid: _securityusersid);
                      const isaccepted =0;
                    return app.models.Userannouncement.create({
                           announcementid:announcementres.announcementid,
                           userid:securityuserid.toLocaleString,
                           isaccepted:isaccepted
                    })
             }
        }).then(result =>{
             var returndata ={};
             returndata.announcement = announcementres;
             returndata.userannouncement = JSON.parse(JSON.stringify(result));
             return returndata;
        })
    }

    Announcement.list=(request) =>{
    return Announcement.find({
            fields:['announcementid','details'],
            include:{
                relation:'userannouncement',
                scope:{
                    fields:['announcementid','userid','userannouncementid'],
                    include:{
                         relation:'user',
                         scope:{
                            fields:['securityusersid','id'],
                            include:{
                                relation:'userprofile',
                                scope:{
                                    fields:['securityusersid','displayname','email']
                                }

                            }
                         }
                    }
                }
            }
        }
    ).then(res =>{
      return res;
        }).catch(err => err)


    }

    Announcement.getuserannouncement = request => {
        const userid = request.where.userid;
        return app.models.Userannouncement.findOne({
          where: {and: [{userid: userid}, {isaccepted: 0}]},
          fields: ['userannouncementid', 'announcementid', 'isaccepted'],
          include: {
            relation: 'announcement',
            scope: {
              fields: ['details']
            }
          }
        })
        .then(data => {

          var result = JSON.parse(JSON.stringify(data));
          if (result) {
            return {
              userannouncementid: result.userannouncementid,
              details: result.announcement? result.announcement.details: '',
              isaccepted: result.isaccepted
            };
        }
        else
            {return null;}
        })
        .catch(err => util.logError(err));
      };

      Announcement.remoteMethod('getuserannouncement', {
        http: {
          path: '/getuserannouncement',
          verb: 'get'
        },
        accepts : [{
          arg : 'filter',
          type : 'Object',
          required: false,
          http: {source: 'query'}
        }],
        returns: {
          type : 'Object',
          root : true
        }
      });

      Announcement.acceptannouncement = (id, request) => {
        const userannouncementid = id;
        const currentDate = new Date().toLocaleString();
        return app.models.Userannouncement.updateAll({userannouncementid: userannouncementid}, {isaccepted: 1, acceptedon: currentDate})
        .then(data => data)
        .catch(err => util.logError(err));
      };

      Announcement.remoteMethod('acceptannouncement', {
        accepts : [
        {
          arg: 'id',
          type: 'string',
          required: true,
          http: { source: 'path' }
			  },
        {
            arg: 'data',
            type: 'Object',
            required: false,
            http: {source: 'body'}
        }
        ],
        http: {"verb": "patch", "path": "/acceptannouncement/:id"},
        returns : {
            type : 'Object',
            root : true
        }
    });

    Announcement.remoteMethod('add', {
        http: {
                path: '/add',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}}, {
              arg: 'reqctx',
              type: 'object',
              http: {source: 'context'}
            } ],
        returns: {
            type : 'string',
            root : true
        }
    });


    Announcement.remoteMethod('list', {
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


    Announcement.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Announcement.observe('access', (ctx, next) => util.access(ctx, next));
    Announcement.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}
