'use strict';
const LOGGER = require("log4js").getLogger("personnytddetail");
const util = require('../utils/utils');
var app = require('../../server/server');
const moment = require('moment');

module.exports = function(PersonNytdDetail) {
    PersonNytdDetail.list = function (request) {
        if (request.where && request.where.summaryid !== undefined) {
            return PersonNytdDetail.find({
                    where: {
                        summaryid: request.where.summaryid
                    }
                }).then(resp => {
                    const data = JSON.parse(JSON.stringify(resp));
                    LOGGER.debug("data" + JSON.stringify(resp));
                    return data;
                })
                .catch(err => err);
        }
        return Promise.resolve([]);
    };

    PersonNytdDetail.remoteMethod('list', {
        http: {
            path: '/list',
            verb: 'get'
        },
        accepts : [{
            arg : 'filter',
            type : 'object',
            http : {source : 'query'}
        }],  
        returns: {
            type : 'object',
            root : true
        } 
    });

    PersonNytdDetail.add = async (request) => {
        var currentreporttype = '';
        var priorreporttype = '';
        var directive = request.where && request.where.directive ? request.where.directive : '';

        var errMsg = 'This Client cannot be included in NYTD Report. NYTD timeframe has expired or the Client is no longer NYTD eligible.'
        try {
            let current;
            var qry = 'SELECT * FROM sp_nytd_client_chk($1::bigint,current_date)';
            util.executeDBQuery(qry, [request.where.cjamspid])
            .then(data_curr => {
                current = data_curr[0].vs_report_type;
            })
            .catch(err => {
                LOGGER.error(err)
            })
            let prior;
            var qry2 = 'SELECT * FROM sp_nytd_client_chk_prior($1::bigint,current_date)';
            util.executeDBQuery(qry2, [request.where.cjamspid])
            .then(data_prior => {
                prior = data_prior[0].vs_prior_report_type;
            })
            .catch(err => {
                LOGGER.error(err)
            })

            currentreporttype = current;
            priorreporttype = prior;

            let data;
            if (directive === 'add' && currentreporttype === 'N' && priorreporttype !== 'B') {
                data = errMsg;
            } else if (directive === 'update' && currentreporttype === 'N' && priorreporttype === 'N') {
                data = errMsg;
            } else {
                var sql = "select * from cjams.sp_nytd_data_population($1::bigint,$2,$3)";
                data = await util.executeDBQuery(sql, [request.where.cjamspid, moment().format('YYYY-MM-DD'), 'D']);
            }
            LOGGER.info(data);
            return data;
        }
        catch (err) {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        }
    }

    PersonNytdDetail.remoteMethod('add', {
        http: {
                path: '/add',
                verb: 'post'
        },
        accepts : [{
            arg : 'data',
            type : 'object',
            http : {source : 'body'}
        }],
        returns: {
            type : 'string',
            root : true
        }
    });

    PersonNytdDetail.saveUpdate = function (request, reqctx) {
        const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;  
        var securityusersid = _securityusersid;

        if (request.directive && request.summaryid && request.summaryid !== undefined) {
            if (request.directive === 'softDelete') {
                return app.models.PersonNytdSummary.updateAll(
                    {   summaryid: request.summaryid },
                    {   activeflag: 0 }
                ).then(res => {
                    return PersonNytdDetail.updateAll(
                        {   summaryid: request.summaryid },
                        {   activeflag: 0 }
                    );
                });
            } else if (request.elements && request.elements.length) {
                return app.models.PersonNytdSummary.update(
                    {   summaryid: request.summaryid },
                    {   validationflag: request.directive === 'saveVerify' ? 1 : 0, 
                        updatedon: moment().format('YYYY-MM-DD HH:mm:ss'),
                        updatedby: securityusersid
                    }
                ).then(res => {
                    request.elements.forEach(rec => 
                        PersonNytdDetail.update(
                            {
                                summaryid: request.summaryid,
                                elementid: rec.elementid
                            },
                            {   elementvalue: rec.elementvalue,
                                updatedon: moment().format('YYYY-MM-DD HH:mm:ss'),
                                updatedby: securityusersid
                            }
                        )
                    );
                    if (request.directive === 'saveVerify') {
                        return PersonNytdDetail.updateAll(
                            {   summaryid: request.summaryid },
                            {   validatedflag: 1 }
                        );
                    } 
                });
            }
        }

        return PersonNytdDetail.find({
            where: { summaryid: request.summaryid }
        }).then(resp => {
         return JSON.parse(JSON.stringify(resp));
        }).catch(err => err);
    };

    PersonNytdDetail.remoteMethod('saveUpdate', {
        http: {
            path: '/saveUpdate',
            verb: 'post'
        },
        accepts : [{
            arg : 'data',
            type : 'object',
            http : {source : 'body'}
        }, {
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  }],  
        returns: {
            type : 'string',
            root : true
        } 
    });

    PersonNytdDetail.remoteMethod('xml', {
        accepts: {arg: 'period', type: 'string', required: true},
        http: {path: '/:period/xml', verb: 'get'},
        returns: [
                {arg: 'body', type: 'file', root: true},
                {arg: 'Content-Type', type: 'string', http: {target: 'header'}},
        ],
    });

    PersonNytdDetail.xml = async (period) => {
        const NytdXml = 
        require('./NytdXml');
        const xmler = new NytdXml();
        const reports = await PersonNytdDetail.getReportsForXml(period);
        const xml = xmler.generate(period, reports);
    
        return [xml, 'application/xml'];
      };

      PersonNytdDetail.getReportsForXml = async (reportingperiod) => {
        const str_rp30 = ' (case when substring(s.reportingperiod,5,2) = \'09\' then substring(s.reportingperiod,5,2) || \'/30/\' || substring(s.reportingperiod,1,4) ';
        const str_rp31 = ' substring(s.reportingperiod,5,2) || \'/31/\' || substring(s.reportingperiod,1,4) '
        const sql = '' + 'select d.summaryid, e.old_id, '+
                            'case when e.old_id = \'3\' then '+
                            '	cjams.f_afcars_encrypt(d.elementvalue) '+
                            'when e.old_id = \'5\' then	'+ 
                            '	(case when d.elementvalue not in (\'Female\', \'Male\') then '+
                            '		(case when p.gendertypekey = \'TGIF\' then '+
                            '			\'Male\' '+
                            '		 when p.gendertypekey = \'TGIM\' then '+	 					
                            '			 \'Female\' '+
                            '		 else '+
                            '			 d.elementvalue '+
                            '		 end) '+
                            '	 else '+
                            '		d.elementvalue '+
                            '	 end ) '+
                            'when e.old_id = \'35\' and d.elementvalue is not null and s.reporttypekey = \'13057\'  then '+
                            ' 	(case when d.insertedon::date > '+
                            str_rp30+
                            '			 else '+
                            str_rp31+
                            '			 end )::date then '+
                            '		to_char('+ str_rp30 +
                            '		else '+
                            str_rp31+
                            '		end )::date,\'MM/DD/YYYY\') '+
                            '	else '+
                            '		to_char(d.insertedon::date,\'MM/DD/YYYY\') '+
                            '	end ) '+
                            'when e.old_id = \'35\' and d.elementvalue is not null and s.reporttypekey != \'13057\'  then '+
                            ' 	(case when d.elementvalue::date > '+
                            str_rp30+
                            '			 else '+
                            str_rp31+
                            '			 end )::date then '+
                            '		to_char('+ str_rp30 +
                            '		else '+
                            str_rp31+
                            '		end )::date,\'MM/DD/YYYY\') '+
                            '	else '+
                            '		to_char(d.elementvalue::date,\'MM/DD/YYYY\') '+
                            '	end ) '+
                            'when e.old_id = \'34\' then '+
                            ' 	(select tpv.value_tx from tb_picklist_values tpv '+
                            '		where tpv.picklist_type_id = 10017 and tpv.picklist_value_cd = d.elementvalue) '+
                            'else '+
                            '	elementvalue '+
                            'end '+
                        'from personnytddetail d '+
                        '	JOIN nytddataelements e ON e.elementid = d.elementid '+
                        '	join personnytdsummary s on s.summaryid = d.summaryid '+
                        '	join person p on p.personid  = s.personid '+
                        'where d.activeflag = 1 '+
                        'and d.summaryid in ( select summaryid '+
                                            'from ('+
                                                'select summaryid, '+
                                                'row_number() over(partition by personid order by updatedon desc) as row_no '+
                                                'from personnytdsummary '+
                                                'where activeflag = 1 '+
                                                'and validationflag = 1 '+
                                                'and btrim(reportingperiod) = $1 '+
                                                'and case when substr($1,5,6) = \'03\' '+
                                                    'then btrim(reporttypekey) not in (\'13055\') '+
                                                    'else btrim(reporttypekey) not in (\'13054\') '+
                                                    'end '+
                                                'and personid is not null '+
                                            ') tab '+
                                            'where tab.row_no = 1 )'                
    
        // wrap in promise to await...
        const results = await util.executeDBQuery(sql, [reportingperiod])
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
        const reports = results.reduce((acc, record) => {
            acc[record.summaryid] = acc[record.summaryid] || [];
            (acc[record.summaryid]).push({
                id: record.old_id,
                value: record.elementvalue,
            });
            return acc;
        }, {});

        const resp = Object.values(reports);
        LOGGER.info(resp);
        return resp;

      };
}
