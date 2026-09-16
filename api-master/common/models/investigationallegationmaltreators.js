'use strict';
const LOGGER = require("log4js").getLogger("investigationallegationmaltreators");
const util = require('../utils/utils');
const app = require('../../server/server');
module.exports = function(Investigationallegationmaltreators) {


    Investigationallegationmaltreators.updateappeal = (request, reqctx) => {
        let _securityusersid = undefined;
		if(reqctx?.req?.headers?.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}
        const securityuserid = request.securityuserid ? request.securityuserid : _securityusersid;
        var attachment = request.attachment && Array.isArray(attachment) ? request.attachment : [];
        var maltreatorid = request.investigationallegationmaltreatorsid;
        return Investigationallegationmaltreators.updateAll({
            investigationallegationmaltreatorsid: request.investigationallegationmaltreatorsid
        }, {
                finalizeddate: request.finalizeddate,
                othermaltreator: request.othermaltreator,
                oaicesentdate: request.oaicesentdate,
                oahearingdatesetflag : request.oahearingdatesetflag,
                oahearingdate : request.oahearingdate,
                oanorhearingreason : request.oanorhearingreason,
                oahearingdecision : request.oahearingdecision,
                oahearingdecisiondate : request.oahearingdecisiondate,
                oadetails : request.oadetails,
                ccstayrequestedflag : request.ccstayrequestedflag,
                ccstaygrantedflag : request.ccstaygrantedflag,
                ccappealedflag : request.ccappealedflag,
                cchearingdecisiontypekey : request.cchearingdecisiontypekey, 
                cchearingdecisiondate : request.cchearingdecisiondate,
                ccdetails: request.ccdetails,
                csastayrequestedflag : request.csastayrequestedflag,
                csastaygrantedflag : request.csastaygrantedflag,
                csaappealedflag : request.csaappealedflag,
                csahearingdecisiontypekey : request.csahearingdecisiontypekey,
                csahearingdecisiondate : request.csahearingdecisiondate,
                oaappealedflag : request.oaappealedflag,
                csadetails : request.csadetails,
                oacasenumber : request.oacasenumber,
                cccasenumber : request.cccasenumber,
                csacasenumber : request.csacasenumber,
                scicesentdate : request.scicesentdate,
                scconfheldflag : request.scconfheldflag,
                scdecisiontypekey : request.scdecisiontypekey,
                scconferencedetail : request.scconferencedetail,
                scconferencedate : request.scconferencedate,
                overridefindingtypekey : request.overridefindingtypekey,
                overridecomments : request.overridecomments,
                cccompileddate : request.cccompileddate,
                overrideapprflag : request.overrideapprflag,
                cccourtdecisionflag : request.cccourtdecisionflag,
                csacourtdecisionflag : request.csacourtdecisionflag,
                coastayreqflag : request.coastayreqflag,
                coastaygrantedflag : request.coastaygrantedflag,
                coaappealedflag : request.coaappealedflag,
                coacourtdecisionflag : request.coacourtdecisionflag,
                coahearingdecisiontypekey : request.coahearingdecisiontypekey,
                coadetails : request.coadetails,
                coacasenumber : request.coacasenumber,
                coacompileddate : request.coacompileddate,
                coahearingdecisiondate: request.coahearingdecisiondate,
                updatedby: securityuserid,
                scisappealed: request.scisappealed,
                scappealedby: request.scappealedby,
                scappealeddate: request.scappealeddate,
                oaldssname: request.oaldssname,
                oaappellentatrny: request.oaappellentatrny,
                oalocaldept: request.oalocaldept,
                oarunningmotion: request.oarunningmotion,
                oahearingdateset: request.oahearingdateset,
                ccldssname: request.ccldssname,
                ccappellentatrny: request.ccappellentatrny,
                coaldssname: request.coaldssname,
                coaappellentatrny: request.coaappellentatrny,
                csaldssname: request.csaldssname,
                csaappellentatrny: request.csaappellentatrny,
                csanotifiedtodirector: request.csanotifiedtodirector,
                csacertiorari: request.csacertiorari,
                ccwhoappealed: request.ccwhoappealed,
                ccnotifiedtodirector: request.ccnotifiedtodirector,
                cccicuitcourtkey: request.cccicuitcourtkey,
                ccldssnotifieddate: request.ccldssnotifieddate,
                csaldssnotifieddate: request.csaldssnotifieddate,
                csacompileddate: request.csacompileddate,
                scsummarymailed: request.scsummarymailed,
                scappealedsetdate: request.scappealedsetdate,
                csawhoappealed: request.csawhoappealed
            }).then(data => {
                var programareareq ={};
                programareareq.eventcode ='IRFINALIZE';
                programareareq.objecttypekey ='servicerequest';
                programareareq.transid = maltreatorid;
                return app.models.Personprogramarea.programassignmentupdate(programareareq, _securityusersid);
            }).then(data => {
                return data;
            }).then(data => {
                var updateres = data;
                LOGGER.debug(JSON.stringify(data));
                   const insertedon = new Date().toLocaleString();
                   LOGGER.debug(attachment.length)
                        for(const element of attachment){
                            data = element;
                            LOGGER.debug(data)
                            data.objectid = request.investigationallegationmaltreatorsid;
                            data.objecttypekey = 'investigationappeal';
                            data.documenttypekey = 'Attachment';
                            data.rootobjectid=request.investigationallegationmaltreatorsid;
                            data.documentdate = insertedon;
                            data.insertedby = securityuserid;
                            data.updatedby = securityuserid;
                            LOGGER.debug(data)

                            var sql = "SELECT * FROM addinvestigationdocument($1)";

                            util.executeDBQuery(sql,[data])
                                .then(_data => {
                                    LOGGER.debug(_data)
                                })
                                .catch(err => {
                                    LOGGER.error('>>>>ERROR:', err);
                                    throw err;
                                });
                        }
                    
                return updateres;
            }).then(res=>{

                    /* call publish function to handle expungement */
                    var sql = 'SELECT * FROM publishinvestigationfinding($1,$2,$3)';
                    util.executeDBQuery(sql, [null, request.investigationallegationmaltreatorsid, null])
                        .catch(err => {
                            // DO NOTHING
                            LOGGER.err(err);
                        });

                return {'count': 1};
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            })

    }


    Investigationallegationmaltreators.remoteMethod('updateappeal',
        {
            http: {
                path: '/updateappeal',
                verb: 'post'
            },
            accepts: [{
                arg: 'data', type: 'object',
                http: { source: 'body' }
            }, {
                arg: 'reqctx',
                type: 'object',
                http: {source: 'context'}
              }],
            returns: {
                type: 'object',
                root: true
            }

        }) ;

        Investigationallegationmaltreators.updateappealhistory = (request, reqctx) => {
            let _securityusersid = undefined;
            if(reqctx?.req?.headers?.securityusersid){
              _securityusersid = reqctx.req.headers.securityusersid;
            }
            const securityuserid = request.securityuserid ? request.securityuserid : _securityusersid;
            var investigationallegationmaltreatorsid=request.investigationallegationmaltreatorsid;
            var attachment = request.attachment && Array.isArray(attachment) ? request.attachment : [];
            return util.executeDBQuery("update investigationallegationmaltreators set activeflag=0, updatedby=$1, updatedon=now() where investigationallegationmaltreatorsid=$2",
                [securityuserid, investigationallegationmaltreatorsid]).then(item => {
                    request.investigationallegationmaltreatorsid = null;
                    request.investigationallegationid = request.allegationid;
                    request.insertedby = securityuserid;
                    const insertedon = new Date().toLocaleString();
                    request.insertedon = insertedon;
                    return Investigationallegationmaltreators.create(request).then(data=>{
                        investigationallegationmaltreatorsid=data.investigationallegationmaltreatorsid;
                   
                    LOGGER.debug(JSON.stringify(data));
                      const uuidv4 = require('uuid').v4;
                      const randomUUID = uuidv4();
                       LOGGER.debug(attachment.length);
                            for(const element of attachment){
                                var attachmentdata = element.attachment[0];
                                LOGGER.debug(attachmentdata);
                                attachmentdata.objectid = investigationallegationmaltreatorsid;
                                attachmentdata.objecttypekey = 'investigationappeal';
                                attachmentdata.documenttypekey = 'Attachment';
                                attachmentdata.rootobjectid=investigationallegationmaltreatorsid;
                                attachmentdata.documentdate = insertedon;
                                attachmentdata.insertedby = securityuserid;
                                attachmentdata.updatedby = securityuserid;
                                attachmentdata.documentpropertiesid = randomUUID;
                                attachmentdata.attachmentdate =attachmentdata.documentdate;

                                LOGGER.debug(attachmentdata);

                                var sql = "SELECT * FROM addinvestigationdocument($1)";

                                util.executeDBQuery(sql,[attachmentdata])
                                    .then(result => {
                                        LOGGER.debug(data);
                                        return data;
                                    })
                                    .catch(err => {
                                        LOGGER.error('>>>>ERROR:', err);
                                        throw err;
                                    });

                            }
                        return data;
                })

               }).then(data => {
                return data;
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            })

        }
    
    
        Investigationallegationmaltreators.remoteMethod('updateappealhistory',
            {
                http: {
                    path: '/updateappealhistory',
                    verb: 'post'
                },
                accepts: [{
                    arg: 'data', type: 'object',
                    http: { source: 'body' }
                }, {
                    arg: 'reqctx',
                    type: 'object',
                    http: {source: 'context'}
                  }],
                returns: {
                    type: 'object',
                    root: true
                }
    
            });

    Investigationallegationmaltreators.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Investigationallegationmaltreators.observe('access', (ctx, next) => util.access(ctx, next));
    Investigationallegationmaltreators.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}
