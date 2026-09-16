'use strict';
var server = require('../../server/server');
const util = require('../utils/utils');
var fs = require('fs');
const LOGGER = require("log4js").getLogger("Servicedictionary");

module.exports = function (Servicedictionary) {
    Servicedictionary.GetAPIDatadictionary = function () {
        const Json2csvParser = require('json2csv').Parser;


        var modelresp = Servicedictionary.getModelProperties(); /* Get Model Properties */

        /* Define CSV headers*/
        const csvheader = ['modelname', 'path', 'fieldname', 'length', 'datatype'];

        const json2csvParser = new Json2csvParser({ csvheader });
        const jsontocsv = json2csvParser.parse(modelresp); //Convert JSON to CSV format

        var filename = new Date().toLocaleString();
        filename = ((filename.replace("-", "")).replace(" ", "")).replace(":", "");
        filename = ((filename.replace("-", "")).replace(" ", "")).replace(":", "");

        var file1 = server.dataSources.localstorage.settings.root + "/uploads/APIDatadic_" + filename + ".csv";

        /*Write CSV file into Disk*/
        fs.writeFile(file1, jsontocsv, (err) => {
            if (err) {
                LOGGER.error(err);
            }

        });

        return jsontocsv;
    };

    //Generate JSON for Model properties
    Servicedictionary.getModelProperties = function () {

        var response = [];
        try {

            var objmodels = server.models(); //Get all models for this project 

            objmodels.forEach(Model => {
                var modelprop = Object.entries(Model.definition.properties);
                var irun = 1;
                modelprop.forEach(prop => {

                    var modeljson = { "modelname": "", "tablename": "", "path": '', "fieldname": '', "index": '', "length": '', "datatype": '' }

                    modeljson.modelname = Model.modelName;

                    if (Model.definition.settings.postgresql != null && Model.definition.settings.postgresql != undefined &&
                        Model.definition.settings.postgresql.table != null && Model.definition.settings.postgresql.table != undefined){
                        modeljson.tablename = Model.definition.settings.postgresql.table;
                    }
                    modeljson.path = "/api" + Model.http.path;
                    modeljson.fieldname = prop[0];
                    modeljson.index = irun++;
                    modeljson.datatype = prop[1].type.name;
                    modeljson.length = prop[1].length;

                    response.push(modeljson);

                });
            });
            return response;
        } catch (error) {
            LOGGER.error('>>>>ERROR:', error);
            throw error;
        }
    }
    Servicedictionary.getApiDatadic = function (req, res, callback) {

        var resp = Servicedictionary.GetAPIDatadictionary();
        res.send(resp);

    };
    Servicedictionary.remoteMethod('getApiDatadic',
        {
            accepts: [
                { arg: 'type', type: 'string', required: false },
                { arg: 'res', type: 'object', 'http': { source: 'res' } }
            ],
            returns: {},
            http: { path: '/getapidatadic', verb: 'get' }
        });
    Servicedictionary.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
}   
