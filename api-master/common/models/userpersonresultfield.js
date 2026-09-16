'use strict';
const LOGGER = require("log4js").getLogger("userpersonresultfield");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Userpersonresultfield) {

	Userpersonresultfield.listUserPreference = () => {
		const userid = app.currentUser.id;
		
		return Userpersonresultfield.find({
			fields: ['userpersonresultfieldid', 'userid', 'personresultfieldid'],
			where: {userid: userid},
			include: {
				relation: 'personresultfield',
				scope: {
					fields: ['personresultfieldkey', 'personresultfielddesc']
				}
			}
		});
	};

	Userpersonresultfield.updateUserPreference = (data) => {
		const userid = app.currentUser.id;
		const userpersonresultfields = data.where.userpersonresultfields;
		
		return Userpersonresultfield.updateAll({userid:userid}, {activeflag: 0})
		.then(result => {
			var sql = 'Update userpersonresultfield set activeflag = 1 where userpersonresultfieldid = $1';

			var prs = userpersonresultfields.filter(x => x.userpersonresultfieldid).map(x => {
                var params = [x.userpersonresultfieldid];

                return util.executeDBQuery(sql, params);
			});
			return Promise.all(prs);
		})
		.then(result => {
			var prs = userpersonresultfields.filter(x => !x.userpersonresultfieldid).map(x => {
				if(!x.userpersonresultfieldid){
					return Userpersonresultfield.create({
						userid: userid,
						personresultfieldid: x.personresultfieldid
					});}
			});
			return Promise.all(prs);
		})
		.catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
	};

	Userpersonresultfield.remoteMethod('listUserPreference', {
        http: {
                path: '/listUserPreference',
                verb: 'get'
        },
        accepts : [],
        returns: {
            type : 'object',
            root : true
        }
	});
	
	Userpersonresultfield.remoteMethod('updateUserPreference', {
        http: {
                path: '/updateUserPreference',
                verb: 'post'
        },
        accepts : [
            {
                arg : 'data',
                type : 'object',
                http : {source : 'body'}
            }],
        returns: {
            type : 'object',
            root : true
        }
    });

    Userpersonresultfield.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Userpersonresultfield.observe('access', (ctx, next) => util.access(ctx, next));
	Userpersonresultfield.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}