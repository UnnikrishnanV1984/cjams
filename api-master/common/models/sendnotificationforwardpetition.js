'use strict';
const LOGGER = require("log4js").getLogger("sendnotificationforwardpetition");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports.addnotifications = function (request) {
	const sql = "select * from sendnotificationforforwardpetition()";
	return util.executeDBQuery(sql, [])
		.then(res => {

			if (res) {
				var usersObj = JSON.parse(JSON.stringify(res));
				if (usersObj.length > 0) {
					const prs = [];
					prs.push(usersObj.map(element => {
						var assignedusers = [];
						assignedusers = element.assignedbyusers;
						if (assignedusers) {
							if (assignedusers.length > 0) {
								sendNotification(assignedusers, element);
							}
						}
					}))
					return Promise.all(prs)
				}
			}
		})
		.then(res => {
			return res;
		})
		.catch(err => {
			LOGGER.error('>>>>ERROR:', err);
			throw err;
		});

};

function sendNotification(assignedusers, element){
	assignedusers.forEach(assigneduser => {
		if (assigneduser) {
			var countyval = assigneduser.county[0].countyname;
			var youth = assigneduser.person[0].youthname;
			var nofiticationJson = {};
			if (element.usertype == 'assignedfrom' && assigneduser.securityusersid != null) {

				nofiticationJson.securityusersid = assigneduser.securityusersid;
				nofiticationJson.usernotificationtypekey = "System";
				nofiticationJson.objectid = element.intakenumber;
				nofiticationJson.subject = 'Transfer intake#"' + element.intakenumber + '" – Pending to Accept';
				nofiticationJson.priorityleveltypekey = "Normal";
				nofiticationJson.body = 'Transferred "' + element.intakenumber + '"  of "' + youth + '"  is pending for process by Receiving "' + countyval + '"';
				nofiticationJson.fromsecurityusersid = assigneduser.securityusersid;
			}
			else if (element.usertype == 'assignedto' && assigneduser.securityusersid != null) {
				nofiticationJson.securityusersid = assigneduser.securityusersid;
				nofiticationJson.usernotificationtypekey = "System";
				nofiticationJson.objectid = element.intakenumber;
				nofiticationJson.subject = 'Transfer  intake#"' + element.intakenumber + '"  – Pending for Process';
				nofiticationJson.priorityleveltypekey = "Normal";
				nofiticationJson.body = 'Transferred "' + element.intakenumber + '"  of "' + youth + '" from "' + countyval + '" is pending for process.';
				nofiticationJson.fromsecurityusersid = assigneduser.securityusersid;
			}
			if (nofiticationJson != {}) {
				const sql = 'select * from send_notification($1, $2, $3, $4, $5, $6, $7, $8, $9)';
				return util.executeDBQuery(sql,[nofiticationJson.securityusersid,nofiticationJson.securityusersid,nofiticationJson.securityusersid,'System','High',nofiticationJson.subject,nofiticationJson.body,nofiticationJson.objectid,false])
				.then(data => {
						return data;
				})
				.catch(err => {
						LOGGER.error(err);
						return err;
				})
			}

		}
	})
}
