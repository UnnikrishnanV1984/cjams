'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Helptext) {

  Helptext.addupdate=  request => {

      return Helptext.find({
        where: {
          and: [{formkey: request.formkey}, {controlindex: request.controlindex}]
        }
      })
			.then(res => {
        if(res.length === 0) {
          return Helptext.create(request);
        }
        else if(res.length > 0) {
          return Helptext.updateAll({formkey: request.formkey, controlindex: request.controlindex},{helptext: request.helptext});
        }
			}).catch(err => err);
		}

  Helptext.list = data => {

    const formkey = data.where.formkey;

    return Helptext.find({
        fields: ['formkey', 'controlindex','helptext'],
        where: {formkey: formkey},
        order: 'controlindex'
    })
    .then(_data => _data)
    .catch(err => util.logError(err));
};


Helptext.remoteMethod(
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

    Helptext.remoteMethod('list', {
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

    Helptext.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Helptext.observe('access', (ctx, next) => util.access(ctx, next));
    Helptext.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
