'use strict';
const LOGGER = require("log4js").getLogger("pdf");
var fs = require('fs');
var app = require('../../server/server');
var config = require('../../server/config.json');
const util = require('../utils/utils');
var pdfGenerator = require('../utils/pdfgenerator');
var Excel = require('exceljs');
var HtmlDocx = require('html-docx-js');
var currencyFormatter = require('currency-formatter');
const moment = require('moment');

const compliantnotifipath = './documenttemplates/compliant-notifi.html';
const intakeappointpath = './documenttemplates/Intake-Appoint.html';
const dhslogopath = "./documenttemplates/assets/images/dhslogo.png";

const stylepath = '{{root_template_path_style}}';
const imagepath = '{{root_template_path_image}}';
const logopath = '{{root_template_path_logo}}';
const officernamefield = '{{officername}}';
const cssurl = "/style.css";
const headerurl = "/header.html";

const tdclosetags = '</td></tr>';
const dtspantags = '</span></div><div class="frm"><span><b>Date</b></span><span>';
const dtspanendtags = '</span></div></div></div>';
const usdtag = '</td><td align="right">$';

const policeno = "(410) 230-3333";
const dtformat = 'MM/DD/YYYY';
const baseurllogstmt = "app.baseurl";
const accounttypestr = 'Account Type';
const totalbalancestr = 'Total Balance';
const contenttypestr = 'Content-Type';
const spreadsheetcontenttype = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
const contentdispositionstr = "Content-Disposition";
const attachmentstr = "attachment; filename=";
const dtformat1 = 'MM/DD/YYYY, h:mm a';
const dtformat2 = 'MM/DD/YYYY, h:mm:ss a';
const dtformat_datetime = 'MM/DD/YYYY HH:mm:ss';

const provideridstr = 'Provider ID';
const providernamestr = 'Provider Name';
const ivespecialistrole = 'IV-E Specialist';
const ivesupervisorrole = 'IV-E Supervisor';

const otherStr = 'Other (specify)';
const nodisplayStyle = 'style="display:none;"';
const supervisorSignDate = '{{supervisorSignDate}}';
const showLDSSSignature = '{{showLDSSSignature}}';
const lineSpaceClose = '<br>&nbsp;</div>';
const closelabeldiv = ' </label></div>';
const divXs12 = '<div class="col-xs-12">';
const divRow = '<div class="row">';
const tableClosetag = '</tbody></table></div></div>'
const tdWidth10 = '<td  width="10%">';
const thPayidTag = '<th>PAYMENT ID</th>';
const thpaytypeTag = '<th>PAYMENT TYPE</th>';
const thgrossAmtTag = '<th>GROSS AMOUNT</th>';
const thnetAmtTag = '<th>NET AMOUNT</th>';
const thcheckTag = '<th>CHECK#</th>';
const tdStyleRightTag = '<td align="right">'
const numFmtStr = '"$"#,##0.00;[Red]\-"$"#,##0.00';
const checkboxDisabled = '<input type="checkbox" disabled/>';
const checkboxDisabledChecked = '<input type="checkbox" disabled checked/>';
const eligibleReimbursible = 'Eligible Reimbursable';
const eligibleNonReimbursible = 'Eligible Non-Reimbursable';
const inputChecboxTag = '<input type="checkbox" ';


const persondetailsbyintakenosql = "select * from persondetailsbyintakenumber($1)";
const letterheadapdxdtojsql = "select * from letterheadapdxdtoj($1,$2,$3)";
const firstnoticesql = "select * from firstnotice($1,$2,$3)";

const getstateInfo = async function (data){
  const sql = "select * from getstateconfiginfo()";
  // reqjson is optional on generatepdf, so callers that pass no template data
  // reach here with undefined. Substitute an object rather than assigning onto
  // it, so the DHS* placeholders still resolve for those documents.
  const statedata = data || {};
  try {
    const response = await util.executeDBQuery(sql, []);
    if (response[0]) {
      const stateinfo = response[0].stateinfo[0];
      statedata.DHSGovernor = stateinfo.governor ? stateinfo.governor : '';
      statedata.DHSLtGovernor = stateinfo.ltgovernor ? stateinfo.ltgovernor : '';
      statedata.DHSSecretary = stateinfo.dhssecretary ? stateinfo.dhssecretary : '';
    }
    return statedata;
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
}

//created by venkatesh -sep-24 - To generate pdf documents from html.
module.exports.CompNotiftest = async function (request) {
  LOGGER.debug("request", request);
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid;

  const sql = "select * from getintakeforpdfcreation($1)";

  try {
    const data = await util.executeDBQuery(sql, [intakeservicerequestevaluationid]);
      if (data.length > 0) {
        LOGGER.debug("data ::: ", app.currentUser);

        var securityuserid = app.currentUser.userprofile.fullname;
        var role = app.currentUser.roletypekey;
        var evaluationfields = data[0];

        var html = fs.readFileSync(compliantnotifipath, 'utf8');

        html = html.replace(stylepath, config.documenttemplates);
        html = html.replace(imagepath, config.documenttemplates);
        html = html.replace('{{crntdate}}', util.formatDate(new Date().toLocaleString()));
        html = html.replace(/{{complaintid}}/g, util.nullcheck(evaluationfields.complaintid));
        html = html.replace(/{{complaintdate}}/g, util.nullcheck(util.formatDate(evaluationfields.complaintreceiveddate)));
        html = html.replace(/{{policelastname}}/g, util.nullcheck(evaluationfields.lastname));
        html = html.replace(/{{policefirstname}}/g, util.nullcheck(evaluationfields.firstname));
        html = html.replace(/{{city}}/g, util.nullcheck(evaluationfields.countyname));
        html = html.replace('{{zip}}', util.nullcheck(evaluationfields.zipcode));
        html = html.replace('{{streetaddress}}', util.nullcheck(evaluationfields.street1) + '<br/>' + util.nullcheck(evaluationfields.street2));
        html = html.replace('{{allegedoffense}}', '<tr><td>' + util.nullcheck(evaluationfields.allegationname) + '</td><td>' + util.nullcheck(util.formatDate(evaluationfields.offensedate)) + tdclosetags);
        html = html.replace('{{policenumber}}', policeno); //util.nullcheck(evaluationfields.zipcode));
        html = html.replace('{{additionalcomments}}', 'Additional comments'); //util.nullcheck(evaluationfields.zipcode));
        html = html.replace(officernamefield, util.nullcheck(securityuserid));
        html = html.replace('{{role}}', util.nullcheck(role));
        html = html.replace('{{datewithaddition}}', util.addextradays(new Date().toLocaleString()));

        //to generate pdf file
        module.exports.generatepdf(request, html);
      }
      return data;
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
};

module.exports.IntakeInfAction = function (request) {
  let reqjson = {};
  let prs = [];
  var securityuserid = app.currentUser.userprofile.securityusersid;
  var role = app.currentUser.roletypekey;
  prs = request.where.intakeservicerequestevaluationid.map(async evaluationid => {

    const sql = "select * from intakeformalaction($1,$2)";
    let Response;
    try {
      const data = await util.executeDBQuery(sql, [evaluationid, securityuserid]);
      if (data.length > 0) {
          let responseval = [];
          let resallegations = "";
          responseval = data[0];
          var html = fs.readFileSync('./documenttemplates/IntakeFormalActionNotification.html', 'utf8');
          if (responseval.offensename != null) {
            responseval.offensename.forEach(allegation => {
              resallegations += '<tr>';
              resallegations += '<td>' + util.nullcheck(allegation) + '</td><td>' + util.nullcheck(responseval.offensedate) + '</td>'
              resallegations += '</tr>';
            })
          }


          reqjson = {
            root_template_path_style: app.baseurl,
            root_template_path_image: app.baseurl,
            "crntdate": util.formatDate(new Date().toLocaleString()),
            "complaintid": util.nullcheck(responseval.complaint_id),
            "complaintdate": util.nullcheck(util.formatDate(new Date(responseval.complaintdate))),
            "youthname": util.nullcheck(responseval.youthname),
            "youthaddress": util.nullcheck(responseval.youthaddress),
            "youthaddress2": util.nullcheck(responseval.youthstate),
            "youthid": util.nullcheck(responseval.youthid),
            "allegedoffense": resallegations,
            "officername": util.nullcheck(responseval.officername),
            "officerphone": responseval.officerphone ? responseval.officerphone : policeno,
            "role": role
          };
          request.where.evaluationid = evaluationid;
          request.where.outputfilename = reqjson.complaintid+"_"+"IntakeInfAction";
          Response = module.exports.generatepdf(request, html, reqjson);
        }

        return Response;
      } catch (err) {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      }
  })
  return Promise.all(prs)
};

module.exports.IntakeDecisionAppealCins = function (request) {
  let reqjson = {};
  let prs = [];
  var securityuserid = app.currentUser.userprofile.securityusersid;
  var role = app.currentUser.roletypekey;

  prs = request.where.intakeservicerequestevaluationid.map(async evaluationid => {

    const sql = "select * from intakedecisionappealcins($1, $2)";
    let Response;
    try {
      const data = await util.executeDBQuery(sql, [evaluationid, securityuserid]);
      if (data.length > 0) {
          let responseval = [];
          let resallegations = "";
          responseval = data[0];
          var html = fs.readFileSync('./documenttemplates/intakeappealcins.html', 'utf8');
          if (responseval.offensename != null) {
            responseval.offensename.forEach(allegation => {
              resallegations += `<tr>
                                  <td> ${util.nullcheck(allegation)} </td><td> ${util.nullcheck(responseval.offensedate)} </td>
                                  </tr>`;
            })
          }

          reqjson = {
            root_template_path_style: app.baseurl,
            root_template_path_image: app.baseurl,
            "crntdate": util.formatDate(new Date().toLocaleString()),
            "complaintid": util.nullcheck(responseval.complaint_id),
            "complaintdate": util.nullcheck(util.formatDate(new Date(responseval.complaintdate))),
            "youthname": util.nullcheck(responseval.youthname),
            "guardianname": util.nullcheck(responseval.parentname),
            "guardianaddress": util.nullcheck(responseval.parentaddress),
            "youthid": util.nullcheck(responseval.youthid),
            "allegedoffense": resallegations,
            "areadirectorname": 'John Davis',
            "areadirectoraddress": '123 Court Street' + '<br/>' + 'Baltimore, MD 21212',
            "comments": util.nullcheck(responseval.reviewcomments),
            "officerphone": util.nullcheck(responseval.officerphone),
            "officername": util.nullcheck(responseval.officername),
            "role": role
          };
          request.where.evaluationid = evaluationid;
          request.where.outputfilename = reqjson.complaintid+"_"+"intakedecisionappeallettercinscases";
          Response = module.exports.generatepdf(request, html, reqjson);
        }

        return Response;
      } catch (err) {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      }
  })
  return Promise.all(prs)
};

module.exports.IntakeDecisionAppeal = function (request) {
  let reqjson = {};
  let prs = [];
  var securityuserid = app.currentUser.userprofile.securityusersid;
  var role = app.currentUser.roletypekey;

  prs = request.where.intakeservicerequestevaluationid.map(async evaluationid => {

    const sql = "select * from intakedecisionappeal($1, $2)";
    let Response;
    try {
      const data = await util.executeDBQuery(sql, [evaluationid, securityuserid]);
      if (data.length > 0) {
          let responseval = [];
          let resallegations = "";
          responseval = data[0];
          var html = fs.readFileSync('./documenttemplates/intakeappeal.html', 'utf8');
          if (responseval.offensename != null) {
            responseval.offensename.forEach(allegation => {
              resallegations += `<tr>
                                    <td>${util.nullcheck(allegation)}</td>
                                    <td> ${util.nullcheck(responseval.offensedate)} </td>
                                  </tr>`;
            })
          }


          reqjson = {
            root_template_path_style: app.baseurl,
            root_template_path_image: app.baseurl,
            "crntdate": util.formatDate(new Date().toLocaleString()),
            "complaintid": util.nullcheck(responseval.complaint_id),
            "complaintdate": util.nullcheck(util.formatDate(new Date(responseval.complaintdate))),
            "youthname": util.nullcheck(responseval.youthname),
            "youthid": util.nullcheck(responseval.youthid),
            "allegedoffense": resallegations,
            "policeagency": util.nullcheck(responseval.agency),
            "policeofficer": util.nullcheck(responseval.policename),
            "policeaddress": util.nullcheck(responseval.policeaddresss),
            "deadlinedate": util.nullcheck(responseval.deadlinedate),
            "attorneyaddress": '300 N. Gay Street' + '<br/>' + 'Baltimore, MD 21202',
            "officerphone": util.nullcheck(responseval.officerphone),
            "officername": util.nullcheck(responseval.officername),
            "role": role
          };
          request.where.evaluationid = evaluationid;
          request.where.outputfilename = reqjson.complaintid+"_"+"intakeappeal";
          Response = module.exports.generatepdf(request, html, reqjson);
        }

        return Response;
      } catch (err) {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      }
  })
  return Promise.all(prs)
};

module.exports.VictimImpacttest = async function (request) {
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid;

  const sql = persondetailsbyintakenosql;

  try {
    const data = await util.executeDBQuery(sql, [intakeservicerequestevaluationid]);
      if (data.length > 0) {
        var securityuserid = app.currentUser.userprofile.fullname;
        var role = app.currentUser.roletypekey;
        for (const element of data) {
          var personfields = element;
          if (personfields.personrole.toLowerCase() == 'victim') {
            var html = fs.readFileSync('./documenttemplates/Intake-Formal-Action-Notification-Letter.html', 'utf8');
            html = html.replace(stylepath, config.documenttemplates);
            html = html.replace(imagepath, config.documenttemplates);
            html = html.replace(/{{youthname}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{youthid}}/g, util.nullcheck(personfields.personid.substr(personfields.personid.length - 10)).toUpperCase());
            html = html.replace(officernamefield, util.nullcheck(securityuserid));
            html = html.replace('{{role}}', util.nullcheck(role));

            //to generate pdf file
            module.exports.generatepdf(request, html);
          }
        }
      }

      return data;
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
};

module.exports.OfficeVisit = async function (request) {
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid;

  const sql = persondetailsbyintakenosql;

  try {
    const data = await util.executeDBQuery(sql, [intakeservicerequestevaluationid]);
      if (data.length > 0) {
        var securityuserid = app.currentUser.userprofile.fullname;
        var role = app.currentUser.roletypekey;
        for (const element of data) {
          var personfields = element;
          var html = fs.readFileSync('./documenttemplates/Intake-Formal-Action-Notification-Letter.html', 'utf8');
          if (personfields.personrole.toLowerCase() == 'youth') {
            html = html.replace(stylepath, config.documenttemplates);
            html = html.replace(imagepath, config.documenttemplates);
            html = html.replace(/{{youthname}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{youthid}}/g, util.nullcheck(personfields.personid.substr(personfields.personid.length - 10)).toUpperCase());
            html = html.replace(officernamefield, util.nullcheck(securityuserid));
            html = html.replace('{{role}}', util.nullcheck(role));
          }
          if (personfields.relationshiptorakey.toLowerCase() == 'father') {

            html = html.replace(/{{youthparentname}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{youthparentaddress}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{youthname}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{youthname}}/g, util.nullcheck(personfields.personfullname));
          }

          //to generate pdf file
          module.exports.generatepdf(request, html);
        }
      }


      return data;
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
};

module.exports.OrientalForm = async function (request) {
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid;

  const sql = persondetailsbyintakenosql;

  try {
    const data = await util.executeDBQuery(sql, [intakeservicerequestevaluationid]);
      if (data.length > 0) {
        var securityuserid = app.currentUser.userprofile.fullname;
        var role = app.currentUser.roletypekey;
        for (const element of data) {
          var personfields = element;
          if (personfields.personrole.toLowerCase() == 'youth') {
            var html = fs.readFileSync('./documenttemplates/Orientation-Form.html', 'utf8');
            html = html.replace(stylepath, config.documenttemplates);
            html = html.replace(imagepath, config.documenttemplates);
            html = html.replace(/{{youthname}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{youthid}}/g, util.nullcheck(personfields.personid.substr(personfields.personid.length - 10)).toUpperCase());
            html = html.replace(officernamefield, util.nullcheck(securityuserid));
            html = html.replace('{{role}}', util.nullcheck(role));

            html = html.replace(/{{casemanager}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{phonenumber}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{officeaddress}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{casemanagersupervisor}}/g, util.nullcheck(personfields.personfullname));
          }


          //to generate pdf file
          module.exports.generatepdf(request, html);
        }
      }
      return data;
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
};

module.exports.testIntakeDS = async function (request) {
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid;

  const sql = persondetailsbyintakenosql;

  try {
      const data = await util.executeDBQuery(sql, [intakeservicerequestevaluationid]);
      if (data.length > 0) {
        for (const element of data) {
          var personfields = element;
          var html = fs.readFileSync('./documenttemplates/Intake_Decision_Sheet.html', 'utf8');
          html = html.replace(stylepath, config.documenttemplates);
          html = html.replace(imagepath, config.documenttemplates);
          if (personfields.personrole.toLowerCase() == 'youth') {
           html = getbyPersonrole(personfields, html);
          } else if (personfields.relationshiptorakey.toLowerCase() == 'mother') {
            html = getRelationtoMother(personfields, html);
          } else if (personfields.relationshiptorakey.toLowerCase() == 'father') {
            html = getRelationtoFather(personfields, html);
          }
          //other details
          html = html.replace(/{{livingwithother}}/g, util.nullcheck(personfields.personfullname));
          html = html.replace(/{{relationship}}/g, util.nullcheck(personfields.personfullname));
          html = html.replace(/{{otherguardian}}/g, util.nullcheck(personfields.personfullname));
          //case manager details
          html = html.replace(/{{casemanagername}}/g, util.nullcheck(personfields.personfullname));
          html = html.replace(/{{casemanagerphonenumber}}/g, util.nullcheck(personfields.personfullname));
          html = html.replace(/{{casemanageroffice}}/g, util.nullcheck(personfields.personfullname));
          //data of interview
          html = html.replace(/{{dateofinterview}}/g, util.nullcheck(personfields.personfullname));
          //to generate pdf file
          //module.exports.generatepdf(request,html);
        }
      }

      return module.exports.generatepdf(request, html);
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
};

function getbyPersonrole(personfields, html){
    var securityuserid = app.currentUser.userprofile.fullname;
    var role = app.currentUser.roletypekey;
   html = html.replace(/{{youthname}}/g, util.nullcheck(personfields.personfullname));
   html = html.replace(officernamefield, util.nullcheck(securityuserid));
   html = html.replace('{{role}}', util.nullcheck(role));
   html = html.replace(/{{folderid}}/g, util.nullcheck(personfields.personfullname));
   html = html.replace(/{{race}}/g, util.nullcheck(personfields.race));

   if (personfields.personschool != null) {
     if (personfields.personschool.length > 0) {
       for (const element of personfields.personschool) {
         var crntschool = element;
         html = html.replace(/{{school}}/g, util.nullcheck(crntschool.schooleducationname));
       }
     }
   }
   if (personfields.crntpersonaddress != null) {
     if (personfields.crntpersonaddress.length > 0) {
       for (const element of personfields.crntpersonaddress) {
         var crntaddress = element;
         html = html.replace(/{{phonenumber}}/g, util.nullcheck(crntaddress.phoneno));
         html = html.replace(/{{address}}/g, util.nullcheck(crntaddress.address1) + "<br/>" + util.nullcheck(crntaddress.address2) +
           util.nullcheck(crntaddress.city) + "<br/>" + util.nullcheck(crntaddress.state) + "<br/>" +
           util.nullcheck(crntaddress.county) + "<br/>" + util.nullcheck(crntaddress.zipcode));
       }
     }
   } else {
     html = html.replace(/{{phonenumber}}/g, '');
     html = html.replace(/{{address}}/g, '')
   }

   html = html.replace(/{{youthid}}/g, util.nullcheck(personfields.personid.substr(personfields.personid.length - 10)).toUpperCase());
   html = html.replace(/{{dob}}/g, util.nullcheck(personfields.dob));

   html = html.replace(/{{grade}}/g, util.nullcheck(personfields.personfullname));
   return html;
}

function getRelationtoMother(personfields, html) {
  //mother's details
  html = html.replace(/{{mothername}}/g, util.nullcheck(personfields.personfullname));
  html = html.replace(/{{motherrace}}/g, util.nullcheck(personfields.race));
  html = html.replace(/{{motherguardian}}/g, util.nullcheck(personfields.personfullname));
  html = html.replace(/{{motherlivewith}}/g, util.nullcheck(personfields.personfullname));
  if (personfields.crntpersonaddress != null) {
    if (personfields.crntpersonaddress.length > 0) {
      for (const element of personfields.crntpersonaddress) {
        var crntaddress = element;
        html = html.replace(/{{motherphonenumber}}/g, util.nullcheck(crntaddress.phoneno));
        html = html.replace(/{{motheraddress}}/g, util.nullcheck(crntaddress.address1) + "<br/>" + util.nullcheck(crntaddress.address2) +
          util.nullcheck(crntaddress.city) + "<br/>" + util.nullcheck(crntaddress.state) + "<br/>" +
          util.nullcheck(crntaddress.county) + "<br/>" + util.nullcheck(crntaddress.zipcode));
      }
    } else {
      html = html.replace(/{{motherphonenumber}}/g, '');
      html = html.replace(/{{motheraddress}}/g, '')
    }
  } else {
    html = html.replace(/{{motherphonenumber}}/g, '');
    html = html.replace(/{{motheraddress}}/g, '')
  }
  return html;
}

function getRelationtoFather(personfields, html){
  //father's details
  html = html.replace(/{{fathername}}/g, util.nullcheck(personfields.personfullname));
  html = html.replace(/{{fatherrace}}/g, util.nullcheck(personfields.race));
  html = html.replace(/{{fatherguardian}}/g, util.nullcheck(personfields.personfullname));
  html = html.replace(/{{fatherlivewith}}/g, util.nullcheck(personfields.personfullname));
  if (personfields.crntpersonaddress != null) {
    if (personfields.crntpersonaddress.length > 0) {
      for (const element of personfields.crntpersonaddress) {
        var crntaddress = element;
        html = html.replace(/{{fatherphonenumber}}/g, util.nullcheck(crntaddress.phoneno));
        html = html.replace(/{{fatheraddress}}/g, util.nullcheck(crntaddress.address1) + "<br/>" + util.nullcheck(crntaddress.address2) +
          util.nullcheck(crntaddress.city) + "<br/>" + util.nullcheck(crntaddress.state) + "<br/>" +
          util.nullcheck(crntaddress.county) + "<br/>" + util.nullcheck(crntaddress.zipcode));
      }
    } else {
      html = html.replace(/{{fatherphonenumber}}/g, '');
      html = html.replace(/{{fatheraddress}}/g, '')
    }
  } else {
    html = html.replace(/{{fatherphonenumber}}/g, '');
    html = html.replace(/{{fatheraddress}}/g, '')
  }
  return html;
}

module.exports.YouthFact = async function (request) {
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid;

  const sql = persondetailsbyintakenosql;

  try {
    const data = await util.executeDBQuery(sql, [intakeservicerequestevaluationid]);
      if (data.length > 0) {
        var securityuserid = app.currentUser.userprofile.fullname;
        var role = app.currentUser.roletypekey;
        for (const element of data) {
          var personfields = element;
          if (personfields.personrole.toLowerCase() == 'youth') {
            var html = fs.readFileSync('./documenttemplates/Residential-services-youth-face-sheet.html', 'utf8');
            html = html.replace(stylepath, config.documenttemplates);
            html = html.replace(imagepath, config.documenttemplates);

            html = html.replace(/{{youthname}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(officernamefield, util.nullcheck(securityuserid));
            html = html.replace('{{role}}', util.nullcheck(role));
            html = html.replace(/{{race}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{youthid}}/g, util.nullcheck(personfields.personid.substr(personfields.personid.length - 10)).toUpperCase());
            //Juvenile’s physical description
            html = html.replace(/{{height}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{hair}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{weight}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{eyes}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{identifyingmarks}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{dob}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{age}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{sex}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{placeofbirth}}/g, util.nullcheck(personfields.personfullname));
            //youth details
            html = html.replace(/{{address}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{county}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{homephonenumber}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{workphonenumber}}/g, util.nullcheck(personfields.personfullname));
            //father details
            html = html.replace(/{{fathername}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{fatheraddress}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{fathercounty}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{fatherhomephonenumber}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{fatherworkphonenumber}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{fatherguardian}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{fatherliveswith}}/g, util.nullcheck(personfields.personfullname));
            //mother's details
            html = html.replace(/{{mothername}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{motheraddress}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{mothercounty}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{motherhomephonenumber}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{motherworkphonenumber}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{motherguardian}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{motherliveswith}}/g, util.nullcheck(personfields.personfullname));
            //other details
            html = html.replace(/{{livingwithother}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{otherhomephonenumber}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{otherguardian}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{relationship}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{otherworkphonenumber}}/g, util.nullcheck(personfields.personfullname));
            //special concerns
            html = html.replace(/{{specialconcerns}}/g, util.nullcheck(personfields.personfullname));
            //typedetails table
            html = html.replace(/{{typedetails}}/g, util.nullcheck(personfields.personfullname));
            //education details
            html = html.replace(/{{lastschoolattended}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{dateoflastschoolattended}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{educationenddate}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{currentgrade}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{countoflastschoolattended}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{educationstartdate}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{specialeducation}}/g, util.nullcheck(personfields.personfullname));
            //admission information
            html = html.replace(/{{nameofintakeofficer}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{dateofcourtorder}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{courtdate}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{jurisdication}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{durationofcourtorder}}/g, util.nullcheck(personfields.personfullname));
            //status details
            html = html.replace(/{{admissiontype}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{casemanager}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{legalincidents}}/g, util.nullcheck(personfields.personfullname));
            //options details
            html = html.replace(/{{casemanagerphonenumber}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{medicalinformation}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{medicalcondition}}/g, util.nullcheck(personfields.personfullname));
            //conditions table 
            html = html.replace(/{{conditiontable}}/g, util.nullcheck(personfields.personfullname));
            //Insurance details
            html = html.replace(/{{insurancecompany}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{policynumber}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{expirationdate}}/g, util.nullcheck(personfields.personfullname));
            //current medication table
            html = html.replace(/{{currentmedicationtable}}/g, util.nullcheck(personfields.personfullname));
            //social and comments
            html = html.replace(/{{dateofsocialhistory}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{comments}}/g, util.nullcheck(personfields.personfullname));
            //interview and admission details
            html = html.replace(/{{interviewer}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{admissiondate}}/g, util.nullcheck(personfields.personfullname));
            html = html.replace(/{{admissiontime}}/g, util.nullcheck(personfields.personfullname));


          }

        }

      }
      return data;
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
};

//authInformation
module.exports.authInformation = function (request) {
  var documntkey = request.documntkey;
  LOGGER.debug(documntkey);
  var html = fs.readFileSync('./documenttemplates/authorizationinformation.html', 'utf8');
  html = html.replace(stylepath, config.documenttemplates);
  html = html.replace(imagepath, config.documenttemplates);
  return module.exports.generatepdf(request, html);
};

//eduservicerecord
module.exports.eduservicerecord = function (request) {
  var html = fs.readFileSync('./documenttemplates/educationservicesrecord.html', 'utf8');
  html = html.replace(stylepath, config.documenttemplates);
  html = html.replace(imagepath, config.documenttemplates);
  return html
};

// acknowledgement letter
module.exports.AckLetter = async function (request) {
  var intakenumber = request.where.intakenumber;


  let reportername = util.nullcheck(request.where.reportername);
  let reporteddate = util.nullcheck(request.where.reporterdate);
  let screenername = util.nullcheck(request.where.screenername);
  let supervisorname = util.nullcheck(request.where.supervisorname);
  let address = util.nullcheck(request.where.address);
  let phonenumber = util.nullcheck(request.where.phonenumber);


  const sql = 'select * from getackletterdetails($1)';
  let Response;
  try {
    const data = await util.executeDBQuery(sql, [intakenumber]);
      if (data.length > 0) {
        if (data[0].getackletterdetails) {
          const ackdetails = data[0].getackletterdetails[0];
          if (!request.where.isdraft) {
            reportername = util.nullcheck(ackdetails.reportername);
            reporteddate = util.nullcheck(ackdetails.reporteddate);
            screenername = util.nullcheck(ackdetails.screenername);
            supervisorname = util.nullcheck(ackdetails.supervisorname);
            address = util.nullcheck(ackdetails.address);
            phonenumber = util.nullcheck(ackdetails.addphonenumber);
          }
        }
      }
      var html = fs.readFileSync('./documenttemplates/acknowledgementletter.html', 'utf8');
      html = html.replace(logopath, app.baseurl);
      html = html.replace(/{{reporteddate}}/g, reporteddate);
      html = html.replace(/{{reportername}}/g, reportername);
      html = html.replace(/{{address}}/g, address);
      html = html.replace(/{{screenername}}/g, screenername);
      html = html.replace(/{{supervisorname}}/g, supervisorname);
      html = html.replace(/{{phonenumber}}/g, phonenumber);
      Response = module.exports.generatepdf(request, html);
      return Response;
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
};

module.exports.AppointLetter = function (request) {
  let reqjson = {};
  let prs = [];
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid;
  var securityuserid = app.currentUser.userprofile.fullname;
  
  var role = app.currentUser.roletypekey;
  const beforesubmit = request.where.beforesubmit;

  if (beforesubmit) {
    const requestJSON = request.where.json;
    requestJSON.root_template_path_style = app.baseurl;
    requestJSON.root_template_path_image = app.baseurl;
    requestJSON.crntdate = util.formatDate(new Date().toLocaleString());
    requestJSON.complaintdate = util.formatDate(requestJSON.complaintdate);

    reqjson = requestJSON;

    const html = fs.readFileSync(intakeappointpath, 'utf8');
    request.where.evaluationid = intakeservicerequestevaluationid;
    request.where.outputfilename = reqjson.complaintid;
    return module.exports.generatepdf(request, html, reqjson);
  } else {
    prs = request.where.intakeservicerequestevaluationid.map(evalutionid => {
      const sql = 'select * from pdfappointmentletter($1)';
      let Response;
      util.executeDBQuery(sql, [evalutionid])
      .then(data=>{
        if (data.length > 0) {
          let responseval = [];
          let resallegations1 = "";
          responseval = data[0];

          const html = fs.readFileSync(intakeappointpath, 'utf8');
          if (responseval.allegationname != null) {
            responseval.allegationname.forEach(allegation => {
              resallegations1 += '<tr>';
              resallegations1 += '<td>' + util.nullcheck(allegation) + '</td><td>' + util.nullcheck(responseval.offensedate) + '</td>'
              resallegations1 += '</tr>';
            })
          }

          reqjson = {
            root_template_path_style: app.baseurl,
            root_template_path_image: app.baseurl,
            crntdate: util.formatDate(new Date().toLocaleString()),
            complaintid: util.nullcheck(responseval.complaintid),
            complaintdate: util.nullcheck(util.formatDate(new Date(responseval.complaintdate))),
            youthname: util.nullcheck(responseval.youthname),
            youthid: util.nullcheck(responseval.cjamspid),
            "allegedoffense": resallegations1,
            "appointmentdate": util.nullcheck(util.formatDate(new Date(responseval.appointmentdate))),
            "appointmentaddress": util.nullcheck(responseval.appointmentaddress),
            "policename": util.nullcheck(responseval.policename),
            "guardianname": util.nullcheck(responseval.guardian_name),
            additionalcomments: "",
            officername: securityuserid,
            role: role
          };
          request.where.evaluationid = evalutionid;
          request.where.outputfilename = reqjson.complaintid+"_"+"appointmentletter";
          Response = module.exports.generatepdf(request, html, reqjson);
        }
        return Response;
      })
      .catch(err=>{
        LOGGER.error(err);
        return err;
      });
    })
    return Promise.all(prs)
  }
};

module.exports.CompNotif = function (request) {
  let reqjson = {};
  let prs = [];
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid;
  var securityuserid = app.currentUser.userprofile.fullname;
  var role = app.currentUser.roletypekey;
  const beforesubmit = request.where.beforesubmit;

  if (beforesubmit) {
    const requestJSON = request.where.json;
    requestJSON.root_template_path_style = app.baseurl;
    requestJSON.root_template_path_image = app.baseurl;
    requestJSON.crntdate = util.formatDate(new Date().toLocaleString());
    requestJSON.complaintdate = util.formatDate(requestJSON.complaintdate);

    reqjson = requestJSON;

    const html = fs.readFileSync(compliantnotifipath, 'utf8');
    request.where.evaluationid = intakeservicerequestevaluationid;
    request.where.outputfilename = reqjson.complaintid;
    return module.exports.generatepdf(request, html, reqjson);
  } else {
    prs = request.where.intakeservicerequestevaluationid.map(async evalutionid => {

      const sql = 'select * from complaintnotification($1)';
      let Response;
      try {
        const data = await util.executeDBQuery(sql, [evalutionid]);
          if (data.length > 0) {

            let responseval = [];
            let resallegations1 = "";
            responseval = data[0];
            const html = fs.readFileSync(compliantnotifipath, 'utf8');
            if (responseval.offensename != null) {
              responseval.offensename.forEach(allegation => {
                resallegations1 += `<tr>
                                    <td>${util.nullcheck(allegation)}</td><td>${util.nullcheck(responseval.offensedate)}</td>
                                    </tr>`;
              })
            }

            reqjson = {
              root_template_path_style: app.baseurl,
              root_template_path_image: app.baseurl,
              crntdate: util.formatDate(new Date().toLocaleString()),
              complaintid: util.nullcheck(responseval.complaint_id),
              complaintdate: util.nullcheck(util.formatDate(new Date(responseval.complaintdate))),
              allegedoffense: resallegations1,
              "policename": util.nullcheck(responseval.policename),
              "policenumber": policeno,
              "agency": util.nullcheck(responseval.agency),
              "policeaddress": util.nullcheck(responseval.policeaddress),
              "additionalcomments": util.nullcheck(responseval.reviewcomments),
              datewithaddition: util.nullcheck(util.formatDate(new Date(responseval.datewithaddition))),
              officername: securityuserid,
              role: role
            };
            request.where.evaluationid = evalutionid;
            request.where.outputfilename = reqjson.complaintid+"_"+"compliantnotification";
            Response = module.exports.generatepdf(request, html, reqjson);

          }
          return Response;
      } catch (err) {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      }

    })
    return Promise.all(prs)
  }
};

module.exports.VictimImpact = function (request) {
  let reqjson = {};
  let prs = [];
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid[0];
  var securityuserid = app.currentUser.userprofile.fullname;
  var role = app.currentUser.roletypekey;
  const beforesubmit = request.where.beforesubmit;

  if (beforesubmit) {
    const requestJSON = request.where.json;
    requestJSON.root_template_path_style = app.baseurl;
    requestJSON.root_template_path_image = app.baseurl;
    requestJSON.crntdate = util.formatDate(new Date().toLocaleString());
    requestJSON.complaintdate = util.formatDate(requestJSON.complaintdate);

    reqjson = requestJSON;

    const html = fs.readFileSync('./documenttemplates/victim-impact-state.html', 'utf8');
    request.where.evaluationid = intakeservicerequestevaluationid;
    request.where.outputfilename = reqjson.complaintid;
    return module.exports.generatepdf(request, html, reqjson);
  } else {
    prs = request.where.victim.map(async victimid => {

      const sql = 'select * from pdfvictimimpact($1,$2)';
      let Response;
      try {
        const data = await util.executeDBQuery(sql, [intakeservicerequestevaluationid, victimid]);
          if (data.length > 0) {
            let responseval = [];
            let victimdetails = "";
            let victimdetail = "";
            var victimphone = "";
            var victimaddress = "";
            responseval = data[0];
            const html = fs.readFileSync('./documenttemplates/victim-impact-state.html', 'utf8');
            victimdetails = responseval.victim;
            if (victimdetails != null) {
              victimdetail = victimdetails[0];
            }

            victimphone = getVictimPhone(victimdetail);
            LOGGER.debug("victimdetail address - " + victimdetail.address);
            victimaddress = getVictimAddress(victimdetail);

            reqjson = {
              root_template_path_style: app.baseurl,
              root_template_path_image: app.baseurl,
              crntdate: util.formatDate(new Date().toLocaleString()),
              "complaintid": util.nullcheck(responseval.complaintid),
              "complaintdate": util.nullcheck(util.formatDate(new Date(responseval.complaintdate))),
              "youthname": util.nullcheck(responseval.youthname),
              "youthid": util.nullcheck(responseval.cjamspid),
              "victimname": util.nullcheck(victimdetail.victimname),
              "victimaddress": util.nullcheck(victimaddress),
              "victimphno": victimphone,
              "officername": securityuserid,
              "role": role
            };
            request.where.evaluationid = intakeservicerequestevaluationid;
            request.where.outputfilename = reqjson.complaintid+"_"+"victimimpactstatement";
            Response = module.exports.generatepdf(request, html, reqjson);
          }

          return Response;
      } catch (err) {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      }

    })
    return Promise.all(prs)
    // .then(result => {
    //     return result;
    // })
  }
};

function getVictimPhone(victimdetail) {
  var victimphone = "";
  if (victimdetail.phone != null) {
    for (var i in victimdetail.phone) {
      if (victimdetail.phone[i].personphonetypekey === 'P') {
        victimphone = victimdetail.phone[i].phonenumber;
        break;
      } else {
        victimphone = victimdetail.phone[i].phonenumber;
      }
    }
  }
  return victimphone;
}

function getVictimAddress(victimdetail){
  var victimaddress = "";
  if (victimdetail.address != null) {
    for (var i in victimdetail.address) {
        victimaddress = victimdetail.address[i].address + '<br>'
        if (victimdetail.address[i].address2) {
          victimaddress += victimdetail.address[i].address2 + '<br>'
        }
        victimaddress += victimdetail.address[i].city + " " + victimdetail.address[i].state +
          '<br>' + victimdetail.address[i].country + ' ' + victimdetail.address[i].zipcode;
        break;
    }
  }
  return victimaddress;
}

module.exports.IntakeDS = function (request) {
  let reqjson = {};
  let prs = [];
  var intakenumber = request.where.intakenumber;
  var securityuserid = app.currentUser.userprofile.fullname;
  var role = app.currentUser.roletypekey;

  prs = request.where.intakeservicerequestevaluationid.map(evaluationid => {

    const sql = 'select * from intakeds($1)';
    let Response;
    return util.executeDBQuery(sql, [evaluationid])
    .then(data=>{
      if (data.length > 0) {
        let responseval = [];
        let resallegations = "";
        responseval = data[0];
        var html = fs.readFileSync('./documenttemplates/Intake_Decision_Sheet.html', 'utf8');
        if (responseval.offensename != null) {
          responseval.offensename.forEach(allegation => {
            resallegations += '<tr>';
            resallegations += '<td>' + util.nullcheck(allegation) + '</td><td>' +
              util.nullcheck(responseval.offencedate) + '</td><td>' +
              util.nullcheck(responseval.victim_name) + '</td><td>' +
              util.nullcheck(responseval.victim_address) + '</td><td>' +
              util.nullcheck(responseval.victim_phonecharacter) + '</td>';
            resallegations += '</tr>';
          })
        }
        const checked = 'fa-check-square-o';
        const unchecked = 'fa-square-o';
        if (responseval.appstatus === 'Held') {
          html = html.replace('{{appstatusheld}}', checked);
          html = html.replace('{{appstatusnotheld}}', unchecked);
        } else {
          html = html.replace('{{appstatusheld}}', unchecked);
          html = html.replace('{{appstatusnotheld}}', checked);
        }

        if (responseval.history === 'History Present') {
          html = html.replace('{{history}}', checked);
        } else {
          html = html.replace('{{history}}', unchecked);
        }

        reqjson = {
          root_template_path_style: app.baseurl,
          root_template_path_image: app.baseurl,
          "crntdate": util.formatDate(new Date().toLocaleString()),
          "youthname": util.nullcheck(responseval.youthname),
          "youthid": util.nullcheck(responseval.youthid),
          "youthaddress": util.nullcheck(responseval.address),
          "folderid": util.nullcheck(responseval.folderid),
          "dob": util.nullcheck(responseval.dob),
          "race": util.nullcheck(responseval.race),
          "gender": util.nullcheck(responseval.gender),
          "phone": util.nullcheck(responseval.phone),
          "school": util.nullcheck(responseval.school),
          "grade": util.nullcheck(responseval.grade),

          "mothername": util.nullcheck(responseval.mname),
          "motherphonenumber": util.nullcheck(responseval.mphone),
          "motheraddress": util.nullcheck(responseval.maddress),
          "mguardian": checkCondition(responseval.mguardian),
          "mlivewith": checkCondition(responseval.mlivewith),
          "fathername": util.nullcheck(responseval.fname),
          "fatherphonenumber": util.nullcheck(responseval.fphone),
          "fatheraddress": util.nullcheck(responseval.faddress),
          "fguardian": checkCondition(responseval.fgaurdian),
          "flivewith": checkCondition(responseval.flivewith),
          "guardianname": util.nullcheck(responseval.oname),
          "guardianrlation": util.nullcheck(responseval.orelation),
          "oguardian": checkCondition(responseval.oguardian),

          "complaintid": util.nullcheck(responseval.complaint_id),
          "complaintdate": util.nullcheck(responseval.complaintdate),
          "allegedoffense": resallegations,
          "complaintsource": util.nullcheck(responseval.complaintsource),
          "complainantname": util.nullcheck(responseval.complaintsname),
          "complainantaddress": util.nullcheck(responseval.complaintaddress),
          "decision": util.nullcheck(responseval.decision),
          "appointmentstatus": util.nullcheck(responseval.appstatus),
          "appointmentdate": util.nullcheck(responseval.appdate),
          "appointmentnotes": util.nullcheck(responseval.appnotes),

          "cwname": util.nullcheck(responseval.cw_name),
          "cwphone": util.nullcheck(responseval.cw_phone),
          "cwaddress": util.nullcheck(responseval.cw_address),
          "iwname": util.nullcheck(responseval.iw_name),
          "supname": util.nullcheck(responseval.sup_name),
          "officername": securityuserid,
          "role": role

        };
        request.where.evaluationid = intakenumber;
        request.where.outputfilename = intakenumber+"_"+"intakedecision";
        Response = module.exports.generatepdf(request, html, reqjson);

      }
      return Response;
    })
    .catch(err=>{
      LOGGER.error(err);
      return err;
    })

  })
  return Promise.all(prs)

};

function checkCondition(data){
  return util.nullcheck(data) ? 'Yes' : 'No'
}

module.exports.ConsentInformalAdjustmentSupervision = function (request) {
  let reqjson = {};
  let prs = [];
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid[0];
  var securityuserid = app.currentUser.userprofile.fullname;
  var role = app.currentUser.roletypekey;

  prs = request.where.victim.map(async victimid => {

    const sql = 'select * from informaladjustmentsupervision($1,$2)';
    let Response;
    try {
      const data = await util.executeDBQuery(sql, [intakeservicerequestevaluationid, victimid]);
        if (data.length > 0) {
          let responseval = [];
          let resallegations2 = "";
          responseval = data[0];
          var html = fs.readFileSync('./documenttemplates/cstinformaladjsupervision.html', 'utf8');
          if (responseval.offensename != null) {
            responseval.offensename.forEach(allegation => {
              resallegations2 += '<tr>';
              resallegations2 += '<td>' + util.nullcheck(allegation) + '</td><td>' + util.nullcheck(responseval.offensedate) + '</td>'
              resallegations2 += '</tr>';
            })
          }

          reqjson = {
            root_template_path_style: app.baseurl,
            root_template_path_image: app.baseurl,
            "crntdate": util.formatDate(new Date().toLocaleString()),
            "complaintid": util.nullcheck(responseval.complaintid),
            "complaintdate": util.nullcheck(util.formatDate(new Date(responseval.complaintdate))),
            "youthname": util.nullcheck(responseval.youthname),
            "youthid": util.nullcheck(responseval.youthid),
            "victimname": util.nullcheck(responseval.victimname),
            "allegedoffense": resallegations2,
            "officername": securityuserid,
            "role": role
          };
          request.where.evaluationid = intakeservicerequestevaluationid;
          request.where.outputfilename = reqjson.complaintid+"_"+"consentinformaladjustmentsupervision";
          Response = module.exports.generatepdf(request, html, reqjson);
        }

        return Response;
      } catch (err) {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      }
  })
  return Promise.all(prs)
};


module.exports.ConsentInformalAdjustment = function (request) {
  let reqjson = {};
  let prs = [];
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid[0];
  var securityuserid = app.currentUser.userprofile.fullname;
  var role = app.currentUser.roletypekey;

  prs = request.where.intakeservicerequestevaluationid.map(async evaluationid => {

    const sql = 'select * from informaladjustmentpdf($1)';
    let Response;
    try {
      const data = await util.executeDBQuery(sql, [evaluationid]);
        if (data.length > 0) {
          let responseval = [];
          let resallegations2 = "";
          responseval = data[0];
          var html = fs.readFileSync('./documenttemplates/cstinformaladjustment.html', 'utf8');
          if (responseval.offensename != null) {
            responseval.offensename.forEach(allegation => {
              resallegations2 += `<tr>
                                  <td>${util.nullcheck(allegation)}</td><td>${util.nullcheck(responseval.offensedate)}</td>
                                  </tr>`;
            })
          }

          reqjson = {
            root_template_path_style: app.baseurl,
            root_template_path_image: app.baseurl,
            "crntdate": util.formatDate(new Date().toLocaleString()),
            "complaintid": util.nullcheck(responseval.complaintid),
            "complaintdate": util.nullcheck(util.formatDate(new Date(responseval.complaintdate))),
            "youthname": util.nullcheck(responseval.youthname),
            "youthid": util.nullcheck(responseval.youthid),
            "allegedoffense": resallegations2,
            "officername": securityuserid,
            "role": role
          };
          request.where.evaluationid = intakeservicerequestevaluationid;
          request.where.outputfilename = reqjson.complaintid+"_"+"consentinformaladjustmentsupervision";
          Response = module.exports.generatepdf(request, html, reqjson);
        }

        return Response;
      } catch (err) {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      }
  })
  return Promise.all(prs)
};

module.exports.CourtMemorandum = function (request) {
  let reqjson = {};
  let prs = [];
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid[0];
  var securityuserid = app.currentUser.userprofile.securityusersid;
  var role = app.currentUser.roletypekey;

  prs = request.where.petition.map(async petitionid => {
    const sql = 'select * from courtmemorandum($1,$2)';
    let Response;
    try {
      const data = await util.executeDBQuery(sql, [petitionid, securityuserid]);
        if (data.length > 0) {
          let responseval = [];
          let hearingdate = '';
          responseval = data[0];
          var html = fs.readFileSync('./documenttemplates/courtmemorandum.html', 'utf8');
          if (responseval.courtorderdate != null) {
            hearingdate = util.formatDateAndTime(responseval.courtorderdate);
          }
          reqjson = {
            root_template_path_style: app.baseurl,
            root_template_path_image: app.baseurl,
            "crntdate": util.formatDate(new Date().toLocaleString()),
            "youthname": util.nullcheck(responseval.youthname),
            "youthid": util.nullcheck(responseval.youthid),
            "dob": util.nullcheck(responseval.dob),
            "petitionid": util.nullcheck(responseval.petition_id),
            "court": util.nullcheck(responseval.court),
            "courtdate": hearingdate,
            "officername": util.nullcheck(responseval.officername),
            "role": role
          };
          request.where.evaluationid = intakeservicerequestevaluationid;
          request.where.outputfilename = reqjson.complaintid+"_"+"courtmemorandum";
          Response = module.exports.generatepdf(request, html, reqjson);
        }

        return Response;
      } catch (err) {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      }
  })
  return Promise.all(prs)
};

module.exports.IntakeRecordReview = function (request) {
  let reqjson = {};
  let prs = [];
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid[0];
  var intakenumber = request.where.intakenumber;

  prs = request.where.intakeservicerequestevaluationid.map(async evaluationid => {
    const sql = 'select * from intakerecordreview($1)';
    let Response;
    try {
      const data = await util.executeDBQuery(sql, [intakenumber]);
        if (data.length > 0) {
          let responseval = [];
          responseval = data[0];
          var html = fs.readFileSync('./documenttemplates/intakerecordreview.html', 'utf8');

          reqjson = {
            root_template_path_style: app.baseurl,
            root_template_path_image: app.baseurl,
            "crntdate": util.formatDate(new Date().toLocaleString()),
            "youthname": util.nullcheck(responseval.youthname),
            "youthid": util.nullcheck(responseval.youthid),
            "dob": util.nullcheck(responseval.dob),
            "folderid": util.nullcheck(responseval.foldertypekey)
          };
          request.where.evaluationid = intakeservicerequestevaluationid;
          request.where.outputfilename = reqjson.complaintid+"_"+"intakerecordreview";
          Response = module.exports.generatepdf(request, html, reqjson);
        }

        return Response;
      } catch (err) {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      }
  })
  return Promise.all(prs)
};

module.exports.OffenseHistory = function (request) {
  let reqjson = {};
  let prs = [];
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid[0];
  
  var role = app.currentUser.roletypekey;

  prs = request.where.intakeservicerequestevaluationid.map(evaluationid => {
    const sql = 'select * from offencehistory($1)';
    let Response;
    return util.executeDBQuery(sql, [evaluationid])
    .then(data => {
    if (data.length > 0) {
          let responseval = [];
          responseval = data[0];
          var html = fs.readFileSync('./documenttemplates/offensehistory.html', 'utf8');
          var offenseData = getOffencedata(responseval);

          const placementdetails = offenseData.placementdetails;
          const appealdetails = offenseData.appealdetails;
          const complaintdetails = offenseData.complaintdetails;
          const petitiondetails = offenseData.petitiondetails;



          const courthearings = responseval.court_details;
          let courthearingdetails = '';
          for (let i in courthearings) {
            if (courthearings[i].petition_d != null) {
              courthearingdetails += '<tr>';
              courthearingdetails += '<td>' + courthearings[i].petition_id + '</td><td>' + courthearings[i].court_date + '</td><td>' +
                courthearings[i].court_action + '</td><td>' + courthearings[i].dispositions + '</td><td>' + courthearings[i].legal_council + '</td><td>' +
                courthearings[i].judge + '</td><td>' + courthearings[i].termination_date + '</td><td>' + courthearings[i].conditions + '</td>'
              courthearingdetails += '</tr>';
            }
          }

          const offenses = responseval.offense_details;
          let offensedetails = '';
          for (let i in offenses) {
            offensedetails += '<tr>';
            offensedetails += '<td>' + offenses[i].complaint_id + '</td><td>' + offenses[i].petition_id + '</td><td>' +
              offenses[i].Offence_name + '</td><td>' + offenses[i].Offence_date + '</td><td>' + offenses[i].adjudicated_date + '</td><td>' +
              offenses[i].adjudicated_decision + '</td><td>' + offenses[i].adjudicated_offense + '</td><td>' +
              ' ' + '</td><td>' + offenses[i].victime_name + '</td><td>' +
              offenses[i].victim_adress + '</td><td>' + offenses[i].victim_phone + '</td>';
            offensedetails += '</tr>';
          }

          reqjson = {
            root_template_path_style: app.baseurl,
            root_template_path_image: app.baseurl,
            "crntdate": util.formatDate(new Date().toLocaleString()),
            "youthname": util.nullcheck(responseval.youthname),
            "youthid": util.nullcheck(responseval.youthid),
            "dob": util.nullcheck(responseval.birthdate),
            "folderid": util.nullcheck(responseval.folderid),
            "race": util.nullcheck(responseval.race),
            "gender": util.nullcheck(responseval.gender),
            "legalincidentdate": util.nullcheck(responseval.legal_incident_date),
            "placementdetails": placementdetails,
            "appealdetails": appealdetails,
            "complaintdetails": complaintdetails,
            "petitiondetails": petitiondetails,
            "courthearingdetails": courthearingdetails,
            "offensedetails": offensedetails,
            "officername": util.nullcheck(responseval.officername),
            "role": role
          };
          request.where.evaluationid = intakeservicerequestevaluationid;
          request.where.outputfilename = reqjson.complaintid+"_"+"offensehistory";
          Response = module.exports.generatepdf(request, html, reqjson);
        }

        return Response;
    })
    .catch(err => {
        LOGGER.error(err);
    })
  })
  return Promise.all(prs)
};

function getOffencedata(responseval){
  const placements = responseval.placement_details;
  let placementdetails = '';
  for (let i in placements) {
    placementdetails += '<tr>';
    placementdetails += '<td>' + placements[i].provider_name + '</td><td>' +
      placements[i].admission_type + '</td><td>' + placements[i].admission_classification + '</td><td>' +
      placements[i].status + '</td><td>' + placements[i].admission_date + '</td><td>' + placements[i].release_date + '</td><td></td>';
    LOGGER.debug('provider - ' + placements[i].provider_name);
  }

  const appealhistory = responseval.appeal_details;
  let appealdetails = '';
  for (let i in appealhistory) {
    LOGGER.debug("appeal date - " + appealhistory[i].appeal_date);
    appealdetails += '<tr>';
    appealdetails += '<td>' + appealhistory[i].appeal_date + '</td><td>' +
      appealhistory[i].appeal_status + '</td><td>' + appealhistory[i].appeal_comments + '</td>';
    appealdetails += '</tr>';
  }

  const complaints = responseval.complaint_details;
  let complaintdetails = '';
  for (let i in complaints) {
    complaintdetails += '<tr>';
    complaintdetails += '<td>' + complaints[i].complaint_id + '</td><td>' + complaints[i].complaint_date + '</td><td>' +
      complaints[i].arrest_date + '</td><td>' + complaints[i].county + '</td><td>' + complaints[i].zipcode + '</td><td>' +
      complaints[i].decision + '</td><td>' + complaints[i].complaintsource + '</td><td>' + complaints[i].complainantname + '</td><td>' +
      complaints[i].complainantaddress + '</td><td>' + complaints[i].complainatphone + '</td>';
    complaintdetails += '</tr>';
  }

  const petitions = responseval.petition_details;
  let petitiondetails = '';
  for (let i in petitions) {
    if (petitions[i].petition_id != null) {
      petitiondetails += '<tr>';
      petitiondetails += '<td>' + petitions[i].petition_id + '</td><td>' +
        petitions[i].complaint_id + '</td><td>' + petitions[i].petetion_date + '</td><td>' +
        petitions[i].petetion_type + '</td><td>' + petitions[i].petetion_notes + '</td>'
      petitiondetails += '</tr>';
    }
  }
  return {
    placementdetails: placementdetails, 
    appealdetails: appealdetails, 
    complaintdetails: complaintdetails, 
    petitiondetails: petitiondetails
  }
}
module.exports.courtqrtp = async function (request, response) {
  request.documntkey = request.where.documenttemplatekey;
  request.intakeserviceid = null; 
  request.pageNumberFooter = true
  var courtorderid = request.where.courtorderid;
  var objectid = request.where.objectid;
  var casenumber = request.where.casenumber;
  var html = fs.readFileSync('./documenttemplates/courtqrtp.html', 'utf8');
  let Response;
  let sql ='';
  if(request.where.objectkey === 'servicecase'){
    sql = 'select * from getservicecasecourtorder($1)';
  } else{
    sql = 'select * from getcourtorder($1)'
  }
  
  try {
    const data = await util.executeDBQuery(sql, [objectid]);
        if (data.length > 0) {

          const courtorder = data.filter(x => x.intakeservreqcourtorderid === courtorderid);
          const dobdate = dateCheck(courtorder[0]?.dob, dtformat);
          const courtorderdate = dateCheck(courtorder[0]?.courtorderdate, dtformat);
          const judgedate = dateCheck(courtorder[0]?.judgedate, dtformat);
          html = html.replace('{{county}}', util.nullcheck(courtorder[0]?.county));
          html = html.replace('{{clientname}}', util.nullcheck(courtorder[0]?.clientname));
          html = html.replace('{{casenumber}}', util.nullcheck(casenumber));
          html = html.replace('{{dob}}', dobdate);
          html = html.replace('{{countyname}}', util.nullcheck(courtorder[0]?.county));
          html = html.replace('{{courtorderdate}}',courtorderdate);
          html = html.replace('{{personsappeared}}', util.nullcheck(courtorder[0]?. personsappeared));
          html = html.replace('{{Child}}', checkboxCheck(util.nullcheck(courtorder[0]?. personsappeared?.indexOf("CH") > -1)));
          html = html.replace('{{ChildsAttorney}}', checkboxCheck(util.nullcheck(courtorder[0]?. personsappeared?.indexOf("CHATT") > -1)));
          html = html.replace('{{Caseworker}}', checkboxCheck(util.nullcheck(courtorder[0]?. personsappeared?.indexOf("CSW") > -1)));
          html = html.replace('{{DSSAttorney}}', checkboxCheck(util.nullcheck(courtorder[0]?. personsappeared?.indexOf("DSATT") > -1)));
          html = html.replace('{{Guardian}}', checkboxCheck(util.nullcheck(courtorder[0]?. personsappeared?.indexOf("GUA") > -1)));
          html = html.replace('{{Mother}}', checkboxCheck(util.nullcheck(courtorder[0]?. personsappeared?.indexOf("MOT") > -1)));
          html = html.replace('{{MothersAttorney}}', checkboxCheck(util.nullcheck(courtorder[0]?. personsappeared?.indexOf("MOTATT") > -1)));
          html = html.replace('{{Father}}', checkboxCheck(util.nullcheck(courtorder[0]?. personsappeared?.indexOf("FAT") > -1)));
          html = html.replace('{{FathersAttorney}}', checkboxCheck(util.nullcheck(courtorder[0]?. personsappeared?.indexOf("FATATT") > -1)));
          html = html.replace('{{CASA}}', checkboxCheck(util.nullcheck(courtorder[0]?. personsappeared?.indexOf("CASA") > -1)));
          html = html.replace('{{PreadoptiveParent}}', checkboxCheck(util.nullcheck(courtorder[0]?. personsappeared?.indexOf("PREAP") > -1)));
          html = html.replace('{{Fosterparents}}', checkboxCheck(util.nullcheck(courtorder[0]?. personsappeared?.indexOf("FOSP") > -1)));
          html = html.replace('{{Other}}', checkboxCheck(util.nullcheck(courtorder[0]?. personsappeared?.indexOf("OTH") > -1)));
          html = html.replace('{{otherpersonsappeared}}', util.nullcheck(courtorder[0]?.otherpersonsappeared) ? "Other Persons Appeared :" + courtorder[0]?.otherpersonsappeared : '');
          html = html.replace('{{courtreview}}', checkboxCheck(util.nullcheck(courtorder[0]?.courtreview)));
          html = html.replace('{{childsneed}}', checkboxCheck(util.nullcheck(courtorder[0]?.childsneed)));
          html = html.replace('{{childneedcantmet}}', checkboxCheck(util.nullcheck(courtorder[0]?.childneedcantmet)));
          html = html.replace('{{childpermanencyplan}}', checkboxCheck(util.nullcheck(courtorder[0]?.childpermanencyplan)));
          html = html.replace('{{childmosteffplan}}', checkboxCheck(util.nullcheck(courtorder[0]?.childmosteffplan)));
          html = html.replace('{{qrtpapproval}}', checkboxCheck(util.nullcheck(courtorder[0]?.qrtpapproval.indexOf("1") > -1)));
          html = html.replace('{{notqrtpapproval}}', checkboxCheck(util.nullcheck(courtorder[0]?.qrtpapproval.indexOf("2") > -1)));
          html = html.replace('{{qrtpapprovaldecision}}', util.nullcheck(courtorder[0]?.qrtpapprovaldecision));
          html = html.replace('{{judgedate}}',judgedate);
          html = html.replace('{{judgename}}', util.nullcheck(courtorder[0]?.judgename));
          html = html.replace('{{judgeid}}', util.nullcheck(courtorder[0]?.judgeid));
        }

        request.where.outputfilename = "courtqrtp";
        Response = module.exports.generatepdf(request, html, {}, { type: 'report', res: response });
      return Response;
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
}

function isChecked(cond){
  return cond ? 'checked' : '';
}

module.exports.qrtpdocument = function (request, response) {
  request.documntkey = request.where.documenttemplatekey; 
  request.intakeserviceid = null; 

  if ( request.where.item) {
    const responseval = request.where.item;
    let otherpersoninfo = '';
    let personinfo = '';
    for(const element of responseval.actordetails){
      personinfo += element.intakeservicerequestactor.person.firstname + ' ' +  element.intakeservicerequestactor.person.lastname+',';
    }
 
    if(responseval && responseval.clientActorsdetails && responseval.clientActorsdetails.length) {
      for(const element of responseval.clientActorsdetails){
        otherpersoninfo += element.intakeservicerequestactor.person.firstname + ' ' +  element.intakeservicerequestactor.person.lastname+',';
      }
      otherpersoninfo = otherpersoninfo.slice(0, -1); 
    }

const formattedpetitiondate = moment(util.nullcheck(util.formatDate(responseval.petitiondate))).format(dtformat);
var html = fs.readFileSync('./documenttemplates/qrtpdocument.html', 'utf8');  

 html = html.replace('{{petitionid}}', responseval.petitionid);
 html = html.replace('{{witness1}}', ((responseval.witness1).trim()));
 html = html.replace('{{associatedattorneys}}', responseval.associatedattorneys);
 html = html.replace('{{petitiontypekey}}', 'QRTP Placement');
 html = html.replace('{{personinfo}}' , personinfo);
 html = html.replace('{{otherpersoninfo}}' , (otherpersoninfo.trim()));
 html = html.replace('{{petitiondate}}',formattedpetitiondate);

request.where.outputfilename = "QRTP Motion Petition";
   Response = module.exports.generatepdf(request, html, {}, {type: 'report', res:response }); 
   return Response;
  }

};

module.exports.FelonyMemo = async function (request) {
  let reqjson = {};
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid[0];
  var intakenumber = request.where.intakenumber;
  var securityuserid = app.currentUser.userprofile.securityusersid;
  var role = app.currentUser.roletypekey;

  const sql = 'select * from felonymemo($1,$2)';
  let Response;
  try {
    const data = await util.executeDBQuery(sql, [intakenumber, securityuserid]);
      if (data.length > 0) {
        let responseval = [];
        responseval = data[0];
        var html = fs.readFileSync('./documenttemplates/felonymemo.html', 'utf8');

        reqjson = {
          root_template_path_style: app.baseurl,
          root_template_path_image: app.baseurl,
          "crntdate": util.formatDate(new Date().toLocaleString()),
          "youthname": util.nullcheck(responseval.youthname),
          "youthid": util.nullcheck(responseval.youthid),
          "attorney": util.nullcheck(responseval.attorney),
          "dob": util.nullcheck(responseval.dob),
          "allegedoffense": util.nullcheck(responseval.offensename),
          "casenumber": util.nullcheck(responseval.casenumber),
          "officername": util.nullcheck(responseval.officername),
          "role": role
        };
        request.where.evaluationid = intakeservicerequestevaluationid;
        request.where.outputfilename = reqjson.complaintid+"_"+"felonymemo";
        Response = module.exports.generatepdf(request, html, reqjson);
      }
      return Response;
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
};

module.exports.cdprelimconsent = function (request) {
  let reqjson = {};
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid[0];
  var securityuserid = app.currentUser.userprofile.fullname;
  const intakenumber = request.where.intakenumber;

  const sql = "select * from cdprelimconsentbs($1)";
  let Response;
  return util.executeDBQuery(sql, [intakenumber])
    .then(data => {
        LOGGER.info(data);
        if (data.length > 0) {
          let responseval = [];
          responseval = data[0];
          var html = fs.readFileSync('./documenttemplates/cdprelimconsent.html', 'utf8');

          const persons = JSON.parse(responseval.persons);
          const youth = persons.filter(x => x.Role === 'Youth');
          let guardian = '';
          for (var i in persons) {
            if (persons[i].RelationshiptoRA === 'mother') {
              guardian = persons[i].fullName;
            }
            if (persons[i].RelationshiptoRA === 'father') {
              guardian = persons[i].fullName;
            }
          }

          const youthid = 'cjamspid' in youth[0] ? youth[0].cjamspid : '';

          reqjson = {
            root_template_path_style: app.baseurl,
            root_template_path_image: app.baseurl,
            "youthname": util.nullcheck(youth[0].fullName),
            "youthid": youthid,
            "guardianname": guardian,
            "providername": util.nullcheck(responseval.provider_name),
            "officer": securityuserid
          };
          request.where.evaluationid = intakeservicerequestevaluationid;
          request.where.outputfilename = reqjson.complaintid+"_"+"CommunityDetectionPreConsent";
          Response = module.exports.generatepdf(request, html, reqjson);
        }
        return Response;
    })
    .catch(err => {
        LOGGER.error(err)
    })
  

};

module.exports.medicalconsentform = async function (request) {
  let reqjson = {};
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid[0];
  const intakenumber = request.where.intakenumber;

  const sql = "select * from medicalconsentformbs($1)";
  let Response;
  try {
      const data = await util.executeDBQuery(sql, [intakenumber]);
        if (data.length > 0) {
          let responseval = [];
          responseval = data[0];
          var html = fs.readFileSync('./documenttemplates/medicalconsentform.html', 'utf8');

          const persons = JSON.parse(responseval.persons);
          let guardian = '';
          for (var i in persons) {
            if (persons[i].RelationshiptoRA === 'mother') {
              guardian = persons[i];
            }
            if (persons[i].RelationshiptoRA === 'father') {
              guardian = persons[i];
            }
          }

          reqjson = {
            root_template_path_style: app.baseurl,
            root_template_path_image: app.baseurl,
            "crntdate": util.formatDate(new Date().toLocaleString()),
            "youthname": util.nullcheck(responseval.youthname),
            "youthid": util.nullcheck(responseval.youthid),
            "folderid": util.nullcheck(responseval.folderid),
            "dob": util.nullcheck(responseval.dob),
            "race": util.nullcheck(responseval.race),
            "physician_name": util.nullcheck(responseval.physician_name),
            "physician_phone": util.nullcheck(responseval.physician_phone),
            "physican_address": util.nullcheck(responseval.physican_address),
            "policy_holder_name": util.nullcheck(responseval.policy_holder_name),
            "policyname": util.nullcheck(responseval.policyname),
            "insurance_company": util.nullcheck(responseval.health_insurance_company),
            "policy_expiration_date": util.nullcheck(responseval.policy_expiration_date),
            "guardianname": util.nullcheck(guardian.fullName),
            "guardian_phone": util.nullcheck(guardian.phoneNumber[0]),
            "guardian_email": util.nullcheck(guardian.emailID[0])
          };
          request.where.evaluationid = intakeservicerequestevaluationid;
          request.where.outputfilename = reqjson.complaintid+"_"+"medicalconsentform";
          Response = module.exports.generatepdf(request, html, reqjson);
        }
        return Response;
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
};

module.exports.familyhistoryreport = function (request) {
  let reqjson = {};
  var healthhistory = '';
    
  return app.models.Personfamilyinfo.getpersonfamilyhistory(request).then((response) => {
    return new Promise((resolve, _reject) => {   
      if (response.data && response.data.length > 0) {
        healthhistory = response.data ? response.data : []; 
      var html = fs.readFileSync('./documenttemplates/person-health-familyhistoryreport.html', 'utf8');
        reqjson = {
          root_template_path_style: app.baseurl,
          root_template_path_image: app.baseurl,
          "healthhistory": util.nullcheck(healthhistory)
        };
         request.where.outputfilename = "Family History Summary";
         Response = module.exports.generatepdf(request, html, reqjson);
      }
      resolve(Response);
      return Response;
      })
    })
    .then(data => data)
    .catch(err => {
      LOGGER.error(err);
    });
};

module.exports.eliminationhistoryreport = function (request) {
  let reqjson = {};
  var healtheliminationhistory = '';
    
  return app.models.Personfamilyinfo.getpersonelimination(request).then((response) => {
    return new Promise((resolve, _reject) => {   
      if (response.data && response.data.length > 0) {
        healtheliminationhistory = response.data ? response.data : []; 
      var html = fs.readFileSync('./documenttemplates/person-health-Elimination.html', 'utf8');
        reqjson = {
          root_template_path_style: app.baseurl,
          root_template_path_image: app.baseurl,
          "healtheliminationhistory": util.nullcheck(healtheliminationhistory)
        };
         request.where.outputfilename = "Person Health Elimination";
         Response = module.exports.generatepdf(request, html, reqjson);
      }
      resolve(Response);
      return Response;
      })
    })
    .then(data => data)
    .catch(err => {
      LOGGER.error(err);
    });
};

module.exports.examinationhealth = async function (request) {

  request.method = 'get';
  const sql = "select * from getexaminationlistfilter($1, $2, $3)";
  let personHealthExamination = '';
  let examinationHealthHtml = '';
  try {
    const data = await util.executeDBQuery(sql, [request.where, request.page, 200]);
        return app.models.Tb_picklist_values.getpicklist({ where: { picklist_type_id: '319' } }).then((pickListResponse) => {
          return app.models.Tb_picklist_values.getpicklist({ where: { picklist_type_id: '323' } }).then((pickListResponse2) => {

          const pickList = JSON.parse(decodeURIComponent(atob(pickListResponse)));
          const reasonNotKeptPicklist = JSON.parse(decodeURIComponent(atob(pickListResponse2)));

          personHealthExamination = checkArrFmt(data);
          personHealthExamination = personHealthExamination.map(
            (examination) => {
              examination.covidtestdate = util.formatDate(examination?.covidtestdate, '/');
              examination.appointment[0].apptDate = util.formatDate(examination?.appointment[0].apptDate, '/');
              examination.appointment[0].nextApptDate = util.formatDate(examination?.appointment[0].nextApptDate, '/');
              examination.appointment[0].starttime = examination.appointment[0].starttime ? moment(examination.appointment[0].starttime, 'HH:mm').format('hh:mm A') : '';
              examination.appointment[0].endtime = examination.appointment[0].endtime ? moment(examination.appointment[0].endtime, 'HH:mm').format('hh:mm A') : '';
              examination = examinationAppointmentCheck(examination, pickList, reasonNotKeptPicklist);
              return examination;
            })
          examinationHealthHtml = fs.readFileSync('./documenttemplates/person-health-examination-health.html', 'utf8');
          return { personHealthExamination, examinationHealthHtml };

          });
        });
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
};

function examinationAppointmentCheck(examination, pickList, reasonNotKeptPicklist){
  if (examination.appointment[0].labtestkey) {
    let desc = '';
    examination.appointment[0].labtestkey.forEach( key => {
      let value = pickList.filter((e) => e.picklist_value_cd == key);
      desc = desc.length > 0 ? desc + ',' + (picklistKey(value)) : value[0].description_tx;
    });
    examination.appointment[0].labtestkey = desc;
  }

  //Reason not kept appointment == notkeptreason
  if (examination.appointment[0].notkeptreason) {
    let value = reasonNotKeptPicklist.filter((e) => e.picklist_value_cd == examination.appointment[0].notkeptreason);
    value = picklistKey(value);
    examination.appointment[0].notkeptreason = value;
  }

  if( examination.appointment[0].starttime && examination.appointment[0].endtime){
    const _startTime = moment(`${examination.appointment[0].apptDate} ${examination.appointment[0].starttime}`, "MM/DD/YYYY hh:mm A");
    const _endTime = moment(`${examination.appointment[0].apptDate} ${examination.appointment[0].endtime}`, "MM/DD/YYYY hh:mm A");

    const computedDuration =_endTime.diff(_startTime, "minutes");
    const hours = Math.floor(computedDuration/60);
    const minutes = computedDuration % 60;
    examination.appointment[0].durationhours = `${hours} Hours ${minutes} Minutes `;
  }
  return examination;
}

module.exports.birthNeonatalInformation = async function (request) {

  const sql = "select * from getbirthinfolistfilter($1, $2, $3)";
  let birthNeonatalInformation = '';
  let birthNeonatalInformationHtml = '';
  try {
      const data = await util.executeDBQuery(sql, [request.where,  request.page, request.limit]);
        birthNeonatalInformation = data ? data : [];
        birthNeonatalInformationHtml = fs.readFileSync('./documenttemplates/person-health-birth-neonatal-information.html', 'utf8');
      return { birthNeonatalInformationHtml, birthNeonatalInformation };
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
};

module.exports.reproductiveHealth = async function (request) {
  if (request.page !== 'undefined') {
      request.skip = (request.page - 1) * request.limit;
  }
  if(!request.skip){
      request.skip=1
  }
  if(!request.limit){
      request.limit=10
  }
  const sql = "select * from getpersonsexualinfofilter($1, $2, $3)";
  let personReproductiveHealth = '';
  let personReproductiveHealthHtml = '';
  try {
      const data = await util.executeDBQuery(sql, [request.where,  request.skip, request.limit]);
        personReproductiveHealth = data ? data : [];
        personReproductiveHealth = personReproductiveHealth?.map((reproductiveHealth) => {
          reproductiveHealth.pregnancyduedate = util.formatDate(reproductiveHealth.pregnancyduedate, '/');
          reproductiveHealth.std_treatment_startdate = util.formatDate(reproductiveHealth.std_treatment_startdate, '/');
          reproductiveHealth.birthcontroldate = util.formatDate(reproductiveHealth.birthcontroldate, '/');
          return reproductiveHealth;
        })
        personReproductiveHealthHtml = fs.readFileSync('./documenttemplates/person-health-reproductive-health.html', 'utf8');
      return { personReproductiveHealth, personReproductiveHealthHtml };
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
};


module.exports.personHospitalization = async function (request) {


  if (request.page !== 'undefined') {
    request.skip = (request.page - 1) * request.limit;
  }
  const sql = "select * from gethospitalizationlistfilter($1, $2, $3)";

  let personHospitalization = '';
  let personHospitalizationHtml = '';
  try {
    const data = await util.executeDBQuery(sql, [request.where, request.page, request.limit]);
        return app.models.Tb_picklist_values.getpicklist({ where: { picklist_type_id: '310' } }).then((pickListResponse) => {
          return app.models.Tb_picklist_values.getpicklist({ where: { picklist_type_id: '454' } }).then((pickListResponse1) => {
            return app.models.Tb_picklist_values.getpicklist({ where: { picklist_type_id: '453' } }).then((pickListResponse2) => {
              return app.models.Tb_picklist_values.getpicklist({ where: { picklist_type_id: '452' } }).then((pickListResponse3) => {
                return app.models.Tb_picklist_values.getpicklist({ where: { picklist_type_id: '450' } }).then((pickListResponse4) => {

                  let pickList = JSON.parse(decodeURIComponent(atob(pickListResponse)));
                  const pickList1 = JSON.parse(decodeURIComponent(atob(pickListResponse1)));
                  const pickList2 = JSON.parse(decodeURIComponent(atob(pickListResponse2)));
                  const pickList3 = JSON.parse(decodeURIComponent(atob(pickListResponse3)));
                  const pickList4 = JSON.parse(decodeURIComponent(atob(pickListResponse4)));
                  pickList = [...pickList, ...pickList1, ...pickList2, ...pickList3, ...pickList4];
                  personHospitalization = data ? data : [];
                  personHospitalization = getHospitalDetails(personHospitalization, pickList, pickList1, pickList2); 
                  personHospitalizationHtml = fs.readFileSync('./documenttemplates/person-health-hospitalization.html', 'utf8');
                  return { personHospitalization, personHospitalizationHtml };
                });
              });
            });
          });
        });
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
};

function getHospitalDetails(personHospitalization, pickList, pickList1, pickList2){
  return personHospitalization?.map((hospitalization) => {
    if (hospitalization.Hospital_examStartDate) {
      const dateString = hospitalization.Hospital_examStartDate;
      hospitalization.Hospital_examStartDate = util.formatDate(hospitalization.Hospital_examStartDate, '/');
      hospitalization.Hospital_examStartDate_starttime = moment(dateString).format("hh:mm A");                      
    }
    if (hospitalization.Hospital_InpatientAdmissionDate) {
      const dateString = hospitalization.Hospital_InpatientAdmissionDate;
      hospitalization.Hospital_InpatientAdmissionDate = util.formatDate(hospitalization.Hospital_InpatientAdmissionDate, '/');
      hospitalization.Hospital_InpatientAdmissionDate_starttime =  moment(dateString).format("hh:mm A");
    }
    if (hospitalization.Hospital_DischargedDate) {
      const dateString = hospitalization.Hospital_DischargedDate;
      hospitalization.Hospital_DischargedDate = util.formatDate(hospitalization.Hospital_DischargedDate, '/');
      hospitalization.Hospital_DischargedDate_starttime =  moment(dateString).format("hh:mm A");
    }
    if (hospitalization.hospitalization_reason) {
      let value = pickList.filter((e) => e.picklist_value_cd == hospitalization.hospitalization_reason);
      value = picklistKey(value);
      hospitalization.hospitalization_reason = value;
    }
    if (hospitalization.Hospital_DischargeRecommendation) {
      let value = pickList2.filter((e) => e.picklist_value_cd == hospitalization.Hospital_DischargeRecommendation);
      value = picklistKey(value);
      hospitalization.Hospital_DischargeRecommendation = value;
    }
    //Hospital_GroupHome field
    if (hospitalization.Hospital_GroupHome) {
      let value = pickList1.filter((e) => e.picklist_value_cd == hospitalization.Hospital_GroupHome);
      value = picklistKey(value);
      hospitalization.Hospital_GroupHome = value;
    }
    if (hospitalization.Actual_Placement_After_Discharge) {
      let value = pickList2.filter((e) => e.picklist_value_cd == hospitalization.Actual_Placement_After_Discharge);
      value = picklistKey(value);
      hospitalization.Actual_Placement_After_Discharge = value;
    }
    if (hospitalization.Hospital_ReasonForOvrStay) {
      let value = pickList.filter((e) => e.picklist_value_cd == hospitalization.Hospital_ReasonForOvrStay);
      value = picklistKey(value);
      hospitalization.Hospital_ReasonForOvrStay = value;
    }
    if (hospitalization.Hospital_OverstayDate) {
      hospitalization.Hospital_OverstayDate = util.formatDate(hospitalization.Hospital_OverstayDate, '/');
    }
    return hospitalization;
  });
}

function picklistKey(value){
  return value.length > 0 ? value[0].description_tx : '';
}

module.exports.immunizationData = async function (request) {

  const sql = "select * from getpersonimmunizationlistfilter($1, $2, $3)";

  let immunizationData = '';
  let immunizationDataHtml = '';
  try {
    const _data = await util.executeDBQuery(sql, [request.where, request.page, request.limit]);
        immunizationData = _data ? _data : [];
        immunizationData = immunizationData.map((data) => {
          const ageatvaccine = getAgeAtVaccine(data.immunizationdate,data.dob);
          data['ageatvaccine'] = ageatvaccine;
          data.source = immunizationSource(data);
          let recordstatus = '';
          if (data.recordstatus == 0) {
            recordstatus = 'DELETED';
          } else if (data.recordstatus == 1) {
            recordstatus = 'REJECTED'
          } else {
            recordstatus = 'ACTIVE'
          }
          data.recordstatus = recordstatus;
          data.immunizationdate = util.formatDate(data.immunizationdate,'/');
          data.updatedon = util.formatDate(data.updatedon,'/');
          return {
            title: `${data.vaccinename} (${data.description})`,
            data: [data],
          };
        })
        immunizationDataHtml = fs.readFileSync('./documenttemplates/person-health-immunization.html','utf8');
        return { immunizationDataHtml,immunizationData };
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
};

function immunizationSource(data) {
  let source = '';
  if (data.source) { 
    source = data.source 
  } else {
    if (data.sourcesystem) {
      if (data.insertedby === 'CRISP_INBOUND') {
        source = 'CRISP';
      } else if (data.insertedby != 'CRISP_INBOUND') {
        source = 'CJAMS / CRISP';
      }
    } else {
      source = 'CJAMS';
    }
  }
  return source;
}

module.exports.disabilitiesReport = function (request) {
  const sql = "select * from getpersondisabilityfilter($1,$2)";
  let disabilitiesData = '';
  let disabilitiesDataHtml = '';
  return util.executeDBQuery(sql,[request.where,null]).then((data) => {
    disabilitiesData = data ? data : [];
    if(disabilitiesData){
      disabilitiesData = disabilitiesData?.map((disability) => {
        disability.startdate = util.formatDate(disability.startdate,'/');
        disability.enddate = util.formatDate(disability.enddate,'/');
        disability.evaluationdate = util.formatDate(disability.evaluationdate,'/');
        return disability;
      })
    }
    disabilitiesData = {
      data: [...disabilitiesData]
    }
    disabilitiesData['hasDisability'] = true;
    const yesDisablities = disabilitiesData.data.filter(pd => pd.disabilityconditiontypekey === 'Yes');
    const noDisablities = disabilitiesData.data.filter(pd => pd.disabilityconditiontypekey === 'No');
    const unkDisablities = disabilitiesData.data.filter(pd => pd.disabilityconditiontypekey === 'Unknown');

    if (disabilitiesData.data.length === 0) {
      disabilitiesData.hasDisability = null;
    } else if (yesDisablities && yesDisablities.length > 0) {
      disabilitiesData.hasDisability = "true";
    } else if (noDisablities && noDisablities.length > 0) {
      disabilitiesData.hasDisability = "false";
    }
    else if (unkDisablities && unkDisablities.length > 0) {
      if (disabilitiesData.data[0].selectdisability) {
        disabilitiesData.hasDisability = disabilitiesData.data[0].selectdisability;
      }
    }
    disabilitiesDataHtml = fs.readFileSync('./documenttemplates/person-health-disabilitiesorspecialneeds-report.html','utf8');

    return { disabilitiesDataHtml,disabilitiesData };
  })
    .then(data => data)
    .catch((err) => {
      LOGGER.error(err);
      return err;
    });
};

module.exports.behavirolHealthData = function (request) {
  if (request.page !== 'undefined') {
    request.skip = (request.page - 1) * request.limit;
  }
  let limit = request.limit;
  if (!request.skip) {
    request.skip = 1
  }
  if (!limit) {
    limit = 10
  }
  const sql = "select * from getbehavioursubstancefilter($1, $2, $3)";

  let personBehavirolHealthData = '';
  let personBehavirolHealthDataHtml = '';

  return util.executeDBQuery(sql,[request.where,request.page,limit]).then((data) => {
    const persontypeservicekeySql = 'select * from personservicetype';
    return util.executeDBQuery(persontypeservicekeySql,[]).then((result) => {
      personBehavirolHealthData = checkArrFmt(data);
      personBehavirolHealthData = personBehavirolHealthData?.map((behavirolHealthData) => {
        behavirolHealthData.dateofevaluation = util.formatDate(behavirolHealthData.dateofevaluation);
        if (behavirolHealthData.typeofservice) {
          let desc = '';
          behavirolHealthData.typeofservice.forEach(key => {
            let value = result.filter((e) => e.personservicetypekey == key);
            desc = desc.length > 0 ? (desc + ',' + (value[0]?.description)) : value[0]?.description;
          });
          behavirolHealthData.typeofservice = desc;
        }
        return behavirolHealthData;
      })
      personBehavirolHealthDataHtml = fs.readFileSync('./documenttemplates/person-health-behavirol-health.html','utf8');

      resolve({ personBehavirolHealthDataHtml,personBehavirolHealthData });
      return { personBehavirolHealthDataHtml,personBehavirolHealthData };
    }).catch((err) => {
      LOGGER.error(err);
      return err;
    });
  })
    .then(data => data)
    .catch((err) => {
      LOGGER.error(err);
      return err;
    });
};

module.exports.form1080aDocument = function(request, response) {
  return app.models.Form1080a.getform1080adetails(request).then((data) => {
      if (data && Object.keys(data).length > 0) {
        
        data.dateofthiscfspicriticalincidentreport = dateCheck(data.dateofthiscfspicriticalincidentreport, dtformat);
        data.datewhentheincidentoccurred = dateCheck(data.datewhentheincidentoccurred, dtformat);
        data.dateldssbecameawareofincident = dateCheck(data.dateldssbecameawareofincident, dtformat);

        data.dob = dateCheck(data.dob, dtformat);
        data.dod = dateCheck(data.dod, dtformat);

        data.datecompleted = dateCheck(data.datecompleted, dtformat);
        data.dateldssheldtherapidresponsereview = dateCheck(data.dateldssheldtherapidresponsereview, dtformat);        
        
        const form1080aData = data;
        let html = fs.readFileSync('./documenttemplates/form1080a.html', 'utf8');
        const reqjson = {
          root_template_path_style: app.baseurl,
          root_template_path_image: app.baseurl,
          "data": util.nullcheck(form1080aData)
        };
        request.where.outputfilename = "Form1080a";
        return  module.exports.generatepdf(request, html, reqjson, {
          type: 'report',
          res: response
        });
       }
    })
    .catch(err => {
      LOGGER.error('Error in form1080aDocument:', err);
      return err;
    })
  };

module.exports.form1080bDocument = function (request, response) {
  try {
    const form1080bData = request.where.data; 

    if (!form1080bData) {
      throw new Error('Form1080B data not found');
    }

    const html = fs.readFileSync('./documenttemplates/form1080b.html', 'utf8');

    const reqjson = {
      root_template_path_style: app.baseurl,
      root_template_path_image: app.baseurl,
      data: util.nullcheck(form1080bData)
    };

    request.where.outputfilename = 'Form1080b';

    return module.exports.generatepdf(request, html, reqjson, {
      type: 'report',
      res: response
    });
  } catch (err) {
    LOGGER.error('Error in form1080bDocument:', err);
    throw err;
  }

};

module.exports.form1080cDocument = function (request, response, reqctx) {
  return app.models.Form1080c.getForm1080c(request, reqctx)
    .then(form1080cData => {

      if (!form1080cData) {
        throw new Error('Form1080c data not found');
      }

      form1080cData.datecompleted = dateCheck(form1080cData.datecompleted, dtformat);

      const html = fs.readFileSync('./documenttemplates/form1080c.html', 'utf8');
      const reqjson = {
        root_template_path_style: app.baseurl,
        root_template_path_image: app.baseurl,
        data: util.nullcheck(form1080cData)
      };
      request.where.outputfilename = 'Form1080c';

      return module.exports.generatepdf(request, html, reqjson, {
        type: 'report',
        res: response
      });
    })
    .catch(err => {
      LOGGER.error('Error in form1080cDocument:', err);
      return err;
    });
};


const getAgeAtVaccine = (immunizationdate, persondob) => {
  if (!immunizationdate || !persondob) {
    return 'N/A';
  }

  const dob = new Date(persondob);
  const vacDate = new Date(immunizationdate);

  let years = vacDate.getFullYear() - dob.getFullYear();
  let months = vacDate.getMonth() - dob.getMonth();

  if (months < 0) {
    years--;
    months += 12;
  }

  return `${years} Year(s) ${months} Month(s)`;
};

module.exports.sleepinghistoryreport = function (request) {
  let reqjson = {};
  var sleepingsummary = '';
    
  return app.models.Personfamilyinfo.getpersonsleeping(request).then((response) => {
    return new Promise((resolve, _reject) => {   
      if (response.data && response.data.length > 0) {
        sleepingsummary = response.data ? response.data : []; 
      var html = fs.readFileSync('./documenttemplates/person-health-sleepingsummary.html', 'utf8');

      sleepingsummary.forEach(item => {
        if (item.sleepingschedule_naptime) {
          item.sleepingschedule_naptime = util.formatTime(item.sleepingschedule_naptime, '/');
        }
        if (item.sleepingschedule_bedtime) {
          item.sleepingschedule_bedtime = util.formatTime(item.sleepingschedule_bedtime, '/');
        }
      });

      reqjson = {
        root_template_path_style: app.baseurl,
        root_template_path_image: app.baseurl,
        sleepingsummary: util.nullcheck(sleepingsummary)
      };

      request.where.outputfilename = "Person Sleeping Information";
      Response = module.exports.generatepdf(request, html, reqjson);

    } 
    resolve(Response);
    return Response;
    });
  })
  .then(data => data)  
  .catch(err => {
    return { error: err.message || 'An error occurred' };
  });
};

module.exports.Mobilityspeechreport = function (request) {
  let reqjson = {};
  var mobilityorspeechsummary = '';
    
  return app.models.Personfamilyinfo.getpersonmobility(request).then((response) => {
    return new Promise((resolve, _reject) => {   
      if (response.data && response.data.length > 0) {
        mobilityorspeechsummary = response.data ? response.data : []; 
      var html = fs.readFileSync('./documenttemplates/person-health-mobilityorspeechsummary.html', 'utf8');
      reqjson = {
        root_template_path_style: app.baseurl,
        root_template_path_image: app.baseurl,
        mobilityorspeechsummary: util.nullcheck(mobilityorspeechsummary)
      };

      request.where.outputfilename = "Mobility or Speech Summary";
      Response = module.exports.generatepdf(request, html, reqjson);

    } 
    resolve(Response);
    return Response;
    });
  })
  .then(data => data)  
  .catch(err => {
    LOGGER.error(err);
    return { error: err.message || 'An error occurred' };
  });
};

module.exports.providerinformationreport = function (request) {
  let reqjson = {};
  var providerinformationsummary = '';
    
  return app.models.Personphycisianinfo.getproviderinfo(request).then((response) => {
    return new Promise((resolve, _reject) => {   
      if (response.data && response.data.length > 0) {
        providerinformationsummary = response.data ? response.data : []; 
      var html = fs.readFileSync('./documenttemplates/person-health-providerinformationsummary.html', 'utf8');

      providerinformationsummary.forEach(item => {
        if (item.physician_phone) {
          item.physician_phone = util.formatPhoneNumber(item.physician_phone, '/');
        }
        item.startdate = util.formatDate(item.startdate, '/');
        item.enddate = util.formatDate(item.enddate, '/');
      });

      reqjson = {
        root_template_path_style: app.baseurl,
        root_template_path_image: app.baseurl,
        providerinformationsummary: util.nullcheck(providerinformationsummary)
      };

      request.where.outputfilename = "Provider Information Summary";
      Response = module.exports.generatepdf(request, html, reqjson);

    } 
    resolve(Response);
    return Response;
    });
  })
  .then(data => data)  
  .catch(err => {
    LOGGER.error(err);
    return { error: err.message || 'An error occurred' };
  });
};


module.exports.healthpassportinformationreport = function (request) {
  let reqjson = {};
  var healthpassportinfosummary = '';
    
  return app.models.Personhealthpassport.list(request).then((response) => {
    return new Promise((resolve, _reject) => {   
      if (response.data && response.data.length > 0) {
        healthpassportinfosummary = response.data ? response.data : []; 
        var html = fs.readFileSync('./documenttemplates/person-health-healthpassportinfosummary.html', 'utf8');

        healthpassportinfosummary.forEach(item => {
          if (item.effectivedate) {
            item.effectivedate = util.formatDate(item.effectivedate, '/');
          }
        });

        reqjson = {
          root_template_path_style: app.baseurl,
          root_template_path_image: app.baseurl,
          healthpassportinfosummary: util.nullcheck(healthpassportinfosummary)
        };

        request.where.outputfilename = "Health Passport Information Summary";
        Response = module.exports.generatepdf(request, html, reqjson);

      }
      resolve(Response);
      return Response;
    });
  })
  .then(data => data)  
  .catch(err => {
    LOGGER.error(err);
    return { error: err.message || 'An error occurred' };
  });
};

module.exports.feedinginformationreport = function (request) {
  let reqjson = {};
  var feedinginfosummary = '';
    
  return app.models.Personfamilyinfo.getpersonfeeding(request).then((response) => {
    return new Promise((resolve, _reject) => {   
      if (response.data && response.data.length > 0) {
        feedinginfosummary = response.data ? response.data : []; 
      var html = fs.readFileSync('./documenttemplates/person-health-feedinginfosummary.html', 'utf8');
      reqjson = {
        root_template_path_style: app.baseurl,
        root_template_path_image: app.baseurl,
        feedinginfosummary: util.nullcheck(feedinginfosummary)
      };

      request.where.outputfilename = "Feeding Information Summary";
      Response = module.exports.generatepdf(request, html, reqjson);

    } 
    resolve(Response);
    return Response;
    });
  })
  .then(data => data)  
  .catch(err => {
    LOGGER.error(err);
    return { error: err.message || 'An error occurred' };
  });
};


module.exports.insuranceinformationreport = function (request) {
  let reqjson = {};
  var insuranceinfosummary = '';
    
  return app.models.Personhealthinsurance.list(request).then((response) => {
    return new Promise((resolve, _reject) => {   
      if (response.data && response.data.length > 0) {
        insuranceinfosummary = response.data ? response.data : []; 
        var html = fs.readFileSync('./documenttemplates/person-health-insuranceinfosummary.html', 'utf8');
        
        insuranceinfosummary.forEach(item => {
          item.effectivedate = util.formatDate(item.effectivedate,'/');
          item.expirationdate = util.formatDate(item.expirationdate,'/');
          item.medicaidstartdate = util.formatDate(item.medicaidstartdate,'/');
          item.medicaidenddate = util.formatDate(item.medicaidenddate,'/');
          item.providerphone = util.formatPhoneNumber(item.providerphone,'/');
        });

        reqjson = {
          root_template_path_style: app.baseurl,
          root_template_path_image: app.baseurl,
          insuranceinfosummary: util.nullcheck(insuranceinfosummary)
        };

        request.where.outputfilename = "Insurance Information Summary";
        Response = module.exports.generatepdf(request, html, reqjson);
      }
      resolve(Response);
      return Response;
    });
  })
  .then(data => data)  
  .catch(err => {
    LOGGER.error(err);
    return { error: err.message || 'An error occurred' };
  });
};

module.exports.medicationincludingpsychotropicreport = function (request) {
  let reqjson = {};
  var medicationincludingpsychotropic = '';
  return app.models.Personmedicalcondition.medicationPsychotrophicpdf(request).then((response) => {
    return new Promise((resolve,_reject) => {
      if (response.data && response.data.length > 0) {
        medicationincludingpsychotropic = response.data ? response.data : [];
        var html = fs.readFileSync('./documenttemplates/person-health-medicationincludingpsychotropic.html','utf8');
        medicationincludingpsychotropic.forEach(item => {
          item.dateofrefill = util.formatDate(item.dateofrefill,'/');
          item.medicationeffectivedate = util.formatDate(item.medicationeffectivedate,'/');
          item.medicationexpirationdate = util.formatDate(item.medicationexpirationdate,'/');
          item.lastdosetakendate = util.formatDate(item.lastdosetakendate,'/');
          item.medicationexpirationdate = util.formatDate(item.datemedicationstarted,'/');
          item.datemedicationstarted = util.formatDate(item.datemedicationstarted,'/');
          if (item.compliant != '') {
            switch (item.compliant) {
              case 0: item.compliant = 'No';
                break;
              case 1: item.compliant = 'Yes';
                break;
              case 2: item.compliant = 'Unknown';
                break;
            }
          }
        });
        reqjson = {
          root_template_path_style: app.baseurl,
          root_template_path_image: app.baseurl,
          medicationincludingpsychotropic: util.nullcheck(medicationincludingpsychotropic)
        };

        request.where.outputfilename = "Medication Including Psychotropic Summary";
        Response = module.exports.generatepdf(request,html,reqjson);

      }
      resolve(Response);
      return Response;
    });
  })
    .then(data => data)
    .catch(err => {
      LOGGER.error(err);
      return { error: err.message || 'An error occurred' };
    });
};

module.exports.conditionsOrDisorders = function (request) {
  let reqjson = {};
  var conditionsorDisorderssummary = '';
    
  return app.models.Personmedicalcondition.list(request).then((response) => {
    return new Promise((resolve, _reject) => {   
      if (response.data && response.data.length > 0) {
        conditionsorDisorderssummary = response.data ? response.data : []; 
      var html = fs.readFileSync('./documenttemplates/person-health-conditionsorDisorderssummary.html', 'utf8');

      conditionsorDisorderssummary.forEach(item => {
        item.begindate = util.formatDate(item.begindate, '/');
        item.enddate = util.formatDate(item.enddate, '/');
        if (item.medicalcondition) {
          item.medicalcondition = item.medicalcondition.replace(/[\[\]"]/g, '');
        } 
        if (item.allergies_adverse_reactions) {
          item.allergies_adverse_reactions = item.allergies_adverse_reactions.replace(/[\[\]"]/g, '');
        }            
      });

      reqjson = {
        root_template_path_style: app.baseurl,
        root_template_path_image: app.baseurl,
        conditionsorDisorderssummary: util.nullcheck(conditionsorDisorderssummary)
      };

      request.where.outputfilename = "Conditions Or Disorders Summary";
      Response = module.exports.generatepdf(request, html, reqjson);

    } 
    resolve(Response);
    return Response;
    });
  })
  .then(data => data)  
  .catch(err => {
    LOGGER.error(err);
    return { error: err.message || 'An error occurred' };
  });
};

module.exports.combinedreport = function (request,data,response) {
  const {
    examinationHealth,
    birthNeonatalInformation,
    reproductiveHealth,
    personHospitalization,
    immunizationData,
    behavirolHealthData,
    disabilities,
  } = data;
  const startDate = util.formatDate(request.where.startDate,'/');
  const endDate = util.formatDate(request.where.endDate,'/');
  const personid = request.where.personid;
  let reqjson = {};
  let cjamspId = '';
  let firstName = '';
  let middleName = '';
  let lastName = '';
  let sleepinghistorysummary = '';
  let mobilityorspeechsummary = '';
  let providerinformationsummary = '';
  let healthpassportinfosummary = '';
  let feedinginfosummary = '';
  let insuranceinfosummary = '';
  let insuranceuploadinfo = '';
  let conditionsorDisorderssummary = '';
  let healtheliminationhistory = '';
  let healthhistory = '';
  let provideruploadinfo = '';
  let medicationincludingpsychotropic = '';
  let conditionsordisorderdocdata = '';
  let personHealthExaminationData = '';
  let familyHistoryDocData = '';
  let personBehavirolHealthInfo = '';
  let personHospitalizationInfo = '';

  return app.models.Person.findOne({
    where: { personid: personid },
    fields: ['cjamspid','firstname','middlename','lastname'],
  }).then((person) => {
    if (person) {
      cjamspId = person.cjamspid;
      firstName = emptyStrCheck(person.firstname);
      middleName = emptyStrCheck(person.middlename);
      lastName = emptyStrCheck(person.lastname);
    }

    return Promise.all([
      app.models.Personfamilyinfo.getpersonsleeping(request),
      app.models.Personfamilyinfo.getpersonmobility(request),
      app.models.Personphycisianinfo.getproviderinfo(request),
      app.models.Personhealthpassport.list(request),
      app.models.Personfamilyinfo.getpersonfeeding(request),
      app.models.Personhealthinsurance.list(request),
      app.models.Personmedicalcondition.list(request),
      app.models.Personfamilyinfo.getpersonelimination(request),
      app.models.Personfamilyinfo.getpersonfamilyhistory(request),
      app.models.Personmedicalcondition.medicationPsychotrophicpdf(request)
    ]).then(([sleepingResponse,mobilityResponse,providerResponse,passportResponse,feedingResponse,insuranceResponse,conditionResponse,eliminationResponse,familyHistoryResponse,psychotropicmedicationResponse]) => {
      sleepinghistorysummary = checkArrFmt(sleepingResponse.data);
      mobilityorspeechsummary = checkArrFmt(mobilityResponse.data);
      providerinformationsummary = checkArrFmt(providerResponse.data);
      healthpassportinfosummary = checkArrFmt(passportResponse.data);
      feedinginfosummary = checkArrFmt(feedingResponse.data);
      insuranceinfosummary = checkArrFmt(insuranceResponse.data);
      conditionsorDisorderssummary = combReportConditionData(conditionResponse,request)
      healtheliminationhistory = checkArrFmt(eliminationResponse.data);
      healthhistory = checkArrFmt(familyHistoryResponse.data);
      medicationincludingpsychotropic = checkArrFmt(psychotropicmedicationResponse.data);

      const examinationHealthHtml = examinationHealth?.examinationHealthHtml;
      const birthNeonatalInformationHtml = birthNeonatalInformation?.birthNeonatalInformationHtml;
      const reproductiveHealthHtml = reproductiveHealth?.personReproductiveHealthHtml;
      const personHospitalizationHtml = personHospitalization?.personHospitalizationHtml;
      const immunizationDataHtml = immunizationData?.immunizationDataHtml;
      const behavirolHealthDataHtml = behavirolHealthData?.personBehavirolHealthDataHtml;
      const disabilitiesHtml = disabilities?.disabilitiesDataHtml;

      const sleepingHtml = fs.readFileSync(
        './documenttemplates/person-health-sleepingsummary.html',
        'utf8'
      );
      const mobilityHtml = fs.readFileSync(
        './documenttemplates/person-health-mobilityorspeechsummary.html',
        'utf8'
      );
      const providerHtml = fs.readFileSync(
        './documenttemplates/person-health-providerinformationsummary.html',
        'utf8'
      );
      const feedingHtml = fs.readFileSync(
        './documenttemplates/person-health-feedinginfosummary.html',
        'utf8'
      );
      const insuranceHtml = fs.readFileSync(
        './documenttemplates/person-health-insuranceinfosummary.html',
        'utf8'
      );
      const conditionsHtml = fs.readFileSync(
        './documenttemplates/person-health-conditionsorDisorderssummary.html',
        'utf8'
      );
      const eliminationHtml = fs.readFileSync(
        './documenttemplates/person-health-Elimination.html',
        'utf8'
      );
      const familyHistoryHtml = fs.readFileSync(
        './documenttemplates/person-health-familyhistoryreport.html',
        'utf8'
      );
      const medicationpsychotropicHtml = fs.readFileSync(
        './documenttemplates/person-health-medicationincludingpsychotropic.html',
        'utf8'
      );
      let combinedHtml = `
                            <html>
                              <style>
                              .new-page {
                                page-break-before: always;
                              }
                          
                              h3 {
                                text-align: center;
                                margin: 0;
                                padding: 0;
                              }

                              h2 {
                                text-align: center;
                                margin: 0;
                                padding: 0;
                                font-weight: bold;
                              }
                          
                              .page-header {
                                text-align: center;
                                font-size: 18px;
                                font-weight: bold;
                                padding: 10px 0;
                              }
                          
                              @page {
                                margin-top: 100px;
                              }
                          
                              .page-header {
                                display: block;
                                position: running(header);
                              }
                          
                              body {
                                margin-top: 100px;
                              }
                              </style>
                              <body>
                              <div class="page-header">
                                <h2>PERSON HEALTH SUMMARY</h2>
                                <h3>CJAMS PID# ${util.nullcheck(cjamspId)}  ${util.nullcheck(firstName)} ${util.nullcheck(middleName)} ${util.nullcheck(lastName)}</h3>
                                <h3>Start Date ${util.nullcheck(startDate)} to End Date ${util.nullcheck(endDate)}</h3>
                              </div>
                                  ${emptyStrCheck(examinationHealthHtml)}
                                  <div class="new-page"></div>
                                  ${emptyStrCheck(birthNeonatalInformationHtml)}
                                  <div class="new-page"></div>
                                  ${emptyStrCheck(reproductiveHealthHtml)}
                                  <div class="new-page"></div>
                                  ${emptyStrCheck(personHospitalizationHtml)}
                                  <div class="new-page"></div>
                                  ${emptyStrCheck(immunizationDataHtml)}
                                  <div class="new-page"></div>
                                  ${emptyStrCheck(behavirolHealthDataHtml)}
                                  <div class="new-page"></div>
                                  ${emptyStrCheck(disabilitiesHtml)}
                                  <div class="new-page"></div>
                                  ${emptyStrCheck(familyHistoryHtml)}
                                  <div class="new-page"></div>
                                  ${emptyStrCheck(feedingHtml)}
                                  <div class="new-page"></div>
                                  ${emptyStrCheck(insuranceHtml)}
                                  <div class="new-page"></div>
                                  ${emptyStrCheck(conditionsHtml)}
                                  <div class="new-page"></div>
                                  ${emptyStrCheck(medicationpsychotropicHtml)}
                                  <div class="new-page"></div>
                                  ${emptyStrCheck(providerHtml)}
                                  <div class="new-page"></div>
                                  ${emptyStrCheck(mobilityHtml)}
                                  <div class="new-page"></div>
                                  ${emptyStrCheck(sleepingHtml)}
                                  <div class="new-page"></div>
                                  ${emptyStrCheck(eliminationHtml)}
                                  <div class="new-page"></div>
                                </body>
                              </html>
                            `;

      // Correcting provider information, health passport, sleeping history, insurance info, conditions or disorders, and psychotropic medication
      providerinformationsummary?.forEach((item) => {
        item.physician_phone = util.formatPhoneNumber(item?.physician_phone,'/');
        item.startdate = util.formatDate(item?.startdate,'/');
        item.enddate = util.formatDate(item?.enddate,'/');
      });

      healthpassportinfosummary?.forEach((item) => {
        item.effectivedate = util.formatDate(item?.effectivedate,'/');
      });

      sleepinghistorysummary?.forEach((_item) => {
        _item.sleepingschedule_naptime = util.formatTime(_item.sleepingschedule_naptime,'/');
        _item.sleepingschedule_bedtime = util.formatTime(_item.sleepingschedule_bedtime,'/');
      });

      insuranceinfosummary?.forEach((_item) => {
        _item.effectivedate = util.formatDate(_item?.effectivedate,'/');
        _item.expirationdate = util.formatDate(_item?.expirationdate,'/');
        _item.medicaidstartdate = util.formatDate(_item.medicaidstartdate,'/');
        _item.medicaidenddate = util.formatDate(_item?.medicaidenddate,'/');
        _item.providerphone = util.formatPhoneNumber(_item?.providerphone,'/');
      });


      conditionsorDisorderssummary?.forEach((item) => {
        item.begindate = util.formatDate(item?.begindate,'/');
        item.enddate = util.formatDate(item?.enddate,'/');
        if (item.medicalcondition_icd10_desc) {
          item.medicalcondition_icd10_desc = item.medicalcondition_icd10_desc.replace(/[\[\]"]/g,'');
        }
        if (item.allergies_adverse_reactions) {
          item.allergies_adverse_reactions = item.allergies_adverse_reactions.replace(/[\[\]"]/g,'');
        }
      });

      medicationincludingpsychotropic?.forEach((item) => {
        item.dateofrefill = util.formatDate(item?.dateofrefill,'/');
        item.medicationeffectivedate = util.formatDate(item?.medicationeffectivedate,'/');
        item.medicationexpirationdate = util.formatDate(item?.medicationexpirationdate,'/');
        item.lastdosetakendate = util.formatDate(item?.lastdosetakendate,'/');
        item.datemedicationstarted = util.formatDate(item?.datemedicationstarted,'/');
        if (item.compliant != '') {
          switch (item.compliant) {
            case 0:
              item.compliant = 'No';
              break;
            case 1:
              item.compliant = 'Yes';
              break;
            case 2:
              item.compliant = 'Unknown';
              break;
          }
        }
      });

      reqjson = {
        root_template_path_style: app.baseurl,
        root_template_path_image: app.baseurl,
        personHealthExamination: util.nullcheck(examinationHealth?.personHealthExamination),
        birthNeonatalInformation: util.nullcheck(birthNeonatalInformation?.birthNeonatalInformation),
        personReproductiveHealth: util.nullcheck(reproductiveHealth?.personReproductiveHealth),
        personHospitalization: util.nullcheck(personHospitalization?.personHospitalization),
        immunizationData: util.nullcheck(immunizationData?.immunizationData),
        personBehavirolHealthData: util.nullcheck(behavirolHealthData?.personBehavirolHealthData),
        disabilitiesData: util.nullcheck(disabilities?.disabilitiesData),
        sleepinghistorysummary: util.nullcheck(sleepinghistorysummary),
        mobilityorspeechsummary: util.nullcheck(mobilityorspeechsummary),
        providerinformationsummary: util.nullcheck(providerinformationsummary),
        provideruploadinfo: util.nullcheck(provideruploadinfo),
        healthpassportinfosummary: util.nullcheck(healthpassportinfosummary),
        feedinginfosummary: util.nullcheck(feedinginfosummary),
        insuranceinfosummary: util.nullcheck(insuranceinfosummary),
        insuranceuploadinfo: util.nullcheck(insuranceuploadinfo),
        conditionsorDisorderssummary: util.nullcheck(conditionsorDisorderssummary),
        healtheliminationhistory: util.nullcheck(healtheliminationhistory),
        healthhistory: util.nullcheck(healthhistory),
        medicationincludingpsychotropic: util.nullcheck(medicationincludingpsychotropic),
        conditionsordisorderdocdata: util.nullcheck(conditionsordisorderdocdata),
        familyHistoryDocData: util.nullcheck(familyHistoryDocData),
        personHealthExaminationData: util.nullcheck(personHealthExaminationData),
        personBehavirolHealthInfo: util.nullcheck(personBehavirolHealthInfo),
        personHospitalizationInfo: util.nullcheck(personHospitalizationInfo),
      };

      request.where.outputfilename = 'Person Health Summary';

      const Response = module.exports.generatepdf(request,combinedHtml,reqjson,{
        type: 'report',
        res: response,
      });

      return Promise.resolve(Response);
    }).catch((err) => {
      LOGGER.error(err);
      return Promise.reject({ error: err.message || 'An error occurred while generating the combined report' });
    });
  });
};

function combReportConditionData(conditionResponse,request) {
  let conditionsorDisorderssummary = [];
  let conditionsOrDisordersData = checkArrFmt(conditionResponse.data);
  const startDateRequest = request.where.startDate;
  const endDateRequest = request.where.endDate;
  const startDay = moment(startDateRequest).startOf('day');
  const endDay = moment(endDateRequest).startOf('day');
  conditionsOrDisordersData = conditionsOrDisordersData.filter(e => {
    const mStartDate = moment(e.startdate).startOf('day');
    const mEndDate = moment(e.enddate).startOf('day');
    const isConditionInDateRange = mStartDate.isValid() && mEndDate.isValid() ? (mStartDate.isBetween(startDay,endDay,null,'[]') || mEndDate.isBetween(startDay,endDay,null,'[]')) : false;

    const hasNoValidDates = !mStartDate.isValid() && !mEndDate.isValid();

    const isEndDateInRangeWithoutStartDate = !mStartDate.isValid() && mEndDate.isValid() ? mEndDate.isBetween(startDay,endDay,null,'[]') : false;

    const isStartDateValidAndBeforeRequestEnd = !mEndDate.isValid() && mStartDate.isValid() ? mStartDate.isSameOrBefore(endDay) : false;

    return (isConditionInDateRange || hasNoValidDates || isEndDateInRangeWithoutStartDate || isStartDateValidAndBeforeRequestEnd);
  });
  conditionsorDisorderssummary = conditionsOrDisordersData;
  return conditionsorDisorderssummary;
}
 
module.exports.cdprogram = async function (request) {
  let reqjson = {};
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid[0];
  const intakenumber = request.where.intakenumber;
  var securityuserid = app.currentUser.userprofile.fullname;
  var role = app.currentUser.roletypekey;

  const sql = "select jsondata ->> 'persons' as persons from intakedastaging where intakenumber = ($1)";
  let Response;
  try {
      const data = await util.executeDBQuery(sql, [intakenumber]);
        if (data.length > 0) {
          let responseval = [];
          responseval = data[0];
          var html = fs.readFileSync('./documenttemplates/cdcontract.html', 'utf8');

          const persons = JSON.parse(responseval.persons);
          const youth = persons.filter(x => x.Role === 'Youth');
          let guardian = '';
          for (var i in persons) {
            if (persons[i].RelationshiptoRA === 'mother') {
              guardian = persons[i];
            }
            if (persons[i].RelationshiptoRA === 'father') {
              guardian = persons[i];
            }
          }

          reqjson = {
            root_template_path_style: app.baseurl,
            root_template_path_image: app.baseurl,
            "crntdate": util.formatDate(new Date().toLocaleString()),
            "youthname": util.nullcheck(youth[0].fullName),
            "parentname": util.nullcheck(guardian.fullName),
            "officer": securityuserid,
            "role": role
          };
          request.where.evaluationid = intakeservicerequestevaluationid;
          request.where.outputfilename = reqjson.complaintid+"_"+"CommunityDetentionProgram";
          Response = module.exports.generatepdf(request, html, reqjson);
        }
        return Response;
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
};

module.exports.cdteleconsentagree = async function (request) {
  let reqjson = {};
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid[0];
  const intakenumber = request.where.intakenumber;
  var securityuserid = app.currentUser.userprofile.fullname;
  var role = app.currentUser.roletypekey;

  const sql = "select * from cdteleconsentagreebs($1)";
  let Response;
  try {
      const data = await util.executeDBQuery(sql, [intakenumber]);
        if (data.length > 0) {
          let responseval = [];
          responseval = data[0];
          var html = fs.readFileSync('./documenttemplates/cdteleconsentagree.html', 'utf8');

          reqjson = {
            root_template_path_style: app.baseurl,
            root_template_path_image: app.baseurl,
            "crntdate": util.formatDate(new Date().toLocaleString()),
            "youthname": util.nullcheck(responseval.youthname),
            "youthaddress": util.nullcheck(responseval.youthaddress),
            "youthcity": util.nullcheck(responseval.youthcity),
            "youthstate": util.nullcheck(responseval.youthstate),
            "youthnumber": util.nullcheck(responseval.youthnumber),
            "prepdate": util.nullcheck(responseval.prepdate),
            "officer": securityuserid,
            "role": role
          };
          request.where.evaluationid = intakeservicerequestevaluationid;
          request.where.outputfilename = reqjson.complaintid+"_"+"authorizationReleaseTelephone";
          Response = module.exports.generatepdf(request, html, reqjson);
        }
        return Response;
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
};

module.exports.nightintake = function (request) {
  let reqjson = {};
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid[0];
  var securityuserid = app.currentUser.userprofile.fullname;
  const role = app.currentUser.roletypekey;
  const intakenumber = request.where.intakenumber;

  const sql = "select * from cdprelimconsentbs($1)";
  let Response;
  return util.executeDBQuery(sql, [intakenumber])
    .then(data => {
        LOGGER.info(data);
        if (data.length > 0) {
          let responseval = [];
          responseval = data[0];
          var html = fs.readFileSync('./documenttemplates/cdnightintake.html', 'utf8');

          const persons = JSON.parse(responseval.persons);
          const youth = persons.filter(x => x.Role === 'Youth');
          let guardian = '';
          for (var i in persons) {
            if (persons[i].RelationshiptoRA === 'mother') {
              guardian = persons[i].fullName;
            }
            if (persons[i].RelationshiptoRA === 'father') {
              guardian = persons[i].fullName;
            }
          }

          const youthid = 'cjamspid' in youth[0] ? youth[0].cjamspid : '';

          reqjson = {
            root_template_path_style: app.baseurl,
            root_template_path_image: app.baseurl,
            "youthname": util.nullcheck(youth[0].fullName),
            "youthid": youthid,
            "guardianname": guardian,
            "providername": util.nullcheck(responseval.provider_name),
            "officer": securityuserid,
            "role": role
          };
          request.where.evaluationid = intakeservicerequestevaluationid;
          request.where.outputfilename = reqjson.complaintid+"_"+"nightintake";
          Response = module.exports.generatepdf(request, html, reqjson);
        }
        return Response;
    })
    .catch(err => {
        LOGGER.error(err)
    })
};

module.exports.fsyouthfacesheet = function (request) {
  let reqjson = {};
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid[0];
  const intakenumber = request.where.intakenumber;

  const sql = "select * from youthfacesheetbs($1)";
  let Response;
  return util.executeDBQuery(sql, [intakenumber])
    .then(data => {
        LOGGER.info(data);
        if (data.length > 0) {
          let responseval = [];
          responseval = data[0];
          var html = fs.readFileSync('./documenttemplates/fsyouthfacesheet.html', 'utf8');

          const education = responseval.education;
          const physician = responseval.physician;
          const insurance = responseval.insurance;
          let provider = '';
          let policy = '';
          let expirationdate = '';
          if (insurance != null) {
            provider = 'provider' in insurance ? insurance.provider : '';
            policy = 'policyname' in insurance ? insurance.policyname : '';
            expirationdate = 'expirationdate' in insurance ? insurance.expirationdate : '';
          }

          reqjson = {
            root_template_path_style: app.baseurl,
            root_template_path_image: app.baseurl,
            "crntdate": util.formatDate(new Date().toLocaleString()),
            "youthname": util.nullcheck(responseval.youthname),
            "youthid": util.nullcheck(responseval.youthid),
            "address1": util.nullcheck(responseval.address1),
            "address2": util.nullcheck(responseval.address2),
            "dob": util.nullcheck(responseval.dateofbirth),
            "race": util.nullcheck(responseval.race),
            "gender": util.nullcheck(responseval.gender),
            "height": util.nullcheck(responseval.height_inches),
            "weight": util.nullcheck(responseval.weight_lbs),
            "hair": util.nullcheck(responseval.hair_color),
            "eye": util.nullcheck(responseval.eye_color),
            "phone": util.nullcheck(responseval.phone),
            "school": util.nullcheck(education.school),
            "lastgrade": util.nullcheck(education.lastgrade),
            "enddate": util.nullcheck(education.enddate),
            "county": util.nullcheck(education.county),
            "specialeducation": util.nullcheck(education.specialeducation),
            "readdate": util.nullcheck(education.readdate),
            "readlevel": util.nullcheck(education.readlevel),
            "mathdate": util.nullcheck(education.mathdate),
            "mathlevel": util.nullcheck(education.mathlevel),
            "physician": util.nullcheck(physician.name),
            "physicianphone": util.nullcheck(physician.phone),
            "insuranceprovider": provider,
            "policyname": policy,
            "expirationdate": expirationdate
            /*"medicalcondition": util.nullcheck(medicalcondition.condition),
            "medication": util.nullcheck(medication.medication)*/
          };
          request.where.evaluationid = intakeservicerequestevaluationid;
          request.where.outputfilename = reqjson.complaintid+"_"+"fieldservicesyouthfacesheet";
          Response = module.exports.generatepdf(request, html, reqjson);
        }
        return Response;
    })
    .catch(err => {
        LOGGER.error(err)
    })
};

module.exports.paidsatisfiedmemo = async function (request) {
  let reqjson = {};
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid[0];
  var securityuserid = app.currentUser.userprofile.fullname;
  const intakenumber = request.where.intakenumber;
  const restitutionno = request.where.restitutionno;

  const sql = "select * from getpaidsatifiedmemo($1,$2)";
  let Response;
  try {
      const data = await util.executeDBQuery(sql, [intakenumber,restitutionno]);
        if (data.length > 0) {
          let responseval = [];
          responseval = data[0];
          var html = fs.readFileSync('./documenttemplates/paidsatisfiedmemo.html', 'utf8');
          let subject = '';
          if (responseval.courtactiontypekey === 'RestiOJS') {
            subject = 'A payment of $' + responseval.payment + ' received satisfies the youth’s share of restitution, however, this case was ordered Joint and Several and not all the youths have satisfied their share. I will notify you when all restitution has been satisfied so that the case can be closed.'
          } else {

            subject = 'A payment of $' + responseval.payment + ' received satisfies the youth’s restitution in full, closing this case in its entirety.'
          }

          reqjson = {
            root_template_path_style: app.baseurl,
            root_template_path_image: app.baseurl,
            "crntdate": util.formatDate(new Date().toLocaleString()),
            "rtcdcoordinator": util.nullcheck(responseval.rtcdcoordinator),
            "youthname": util.nullcheck(responseval.youthname),
            "description": util.nullcheck(responseval.description),
            "subject": subject,
            "officer": securityuserid
          };
          request.where.evaluationid = intakeservicerequestevaluationid;
          request.where.outputfilename = restitutionno+"_"+"PaidandSatisfiedMemo";
          Response = module.exports.generatepdf(request, html, reqjson);
        }
        return Response;
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
};

module.exports.noticesatisfaction = async function (request) {
  let reqjson = {};
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid[0];
  var securityuserid = app.currentUser.userprofile.fullname;
  const intakenumber = request.where.intakenumber;
  const restitutionno = request.where.restitutionno;

  const sql = "select * from getsatisfactionnotice($1)";
  let Response;
  try {
      const data = await util.executeDBQuery(sql, [intakenumber]);
        if (data.length > 0) {
          let responseval = [];
          responseval = data[0];
          var html = fs.readFileSync('./documenttemplates/noticeofsatisfaction.html', 'utf8');
          reqjson = {
            root_template_path_style: app.baseurl,
            root_template_path_image: app.baseurl,
            "crntdate": util.formatDate(new Date().toLocaleString()),
            "youthname": util.nullcheck(responseval.youthname),
            "victim": util.nullcheck(responseval.victim),
            "county": util.nullcheck(responseval.county),
            "casenumber": util.nullcheck(responseval.casenumber),
            "amount": util.nullcheck(responseval.amount),
            "paymentdate": responseval.paymentdate ? util.formatDate(util.nullcheck(responseval.paymentdate).toLocaleString()) : "",
            "lasthearing": util.nullcheck(responseval.lasthearing),
            "officer": securityuserid
          };
          request.where.evaluationid = intakeservicerequestevaluationid;
          request.where.outputfilename = restitutionno+"_"+"noticeofsatisfaction";
          Response = module.exports.generatepdf(request, html, reqjson);
        }
        return Response;
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
};

module.exports.fsyouthfacesheet = function (request) {
  let reqjson = {};
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid[0];
  const intakenumber = request.where.intakenumber;

  const sql = "select * from youthfacesheetbs($1)";
  let Response;
  return util.executeDBQuery(sql, [intakenumber])
    .then(data => {
        LOGGER.info(data);
        if (data.length > 0) {
          let responseval = [];
          responseval = data[0];
          var html = fs.readFileSync('./documenttemplates/fsyouthfacesheet.html', 'utf8');

          const education = responseval.education;
          const physician = responseval.physician;
          const insurance = responseval.insurance;
          let provider = '';
          let policy = '';
          let expirationdate = '';
          if (insurance != null) {
            provider = 'provider' in insurance ? insurance.provider : '';
            policy = 'policyname' in insurance ? insurance.policyname : '';
            expirationdate = 'expirationdate' in insurance ? insurance.expirationdate : '';
          }

          reqjson = {
            root_template_path_style: app.baseurl,
            root_template_path_image: app.baseurl,
            "crntdate": util.formatDate(new Date().toLocaleString()),
            "youthname": util.nullcheck(responseval.youthname),
            "youthid": util.nullcheck(responseval.youthid),
            "address1": util.nullcheck(responseval.address1),
            "address2": util.nullcheck(responseval.address2),
            "dob": util.nullcheck(responseval.dateofbirth),
            "race": util.nullcheck(responseval.race),
            "gender": util.nullcheck(responseval.gender),
            "height": util.nullcheck(responseval.height_inches),
            "weight": util.nullcheck(responseval.weight_lbs),
            "hair": util.nullcheck(responseval.hair_color),
            "eye": util.nullcheck(responseval.eye_color),
            "phone": util.nullcheck(responseval.phone),
            "school": util.nullcheck(education.school),
            "lastgrade": util.nullcheck(education.lastgrade),
            "enddate": util.nullcheck(education.enddate),
            "county": util.nullcheck(education.county),
            "specialeducation": util.nullcheck(education.specialeducation),
            "readdate": util.nullcheck(education.readdate),
            "readlevel": util.nullcheck(education.readlevel),
            "mathdate": util.nullcheck(education.mathdate),
            "mathlevel": util.nullcheck(education.mathlevel),
            "physician": util.nullcheck(physician.name),
            "physicianphone": util.nullcheck(physician.phone),
            "insuranceprovider": provider,
            "policyname": policy,
            "expirationdate": expirationdate
            /*"medicalcondition": util.nullcheck(medicalcondition.condition),
            "medication": util.nullcheck(medication.medication)*/
          };
          request.where.evaluationid = intakeservicerequestevaluationid;
          request.where.outputfilename = reqjson.complaintid;
          Response = module.exports.generatepdf(request, html, reqjson);
        }
        return Response;
    })
    .catch(err => {
        LOGGER.error(err)
        return err;
    })
};

module.exports.noticesatisfaction = async function (request) {
  let reqjson = {};
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid[0];
  var securityuserid = app.currentUser.userprofile.fullname;

  const intakenumber = request.where.intakenumber;

  const sql = "select * from getsatisfactionnotice($1)";
  let Response;
  try {
      const data = await util.executeDBQuery(sql, [intakenumber]);
        if (data.length > 0) {
          let responseval = [];
          responseval = data[0];
          var html = fs.readFileSync('./documenttemplates/noticeofsatisfaction.html', 'utf8');
          reqjson = {
            root_template_path_style: app.baseurl,
            root_template_path_image: app.baseurl,
            "crntdate": util.formatDate(new Date().toLocaleString()),
            "youthname": util.nullcheck(responseval.youthname),
            "victim": util.nullcheck(responseval.victim),
            "county": util.nullcheck(responseval.county),
            "casenumber": util.nullcheck(responseval.casenumber),
            "amount": util.nullcheck(responseval.amount),
            "paymentdate": util.formatDate(util.nullcheck(responseval.paymentdate).toLocaleString()),
            "lasthearing": util.nullcheck(responseval.lasthearing),
            "officer": securityuserid
          };
          request.where.evaluationid = intakeservicerequestevaluationid;
          request.where.outputfilename = reqjson.complaintid;
          Response = module.exports.generatepdf(request, html, reqjson);
        }
        return Response;
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
};

module.exports.cdteleconsentagree = async function (request) {
  let reqjson = {};
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid[0];
  const intakenumber = request.where.intakenumber;
  var securityuserid = app.currentUser.userprofile.fullname;
  var role = app.currentUser.roletypekey;

  const sql = "select * from cdteleconsentagreebs($1)";
  let Response;
  try {
      const data = await util.executeDBQuery(sql, [intakenumber]);
        if (data.length > 0) {
          let responseval = [];
          responseval = data[0];
          var html = fs.readFileSync('./documenttemplates/cdteleconsentagree.html', 'utf8');

          reqjson = {
            root_template_path_style: app.baseurl,
            root_template_path_image: app.baseurl,
            "crntdate": util.formatDate(new Date().toLocaleString()),
            "youthname": util.nullcheck(responseval.youthname),
            "youthaddress": util.nullcheck(responseval.youthaddress),
            "youthcity": util.nullcheck(responseval.youthcity),
            "youthstate": util.nullcheck(responseval.youthstate),
            "youthnumber": util.nullcheck(responseval.youthnumber),
            "prepdate": util.nullcheck(responseval.prepdate),
            "officer": securityuserid,
            "role": role
          };
          request.where.evaluationid = intakeservicerequestevaluationid;
          request.where.outputfilename = reqjson.complaintid;
          Response = module.exports.generatepdf(request, html, reqjson);
        }
        return Response;
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
};

module.exports.NoticePreIntake = function (request) {
  let reqjson = {};
  let prs = [];
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid[0];
  var securityuserid = app.currentUser.userprofile.fullname;
  var intakenumber = request.where.intakenumber;

  prs = request.where.intakeservicerequestevaluationid.map(evaluationid => {

    const sql = "select jsondata->>'persons' as persons, jsondata->>'complaintInfoReview' as complaintreview, jsondata->>'insufficientInfoNarrative' as comments, raname from intakedastaging da where intakenumber= $1";
    let Response;
    return util.executeDBQuery(sql, [intakenumber])
    .then(data => {
        LOGGER.info(data);
        if (data.length > 0) {
          let responseval = [];
          responseval = data[0];
          let decision = '';
          var html = fs.readFileSync('./documenttemplates/preintakeletter.html', 'utf8');

          const reviewdata = JSON.parse(responseval.complaintreview);

          const jurisdiction = reviewdata.No_Jurisdiction;
          const insuffInfo = reviewdata.Insufficient_Information;

          if (jurisdiction !== undefined && jurisdiction.length > 0) {
            decision += '<ul> No Jurisdiction';
            jurisdiction.forEach(info => {
              decision += '<li>' + info + '</li>';
            })
            decision += '</ul>';
          }
          if (insuffInfo !== undefined && insuffInfo.length > 0) {
            decision += '<ul> <b>Insufficent Information</b>';
            insuffInfo.forEach(info => {
              var str = info.replace('Please add ', '');
              decision += '<li>' + str + '</li>';
            })
            decision += '</ul>';
          }
          const persons = JSON.parse(responseval.persons);
          const victim = persons.filter(x => x.Role === 'Victim');


          reqjson = {
            root_template_path_style: app.baseurl,
            root_template_path_image: app.baseurl,
            "crntdate": util.formatDate(new Date().toLocaleString()),
            "youthname": util.nullcheck(responseval.raname),
            //"youthid": youthid,
            "youthid": '100000612',
            "victimname": util.nullcheck(victim[0].fullName),
            "decision": decision,
            "comments": util.nullcheck(responseval.comments),
            "officername": securityuserid,
            //"role": role
            "role": 'Referral Worker'
          };
          request.where.evaluationid = intakeservicerequestevaluationid;
          request.where.outputfilename = reqjson.complaintid;
          Response = module.exports.generatepdf(request, html, reqjson);
        }

        return Response;
    })
    .catch(err => {
        LOGGER.error(err)
    })
  })
  return Promise.all(prs)
};

module.exports.DetentionShelterAuth = function (request) {
  let reqjson = {};
  let prs = [];
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid[0];

  prs = request.where.intakeservicerequestevaluationid.map(async evaluationid => {

    const sql = 'select * from detentionshelterauthorization($1)';
    let Response;
    try {
      const data = await util.executeDBQuery(sql, [evaluationid]);
        if (data.length > 0) {
          let responseval = [];
          let resallegations = "";
          responseval = data[0];
          var html = fs.readFileSync('./documenttemplates/detentionshelterauthoriz.html', 'utf8');
          if (responseval.offensename != null) {
            responseval.offensename.forEach(allegation => {
              resallegations += `<tr>`;
              resallegations += '<td>' + util.nullcheck(allegation) + '</td><td>' + util.nullcheck(responseval.offensedate) + '</td>'
              resallegations += '</tr>';
            })
          }

          reqjson = {
            root_template_path_style: app.baseurl,
            root_template_path_image: app.baseurl,
            "crntdate": util.formatDate(new Date().toLocaleString()),
            "complaintid": util.nullcheck(responseval.complaint_id),
            "complaintdate": util.nullcheck(util.formatDate(new Date(responseval.complaintdate))),
            "youthname": util.nullcheck(responseval.youthname),
            "youthid": util.nullcheck(responseval.youthid),
            "allegedoffense": resallegations,
            "race": util.nullcheck(responseval.race),
            "parentname": util.nullcheck(responseval.parentname),
            "parentaddress": util.nullcheck(responseval.parentaddress),
            "providername": util.nullcheck(responseval.provider_name),
            "provideraddress": util.nullcheck(responseval.provider_address),
            "providerphone": util.nullcheck(responseval.provider_number),
            "admissiondate": util.nullcheck(responseval.admissiondate)
          };
          request.where.evaluationid = intakeservicerequestevaluationid;
          request.where.outputfilename = reqjson.complaintid+"_"+"detentionshelterauthoriz";
          Response = module.exports.generatepdf(request, html, reqjson);
        }

        return Response;
      } catch (err) {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      }
  })
  return Promise.all(prs)
};

module.exports.MedicalSubstanceAbuse = function (request) {
  let reqjson = {};
  let prs = [];
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid[0];

  prs = request.where.intakeservicerequestevaluationid.map(async evaluationid => {

    const sql = 'select * from medicalsubstanceabusereferal($1)';
    let Response;
    try {
      const data = await util.executeDBQuery(sql, [evaluationid]);
        if (data.length > 0) {
          let responseval = [];
          responseval = data[0];
          var html = fs.readFileSync('./documenttemplates/medicalsubstanceabusereferal.html', 'utf8');

          reqjson = {
            root_template_path_style: app.baseurl,
            root_template_path_image: app.baseurl,
            "youthname": util.nullcheck(responseval.youthname),
            "youthid": util.nullcheck(responseval.youthid),
            "complaintid": util.nullcheck(responseval.complaint_id),
            "interviewdate": util.nullcheck(responseval.appdate),
            "guardianname": util.nullcheck(responseval.guardian_name),
            "dob": util.nullcheck(responseval.dob),
            "folderid": util.nullcheck(responseval.folderid),
            "guardianphone": util.nullcheck(responseval.guardian_phone)
          };
          request.where.evaluationid = intakeservicerequestevaluationid;
          request.where.outputfilename = reqjson.complaintid;
          Response = module.exports.generatepdf(request, html, reqjson);
        }

        return Response;
      } catch (err) {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      }
  })
  return Promise.all(prs)
};

module.exports.victimConsentInformalSupervision = function (request) {
  let reqjson = {};
  let prs = [];
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid;
  var securityuserid = app.currentUser.userprofile.securityusersid;
  var victim = request.where.victim.length ? request.where.victim[0] : null;
  var role = app.currentUser.roletypekey;

  prs = request.where.intakeservicerequestevaluationid.map(evaluationid => {

    const sql = 'select * from victimconsentforinformalsupervision($1,$2,$3)';
    let Response;
    return util.executeDBQuery(sql, [evaluationid, securityuserid, victim])
    .then(data => {
      if (data.length > 0) {
        let responseval = [];
        responseval = data[0];
        let resallegations = '';
        var html = fs.readFileSync('./documenttemplates/victimconsent.html', 'utf8');

        if (responseval.offensename != null) {
          responseval.offensename.forEach(allegation => {
            resallegations += `<tr><td>` + util.nullcheck(allegation) + '</td><td>' + util.nullcheck(responseval.offensedate) + '</td>'
            resallegations += '</tr>';
          })
        }

        const youth = responseval.youth;
        const victim1 = responseval.victim;
        let address = '';
        address = getVictimAddressCIS(victim1);
        

        reqjson = {
          root_template_path_style: app.baseurl,
          root_template_path_image: app.baseurl,
          "youthname": youth.name,
          "youthid": youth,
          id,
          "victimname": util.nullcheck(responseval.victim.name),
          "address": address,
          "complaintid": util.nullcheck(responseval.complaint_id),
          "dob": util.formatDate(util.nullcheck(responseval.dob).toLocaleString()),
          "allegedoffense": resallegations,
          "officername": util.nullcheck(responseval.officername),
          "role": role
        };
        request.where.evaluationid = intakeservicerequestevaluationid;
        request.where.outputfilename = reqjson.complaintid+"_"+"victimconsentinformalsupervision";
        Response = module.exports.generatepdf(request, html, reqjson);
      }

      return Response;
    })
    .catch(err => {
        LOGGER.error(err);
        return err;
    })
    
  })
  return Promise.all(prs)
};

function getVictimAddressCIS(victim){
  let address = '';
  if (victim) {
    const addresses = victim.address;
    for (var i in addresses) {
      if (addresses[i].personaddresstypekey == '31') {
        address = addresses[i];
      }
    }
  }
  return address;
}

/*Department of Juvenile Services Juvenile Restitution Input Document*/
module.exports.appendixb = async function (request) {
  let reqjson = {};
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid[0];
  const restitutionno = request.where.restitutionno;

  const sql = "select * from juvenilerestitutioninputdocument($1)";
  let Response;
  try {
      const data = await util.executeDBQuery(sql, [intakeservicerequestevaluationid]);
        if (data.length > 0) {
          let responseval = [];
          responseval = data[0];

          var html = fs.readFileSync('./documenttemplates/appendixb.html', 'utf8');

          reqjson = {
            root_template_path_style: app.baseurl,
            root_template_path_image: app.baseurl,
            "crntdate": util.formatDate(new Date().toLocaleString()),
            "youthname": util.nullcheck(responseval.youthname),
            "restitutioncaseid": util.nullcheck(responseval.restitution_no),
            "offenderid": util.nullcheck(responseval.youthid),
            "victimid": util.nullcheck(responseval.victim_id),
            "youthfname": util.nullcheck(responseval.youthfname),
            "youthlname": util.nullcheck(responseval.youthlname),
            "youthmname": util.nullcheck(responseval.youthmname),
            "telephonenumber": util.nullcheck(responseval.phone),
            "dob": util.nullcheck(responseval.dob),
            "address": util.nullcheck(responseval.address),
            "pcity": util.nullcheck(responseval.pcity),
            "pzipcode": util.nullcheck(responseval.pzipcode),
            "pstate": util.nullcheck(responseval.pstate),
            "pcounty": util.nullcheck(responseval.pcounty),
            "socialsecurityid": util.nullcheck(responseval.social_security_no),
            "driverslic": util.nullcheck(responseval.license_no),
            "motherfname": util.nullcheck(responseval.m_fname),
            "motherlname": util.nullcheck(responseval.m_lname),
            "mothermname": util.nullcheck(responseval.m_mname),
            "motherphonenumber": util.nullcheck(responseval.m_phone),
            "motherdob": util.nullcheck(responseval.m_dob),
            "motheraddress": util.nullcheck(responseval.m_address),
            "mothercity": util.nullcheck(responseval.m_city),
            "motherzipcode": util.nullcheck(responseval.m_zipcode),
            "motherstate": util.nullcheck(responseval.m_state),
            "mothersocialsecurityno": util.nullcheck(responseval.m_social_security_no),
            "motherlicenseno": util.nullcheck(responseval.m_license_no),
            "fatherfname": util.nullcheck(responseval.f_fname),
            "fatherlname": util.nullcheck(responseval.f_lname),
            "fathermname": util.nullcheck(responseval.f_mname),
            "fatherphonenumber": util.nullcheck(responseval.f_phone),
            "fatherdob": util.nullcheck(responseval.f_dob),
            "fatheraddress": util.nullcheck(responseval.f_address),
            "fathercity": util.nullcheck(responseval.f_city),
            "fatherzipcode": util.nullcheck(responseval.f_zipcode),
            "fatherstate": util.nullcheck(responseval.f_state),
            "fathersocialsecurityno": util.nullcheck(responseval.f_social_security_no),
            "fatherlicenseno": util.nullcheck(responseval.f_license_no),
            "offenderfname": util.nullcheck(responseval.o_fname),
            "offenderlname": util.nullcheck(responseval.o_lname),
            "offendermname": util.nullcheck(responseval.o_mname),
            "offenderphonenumber": util.nullcheck(responseval.o_phone),
            "offenderdob": util.nullcheck(responseval.o_dob),
            "offenderaddress": util.nullcheck(responseval.o_address),
            "offendercity": util.nullcheck(responseval.o_city),
            "offenderzipcode": util.nullcheck(responseval.o_zipcode),
            "offenderstate": util.nullcheck(responseval.o_state),
            "offendersocialsecurityno": util.nullcheck(responseval.o_social_security_no),
            "offenderlicenseno": util.nullcheck(responseval.o_license_no),
            "victimfname": util.nullcheck(responseval.v_fname),
            "victimlname": util.nullcheck(responseval.v_lname),
            "victimmname": util.nullcheck(responseval.v_mname),
            "victimphonenumber": util.nullcheck(responseval.v_phone),
            "victimaddress": util.nullcheck(responseval.v_address),
            "victimcity": util.nullcheck(responseval.v_city),
            "victimzipcode": util.nullcheck(responseval.v_zipcode),
            "victimstate": util.nullcheck(responseval.v_state),
            "totalrestitution": util.nullcheck(responseval.total_restitution),
            "youthshare": util.nullcheck(responseval.youth_share),
            "petitionid": util.nullcheck(responseval.petition_id),
            "courtcounty": util.nullcheck(responseval.court_county),
            "dateordered": responseval.dateordered ? util.formatDate(util.nullcheck(responseval.dateordered).toLocaleString()) : "",
            "paymentplan": util.nullcheck(responseval.payment_plan),
            "policecomplaintid": util.nullcheck(responseval.police_complaint_id)
          };

          request.where.evaluationid = intakeservicerequestevaluationid;
          request.where.outputfilename = restitutionno+"_"+"juvenileservicesjuvenilerestitutioninput";

          Response = module.exports.generatepdf(request, html, reqjson);
        }
        return Response;
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
}

/* Initial letter sent to YOUTH(S)/PARENT(S) upon opening a new FORMAL account. */

module.exports.appendixd = async function (request) {
  let reqjson = {};
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid[0];
  var usersecurityid = app.currentUser.userprofile.securityusersid;

  const intakenumber = request.where.intakenumber;
  const restitutionno = request.where.restitutionno;

  const sql = letterheadapdxdtojsql;

  let Response;
  try {
      const data = await util.executeDBQuery(sql, [intakenumber,restitutionno,usersecurityid]);
        if (data.length > 0) {
          let responseval = [];
          responseval = data[0];

          var html = fs.readFileSync('./documenttemplates/appendixd.html', 'utf8');

          reqjson = {
            root_template_path_style: app.baseurl,
            root_template_path_image: app.baseurl,
            "crntdate": util.formatDate(new Date().toLocaleString()),
            "youthname": util.nullcheck(responseval.youthname),
            "name": util.nullcheck(responseval.youthname),
            "address": util.nullcheck(responseval.youth_address),
            "youthparent": util.nullcheck(responseval.youth_parent),
            "county": util.nullcheck(responseval.county),
            "restitutionid": util.nullcheck(responseval.restitution),
            "amountowed": util.nullcheck(responseval.amount_ordered),
            "petitionid": util.nullcheck(responseval.petition_id),
            "telephonenumber": util.nullcheck(responseval.phone_number),
            "restitutioncoordinatorname": util.nullcheck(responseval.restitution_coordinator),
            "casemanagementspecialistname": util.nullcheck(responseval.case_mgmt_specialist)
          };

          request.where.evaluationid = intakeservicerequestevaluationid;
          request.where.outputfilename = responseval.restitution+"_"+"initialletteryouthparentformalaccount";

          Response = module.exports.generatepdf(request, html, reqjson);
        }
        return Response;
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
};


/*Initial letter sent to VICTIM(S) upon opening a new FORMAL account.*/

module.exports.appendixe = async function (request) {
  let reqjson = {};
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid[0];
  var usersecurityid = app.currentUser.userprofile.securityusersid;

  const intakenumber = request.where.intakenumber;
  const restitutionno = request.where.restitutionno;

  const sql = letterheadapdxdtojsql;

  let Response;
  try {
       const data = await util.executeDBQuery(sql, [intakenumber,restitutionno,usersecurityid]);
        if (data.length > 0) {
          let responseval = [];
          responseval = data[0];

          var html = fs.readFileSync('./documenttemplates/appendixe.html', 'utf8');

          reqjson = {
            root_template_path_style: app.baseurl,
            root_template_path_image: app.baseurl,
            "crntdate": util.formatDate(new Date().toLocaleString()),
            "youthname": util.nullcheck(responseval.youthname),
            "address": util.nullcheck(responseval.victim_address),
            "county": util.nullcheck(responseval.county),
            "petitionid": util.nullcheck(responseval.petition_id),
            "dateordered": responseval.court_ordered_date_time ? util.formatDateAndTime(util.nullcheck(responseval.court_ordered_date_time).toLocaleString()) : '',
            "amountordered": util.nullcheck(responseval.amount_ordered),
            "victimname": util.nullcheck(responseval.victim),
            "restitutioncaseid": util.nullcheck(responseval.restitution),
            "telephonenumber": util.nullcheck(responseval.phone_number),
            "restitutioncoordinatorname": util.nullcheck(responseval.restitution_coordinator),
            "casemanagementspecialistname": util.nullcheck(responseval.case_mgmt_specialist)
          };

          request.where.evaluationid = intakeservicerequestevaluationid;
          request.where.outputfilename = responseval.restitution+"_"+"initiallettervictimformalaccount";

          Response = module.exports.generatepdf(request, html, reqjson);

        }
        return Response;
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
};

/*Initial letter sent to YOUTH(S)/PARENT(S) upon opening a new INFORMAL restitution account. */

module.exports.appendixf = async function (request) {
  let reqjson = {};
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid[0];
  var usersecurityid = app.currentUser.userprofile.securityusersid;

  const intakenumber = request.where.intakenumber;
  const restitutionno = request.where.restitutionno;

  const sql = letterheadapdxdtojsql;
  let Response;
  try {
       const data = await util.executeDBQuery(sql, [intakenumber,restitutionno,usersecurityid]);
        if (data.length > 0) {
          let responseval = [];
          responseval = data[0];
          var html = fs.readFileSync('./documenttemplates/appendixf.html', 'utf8');

          reqjson = {
            root_template_path_style: app.baseurl,
            root_template_path_image: app.baseurl,
            "crntdate": util.formatDate(new Date().toLocaleString()),
            "name": util.nullcheck(responseval.youthname),
            "youthname": util.nullcheck(responseval.youthname),
            "county": util.nullcheck(responseval.county),
            "address": util.nullcheck(responseval.youth_address),
            "youthparent": util.nullcheck(responseval.youth_parent),
            "restitutionid": util.nullcheck(responseval.restitution),
            "amountdue": util.nullcheck(responseval.amount_ordered),
            "duedate": util.formatDate(util.nullcheck(responseval.due_date).toLocaleString()),
            "telephonenumber": util.nullcheck(responseval.phone_number),
            "restitutioncoordinatorname": util.nullcheck(responseval.restitution_coordinator),
            "casemanagementspecialistname": util.nullcheck(responseval.case_mgmt_specialist)
          };
          request.where.evaluationid = intakeservicerequestevaluationid;
          request.where.outputfilename =restitutionno+"_"+"initialletteryouth/parent(S)informalrestitutionaccount";

          Response = module.exports.generatepdf(request, html, reqjson);

        }
        return Response;
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
};

/*Initial letter sent to VICTIM upon opening a new INFORMAL case account.*/

module.exports.appendixg = async function (request) {
  let reqjson = {};
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid[0];
  var usersecurityid = app.currentUser.userprofile.securityusersid;

  const intakenumber = request.where.intakenumber;
  const restitutionno = request.where.restitutionno;

  const sql = letterheadapdxdtojsql;
  let Response;
  try {
       const data = await util.executeDBQuery(sql, [intakenumber,restitutionno,usersecurityid]);
        if (data.length > 0) {
          let responseval = [];
          responseval = data[0];
          var html = fs.readFileSync('./documenttemplates/appendixg.html', 'utf8');

          reqjson = {
            root_template_path_style: app.baseurl,
            root_template_path_image: app.baseurl,
            "crntdate": util.formatDate(new Date().toLocaleString()),
            "name": util.nullcheck(responseval.victim),
            "youthname": util.nullcheck(responseval.youthname),
            "victimname": util.nullcheck(responseval.victim),
            "county": util.nullcheck(responseval.county),
            "address": util.nullcheck(responseval.victim_address),
            "restitutionid": util.nullcheck(responseval.restitution),
            "amount": util.nullcheck(responseval.amount_ordered),
            "complaintid": util.nullcheck(responseval.complaint_id),
            "telephonenumber": util.nullcheck(responseval.phone_number),
            "restitutioncoordinatorname": util.nullcheck(responseval.restitution_coordinator),
            "casemanagementspecialistname": util.nullcheck(responseval.case_mgmt_specialist)
          };
          request.where.evaluationid = intakeservicerequestevaluationid;
          request.where.outputfilename = responseval.restitution+"_"+"initiallettervictiminformalcaseaccount";

          Response = module.exports.generatepdf(request, html, reqjson);

        }
        return Response;
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
};

/*Letter sent to VICTIM to notify of change in status of INFORMAL case*/

module.exports.appendixh = async function (request) {
  let reqjson = {};
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid[0];
  var usersecurityid = app.currentUser.userprofile.securityusersid;

  const intakenumber = request.where.intakenumber;
  const restitutionno = request.where.restitutionno;

  const sql = letterheadapdxdtojsql;
  let Response;
  try {
       const data = await util.executeDBQuery(sql, [intakenumber,restitutionno,usersecurityid]);
        if (data.length > 0) {
          let responseval = [];
          responseval = data[0];
          var html = fs.readFileSync('./documenttemplates/appendixh.html', 'utf8');

          reqjson = {
            root_template_path_style: app.baseurl,
            root_template_path_image: app.baseurl,
            "crntdate": util.formatDate(new Date().toLocaleString()),
            "name": util.nullcheck(responseval.victim),
            "youthname": util.nullcheck(responseval.youthname),
            "youthparent": util.nullcheck(responseval.youth_parent),
            "victimname": util.nullcheck(responseval.victim),
            "address": util.nullcheck(responseval.victim_address),
            "county": util.nullcheck(responseval.county),
            "restitutionid": util.nullcheck(responseval.restitution),
            "complaintid": util.nullcheck(responseval.complaint_id),
            "amount": util.nullcheck(responseval.amount_ordered),
            "duedate": util.formatDate(util.nullcheck(responseval.due_date).toLocaleString()),
            "telephonenumber": util.nullcheck(responseval.phone_number),
            "restitutioncoordinatorname": util.nullcheck(responseval.restitution_coordinator),
            "casemanagementspecialistname": util.nullcheck(responseval.case_mgmt_specialist)
          };
          request.where.evaluationid = intakeservicerequestevaluationid;
          request.where.outputfilename = responseval.restitution+"_"+"lettervictimchangestatusinformalcase";

          Response = module.exports.generatepdf(request, html, reqjson);

        }
        return Response;
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
};

/*Initial letter sent to YOUTH(S)/PARENT(S) upon opening a new STET/Mutual Postponement, Unsupervised Probation account
 */

module.exports.appendixi = async function (request) {
  let reqjson = {};
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid[0];
  var usersecurityid = app.currentUser.userprofile.securityusersid;

  const intakenumber = request.where.intakenumber;
  const restitutionno = request.where.restitutionno;

  const sql = letterheadapdxdtojsql;
  let Response;
  try {
       const data = await util.executeDBQuery(sql, [intakenumber,restitutionno,usersecurityid]);
        if (data.length > 0) {
          let responseval = [];
          responseval = data[0];
          var html = fs.readFileSync('./documenttemplates/appendixi.html', 'utf8');

          reqjson = {
            root_template_path_style: app.baseurl,
            root_template_path_image: app.baseurl,
            "crntdate": util.formatDate(new Date().toLocaleString()),
            "parentname": util.nullcheck(responseval.youth_parent),
            "address": util.nullcheck(responseval.youth_address),
            "youthparent": util.nullcheck(responseval.youth_parent),
            "county": util.nullcheck(responseval.county),
            "youthname": util.nullcheck(responseval.youthname),
            "restitutionaccountnumber": util.nullcheck(responseval.restitution),
            "amount": util.nullcheck(responseval.amount_ordered),
            "petitionid": util.nullcheck(responseval.petition_id),
            "duedate": util.formatDate(util.nullcheck(responseval.due_date).toLocaleString()),
            "hearingdate": responseval.hearing_date_time ? util.formatDateAndTime(util.nullcheck(responseval.hearing_date_time).toLocaleString()) : "",
            "telephonenumber": util.nullcheck(responseval.phone_number),
            "restitutioncoordinatorname": util.nullcheck(responseval.restitution_coordinator),
            "Stateattorneyofficerestitution": util.nullcheck(responseval.state_attorney_office)
          };
         
          request.where.evaluationid = intakeservicerequestevaluationid;
          request.where.outputfilename = restitutionno+"_"+"initialletteryouth(s)/parent(s)stet/mutualpostponement";

          Response = module.exports.generatepdf(request, html, reqjson);

        }
        return Response;
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
};

/*Initial letter sent to VICTIM upon opening a new STET/MUTUAL POSTPONEMENT/UNSUPERVISED PROBATION case account. */

module.exports.appendixj = async function (request) {
  let reqjson = {};
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid[0];
  var usersecurityid = app.currentUser.userprofile.securityusersid;

  const intakenumber = request.where.intakenumber;
  const restitutionno = request.where.restitutionno;

  const sql = letterheadapdxdtojsql;
  let Response;
  try {
       const data = await util.executeDBQuery(sql, [intakenumber,restitutionno,usersecurityid]);
        if (data.length > 0) {
          let responseval = [];
          responseval = data[0];
          var html = fs.readFileSync('./documenttemplates/appendixj.html', 'utf8');

          reqjson = {
            root_template_path_style: app.baseurl,
            root_template_path_image: app.baseurl,
            "crntdate": util.formatDate(new Date().toLocaleString()),
            "county": util.nullcheck(responseval.county),
            "youthname": util.nullcheck(responseval.youthname),
            "restitutioncaseid": util.nullcheck(responseval.restitution),
            "amountowed": util.nullcheck(responseval.amount_ordered),
            "victimname": util.nullcheck(responseval.victim),
            "address": util.nullcheck(responseval.victim_address),
            "petitionid": util.nullcheck(responseval.petition_id),
            "telephonenumber": util.nullcheck(responseval.phone_number),
            "restitutioncoordinatorname": util.nullcheck(responseval.restitution_coordinator),
            "Stateattorneyofficerestitution": util.nullcheck(responseval.state_attorney_office)
          };
          request.where.evaluationid = intakeservicerequestevaluationid;
          request.where.outputfilename = restitutionno+"_"+"initialvictimstet/mutualpostponement/unsupervisedprobationcaseaccount";

          Response = module.exports.generatepdf(request, html, reqjson);

        }
        return Response;
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
};

/*Notification of Transfer of Jurisdiction to VICTIMS */
module.exports.appendixl = async function (request) {
  let reqjson = {};
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid[0];
  var usersecurityid = app.currentUser.userprofile.securityusersid;

  const intakenumber = request.where.intakenumber;
  const restitutionno = request.where.restitutionno;

  const sql = "select * from jurisdictiontransferapdxl($1,$2,$3)";
  let Response;
  try {
      const data = await util.executeDBQuery(sql, [intakenumber,restitutionno,usersecurityid]);
        if (data.length > 0) {
          let responseval = [];
          responseval = data[0];

          var html = fs.readFileSync('./documenttemplates/appendixl.html', 'utf8');

          reqjson = {
            root_template_path_style: app.baseurl,
            root_template_path_image: app.baseurl,
            "crntdate": util.formatDate(new Date().toLocaleString()),
            "address": util.nullcheck(responseval.victim_address),
            "county": util.nullcheck(responseval.to_county),
            "victimname": util.nullcheck(responseval.victimname),
            "youthname": util.nullcheck(responseval.youthname),
            "restitutioncoordinatornamefrom": util.nullcheck(responseval.restitution_co_ordinator_from),
            "restitutioncoordinatornameto": util.nullcheck(responseval.restitution_co_ordinator_to),
            "restitutioncoordinatoraddressto": util.nullcheck(responseval.restitution_coordinator_to_address),
            "restitutioncoordinatorphonenumberto": util.nullcheck(responseval.restitution_coordinator_to_phone),
            "petitionoldid": util.nullcheck(responseval.petition_id),
            "petitionnewid": util.nullcheck(responseval.new_petitionid)
          };
          request.where.evaluationid = intakeservicerequestevaluationid;
          request.where.outputfilename = restitutionno+"_"+"notificationtransferjurisdictiontovictims";

          Response = module.exports.generatepdf(request, html, reqjson);

        }
        return Response;
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
};


/*FIRST NOTICE*/

module.exports.appendixn = async function (request) {
  let reqjson = {};
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid[0];
  var usersecurityid = app.currentUser.userprofile.securityusersid;

  const intakenumber = request.where.intakenumber;
  const restitutionno = request.where.restitutionno;

  const sql = firstnoticesql;
  let Response;
  try {
       const data = await util.executeDBQuery(sql, [intakenumber,restitutionno,usersecurityid]);
        if (data.length > 0) {
          let responseval = [];
          responseval = data[0];
          var html = fs.readFileSync('./documenttemplates/appendixn.html', 'utf8');

          reqjson = {
            root_template_path_style: app.baseurl,
            root_template_path_image: app.baseurl,
            "crntdate": util.formatDate(new Date().toLocaleString()),
            "address": util.nullcheck(responseval.liablepersonaddress),
            "name": util.nullcheck(responseval.liablepersonname),
            "county": util.nullcheck(responseval.county_name),
            "youthname": util.nullcheck(responseval.youthname),
            "restitutionid": util.nullcheck(responseval.restitutionno),
            "dateordered": responseval.dateordered ? util.formatDate(util.nullcheck(responseval.dateordered).toLocaleString()) : "",
            "amountordered": util.nullcheck(responseval.amountordered),
            "outstandingbalance": util.nullcheck(responseval.balance),
            "asof": util.nullcheck(responseval.todaydate),
            "telephonenumber": util.nullcheck(responseval.coordinatorphone),
            "restitutioncoordinatorname": util.nullcheck(responseval.coordinatorname),
            "casemgmtspecialist ": util.nullcheck(responseval.cw_name)
          };
          request.where.evaluationid = intakeservicerequestevaluationid;
          request.where.outputfilename = restitutionno+"_"+"firstnotice";

          Response = module.exports.generatepdf(request, html, reqjson);

        }
        return Response;
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
};

/*SECOND NOTICE*/

module.exports.appendixo = async function (request) {
  let reqjson = {};
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid[0];
  var usersecurityid = app.currentUser.userprofile.securityusersid;

  const intakenumber = request.where.intakenumber;
  const restitutionno = request.where.restitutionno;

  const sql = firstnoticesql;
  let Response;
  try {
       const data = await util.executeDBQuery(sql, [intakenumber,restitutionno,usersecurityid]);
        if (data.length > 0) {
          let responseval = [];
          responseval = data[0];
          var html = fs.readFileSync('./documenttemplates/appendixo.html', 'utf8');

          reqjson = {
            root_template_path_style: app.baseurl,
            root_template_path_image: app.baseurl,
            "crntdate": util.formatDate(new Date().toLocaleString()),
            "address": util.nullcheck(responseval.liablepersonaddress),
            "name": util.nullcheck(responseval.liablepersonname),
            "county": util.nullcheck(responseval.county_name),
            "youthname": util.nullcheck(responseval.youthname),
            "restitutionid": util.nullcheck(responseval.restitutionno),
            "dateordered": responseval.dateordered ? util.formatDate(util.nullcheck(responseval.dateordered).toLocaleString()) : "",
            "amountordered": util.nullcheck(responseval.amountordered),
            "outstandingbalance": util.nullcheck(responseval.balance),
            "asof": util.nullcheck(responseval.todaydate),
            "telephonenumber": util.nullcheck(responseval.coordinatorphone),
            "restitutioncoordinatorname": util.nullcheck(responseval.coordinatorname),
            "casemgmtspecialist": util.nullcheck(responseval.cw_name)
          };
          request.where.evaluationid = intakeservicerequestevaluationid;
          request.where.outputfilename = restitutionno+"_"+"secondnotice";

          Response = module.exports.generatepdf(request, html, reqjson);

        }
        return Response;
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
};

/*THIRD NOTICE*/

module.exports.appendixp = async function (request) {
  let reqjson = {};

  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid[0];
  var usersecurityid = app.currentUser.userprofile.securityusersid;

  const intakenumber = request.where.intakenumber;  
  const restitutionno = request.where.restitutionno;

  const sql = firstnoticesql;
  let Response;
  try {
       const data = await util.executeDBQuery(sql, [intakenumber,restitutionno,usersecurityid]);
        if (data.length > 0) {
          let responseval = [];
          responseval = data[0];
          var html = fs.readFileSync('./documenttemplates/appendixp.html', 'utf8');

          reqjson = {
            root_template_path_style: app.baseurl,
            root_template_path_image: app.baseurl,
            "crntdate": util.formatDate(new Date().toLocaleString()),
            "address": util.nullcheck(responseval.liablepersonaddress),
            "name": util.nullcheck(responseval.liablepersonname),
            "county": util.nullcheck(responseval.county_name),
            "youthname": util.nullcheck(responseval.youthname),
            "restitutionid": util.nullcheck(responseval.restitutionno),
            "dateordered": responseval.dateordered ? util.formatDate(util.nullcheck(responseval.dateordered).toLocaleString()) : "",
            "amountordered": util.nullcheck(responseval.amountordered),
            "outstandingbalance": util.nullcheck(responseval.balance),
            "asof": util.nullcheck(responseval.todaydate),
            "telephonenumber": util.nullcheck(responseval.coordinatorphone),
            "restitutioncoordinatorname": util.nullcheck(responseval.coordinatorname),
            "casemgmtspecialist": util.nullcheck(responseval.cw_name)
          };
          request.where.evaluationid = intakeservicerequestevaluationid;
          request.where.outputfilename = restitutionno+"_"+"thirdnotice";

          Response = module.exports.generatepdf(request, html, reqjson);

        }
        return Response;
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
};

/*Memorandum to State’s Attorney’s Office for Paid or Unsatisfied Restitution */
module.exports.appendixs = async function (request) {
  let reqjson = {};
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid[0];
  var usersecurityid = app.currentUser.userprofile.securityusersid;

  const intakenumber = request.where.intakenumber;
  const restitutionno = request.where.restitutionno;

  const sql = "select * from paidorunsatisfiedrestitution($1,$2)";
  let Response;
  try {
       const data = await util.executeDBQuery(sql, [intakenumber,usersecurityid]);
        if (data.length > 0) {
          let responseval = [];
          responseval = data[0];
          var html = fs.readFileSync('./documenttemplates/appendixs.html', 'utf8');

          reqjson = {
            root_template_path_style: app.baseurl,
            root_template_path_image: app.baseurl,
            "crntdate": util.formatDate(new Date().toLocaleString()),
            "StateAttorneyOffice": "",
            "restitutioncoordinatorname": util.nullcheck(responseval.coordinatorname),
            "youthname": util.nullcheck(responseval.youthname),
            "hearingdate": util.nullcheck(responseval.judgementdate),
            "duedate":util.nullcheck(responseval.paymentduedate),
            "county":util.nullcheck(responseval.county_name),
            "petitionid": util.nullcheck(responseval.petition_id),
            "amountordered": util.nullcheck(responseval.payamount),
            "amountpayed": util.nullcheck(responseval.paidamount),
            "telephonenumber": util.nullcheck(responseval.coordinatorphone)
          };
          request.where.evaluationid = intakeservicerequestevaluationid;
          request.where.outputfilename = restitutionno+"_"+"memorandumstateattorneyofficepaid";

          Response = module.exports.generatepdf(request, html, reqjson);

        }
        return Response;
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
};

/*Letter to victim(s) when case is forwarded to Central Collections. */

module.exports.lettervictimcc = async function (request) {
  let reqjson = {};

  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid[0];
  var usersecurityid = app.currentUser.userprofile.securityusersid;

  const restitutionno = request.where.restitutionno;
  const intakenumber = request.where.intakenumber;

  const sql = firstnoticesql;
  let Response;
  try {
       const data = await util.executeDBQuery(sql, [intakenumber,restitutionno,usersecurityid]);
        if (data.length > 0) {
          let responseval = [];
          responseval = data[0];
          LOGGER.debug(responseval.dateordered);
          var html = fs.readFileSync('./documenttemplates/appendixq.html', 'utf8');

          reqjson = {
            root_template_path_style: app.baseurl,
            root_template_path_image: app.baseurl,
            "crntdate": util.formatDate(new Date().toLocaleString()),
            "address": "",
            "victimname": "",
            "county": util.nullcheck(responseval.county_name),
            "respondentname": util.nullcheck(responseval.youthname),
            "restitutionid": util.nullcheck(responseval.restitutionno),
            "dateordered": responseval.dateordered ? util.formatDate(util.nullcheck(responseval.dateordered).toLocaleString()) : "",
            "amountordered": util.nullcheck(responseval.amountordered),
            "outstandingbalance": util.nullcheck(responseval.balance),
            "asof": util.nullcheck(responseval.todaydate),
            "telephonenumber": util.nullcheck(responseval.coordinatorphone),
            "restitutioncoordinatorname": util.nullcheck(responseval.coordinatorname),
            "casemgmtspecialist": util.nullcheck(responseval.cw_name)
          };

          request.where.evaluationid = intakeservicerequestevaluationid;
          request.where.outputfilename = restitutionno+"_"+"lettervictim(s)forwardedcentralcollections";

          Response = module.exports.generatepdf(request, html, reqjson);

        }
        return Response;
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
};

/* Guide to Restitution*/

module.exports.guidetorestitution = async function (request) {
  let reqjson = {};
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid[0];
  var usersecurityid = app.currentUser.userprofile.securityusersid;

  const intakenumber = request.where.intakenumber;
  const restitutionno = request.where.restitutionno;

  const sql = "select * from guidetorestitution($1,$2)";

  let Response;
  try {
      const data = await util.executeDBQuery(sql, [intakenumber,usersecurityid]);
        if (data.length > 0) {
          let responseval = [];
          responseval = data[0];

          var html = fs.readFileSync('./documenttemplates/guidetorestitution.html', 'utf8');

          reqjson = {
            root_template_path_style: app.baseurl,
            root_template_path_image: app.baseurl,
            "crntdate": util.formatDate(new Date().toLocaleString()),
            "casemanager": util.nullcheck(responseval.cw_name),
            "casemanagerofficephoneno": util.nullcheck(responseval.cw_phone),
            "restitutioncoordinatorname": util.nullcheck(responseval.coordinatorname),
            "restitutioncoordinatophoneno": util.nullcheck(responseval.coordinatorphone),
            "parentname": util.nullcheck(responseval.parentorguardian),
            "youthname": util.nullcheck(responseval.youthname),
            "todaydate": util.nullcheck(responseval.todaydate)
          };

          request.where.evaluationid = intakeservicerequestevaluationid;
          request.where.outputfilename = restitutionno+"_"+"guidetorestitution";

          Response = module.exports.generatepdf(request, html, reqjson);
        }
        return Response;
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
};

//restitution payment slip
module.exports.res_pmt_slip = async function (request) {
  let reqjson = {};
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid[0];
  const intakenumber = request.where.intakenumber;
  const restitutionno = request.where.restitutionno;

  const sql = "select * from restitution_pmt_slip($1,$2)";
  let Response;
  try {
      const data = await util.executeDBQuery(sql, [intakenumber,restitutionno]);
        if (data.length > 0) {
          let responseval = [];
          responseval = data[0];

          var html = fs.readFileSync('./documenttemplates/res_pmt_slip.html', 'utf8');

          reqjson = {
            root_template_path_style: app.baseurl,
            root_template_path_image: app.baseurl,
            "crntdate": util.formatDate(new Date().toLocaleString()),
            "youthname": util.nullcheck(responseval.youthname),
            "youthparent": util.nullcheck(responseval.youth_parent),
            "restitutionid": util.nullcheck(responseval.restitution),
            "amount": util.nullcheck(responseval.amount_ordered),
            "petitionid": util.nullcheck(responseval.petition_id),
          };
          request.where.evaluationid = intakeservicerequestevaluationid;
          request.where.outputfilename = restitutionno+"_"+"restitutionpaymentslip";

          Response = module.exports.generatepdf(request, html, reqjson);

        }
        return Response;
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
};

/* Transfer of Jurisdiction Restitution Account File*/

module.exports.appendixk = async function (request) {

  let reqjson = {};
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid[0];
  var usersecurityid = app.currentUser.userprofile.securityusersid;
  const intakenumber = request.where.intakenumber;
  const restitutionno = request.where.restitutionno;

  const sql = "select * from jurisdictiontransferapdxk($1,$2,$3)";
  let Response;
  try {
      const data = await util.executeDBQuery(sql, [intakenumber,restitutionno,usersecurityid]);
        if (data.length > 0) {
          let responseval = [];
          responseval = data[0];

          var html = fs.readFileSync('./documenttemplates/appendixk.html', 'utf8');

          reqjson = {
            root_template_path_style: app.baseurl,
            root_template_path_image: app.baseurl,
            "crntdate": util.formatDate(new Date().toLocaleString()),
            "restitution_coordinator_from": util.nullcheck(responseval.restitution_co_ordinator_from),
            "restitution_coordinator_from_region": util.nullcheck(responseval.restitution_co_ordinator_from_region),
            "restitution_co_ordinator_to": util.nullcheck(responseval.restitution_co_ordinator_to),
            "restitution_co_ordinator_to_region": util.nullcheck(responseval.restitution_co_ordinator_to_region),
            "youthname": util.nullcheck(responseval.youth_name),
            "restitutionid": util.nullcheck(responseval.restitution),
            "from_county": util.nullcheck(responseval.from_county),
            "to_county": util.nullcheck(responseval.to_county),
            "old_petitionid": util.nullcheck(responseval.old_petitionid),
            "new_petitionid": util.nullcheck(responseval.new_petitionid),
            "court_ordered_date_time": responseval.court_ordered_date_time ? util.formatDateAndTime(util.nullcheck(responseval.court_ordered_date_time).toLocaleString()) : ""
          };
          request.where.evaluationid = intakeservicerequestevaluationid;
          request.where.outputfilename = restitutionno+"_"+"transferjurisdictionrestitutionaccount";

          Response = module.exports.generatepdf(request, html, reqjson);

        }
        return Response;
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
};

/* Acknowledgment of Receipt of a Transfer of Jurisdiction Restitution Account File */
module.exports.appendixm = async function (request) {

  let reqjson = {};
  var intakeservicerequestevaluationid = request.where.intakeservicerequestevaluationid[0];
  var usersecurityid = app.currentUser.userprofile.securityusersid;
  const intakenumber = request.where.intakenumber;
  const restitutionno = request.where.restitutionno;

  const sql = "select * from jurisdictiontransferapdxM($1,$2,$3)";
  let Response;
  try {
      const data = await util.executeDBQuery(sql, [intakenumber,restitutionno,usersecurityid]);
        if (data.length > 0) {
          let responseval = [];
          responseval = data[0];

          var html = fs.readFileSync('./documenttemplates/appendixm.html', 'utf8');

          reqjson = {
            root_template_path_style: app.baseurl,
            root_template_path_image: app.baseurl,
            "crntdate": util.formatDate(new Date().toLocaleString()),
            "restitution_coordinator_from": util.nullcheck(responseval.restitution_co_ordinator_from),
            "restitution_coordinator_from_region": util.nullcheck(responseval.restitution_co_ordinator_from_region),
            "restitution_co_ordinator_to": util.nullcheck(responseval.restitution_co_ordinator_to),
            "restitution_co_ordinator_to_region": util.nullcheck(responseval.restitution_co_ordinator_to_region),
            "youthname": util.nullcheck(responseval.youth_name),
            "restitutionid": util.nullcheck(responseval.restitution),
            "from_county": util.nullcheck(responseval.from_county),
            "to_county": util.nullcheck(responseval.to_county),
            "old_petitionid": util.nullcheck(responseval.old_petitionid),
            "new_petitionid": util.nullcheck(responseval.new_petitionid),
            "court_ordered_date_time": responseval.court_ordered_date_time ? util.formatDateAndTime(util.nullcheck(responseval.court_ordered_date_time).toLocaleString()) : "",
            "case_mgmt_specialist": util.nullcheck(responseval.case_mgmt_specialist)
          };
          request.where.evaluationid = intakeservicerequestevaluationid;
          request.where.outputfilename = restitutionno+"_"+"acknowledgmenttransferjurisdictionrestitutionaccount";

          Response = module.exports.generatepdf(request, html, reqjson);

        }
        return Response;
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
};

//IHAS monthly report PDF

// acknowledgement letter
module.exports.IhasMonthlyReport = function (request) {
  var intakeserviceid = request.where.intakeserviceid;
  var securityuserid = app.currentUser.userprofile.fullname;

  const sql = 'select * from getihasmonthlyreportdetailsprint($1)';
  let Response;
  let reqjson = {};
  var html = fs.readFileSync('./documenttemplates/monthly-report.html','utf8');
  return util.executeDBQuery(sql,[intakeserviceid])
    .then(data => {
      if (data.length > 0) {
        var monthlyreportsdetails = data[0];
        var monthlyreport = data[0].ihasprovidedmonthlyreportdaysconfig;
        var serviceplanrate = data[0].l_serviceplanrate;
        var choreonly = '';
        var personcareonly = '';
        var heavyChore = '';
        var generalTransport = '';
        var medicalTransport = '';
        var therapeuticParent = '';
        var therapeuticAdult = '';
        var respiteCare = '';
        var clientServices = '';
        var directServices = '';
        var aideTravelHours = '';
        var aideHoursMiscellaneous = '';
        var tasksPerformed = '';
        var aideTimeOut = '';
        var aideTimeIn = '';
        var choreOnlyTotal = '';
        var choretotal = '';
        var personalrate = '';
        var chorerate = '';
        var respiterate = '';
        var nursingrate = '';
        var personalCareOnlyTotal = '';
        var personalCaretotal = '';
        var heavychoreOnlyTotal = '';
        var heavychoretotal = '';
        var generalOnlyTotal = '';
        var generaltotal = '';
        var medicalOnlyTotal = '';
        var medicaltotal = '';
        var parentAideOnlyTotal = '';
        var parentAidetotal = '';
        var adultAideOnlyTotal = '';
        var adultAidetotal = '';
        var respitecareOnlyTotal = '';
        var respitecaretotal = '';
        var clientRelatedServicesOnlyTotal = '';
        var clientRelatedServicestotal = '';


        for (const element of monthlyreport) {
          LOGGER.debug(element.activitykey);
          switch (element.activitykey) {
            case 'Chore Only':
              choreonly = '<td>' + util.nullcheck(element.day01) + '</td><td>' + util.nullcheck(element.day02) + '</td><td>' + util.nullcheck(element.day03) + '</td><td>' + util.nullcheck(element.day04) + '</td><td>' + util.nullcheck(element.day05) + '</td><td>' + util.nullcheck(element.day06) + '</td><td>' +
                util.nullcheck(element.day07) + '</td><td>' + util.nullcheck(element.day08) + '</td><td>' + util.nullcheck(element.day09) + '</td><td>' +
                util.nullcheck(element.day10) + '</td><td>' + util.nullcheck(element.day11) + '</td><td>' + util.nullcheck(element.day12) + '</td><td>' + util.nullcheck(element.day13) + '</td><td>' +
                util.nullcheck(element.day14) + '</td><td>' + util.nullcheck(element.day15) + '</td><td>' + util.nullcheck(element.day16) + '</td><td>' + util.nullcheck(element.day17) +
                '</td><td>' + util.nullcheck(element.day18) + '</td><td>' + util.nullcheck(element.day19) + '</td><td>' + util.nullcheck(element.day20) + '</td><td>' + util.nullcheck(element.day21) +
                '</td><td>' + util.nullcheck(element.day22) + '</td><td>' + util.nullcheck(element.day23) + '</td><td>' + util.nullcheck(element.day24) + '</td><td>' + util.nullcheck(element.day25) + '</td><td>' + util.nullcheck(element.day26) +
                '</td><td>' + util.nullcheck(element.day27) + '</td><td>' + util.nullcheck(element.day28) + '</td><td>' + util.nullcheck(element.day29) + '</td><td>' + util.nullcheck(element.day30) + '</td><td>' + util.nullcheck(element.day31) + '</td>';
              choreOnlyTotal = element.categorytotal;
              choretotal = element.total;
              break;
            case 'Personal Care Only':
              personcareonly = '<td>' + util.nullcheck(element.day01) + '</td><td>' + util.nullcheck(element.day02) + '</td><td>' + util.nullcheck(element.day03) + '</td><td>' + util.nullcheck(element.day04) + '</td><td>' + util.nullcheck(element.day05) + '</td><td>' + util.nullcheck(element.day06) + '</td><td>' +
                util.nullcheck(element.day07) + '</td><td>' + util.nullcheck(element.day08) + '</td><td>' + util.nullcheck(element.day09) + '</td><td>' +
                util.nullcheck(element.day10) + '</td><td>' + util.nullcheck(element.day11) + '</td><td>' + util.nullcheck(element.day12) + '</td><td>' + util.nullcheck(element.day13) + '</td><td>' +
                util.nullcheck(element.day14) + '</td><td>' + util.nullcheck(element.day15) + '</td><td>' + util.nullcheck(element.day16) + '</td><td>' + util.nullcheck(element.day17) +
                '</td><td>' + util.nullcheck(element.day18) + '</td><td>' + util.nullcheck(element.day19) + '</td><td>' + util.nullcheck(element.day20) + '</td><td>' + util.nullcheck(element.day21) +
                '</td><td>' + util.nullcheck(element.day22) + '</td><td>' + util.nullcheck(element.day23) + '</td><td>' + util.nullcheck(element.day24) + '</td><td>' + util.nullcheck(element.day25) + '</td><td>' + util.nullcheck(element.day26) +
                '</td><td>' + util.nullcheck(element.day27) + '</td><td>' + util.nullcheck(element.day28) + '</td><td>' + util.nullcheck(element.day29) + '</td><td>' + util.nullcheck(element.day30) + '</td><td>' + util.nullcheck(element.day31) + '</td>';
              personalCareOnlyTotal = element.categorytotal;
              personalCaretotal = element.total;
              break;
            case 'Heavy Chore':
              heavyChore = '<td>' + util.nullcheck(element.day01) + '</td><td>' + util.nullcheck(element.day02) + '</td><td>' + util.nullcheck(element.day03) + '</td><td>' + util.nullcheck(element.day04) + '</td><td>' + util.nullcheck(element.day05) + '</td><td>' + util.nullcheck(element.day06) + '</td><td>' +
                util.nullcheck(element.day07) + '</td><td>' + util.nullcheck(element.day08) + '</td><td>' + util.nullcheck(element.day09) + '</td><td>' +
                util.nullcheck(element.day10) + '</td><td>' + util.nullcheck(element.day11) + '</td><td>' + util.nullcheck(element.day12) + '</td><td>' + util.nullcheck(element.day13) + '</td><td>' +
                util.nullcheck(element.day14) + '</td><td>' + util.nullcheck(element.day15) + '</td><td>' + util.nullcheck(element.day16) + '</td><td>' + util.nullcheck(element.day17) +
                '</td><td>' + util.nullcheck(element.day18) + '</td><td>' + util.nullcheck(element.day19) + '</td><td>' + util.nullcheck(element.day20) + '</td><td>' + util.nullcheck(element.day21) +
                '</td><td>' + util.nullcheck(element.day22) + '</td><td>' + util.nullcheck(element.day23) + '</td><td>' + util.nullcheck(element.day24) + '</td><td>' + util.nullcheck(element.day25) + '</td><td>' + util.nullcheck(element.day26) +
                '</td><td>' + util.nullcheck(element.day27) + '</td><td>' + util.nullcheck(element.day28) + '</td><td>' + util.nullcheck(element.day29) + '</td><td>' + util.nullcheck(element.day30) + '</td><td>' + util.nullcheck(element.day31) + '</td>';
              heavychoreOnlyTotal = element.categorytotal;
              heavychoretotal = element.total;
              break;
            case 'Trasportation/Escort General':
              generalTransport = '<td>' + util.nullcheck(element.day01) + '</td><td>' + util.nullcheck(element.day02) + '</td><td>' + util.nullcheck(element.day03) + '</td><td>' + util.nullcheck(element.day04) + '</td><td>' + util.nullcheck(element.day05) + '</td><td>' + util.nullcheck(element.day06) + '</td><td>' +
                util.nullcheck(element.day07) + '</td><td>' + util.nullcheck(element.day08) + '</td><td>' + util.nullcheck(element.day09) + '</td><td>' +
                util.nullcheck(element.day10) + '</td><td>' + util.nullcheck(element.day11) + '</td><td>' + util.nullcheck(element.day12) + '</td><td>' + util.nullcheck(element.day13) + '</td><td>' +
                util.nullcheck(element.day14) + '</td><td>' + util.nullcheck(element.day15) + '</td><td>' + util.nullcheck(element.day16) + '</td><td>' + util.nullcheck(element.day17) +
                '</td><td>' + util.nullcheck(element.day18) + '</td><td>' + util.nullcheck(element.day19) + '</td><td>' + util.nullcheck(element.day20) + '</td><td>' + util.nullcheck(element.day21) +
                '</td><td>' + util.nullcheck(element.day22) + '</td><td>' + util.nullcheck(element.day23) + '</td><td>' + util.nullcheck(element.day24) + '</td><td>' + util.nullcheck(element.day25) + '</td><td>' + util.nullcheck(element.day26) +
                '</td><td>' + util.nullcheck(element.day27) + '</td><td>' + util.nullcheck(element.day28) + '</td><td>' + util.nullcheck(element.day29) + '</td><td>' + util.nullcheck(element.day30) + '</td><td>' + util.nullcheck(element.day31) + '</td>';
              generalOnlyTotal = element.categorytotal;
              generaltotal = element.total;
              break;
            case 'Trasportation/Escort Medical':
              medicalTransport = '<td>' + util.nullcheck(element.day01) + '</td><td>' + util.nullcheck(element.day02) + '</td><td>' + util.nullcheck(element.day03) + '</td><td>' + util.nullcheck(element.day04) + '</td><td>' + util.nullcheck(element.day05) + '</td><td>' + util.nullcheck(element.day06) + '</td><td>' +
                util.nullcheck(element.day07) + '</td><td>' + util.nullcheck(element.day08) + '</td><td>' + util.nullcheck(element.day09) + '</td><td>' +
                util.nullcheck(element.day10) + '</td><td>' + util.nullcheck(element.day11) + '</td><td>' + util.nullcheck(element.day12) + '</td><td>' + util.nullcheck(element.day13) + '</td><td>' +
                util.nullcheck(element.day14) + '</td><td>' + util.nullcheck(element.day15) + '</td><td>' + util.nullcheck(element.day16) + '</td><td>' + util.nullcheck(element.day17) +
                '</td><td>' + util.nullcheck(element.day18) + '</td><td>' + util.nullcheck(element.day19) + '</td><td>' + util.nullcheck(element.day20) + '</td><td>' + util.nullcheck(element.day21) +
                '</td><td>' + util.nullcheck(element.day22) + '</td><td>' + util.nullcheck(element.day23) + '</td><td>' + util.nullcheck(element.day24) + '</td><td>' + util.nullcheck(element.day25) + '</td><td>' + util.nullcheck(element.day26) +
                '</td><td>' + util.nullcheck(element.day27) + '</td><td>' + util.nullcheck(element.day28) + '</td><td>' + util.nullcheck(element.day29) + '</td><td>' + util.nullcheck(element.day30) + '</td><td>' + util.nullcheck(element.day31) + '</td>';
              medicalOnlyTotal = element.categorytotal;
              medicaltotal = element.total;
              break;
            case 'Therapeutic Parent Aide':
              therapeuticParent = '<td>' + util.nullcheck(element.day01) + '</td><td>' + util.nullcheck(element.day02) + '</td><td>' + util.nullcheck(element.day03) + '</td><td>' + util.nullcheck(element.day04) + '</td><td>' + util.nullcheck(element.day05) + '</td><td>' + util.nullcheck(element.day06) + '</td><td>' +
                util.nullcheck(element.day07) + '</td><td>' + util.nullcheck(element.day08) + '</td><td>' + util.nullcheck(element.day09) + '</td><td>' +
                util.nullcheck(element.day10) + '</td><td>' + util.nullcheck(element.day11) + '</td><td>' + util.nullcheck(element.day12) + '</td><td>' + util.nullcheck(element.day13) + '</td><td>' +
                util.nullcheck(element.day14) + '</td><td>' + util.nullcheck(element.day15) + '</td><td>' + util.nullcheck(element.day16) + '</td><td>' + util.nullcheck(element.day17) +
                '</td><td>' + util.nullcheck(element.day18) + '</td><td>' + util.nullcheck(element.day19) + '</td><td>' + util.nullcheck(element.day20) + '</td><td>' + util.nullcheck(element.day21) +
                '</td><td>' + util.nullcheck(element.day22) + '</td><td>' + util.nullcheck(element.day23) + '</td><td>' + util.nullcheck(element.day24) + '</td><td>' + util.nullcheck(element.day25) + '</td><td>' + util.nullcheck(element.day26) +
                '</td><td>' + util.nullcheck(element.day27) + '</td><td>' + util.nullcheck(element.day28) + '</td><td>' + util.nullcheck(element.day29) + '</td><td>' + util.nullcheck(element.day30) + '</td><td>' + util.nullcheck(element.day31) + '</td>';
              parentAideOnlyTotal = element.categorytotal;
              parentAidetotal = element.total;
              break;
            case 'Therapeutic Adult Aide':
              therapeuticAdult = '<td>' + util.nullcheck(element.day01) + '</td><td>' + util.nullcheck(element.day02) + '</td><td>' + util.nullcheck(element.day03) + '</td><td>' + util.nullcheck(element.day04) + '</td><td>' + util.nullcheck(element.day05) + '</td><td>' + util.nullcheck(element.day06) + '</td><td>' +
                util.nullcheck(element.day07) + '</td><td>' + util.nullcheck(element.day08) + '</td><td>' + util.nullcheck(element.day09) + '</td><td>' +
                util.nullcheck(element.day10) + '</td><td>' + util.nullcheck(element.day11) + '</td><td>' + util.nullcheck(element.day12) + '</td><td>' + util.nullcheck(element.day13) + '</td><td>' +
                util.nullcheck(element.day14) + '</td><td>' + util.nullcheck(element.day15) + '</td><td>' + util.nullcheck(element.day16) + '</td><td>' + util.nullcheck(element.day17) +
                '</td><td>' + util.nullcheck(element.day18) + '</td><td>' + util.nullcheck(element.day19) + '</td><td>' + util.nullcheck(element.day20) + '</td><td>' + util.nullcheck(element.day21) +
                '</td><td>' + util.nullcheck(element.day22) + '</td><td>' + util.nullcheck(element.day23) + '</td><td>' + util.nullcheck(element.day24) + '</td><td>' + util.nullcheck(element.day25) + '</td><td>' + util.nullcheck(element.day26) +
                '</td><td>' + util.nullcheck(element.day27) + '</td><td>' + util.nullcheck(element.day28) + '</td><td>' + util.nullcheck(element.day29) + '</td><td>' + util.nullcheck(element.day30) + '</td><td>' + util.nullcheck(element.day31) + '</td>';
              adultAideOnlyTotal = element.categorytotal;
              adultAidetotal = element.total;
              break;
            case 'Respite Care':
              respiteCare = '<td>' + util.nullcheck(element.day01) + '</td><td>' + util.nullcheck(element.day02) + '</td><td>' + util.nullcheck(element.day03) + '</td><td>' + util.nullcheck(element.day04) + '</td><td>' + util.nullcheck(element.day05) + '</td><td>' + util.nullcheck(element.day06) + '</td><td>' +
                util.nullcheck(element.day07) + '</td><td>' + util.nullcheck(element.day08) + '</td><td>' + util.nullcheck(element.day09) + '</td><td>' +
                util.nullcheck(element.day10) + '</td><td>' + util.nullcheck(element.day11) + '</td><td>' + util.nullcheck(element.day12) + '</td><td>' + util.nullcheck(element.day13) + '</td><td>' +
                util.nullcheck(element.day14) + '</td><td>' + util.nullcheck(element.day15) + '</td><td>' + util.nullcheck(element.day16) + '</td><td>' + util.nullcheck(element.day17) +
                '</td><td>' + util.nullcheck(element.day18) + '</td><td>' + util.nullcheck(element.day19) + '</td><td>' + util.nullcheck(element.day20) + '</td><td>' + util.nullcheck(element.day21) +
                '</td><td>' + util.nullcheck(element.day22) + '</td><td>' + util.nullcheck(element.day23) + '</td><td>' + util.nullcheck(element.day24) + '</td><td>' + util.nullcheck(element.day25) + '</td><td>' + util.nullcheck(element.day26) +
                '</td><td>' + util.nullcheck(element.day27) + '</td><td>' + util.nullcheck(element.day28) + '</td><td>' + util.nullcheck(element.day29) + '</td><td>' + util.nullcheck(element.day30) + '</td><td>' + util.nullcheck(element.day31) + '</td>';
              respitecareOnlyTotal = element.categorytotal;
              respitecaretotal = element.total;
              break;
            case 'Other Client Related Services':
              clientServices = '<td>' + util.nullcheck(element.day01) + '</td><td>' + util.nullcheck(element.day02) + '</td><td>' + util.nullcheck(element.day03) + '</td><td>' + util.nullcheck(element.day04) + '</td><td>' + util.nullcheck(element.day05) + '</td><td>' + util.nullcheck(element.day06) + '</td><td>' +
                util.nullcheck(element.day07) + '</td><td>' + util.nullcheck(element.day08) + '</td><td>' + util.nullcheck(element.day09) + '</td><td>' +
                util.nullcheck(element.day10) + '</td><td>' + util.nullcheck(element.day11) + '</td><td>' + util.nullcheck(element.day12) + '</td><td>' + util.nullcheck(element.day13) + '</td><td>' +
                util.nullcheck(element.day14) + '</td><td>' + util.nullcheck(element.day15) + '</td><td>' + util.nullcheck(element.day16) + '</td><td>' + util.nullcheck(element.day17) +
                '</td><td>' + util.nullcheck(element.day18) + '</td><td>' + util.nullcheck(element.day19) + '</td><td>' + util.nullcheck(element.day20) + '</td><td>' + util.nullcheck(element.day21) +
                '</td><td>' + util.nullcheck(element.day22) + '</td><td>' + util.nullcheck(element.day23) + '</td><td>' + util.nullcheck(element.day24) + '</td><td>' + util.nullcheck(element.day25) + '</td><td>' + util.nullcheck(element.day26) +
                '</td><td>' + util.nullcheck(element.day27) + '</td><td>' + util.nullcheck(element.day28) + '</td><td>' + util.nullcheck(element.day29) + '</td><td>' + util.nullcheck(element.day30) + '</td><td>' + util.nullcheck(element.day31) + '</td>';
              clientRelatedServicesOnlyTotal = element.categorytotal;
              clientRelatedServicestotal = element.total;
              break;
            case 'Total Direct Service Hours':
              directServices = '<td>' + util.nullcheck(element.day01) + '</td><td>' + util.nullcheck(element.day02) + '</td><td>' + util.nullcheck(element.day03) + '</td><td>' + util.nullcheck(element.day04) + '</td><td>' + util.nullcheck(element.day05) + '</td><td>' + util.nullcheck(element.day06) + '</td><td>' +
                util.nullcheck(element.day07) + '</td><td>' + util.nullcheck(element.day08) + '</td><td>' + util.nullcheck(element.day09) + '</td><td>' +
                util.nullcheck(element.day10) + '</td><td>' + util.nullcheck(element.day11) + '</td><td>' + util.nullcheck(element.day12) + '</td><td>' + util.nullcheck(element.day13) + '</td><td>' +
                util.nullcheck(element.day14) + '</td><td>' + util.nullcheck(element.day15) + '</td><td>' + util.nullcheck(element.day16) + '</td><td>' + util.nullcheck(element.day17) +
                '</td><td>' + util.nullcheck(element.day18) + '</td><td>' + util.nullcheck(element.day19) + '</td><td>' + util.nullcheck(element.day20) + '</td><td>' + util.nullcheck(element.day21) +
                '</td><td>' + util.nullcheck(element.day22) + '</td><td>' + util.nullcheck(element.day23) + '</td><td>' + util.nullcheck(element.day24) + '</td><td>' + util.nullcheck(element.day25) + '</td><td>' + util.nullcheck(element.day26) +
                '</td><td>' + util.nullcheck(element.day27) + '</td><td>' + util.nullcheck(element.day28) + '</td><td>' + util.nullcheck(element.day29) + '</td><td>' + util.nullcheck(element.day30) + '</td><td>' + util.nullcheck(element.day31) + '</td>';
              break;
            case 'Aide Travel Hours':
              aideTravelHours = '<td>' + util.nullcheck(element.day01) + '</td><td>' + util.nullcheck(element.day02) + '</td><td>' + util.nullcheck(element.day03) + '</td><td>' + util.nullcheck(element.day04) + '</td><td>' + util.nullcheck(element.day05) + '</td><td>' + util.nullcheck(element.day06) + '</td><td>' +
                util.nullcheck(element.day07) + '</td><td>' + util.nullcheck(element.day08) + '</td><td>' + util.nullcheck(element.day09) + '</td><td>' +
                util.nullcheck(element.day10) + '</td><td>' + util.nullcheck(element.day11) + '</td><td>' + util.nullcheck(element.day12) + '</td><td>' + util.nullcheck(element.day13) + '</td><td>' +
                util.nullcheck(element.day14) + '</td><td>' + util.nullcheck(element.day15) + '</td><td>' + util.nullcheck(element.day16) + '</td><td>' + util.nullcheck(element.day17) +
                '</td><td>' + util.nullcheck(element.day18) + '</td><td>' + util.nullcheck(element.day19) + '</td><td>' + util.nullcheck(element.day20) + '</td><td>' + util.nullcheck(element.day21) +
                '</td><td>' + util.nullcheck(element.day22) + '</td><td>' + util.nullcheck(element.day23) + '</td><td>' + util.nullcheck(element.day24) + '</td><td>' + util.nullcheck(element.day25) + '</td><td>' + util.nullcheck(element.day26) +
                '</td><td>' + util.nullcheck(element.day27) + '</td><td>' + util.nullcheck(element.day28) + '</td><td>' + util.nullcheck(element.day29) + '</td><td>' + util.nullcheck(element.day30) + '</td><td>' + util.nullcheck(element.day31) + '</td>';
              break;
            case 'Aide Hours Miscellaneous Admin':
              aideHoursMiscellaneous = '<td>' + util.nullcheck(element.day01) + '</td><td>' + util.nullcheck(element.day02) + '</td><td>' + util.nullcheck(element.day03) + '</td><td>' + util.nullcheck(element.day04) + '</td><td>' + util.nullcheck(element.day05) + '</td><td>' + util.nullcheck(element.day06) + '</td><td>' +
                util.nullcheck(element.day07) + '</td><td>' + util.nullcheck(element.day08) + '</td><td>' + util.nullcheck(element.day09) + '</td><td>' +
                util.nullcheck(element.day10) + '</td><td>' + util.nullcheck(element.day11) + '</td><td>' + util.nullcheck(element.day12) + '</td><td>' + util.nullcheck(element.day13) + '</td><td>' +
                util.nullcheck(element.day14) + '</td><td>' + util.nullcheck(element.day15) + '</td><td>' + util.nullcheck(element.day16) + '</td><td>' + util.nullcheck(element.day17) +
                '</td><td>' + util.nullcheck(element.day18) + '</td><td>' + util.nullcheck(element.day19) + '</td><td>' + util.nullcheck(element.day20) + '</td><td>' + util.nullcheck(element.day21) +
                '</td><td>' + util.nullcheck(element.day22) + '</td><td>' + util.nullcheck(element.day23) + '</td><td>' + util.nullcheck(element.day24) + '</td><td>' + util.nullcheck(element.day25) + '</td><td>' + util.nullcheck(element.day26) +
                '</td><td>' + util.nullcheck(element.day27) + '</td><td>' + util.nullcheck(element.day28) + '</td><td>' + util.nullcheck(element.day29) + '</td><td>' + util.nullcheck(element.day30) + '</td><td>' + util.nullcheck(element.day31) + '</td>';
              break;
            case 'Indicate Codes(s) for Tasks Performed':
              tasksPerformed = '<td>' + util.nullcheck(element.day01) + '</td><td>' + util.nullcheck(element.day02) + '</td><td>' + util.nullcheck(element.day03) + '</td><td>' + util.nullcheck(element.day04) + '</td><td>' + util.nullcheck(element.day05) + '</td><td>' + util.nullcheck(element.day06) + '</td><td>' +
                util.nullcheck(element.day07) + '</td><td>' + util.nullcheck(element.day08) + '</td><td>' + util.nullcheck(element.day09) + '</td><td>' +
                util.nullcheck(element.day10) + '</td><td>' + util.nullcheck(element.day11) + '</td><td>' + util.nullcheck(element.day12) + '</td><td>' + util.nullcheck(element.day13) + '</td><td>' +
                util.nullcheck(element.day14) + '</td><td>' + util.nullcheck(element.day15) + '</td><td>' + util.nullcheck(element.day16) + '</td><td>' + util.nullcheck(element.day17) +
                '</td><td>' + util.nullcheck(element.day18) + '</td><td>' + util.nullcheck(element.day19) + '</td><td>' + util.nullcheck(element.day20) + '</td><td>' + util.nullcheck(element.day21) +
                '</td><td>' + util.nullcheck(element.day22) + '</td><td>' + util.nullcheck(element.day23) + '</td><td>' + util.nullcheck(element.day24) + '</td><td>' + util.nullcheck(element.day25) + '</td><td>' + util.nullcheck(element.day26) +
                '</td><td>' + util.nullcheck(element.day27) + '</td><td>' + util.nullcheck(element.day28) + '</td><td>' + util.nullcheck(element.day29) + '</td><td>' + util.nullcheck(element.day30) + '</td><td>' + util.nullcheck(element.day31) + '</td>';
              break;
            case 'AIDE TIME OUT':
              aideTimeOut = '<td>' + util.nullcheck(element.day01) + '</td><td>' + util.nullcheck(element.day02) + '</td><td>' + util.nullcheck(element.day03) + '</td><td>' + util.nullcheck(element.day04) + '</td><td>' + util.nullcheck(element.day05) + '</td><td>' + util.nullcheck(element.day06) + '</td><td>' +
                util.nullcheck(element.day07) + '</td><td>' + util.nullcheck(element.day08) + '</td><td>' + util.nullcheck(element.day09) + '</td><td>' +
                util.nullcheck(element.day10) + '</td><td>' + util.nullcheck(element.day11) + '</td><td>' + util.nullcheck(element.day12) + '</td><td>' + util.nullcheck(element.day13) + '</td><td>' +
                util.nullcheck(element.day14) + '</td><td>' + util.nullcheck(element.day15) + '</td><td>' + util.nullcheck(element.day16) + '</td><td>' + util.nullcheck(element.day17) +
                '</td><td>' + util.nullcheck(element.day18) + '</td><td>' + util.nullcheck(element.day19) + '</td><td>' + util.nullcheck(element.day20) + '</td><td>' + util.nullcheck(element.day21) +
                '</td><td>' + util.nullcheck(element.day22) + '</td><td>' + util.nullcheck(element.day23) + '</td><td>' + util.nullcheck(element.day24) + '</td><td>' + util.nullcheck(element.day25) + '</td><td>' + util.nullcheck(element.day26) +
                '</td><td>' + util.nullcheck(element.day27) + '</td><td>' + util.nullcheck(element.day28) + '</td><td>' + util.nullcheck(element.day29) + '</td><td>' + util.nullcheck(element.day30) + '</td><td>' + util.nullcheck(element.day31) + '</td>';
              break;
            case 'AIDE TIME IN':
              aideTimeIn = '<td>' + util.nullcheck(element.day01) + '</td><td>' + util.nullcheck(element.day02) + '</td><td>' + util.nullcheck(element.day03) + '</td><td>' + util.nullcheck(element.day04) + '</td><td>' + util.nullcheck(element.day05) + '</td><td>' + util.nullcheck(element.day06) + '</td><td>' +
                util.nullcheck(element.day07) + '</td><td>' + util.nullcheck(element.day08) + '</td><td>' + util.nullcheck(element.day09) + '</td><td>' +
                util.nullcheck(element.day10) + '</td><td>' + util.nullcheck(element.day11) + '</td><td>' + util.nullcheck(element.day12) + '</td><td>' + util.nullcheck(element.day13) + '</td><td>' +
                util.nullcheck(element.day14) + '</td><td>' + util.nullcheck(element.day15) + '</td><td>' + util.nullcheck(element.day16) + '</td><td>' + util.nullcheck(element.day17) +
                '</td><td>' + util.nullcheck(element.day18) + '</td><td>' + util.nullcheck(element.day19) + '</td><td>' + util.nullcheck(element.day20) + '</td><td>' + util.nullcheck(element.day21) +
                '</td><td>' + util.nullcheck(element.day22) + '</td><td>' + util.nullcheck(element.day23) + '</td><td>' + util.nullcheck(element.day24) + '</td><td>' + util.nullcheck(element.day25) + '</td><td>' + util.nullcheck(element.day26) +
                '</td><td>' + util.nullcheck(element.day27) + '</td><td>' + util.nullcheck(element.day28) + '</td><td>' + util.nullcheck(element.day29) + '</td><td>' + util.nullcheck(element.day30) + '</td><td>' + util.nullcheck(element.day31) + '</td>';
              break;
          }
        }
        for (const element of serviceplanrate) {
          switch (element.servicetsubtypename) {
            case 'PERSONAL':
              personalrate = util.nullcheck(element.rate);
              break;
            case 'CHORES':
              chorerate = util.nullcheck(element.rate);
              break;
            case 'RESPITE':
              respiterate = util.nullcheck(element.rate);
              break;
            case 'NURSING CARE':
              nursingrate = util.nullcheck(element.rate);
              break;

          }
        }

        reqjson = {
          root_template_path_style: app.baseurl,
          root_template_path_image: app.baseurl,
          caseworkername: securityuserid,
          clientname: util.nullcheck(monthlyreportsdetails.displayname),
          clientid: util.nullcheck(monthlyreportsdetails.cjamspid),
          providername: util.nullcheck(monthlyreportsdetails.providername),
          // complaintdate : util.nullcheck(util.formatDate(new Date(responseval.complaintdate))),
          provideraddress: util.nullcheck(monthlyreportsdetails.provideraddress),
          providercity: util.nullcheck(monthlyreportsdetails.providercity),
          providerstate: util.nullcheck(monthlyreportsdetails.providerstate),
          providerzipcode: util.nullcheck(monthlyreportsdetails.providerzipcode),
          providerphoneno: util.nullcheck(monthlyreportsdetails.providerphoneno),
          categoryihasfamily: util.nullcheck(monthlyreportsdetails.categoryihasfamily),
          categoryihasadults: util.nullcheck(monthlyreportsdetails.categoryihasadults),
          categoryeligible: util.nullcheck(monthlyreportsdetails.categoryeligible),
          categoryihasanothereservice: util.nullcheck(monthlyreportsdetails.categoryihasanothereservice),
          providerihasfamily: util.nullcheck(monthlyreportsdetails.providerihasfamily),
          providerihasadults: util.nullcheck(monthlyreportsdetails.providerihasadults),
          providereligible: util.nullcheck(monthlyreportsdetails.providereligible),
          providerihasanothereservice: util.nullcheck(monthlyreportsdetails.providerihasanothereservice),
          pca: util.nullcheck(monthlyreportsdetails.pca),
          agencyobject: util.nullcheck(monthlyreportsdetails.agencyobject),
          ldsssignature: util.nullcheck(monthlyreportsdetails.ldsssignature),
          aidesignature: util.nullcheck(monthlyreportsdetails.aidesignature),
          caregiversignature: util.nullcheck(monthlyreportsdetails.caregiversignature),
          caregiversigndate: util.nullcheck(util.formatDate(new Date(monthlyreportsdetails.caregiversigndate))),
          ldsssignaturedate: util.nullcheck(util.formatDate(new Date(monthlyreportsdetails.ldsssignaturedate))),
          aidesignaturedate: util.nullcheck(util.formatDate(new Date(monthlyreportsdetails.aidesignaturedate))),
          accountclerksign: util.nullcheck(monthlyreportsdetails.accountclerksign),
          providerssn: util.nullcheck(monthlyreportsdetails.providerssn),
          reportedmonthyear: util.nullcheck(monthlyreportsdetails.reportedmonthyear),
          totalinvoiceamount: util.nullcheck(monthlyreportsdetails.totalinvoiceamount),
          categoryIhasFamily: util.nullcheck(monthlyreportsdetails.categoryihasfamily),
          categoryIhasAdults: util.nullcheck(monthlyreportsdetails.categoryihasadults),
          categoryEligible: util.nullcheck(monthlyreportsdetails.categoryeligible),
          categoryIhasAnothereService: util.nullcheck(monthlyreportsdetails.categoryihasanothereservice),
          providerIhasFamily: util.nullcheck(monthlyreportsdetails.providerihasfamily),
          providerIhasAdults: util.nullcheck(monthlyreportsdetails.providerihasadults),
          providerEligible: util.nullcheck(monthlyreportsdetails.providereligible),
          providerIhasAnothereService: util.nullcheck(monthlyreportsdetails.providerihasanothereservice),
          htmlChoreonly: choreonly,
          htmlpersoncareonly: personcareonly,
          htmlheavyChore: heavyChore,
          htmlgeneraltransport: generalTransport,
          htmlmedicaltransport: medicalTransport,
          htmltherapeuticParent: therapeuticParent,
          htmltherapeuticAdult: therapeuticAdult,
          htmlrespiteCare: respiteCare,
          htmlclientServices: clientServices,
          htmldirectServices: directServices,
          htmlaideTravelHours: aideTravelHours,
          htmlaideHoursMiscellaneous: aideHoursMiscellaneous,
          htmltasksPerformed: tasksPerformed,
          htmlaideTimeOut: aideTimeOut,
          htmlaideTimeIn: aideTimeIn,
          htmlchoreOnlyTotal: choreOnlyTotal,
          htmlchoretotal: choretotal,
          htmlpersonalrate: personalrate,
          htmlchorerate: chorerate,
          htmlrespiterate: respiterate,
          htmlnursingrate: nursingrate,
          htmlpersonalCareOnlyTota: personalCareOnlyTotal,
          htmlpersonalCaretotal: personalCaretotal,
          htmlheavychoreOnlyTotal: heavychoreOnlyTotal,
          htmlheavychoretotal: heavychoretotal,
          htmlgeneralOnlyTotal: generalOnlyTotal,
          htmlgeneraltotal: generaltotal,
          htmlmedicalOnlyTotal: medicalOnlyTotal,
          htmlmedicalTotal: medicaltotal,
          htmlparentAideOnlyTotal: parentAideOnlyTotal,
          htmlparentAidetotal: parentAidetotal,
          htmladultAideOnlyTotal: adultAideOnlyTotal,
          htmladultAidetotal: adultAidetotal,
          htmlrespitecareOnlyTotal: respitecareOnlyTotal,
          htmlrespitecaretotal: respitecaretotal,
          htmlclientRelatedServicesOnlyTotal: clientRelatedServicesOnlyTotal,
          htmlclientRelatedServicestotal: clientRelatedServicestotal,
          // htmldirectServicesOnlyTotal:directServicesOnlyTotal,
          //htmldirectServicestotal:directServicestotal,
          //htmlaideTravelHoursOnlyTotal:aideTravelHoursOnlyTotal,
          //htmlaideTravelHourstotal:aideTravelHourstotal,
          //htmlmiscellaneousOnlyTotal:miscellaneousOnlyTotal,
          //htmlmiscellaneoustotal:miscellaneoustotal,
          // htmltasksPerformedOnlyTotal:tasksPerformedOnlyTotal,
          //htmltasksPerformedtotal:tasksPerformedtotal,
          //htmlaideTimeOutOnlyTotal:aideTimeOutOnlyTotal,
          //htmlaideTimeOuttotal:aideTimeOuttotal,
          //htmlaideTimeInOnlyTotal:aideTimeInOnlyTotal,
          //htmlaideTimeIntotal:aideTimeIntotal
        };
      }
      request.where.outputfilename = "monthly-report";
      Response = module.exports.generatepdf(request,html,reqjson);
      return Response;
    })
    .catch(err => {
        LOGGER.error(err);
        return err;
    })
};

module.exports.paymentauthorization = async function (request) {
  var paymentid = request.where.paymentid;

  const sql = 'select * from getpaymentdocument($1)';
  let Response;
  let restitutionjson;
  let payername;
  let memofirstname;
  let payeraddress;
  let payercity;
  let payerstatekey;
  let payerzipcode;
  let accountarea;
  let checknumber;

  try {
    const data = await util.executeDBQuery(sql, [paymentid]);
    if (data.length > 0) {
      restitutionjson = data[0];
      payername = util.nullcheck(restitutionjson.payername);
      memofirstname = util.nullcheck(restitutionjson.memofirstname);
      payeraddress = util.nullcheck(restitutionjson.payeraddress);
      payercity = util.nullcheck(restitutionjson.payercity);
      payerstatekey = util.nullcheck(restitutionjson.payerstatekey);
      payerzipcode = util.nullcheck(restitutionjson.payerzipcode);
      accountarea = util.nullcheck(restitutionjson.accountarea);
      checknumber = util.nullcheck(restitutionjson.checknumber);
    }
    var html = fs.readFileSync('./documenttemplates/Payment-Authorization-Slip.html', 'utf8');

    html = html.replace(/{{payername}}/g, payername);
    html = html.replace(/{{memofirstname}}/g, memofirstname);
    html = html.replace(/{{payeraddress}}/g, payeraddress);
    html = html.replace(/{{payercity}}/g, payercity);
    html = html.replace(/{{payerstatekey}}/g, payerstatekey);
    html = html.replace(/{{payerzipcode}}/g, payerzipcode);
    html = html.replace(/{{accountarea}}/g, accountarea);
    html = html.replace(/{{checknumber}}/g, checknumber);
    Response = module.exports.generatepdf(request, html);
    return Response;
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
};

module.exports.servicepurchaseauthorizations = function (request, response) {
  var caseNumber = request.where.daNumber;
  var clientid = request.where.clientid;
  var servicelogid =  request.where.service_log_id;
  var roleid = request.where.roletypekey;
  request.where.roleid = request.where.roletypekey;
  var html = fs.readFileSync('./documenttemplates/servicelogpurchaseauthreport.html', 'utf8');
  const sql = 'SELECT * FROM get_service_log_auths($1,$2,$3,$4)';
  let reqjson = {};
  return util.executeDBQuery(sql, [caseNumber,roleid,clientid,servicelogid])
    .then(data => {
      if (data.length > 0) {
        reqjson = data[0];
        reqjson.courtorder = (reqjson.courtorder && reqjson.courtorder === 'Y') ? true : false;
        reqjson.service_end_reason_cd = reqjson.service_end_reason_cd ? true : false;
        reqjson.no_service_reason_cd = reqjson.no_service_reason_cd ? true : false;
        if(Array.isArray(reqjson.purchaseauths)) {
          reqjson.purchaseauths.forEach(purauth => {
            if(purauth.purchaseauthreq){
              purauth.rundate = purauth.purchaseauthreq.rundate;
              purauth.providerid = purauth.purchaseauthreq.provider_id;
              purauth.taxidno= purauth.purchaseauthreq.tax_id_no;
              purauth.providernm = purauth.purchaseauthreq.provider_nm;
              purauth.provideraddress = purauth.purchaseauthreq.provider_address;
              purauth.providerph = util.formatPhoneNumber(util.nullcheck(purauth.purchaseauthreq.provider_ph));
              purauth.casename = purauth.purchaseauthreq.casename;
              purauth.clientname = purauth.purchaseauthreq.clientname;
              purauth.servicenm = purauth.purchaseauthreq.service_nm;
              purauth.caseid = purauth.purchaseauthreq.case_id;
              purauth.justificationtx = purauth.purchaseauthreq.justification_tx;
              purauth.fiscalcategorydesc = purauth.purchaseauthreq.fiscal_category_desc;
              purauth.cfecareduration = purauth.purchaseauthreq.cfecareduration;
              purauth.costno = purauth.purchaseauthreq.cost_no;
              purauth.paymentid = purauth.purchaseauthreq.payment_id;
              purauth.startdt = purauth.purchaseauthreq.start_dt;
              purauth.enddt = purauth.purchaseauthreq.end_dt;
              purauth.vouchersw = purauth.purchaseauthreq.voucher_sw;
              purauth.finalamount = util.nullcheck(purauth.purchaseauthreq.final_amount_no);
              purchaseauthreqCheck(purauth);
              purchaseauthreqPaymentCheck(purauth);
            }
          });
        }
      }    
    reqjson.root_template_path_logo = app.baseurl;
    reqjson.service_log_id = servicelogid;
    reqjson.clientid = clientid;  
    request.where.outputfilename = "serviceauthorization-" + servicelogid;
    Response = module.exports.generatepdf(request, html, reqjson, { type: 'report', res: response });
    return Response;
    })
    .catch(err => {
        util.logError(err);
        LOGGER.error(err);
        return err;
    })
};

function purchaseauthreqCheck(purauth){
  if(purauth.purchaseauthreq.case_worker) {
    purauth.cwlocaldepartment = purauth.purchaseauthreq.case_worker.localdepartment;
    purauth.cwaddress = purauth.purchaseauthreq.case_worker.address;
    purauth.cwfullname = purauth.purchaseauthreq.case_worker.fullname;
    purauth.cwrequestorphone = util.formatPhoneNumber(util.nullcheck(purauth.purchaseauthreq.case_worker.requestorphone));
    purauth.cwrequestorname = purauth.purchaseauthreq.case_worker.requestorname;
  }
  if(purauth.purchaseauthreq.supervisor !=null) {            
    purauth.supervisordate = util.nullcheck(purauth.purchaseauthreq.supervisor.insertedon);
    purauth.supervisorname = purauth.supervisordate == '' ? '' : util.nullcheck(purauth.purchaseauthreq.supervisor.fullname);
  }
  if(purauth.finalamount) {
    purauth.finalamount = '$'+purauth.finalamount;
  }
  if(purauth.purchaseauthreq.funding) {
    purauth.fundingdate = util.nullcheck(purauth.purchaseauthreq.funding.insertedon);
    purauth.fundingname = purauth.fundingdate == '' ? '' : util.nullcheck(purauth.purchaseauthreq.funding.fullname);                
  }    
  
  if (purauth.purchaseauthreq.director) {
    purauth.directordate = util.nullcheck(purauth.purchaseauthreq.director.insertedon);
    purauth.directorname = purauth.directordate == '' ? '' : util.nullcheck(purauth.purchaseauthreq.director.fullname);
  }
}

function purchaseauthreqPaymentCheck(purauth){
  if(purauth.purchaseauthreq.payment) {
    purauth.paymentdate = util.nullcheck(purauth.purchaseauthreq.payment.insertedon);
    purauth.paymentname = purauth.paymentdate == '' ? '' : util.nullcheck(purauth.purchaseauthreq.payment.fullname);
  }    
  if (purauth.costno >= 1000) {
    if (purauth.cwlocaldepartment === 'Baltimore City' && purauth.costno < 5000) {
      purauth.director = '<div class="col-xs-6"><div class="row"><div class="frm"><span><b>Program manager</b></span><span>' + purauth.directorname + dtspantags + purauth.directordate + dtspanendtags
    } else {
      purauth.director = '<div class="col-xs-6"><div class="row"><div class="frm"><span><b>Director</b></span><span>' + purauth.directorname + dtspantags + purauth.directordate + dtspanendtags
    }
  } 
  if (purauth.costno < 1000) {
    purauth.director = '<div class="col-xs-6"><div class="row"><div class="frm"><span><b>Director : N/A</b></span></div><div class="frm"></div></div></div>'
  }
}

module.exports.Purchaseauthorization = function (request,response) {
  var authorizationid = request.where.authorizationid;
  var isapproved = request.where.isapproved;
  var status = request.where.status;
  var statustext = '';
  if (isapproved == null || isapproved == undefined || !isapproved) {
    isapproved = false;
    statustext = '<span class="denied">' + String(util.nullcheck(status)).toUpperCase() + '</span>';
  }
  else {
    statustext = '<span class="approved">' + String(util.nullcheck(status)).toUpperCase() + '</span>';
  }

  const sql = 'select * from get_authorization_request($1,$2)';

  let Response;
  let authorizationjson;
  let caseworkerjson;
  let case_id;
  let authorization_id;
  let provider_id;
  let provider_nm;
  let provider_ph;
  let adr_street_no;
  let adr_street_nm;
  let adr_city_nm;
  let adr_state_cd;
  let adr_zip5_no;
  let fullname = ' ';
  let phonenumber = ' ';
  let localdepartment = ' ';
  let client_id;
  let ssno;
  let justification_tx;
  let fiscaldesc;
  let cfecareduration;
  let startdt;
  let enddt;
  let costno;
  let voucher;
  let service_nm;
  let caseworkeraddress = ' ';
  let requestorname = ' ';
  let requestorphone = ' ';
  let clientname;
  let provideraddress = ' ';

  let casename;
  let director = ' ';
  let rundate;
  let service_log_id;
  let payment_id;

  return util.executeDBQuery(sql,[authorizationid,isapproved])
    .then(data => {
      let nameCheck = {};
      if (data.length > 0) {
        authorizationjson = data[0];
        caseworkerjson = authorizationjson.case_worker;
        rundate = authorizationjson.rundate;
        case_id = util.nullcheck(authorizationjson.case_id);
        ssno = util.nullcheck(authorizationjson.tax_id_no);
        authorization_id = util.nullcheck(authorizationjson.authorization_id);
        provider_id = util.nullcheck(authorizationjson.provider_id);
        provider_nm = util.nullcheck(authorizationjson.provider_nm);
        provider_ph = util.formatPhoneNumber(util.nullcheck(authorizationjson.provider_ph));
        adr_street_no = util.nullcheck(authorizationjson.adr_street_no);
        adr_street_nm = util.nullcheck(authorizationjson.adr_street_nm);
        adr_state_cd = util.nullcheck(authorizationjson.adr_state_cd);
        adr_zip5_no = util.nullcheck(authorizationjson.adr_zip5_no);
        service_log_id = util.nullcheck(authorizationjson.service_log_id);
        if (caseworkerjson) {
          fullname = util.nullcheck(caseworkerjson.fullname);
          phonenumber = util.formatPhoneNumber(util.nullcheck(caseworkerjson.requestorphone));
          localdepartment = util.nullcheck(caseworkerjson.localdepartment);
          caseworkeraddress = util.nullcheck(caseworkerjson.address);
          caseworkeraddress = util.nullcheck(caseworkerjson.address);
          requestorname = util.nullcheck(caseworkerjson.requestorname);
          requestorphone = util.formatPhoneNumber(util.nullcheck(caseworkerjson.requestorphone));
        }

        client_id = util.nullcheck(authorizationjson.client_id);
        justification_tx = util.nullcheck(authorizationjson.justification_tx);
        fiscaldesc = util.nullcheck(authorizationjson.fiscal_category_desc);
        cfecareduration = util.nullcheck(authorizationjson.cfecareduration);
        startdt = util.nullcheck(authorizationjson.start_dt);
        enddt = util.nullcheck(authorizationjson.end_dt);
        costno = util.nullcheck(authorizationjson.cost_no);
        voucher = util.nullcheck(authorizationjson.voucher_sw);

        service_nm = util.nullcheck(authorizationjson.service_nm);
        clientname = util.nullcheck(authorizationjson.clientname);
        casename = util.nullcheck(authorizationjson.casename);

        nameCheck = nameDateCheck(authorizationjson);


        provideraddress = util.nullcheck(authorizationjson.provider_address);
        payment_id = util.nullcheck(authorizationjson.payment_id);
        director = getdirector(costno,localdepartment,nameCheck);
        LOGGER.debug(director)

      }
      var html = fs.readFileSync('./documenttemplates/purchaseauthreport.html','utf8');

      const insertedon = new Date().toLocaleString();
      html = html.replace(logopath,app.baseurl);
      html = html.replace(/{{case_id}}/g,case_id);
      html = html.replace(/{{authorization_id}}/g,authorization_id);
      html = html.replace(/{{provider_id}}/g,provider_id);
      html = html.replace(/{{provider_nm}}/g,provider_nm);
      html = html.replace(/{{provider_ph}}/g,provider_ph);
      html = html.replace(/{{adr_street_no}}/g,adr_street_no);
      html = html.replace(/{{adr_street_nm}}/g,adr_street_nm);
      html = html.replace(/{{adr_city_nm}}/g,adr_city_nm);
      html = html.replace(/{{adr_state_cd}}/g,adr_state_cd);
      html = html.replace(/{{adr_zip5_no}}/g,adr_zip5_no);
      html = html.replace(/{{localdepartment}}/g,localdepartment);
      html = html.replace(/{{fullname}}/g,fullname);
      html = html.replace(/{{phonenumber}}/g,phonenumber);
      html = html.replace(/{{client_id}}/g,client_id);
      html = html.replace(/{{adr_state_cd}}/g,adr_state_cd);
      html = html.replace(/{{justification_tx}}/g,justification_tx);
      html = html.replace(/{{fiscaldesc}}/g,fiscaldesc);
      html = html.replace(/{{cfecareduration}}/g,cfecareduration);
      html = html.replace(/{{startdt}}/g,startdt);
      html = html.replace(/{{enddt}}/g,enddt);
      html = html.replace(/{{costno}}/g,costno);
      html = html.replace(/{{voucher}}/g,voucher);
      html = html.replace(/{{finalamount}}/g,nameCheck.finalamount);
      html = html.replace(/{{service_nm}}/g,service_nm);
      html = html.replace(/{{insertedon}}/g,insertedon);
      html = html.replace(/{{caseworkeraddress}}/g,caseworkeraddress);
      html = html.replace(/{{clientname}}/g,clientname);
      html = html.replace(/{{provideraddress}}/g,provideraddress);
      html = html.replace(/{{supervisorname}}/g,nameCheck.supervisorname);
      html = html.replace(/{{supervisordate}}/g,nameCheck.supervisordate);
      html = html.replace(/{{fundingname}}/g,nameCheck.fundingname);
      html = html.replace(/{{fundingdate}}/g,nameCheck.fundingdate);
      html = html.replace(/{{paymentname}}/g,nameCheck.paymentname);
      html = html.replace(/{{paymentdate}}/g,nameCheck.paymentdate);
      html = html.replace(/{{requestorname}}/g,requestorname);
      html = html.replace(/{{requestorphone}}/g,requestorphone);

      html = html.replace(/{{casename}}/g,casename);
      html = html.replace(/{{director}}/g,director);
      html = html.replace(/{{rundate}}/g,rundate);
      html = html.replace(/{{ssno}}/g,ssno);
      html = html.replace(/{{service_log_id}}/g,service_log_id);
      html = html.replace(/{{payment_id}}/g,payment_id);
      html = html.replace(/{{status}}/g,statustext);

      request.where.outputfilename = "authorization-" + authorizationid;
      Response = module.exports.generatepdf(request,html,{},{ type: 'report',res: response });
      return Response;
    })
    .catch(err => {
      util.logError(err)
      LOGGER.error(err);
      return err;
    })
};

function getdirector(costno,localdepartment,nameCheck) {
  let director = ' ';
  if (costno >= 1000) {
    if (localdepartment === 'Baltimore City' && costno < 5000) {
      director = '<div class="col-xs-6"><div class="row"><div class="frm"><span><b>Program manager</b></span><span>' + nameCheck.directorname + dtspantags + nameCheck.directordate + dtspanendtags
    } else {
      director = '<div class="col-xs-6"><div class="row"><div class="frm"><span><b>Director</b></span><span>' + nameCheck.directorname + dtspantags + nameCheck.directordate + dtspanendtags
    }
  }
  if (costno < 1000) {
    director = '<div class="col-xs-6"><div class="row"><div class="frm"><span><b>Director : N/A</b></span></div><div class="frm"></div></div></div>'
  }
  return director;
}

function nameDateCheck(authorizationjson) {
  let finalamount = util.nullcheck(authorizationjson.final_amount_no);
  const supervisor = authorizationjson.supervisor;
  const funding = authorizationjson.funding;
  const payment = authorizationjson.payment;
  const directorjson = authorizationjson.director;


  let supervisorname = ' ';
  let supervisordate = ' ';
  let directorname = ' ';
  let directordate = ' ';
  let fundingname = ' ';
  let fundingdate = ' ';
  let paymentname = ' ';
  let paymentdate = ' ';

  if (finalamount) {
    finalamount = '$' + finalamount;
  }
  if (supervisor != null) {
    supervisordate = util.nullcheck(supervisor.insertedon);
    supervisorname = supervisordate === '' ? '' : util.nullcheck(supervisor.fullname);
  }
  if (funding) {
    fundingdate = util.nullcheck(funding.insertedon);
    fundingname = fundingdate === '' ? '' : util.nullcheck(funding.fullname);
  }
  if (payment) {
    paymentdate = util.nullcheck(payment.insertedon);
    paymentname = paymentdate === '' ? '' : util.nullcheck(payment.fullname);
  }
  if (directorjson) {
    directordate = util.nullcheck(directorjson.insertedon);
    directorname = directordate === '' ? '' : util.nullcheck(directorjson.fullname);
  }
  return {
    finalamount,
    supervisordate,
    supervisorname,
    fundingdate,
    fundingname,
    paymentdate,
    paymentname,
    directordate,
    directorname
  }

}

module.exports.cfePaymentReport = function (request,response) {
  var ancillaryservicesid = request.where.ancillaryservicesid;
  const sql = ` SELECT ans.ancillaryservicesid,
                      ans.alternateid,
                      ans.paymenttype,
                      tpv.value_tx AS paymenttypevalue,
                      to_char(ans.startdate, 'MM/DD/YYYY') as startdate,
                      ans.insertedon,
                      to_char(ans.enddate, 'MM/DD/YYYY') as enddate,
                      ans.noofbeds,	
                      ans.costnotexceed,	
                      ans."comments",	
                      ans.finalamount,	
                      ans.financecategorycode,	
                      coalesce(tfcm.fiscal_category_desc, '') || ' (' || tfcm.fiscal_category_cd || ')' AS financecategorydescriptionwithcode,
                      ans.updatedby,	
                      ans.updatedon,	
                      ans.insertedby,	
                      ans.insertedon,
                      ans.providerserviceid,
                      ans.paymentid,
                      (
                        SELECT row_to_json(X) 
                        FROM   (
                          select TBS.Provider_ID as ProviderID 
                              , TBS.provider_service_id
                              , case when (PVR.Provider_nm is null or (PVR.provider_nm='')) then concat(PVR.provider_first_nm,' ', PVR.provider_last_nm) else PVR.provider_nm end AS ProviderName
                              , PVR.tax_id_no AS TaxID
                              , (select provider_adr from get_provider_address(TBS.provider_id::integer,trim('{3357,3356}')))
                          FROM prov.TB_PROVIDER_SERVICES TBS 
                          INNER JOIN prov.tb_provider PVR ON PVR.Provider_id = TBS.Provider_id and PVR.delete_sw='N' 
                          WHERE provider_service_id = ans.providerserviceid
                            AND PVR.provider_status_cd = '1791' AND PVR.delete_sw='N' 
                            AND TBS.start_dt <= now()::date AND TBS.delete_sw='N' 
                            AND ((TBS.end_dt is null) or (TBS.end_dt >= now()::date)) 
                          LIMIT 1
                        ) AS X
                      )::jsonb providerinfo,
                      (select json_agg(v) as routinginfo from (
                          select routingstatustypeid,
                          r2.insertedon,
                          r2.updatedon as updatedon,  
                          LEAD(r2.routingstatustypeid,1) OVER (
                            ORDER BY r2.insertedon
                          ) nextroutingstatustypeid,
                          r2.fromsecurityusersid,
                          (	select up.firstname || ' ' || up.lastname 
                            from userprofile up 
                            where up.securityusersid::character varying  = r2.fromsecurityusersid
                              and up.activeflag=1 
                          ) as requestorname,
                          r2.tosecurityusersid,
                          (	select up.firstname || ' ' || up.lastname 
                            from userprofile up 
                            where up.securityusersid::character varying  = r2.tosecurityusersid
                              and up.activeflag=1 
                          ) as approvername,
                          rt1.description as fromrole,
                          rt2.description as torole
                          from routing r2 
                          left join role rt1 on rt1.roletypekey=r2.fromroleid
                          left join role rt2 on rt2.roletypekey=r2.toroleid
                          where r2.objectid = ans.ancillaryservicesid:: character varying 
                          order by r2.insertedon desc
                      ) as v) ::jsonb as routinginfo
                FROM cjams.ancillaryservices ans
                INNER JOIN prov.TB_PROVIDER_SERVICES PS ON PS.provider_service_id = ans.providerserviceid
			          INNER JOIN prov.tb_provider PR ON PR.Provider_id = PS.Provider_id and PR.delete_sw='N' and pr.provider_status_cd = '1791'  and PS.delete_sw='N'
                left join routing r on r.objectid = ans.ancillaryservicesid:: character varying 
                LEFT JOIN cjams.tb_picklist_values tpv ON tpv.picklist_type_id = 2 AND tpv.picklist_value_cd = ans.paymenttype AND tpv.delete_sw = 'N'
			          LEFT JOIN cjams.tb_fiscal_category_master tfcm ON tfcm.fiscal_category_cd = ans.financecategorycode AND tfcm.delete_sw = 'N'
                WHERE ans.ancillaryservicesid = $1 `;

  let Response;
  let inputjson;

  return util.executeDBQuery(sql,[ancillaryservicesid])
    .then(data => {
      if (data.length > 0) {
        inputjson = data[0];
        var html = fs.readFileSync('./documenttemplates/cfepaymentreport.html','utf8');
        html = html.replace(logopath,app.baseurl);
        html = html.replace(/{{authorization_id}}/g,inputjson.alternateid);
        html = html.replace(/{{provider_id}}/g,inputjson.providerinfo.providerid);
        html = html.replace(/{{provider_nm}}/g,inputjson.providerinfo.providername);
        html = html.replace(/{{provideraddress}}/g,emptyStrCheck(inputjson.providerinfo.provider_adr));
        html = html.replace(/{{ssno}}/g,inputjson.providerinfo.taxid);
        html = html.replace(/{{justification_tx}}/g,inputjson.comments);
        html = html.replace(/{{fiscaldesc}}/g,inputjson.financecategorydescriptionwithcode);
        html = html.replace(/{{startdt}}/g,inputjson.startdate);
        html = html.replace(/{{enddt}}/g,inputjson.enddate);
        html = html.replace(/{{costno}}/g,inputjson.costnotexceed);
        html = html.replace(/{{payment_type}}/g,emptyStrCheck(inputjson.paymenttypevalue));
        html = html.replace(/{{noofbeds}}/g,emptyStrCheck(inputjson.noofbeds));

        inputjson.routinginfo.forEach(element => {
          switch (element.routingstatustypeid) {
            case 110:
              html = html.replace(/{{workername}}/g,element.requestorname);
              html = html.replace(/{{requestedon}}/g,moment(element.updatedon).format("MM/DD/YYYY hh:mm A"));
              html = html.replace(/{{rundate}}/g,moment(element.insertedon).format("MM/DD/YYYY hh:mm A"));
              break;
            case 111:
              html = html.replace(/{{supervisorname}}/g,element.requestorname);
              html = html.replace(/{{approvedon}}/g,moment(element.insertedon).format("MM/DD/YYYY hh:mm A"));
              break;
            case 112:
              html = html.replace(/{{fundapprovername}}/g,element.requestorname);
              html = html.replace(/{{fundapprovedon}}/g,moment(element.insertedon).format("MM/DD/YYYY hh:mm A"));
              break;
            case 113:
              html = html.replace(/{{paymentapprovername}}/g,element.requestorname);
              html = html.replace(/{{paymentapprovedon}}/g,moment(element.insertedon).format("MM/DD/YYYY hh:mm A"));
              break;
          }
        })

        if (html.includes('{{fundapprovername}}')) {
          html = html.replace(/{{fundapprovername}}/g,'');
          html = html.replace(/{{fundapprovedon}}/g,'');
        }

        if (html.includes('{{paymentapprovername}}')) {
          html = html.replace(/{{paymentapprovername}}/g,'');
          html = html.replace(/{{paymentapprovedon}}/g,'');
        }
        request.where.outputfilename = "cfepayment-" + ancillaryservicesid;
        Response = module.exports.generatepdf(request,html,{},{ type: 'report',res: response });
        return Response;
      }
    })
    .catch(_err => {
      util.logError(_err)
      LOGGER.error(_err);
      return _err;
    });
};

module.exports.overpaymentnotice = function (request,response,_securityusersid) {
  var providerid = request.where.provider_id;
  var receivabledetailid = request.where.receivable_detail_id;
  const currentdate = util.formatDate(new Date().toISOString().slice(0,10));
  var noticetemplatename = 'overpayment1';
  var v_collection_status_cd = '776';
  switch (request.where.notice_type) {
    case '1':
      noticetemplatename = 'overpayment1'
      break;
    case '2':
      noticetemplatename = 'overpayment2'
      v_collection_status_cd = '777';
      break;
    case '3':
      noticetemplatename = 'overpayment3'
      v_collection_status_cd = '778';
      break;
    case 'Offset':
      noticetemplatename = 'overpayment-now-offset'
      v_collection_status_cd = '779';
      break;
    case 'Recovery':
      noticetemplatename = 'overpayment-now-recovery'
      v_collection_status_cd = '780';
      break;
    case 'Debt Referral Notice':
    case 'Reffered to CCU':
      noticetemplatename = 'debt-referral-notice'
      v_collection_status_cd = '775';
      break;
    case 'A/R Balance Notice':
      noticetemplatename = 'ar-balance-notice'
      break;

  }

  const sql = "select * from getpaymentnotice($1,$2,$3,$4)";

  let Response;
  let providername = "";
  let provideraddress = "";
  let balancenotice;
  let overpaidamount = 0;
  let placementdetails = "";
  let totalbal = "";
  let paymentdate = "";
  let startdate = "";
  let amount = "";
  let receivableamount = "";
  let percentageno = "";
  let reciptDate = "";
  let userstreetaddress = "";
  let usercityandState = "";
  let userPhoneNumber = "";

  return util.executeDBQuery(sql,[providerid,receivabledetailid,v_collection_status_cd,_securityusersid])
    .then(data => {
      if (data.length > 0) {
        providername = util.nullcheck(data[0].providername);
        provideraddress = util.nullcheck(data[0].provideraddress);
        totalbal = util.nullcheck(data[0].totalbal);
        paymentdate = util.nullcheck(data[0].paymentdate);
        startdate = util.nullcheck(data[0].startdate);
        amount = util.nullcheck(data[0].amount);
        receivableamount = util.nullcheck(data[0].receivablebalanceno);
        percentageno = util.nullcheck(data[0].percentageno);
        reciptDate = util.nullcheck(data[0].reciptdate);
        userstreetaddress = util.nullcheck(data[0].useraddress?.[0].address);
        usercityandState = util.nullcheck(data[0].useraddress?.[0].city) + ', '
          + util.nullcheck(data[0].useraddress?.[0].state);
        userPhoneNumber = util.nullcheck(util.formatPhoneNumber(data[0].useraddress?.[0].phonenumber));

        if (returnPaymentdetailsFn(data)) {
          data[0].paymentdetails.map(element => {
            if (returnReciptDateFn(reciptDate)) {
              reciptDate = util.nullcheck(element.receiptdate);
            }
            overpaidamount = parseFloat(util.nullcheck(overpaidamount)) + parseFloat(util.nullcheck(element.receivable_balance_no));
            placementdetails = placementdetails + `<tr>
            <td style="border:1px solid black;" valign="top">${util.nullcheck(element.childname)}</td>
            <td style="border:1px solid black;" valign="top">${util.nullcheck(element.cjamspid)}</td>
            <td style="border:1px solid black;" valign="top">${util.nullcheck(element.service)}</td>
            <td style="border:1px solid black;" valign="top">${util.nullcheck(dateCheck(element.start_dt,'MM-DD-yyyy'))}</td>
            <td style="border:1px solid black;" valign="top">${util.nullcheck(dateCheck(element.end_dt,'MM-DD-yyyy'))}</td>
            <td style="border:1px solid black;" valign="top">${util.nullcheck(element.payment_id)}</td>
            <td style="border:1px solid black;" valign="top">${util.nullcheck(element.payment_dt)}</td>
            <td style="border:1px solid black;" valign="top">$${util.nullcheck(element.receivable_balance_no)}</td>
            <td style="border:1px solid black;" valign="top">${util.nullcheck(element.county)}</td>
            </tr>`
          })
        }
        balancenotice = balancenoticeCheck(data,userstreetaddress,usercityandState);
      }

      var html = fs.readFileSync(
        `./documenttemplates/${noticetemplatename}.html`,
        "utf8"
      );

      html = html.replace(/{{root_template_path_style}}/g,app.baseurl);
      html = html.replace(/{{providername}}/g,providername);
      html = html.replace(/{{provideraddress}}/g,provideraddress);
      html = html.replace(/{{overpaidamount}}/g,overpaidamount);
      html = html.replace(/{{userPhoneNumber}}/g,userPhoneNumber);
      html = html.replace(/{{depthead}}/g,balancenotice.depthead);
      html = html.replace(/{{localdept}}/g,balancenotice.localdept);
      html = html.replace(/{{localdeptFinance}}/g,balancenotice.localdeptFinance);
      html = html.replace(/{{streetaddress}}/g,balancenotice.streetaddress);
      html = html.replace(/{{cityandState}}/g,balancenotice.cityandState);
      html = html.replace(/{{currentpaidamount}}/g,balancenotice.currentpaidamount);
      html = html.replace(/{{currentpaiddate}}/g,balancenotice.currentpaiddate);
      html = html.replace(/{{placementdetails}}/g,placementdetails);
      html = html.replace(/{{currentdate}}/g,currentdate);
      html = html.replace(/{{totalbal}}/g,totalbal);
      html = html.replace(/{{paymentdate}}/g,paymentdate);
      html = html.replace(/{{startdate}}/g,startdate);
      html = html.replace(/{{amount}}/g,amount);
      html = html.replace(/{{receivableamount}}/g,receivableamount);
      html = html.replace(/{{percentageno}}/g,percentageno);
      html = html.replace(/{{reciptDate}}/g,reciptDate);

      request.where.outputfilename = "overpayment-" + receivabledetailid;

      // Check format and route accordingly
      if (request.where.format === 'PDF') {
        Response = module.exports.generatepdf(
          request,
          html,
          {},
          { type: "report", res: response }
        );
      } else {
        // Handle DOCX        
        Response = module.exports.generatedocx(html);
      }
      return Response;
    })
    .catch(err => {
      LOGGER.error(err);
      util.logError(err);
      return err;
    })
};

function returnReciptDateFn(reciptDate) {
  return reciptDate == null || reciptDate === undefined || reciptDate === '';
}

function returnPaymentdetailsFn(data) {
  return data[0].paymentdetails && data[0].paymentdetails.length > 0;
}

function balancenoticeCheck(data,userstreetaddress,usercityandState) {
  let localdept = "";
  let localdeptFinance = "";
  let depthead = "";
  let streetaddress = "";
  let cityandState = "";
  let currentpaidamount = "";
  let currentpaiddate = "";

  if (data[0].balancenotice && data[0].balancenotice.length > 0) {
    data[0].balancenotice.map(element => {
      localdept = util.nullcheck(element.localdept);
      if (localdept === 'Baltimore City Department of Social Services') {
        depthead = 'Debra Dandridge Joyce';
        localdeptFinance = localdept + ', Finance';
        streetaddress = userstreetaddress;
        cityandState = usercityandState;
      } else if (localdept === 'Garrett County Department of Social Services') {
        localdeptFinance = localdept;
        streetaddress = userstreetaddress;
        cityandState = usercityandState;
      } else {
        localdeptFinance = localdept + ', Finance';
        streetaddress = userstreetaddress;
        cityandState = usercityandState;
      }
      currentpaidamount = util.nullcheck(element.collected_amount_no);
      currentpaiddate = dateCheck(element.create_ts, dtformat);
    })
  }
  return {
    localdept,
    depthead,
    localdeptFinance,
    streetaddress,
    cityandState,
    currentpaidamount,
    currentpaiddate
  }
}

module.exports.child116report = function (request,response) {
  var clientaccountid = request.where.clientaccountid;

  const sql = 'select * from getchild116report($1,$2,$3,$4,$5,$6)';
  let Response;
  let childjson;
  let transactiondetails;
  let otherancillaryexcessdetails;
  let client_id;
  let ssn;
  let account_type_nm;
  let bank_nm;
  let account_no_tx;
  let total_balance_no;
  let status_nm;

  let total_obligated;
  let obligated_for_anc;
  let obligated_for_coc;

  let clientname;
  let dob;

  let rundate;
  let open_dt;
  let close_dt;
  let transactionelement = '';
  let ancillarydetails = '';
  let reimbursementdetails = '';

  return util.executeDBQuery(sql,[clientaccountid,1000,1,request.where.date_sw,request.where.date_from,request.where.date_to])
    .then(async data => {
      if (data.length > 0) {
        childjson = data[0];
        transactiondetails = util.nullcheck(childjson.transactiondetails);
        otherancillaryexcessdetails = util.nullcheck(childjson.otherancillaryexcessdetails);
        rundate = util.nullcheck(childjson.rundate);
        clientname = (util.nullcheck(childjson.clientfirstname) + ' ' + util.nullcheck(childjson.clientlastname));
        client_id = util.nullcheck(childjson.client_id);
        ssn = util.nullcheck(childjson.ssn);
        dob = util.nullcheck(childjson.dob);
        account_type_nm = util.nullcheck(childjson.account_type_nm);
        account_no_tx = util.nullcheck(childjson.account_no_tx);
        bank_nm = util.nullcheck(childjson.bank_nm);
        status_nm = util.nullcheck(childjson.status_nm);
        open_dt = util.nullcheck(childjson.open_dt);
        close_dt = util.nullcheck(childjson.close_dt);
        total_balance_no = util.nullcheck(currencyFormatter.format(childjson.total_balance_no,{ code: 'USD' }));
        obligated_for_anc = util.nullcheck(currencyFormatter.format(childjson.obligated_for_anc,{ code: 'USD' }));
        obligated_for_coc = util.nullcheck(currencyFormatter.format(childjson.obligated_for_coc,{ code: 'USD' }));
        total_obligated = util.nullcheck(currencyFormatter.format(childjson.total_obligated,{ code: 'USD' }));

        const details = getchild116Details(transactiondetails, otherancillaryexcessdetails);
        transactionelement += details.transactionelement; 
        ancillarydetails += details.ancillarydetails;
        reimbursementdetails += details.reimbursementdetails;
      }
      var html = ''
      const format = request.where.format;
      if (format == 'pdf') {
        html = fs.readFileSync('./documenttemplates/dhr116.html','utf8');
      }
      if (format == 'excel') {
        html = fs.readFileSync('./documenttemplates/dhr116forcsv.html','utf8');
      }

      LOGGER.debug(app.baseurl + baseurllogstmt);

      html = html.replace(logopath,app.baseurl);
      html = html.replace(/{{rundate}}/g,rundate);
      html = html.replace(/{{clientname}}/g,clientname);
      html = html.replace(/{{client_id}}/g,client_id);
      html = html.replace(/{{ssn}}/g,ssn);
      html = html.replace(/{{dob}}/g,dob);
      html = html.replace(/{{account_type_nm}}/g,account_type_nm);
      html = html.replace(/{{account_no_tx}}/g,account_no_tx);
      html = html.replace(/{{bank_nm}}/g,bank_nm);
      html = html.replace(/{{status_nm}}/g,status_nm);
      html = html.replace(/{{open_dt}}/g,open_dt);
      html = html.replace(/{{close_dt}}/g,close_dt);
      html = html.replace(/{{total_balance_no}}/g,total_balance_no);
      html = html.replace(/{{obligated_for_anc}}/g,obligated_for_anc);
      html = html.replace(/{{obligated_for_coc}}/g,obligated_for_coc);
      html = html.replace(/{{transactiondetails}}/g,transactionelement);
      html = html.replace(/{{ancillarydetails}}/g,ancillarydetails);
      html = html.replace(/{{reimbursementdetails}}/g,reimbursementdetails);
      html = html.replace(/{{total_obligated}}/g,total_obligated);
      request.where.outputfilename = "dhr116-" + clientaccountid;
      if (format == 'excel') {

        const workbook = new Excel.Workbook();
        const worksheet = workbook.addWorksheet(request.where.outputfilename);
        var imageId2 = workbook.addImage({
          buffer: fs.readFileSync(dhslogopath),
          extension: 'png',
        });
        LOGGER.debug(client_id + "client_id");
        worksheet.addImage(imageId2,'A1:B2');
        worksheet.getColumn(4).values = ['DHS 116 Child Account History Report'];
        worksheet.getRow(6).values = ['','Client ID',client_id,'','','Run Date',rundate];
        worksheet.getRow(7).values = ['','Client Name',clientname];
        worksheet.getRow(8).values = ['','DOB ',dob,'','','SSN',ssn];
        worksheet.getRow(9).values = ['',accounttypestr,account_type_nm,'','','Account Number',account_no_tx];
        worksheet.getRow(10).values = ['','Bank Name',bank_nm,'','','Account Status',status_nm];
        worksheet.getRow(11).values = ['','Open Date',open_dt,'','','Close Date',close_dt];
        worksheet.getRow(12).values = ['',totalbalancestr,total_balance_no,'','','Total Available for Cost of Care',obligated_for_coc];
        worksheet.getRow(13).values = ['','Total Obligated',total_obligated,'','','Total Available For Ancillary',obligated_for_anc];
        worksheet.getRow(15).values = ['Transactions'];
        worksheet.getRow(16).values = ['','Transaction ID','Entry Date','Benefit/Ancillary Month/Year','Transaction Type','Transaction Source','credit_debit','Amount'];
        let row = 17;
        if (Array.isArray(transactiondetails)) {
          transactiondetails.forEach(element => {
            var transaction_amount_no = currencyCheck(element.transaction_amount_no);
            worksheet.getRow(row).values = ['',element.transaction_id,element.benefit_start_dt,element.monthyear,element.transaction_type_nm,element.transaction_source_nm,element.credit_debit,transaction_amount_no];
            row += 1;
          });
        }
        row = row + 2;
        worksheet.getRow(15).values = ['Cost of Care Reimbursement'];
        row = row + 1;
        worksheet.getRow(row).values = ['','Benefit Month/Year','Receipts Available for COC','COC Reimbursement','Excess Available for Ancillary'];
        row = row + 1;
        if (Array.isArray(otherancillaryexcessdetails)) {
          otherancillaryexcessdetails.forEach(element => {
            worksheet.getRow(row).values = ['',element.benefitmonyear,currencyFormatter.format(element.receipts_for_coc,{ code: 'USD' }),currencyFormatter.format(element.coc_reimbursement,{ code: 'USD' }),currencyFormatter.format(element.excess_after_coc_reimbursement,{ code: 'USD' })];
            row += 1;

          });
        }
        row = row + 2;
        worksheet.getRow(15).values = ['Ancillary Services Child Account Funded'];
        row = row + 1;
        worksheet.getRow(row).values = ['','Transaction Month/Year','Receipts Available for Ancillary','Excess After COC Reimbursement','Obligations','Ancillary Payments','Balance Available for Ancillary'];
        row = row + 1;
        if (Array.isArray(otherancillaryexcessdetails)) {

          otherancillaryexcessdetails.forEach(element => {
            const balance_avail_for_ancillary = currencyCheck(element.balance_avail_for_ancillary);

            const receipts_for_anc = currencyCheck(element.receipts_for_anc);
            worksheet.getRow(row).values = ['',element.benefitmonyear,receipts_for_anc,currencyFormatter.format(element.excess_after_coc_reimbursement,{ code: 'USD' }),currencyFormatter.format(element.obligations,{ code: 'USD' }),currencyFormatter.format(element.ancillary_payments,{ code: 'USD' }),balance_avail_for_ancillary];
            row += 1;

          });
        }

        var fileName = `${request.where.outputfilename}.${request.where.format}`;
        response.setHeader(contenttypestr,spreadsheetcontenttype);
        response.setHeader(contentdispositionstr,attachmentstr + fileName);
        if (format === 'excel') {
          await workbook.xlsx.write(response)
            .then(() => response.end());
        } else if (format === 'csv') {
          await workbook.csv.write(response)
            .then(() => response.end());
        }
      } else {
        Response = module.exports.generatepdf(request,html,{},{
          type: 'report',
          res: response
        });
        return Response;
      }
    })
    .catch(err => {
      LOGGER.error(err);
      return err;
    });

};

function getchild116Details(transactiondetails, otherancillaryexcessdetails){
  let transactionelement = '';
  let ancillarydetails = '';
  let reimbursementdetails = '';
  if (Array.isArray(transactiondetails)) {
    transactiondetails.forEach(element => {
      const transaction_amount_no = currencyCheck(element.transaction_amount_no);
      transactionelement += '<tr><td>' + element.transaction_id + '</td><td>' + element.transaction_dt + '</td><td>' +
        element.monthyear + '</td><td>' + element.transaction_type_nm + '</td><td>' + element.transaction_source_nm + '</td><td>' + element.credit_debit + usdtag + transaction_amount_no + tdclosetags;
    });
  }
  if (Array.isArray(otherancillaryexcessdetails)) {
    otherancillaryexcessdetails.forEach(element => {
      const balance_avail_for_ancillary = currencyCheck(element.balance_avail_for_ancillary);
      const receipts_for_anc = currencyCheck(element.receipts_for_anc);
      ancillarydetails += '<tr><td>' + element.benefitmonyear + usdtag + currencyFormatter.format(element.receipts_for_coc,{ code: 'USD' }) +
        usdtag + currencyFormatter.format(element.actual_coc,{ code: 'USD' }) + usdtag +
        currencyFormatter.format(element.coc_reimbursement,{ code: 'USD' }) + usdtag + currencyFormatter.format(element.excess_after_coc_reimbursement,{ code: 'USD' }) + tdclosetags;
      reimbursementdetails = reimbursementdetails + '<tr><td>' + element.benefitmonyear + usdtag + receipts_for_anc + usdtag +
        currencyFormatter.format(element.excess_after_coc_reimbursement,{ code: 'USD' }) + usdtag + currencyFormatter.format(element.obligations,{ code: 'USD' }) + usdtag + currencyFormatter.format(element.ancillary_payments,{ code: 'USD' }) + usdtag + balance_avail_for_ancillary + tdclosetags;
    });
  }
  return {
    transactionelement,
    ancillarydetails,
    reimbursementdetails
  }
}

function currencyCheck(value){
  let balance;
  if (value) {
    balance = currencyFormatter.format(value,{ code: 'USD' });
  } else {
    balance = '$0.00';
  }
  return balance;
}

module.exports.child117report = function (request, response) {
  var commaccountid = request.where.commaccountid;
  var date_from = request.where.date_from;
  var date_to = request.where.date_to;
  var date_sw = request.where.date_sw;

  const sql = 'select * from get_child117report($1,$2,$3,$4)';
  let Response;
  let childjson;
  let transactiondetails;
  let bank_nm;
  let open_dt;
  let close_dt;
  let rundate;
  let account_type_nm = '';
  let account_no_tx;
  let total_balance_no;
  let status_nm;
  let fullname;
 
  let transactionelement = '';
  let interest_amount_no;
  let intereststartdate;
  let interestenddate;
  let account_type_cd;

  return util.executeDBQuery(sql, [commaccountid, date_sw, date_from, date_to])
    .then(async data => {
      if (data.length > 0) {
        childjson = data[0];
        transactiondetails = util.nullcheck(childjson.transactiondetails);
        rundate = util.nullcheck(childjson.rundate);
        bank_nm = util.nullcheck(childjson.bank_nm);
        open_dt = util.nullcheck(childjson.open_dt);
        close_dt = util.nullcheck(childjson.close_dt);
        account_no_tx = util.nullcheck(childjson.account_no_tx);
        status_nm = util.nullcheck(childjson.status_nm);
        account_type_cd = util.nullcheck(childjson.account_type_cd);
    
        status_nm = ((status_nm === '') && ((close_dt === '') || (close_dt !== '' && new Date(close_dt) >= new Date()))) ? 'Active' : 'Closed';

        intereststartdate = util.nullcheck(childjson.intereststartdate);
        interestenddate = util.nullcheck(childjson.interestenddate);
        interest_amount_no = util.nullcheck(childjson.interest_amount_no);
        interest_amount_no = currencyCheck(interest_amount_no);
        total_balance_no = util.nullcheck(childjson.total_balance_no);
        total_balance_no = currencyCheck(total_balance_no);
        fullname = util.nullcheck(childjson.fullname);
        
        const tdDetails = child117transactiondetailsCheck(transactiondetails, total_balance_no, interest_amount_no);
        account_type_nm = tdDetails.account_type_nm;
        transactionelement = tdDetails.transactionelement;
      }
      var html = ''
      const format = request.where.format;
      if (format == 'pdf') {
        html = fs.readFileSync('./documenttemplates/dhr117.html', 'utf8');
      }
      if (format == 'excel') {
        html = fs.readFileSync('./documenttemplates/dhr117forcsv.html', 'utf8');
      }
      html = html.replace(logopath, app.baseurl);
      html = html.replace(/{{rundate}}/g, rundate);
      html = html.replace(/{{bank_nm}}/g, bank_nm);
      html = html.replace(/{{open_dt}}/g, open_dt);
      html = html.replace(/{{close_dt}}/g, close_dt);
      html = html.replace(/{{account_type_cd}}/g, account_type_cd);
      html = html.replace(/{{account_no_tx}}/g, account_no_tx);
      html = html.replace(/{{status_nm}}/g, status_nm);
      html = html.replace(/{{total_balance_no}}/g, total_balance_no);
      html = html.replace(/{{interest_amount_no}}/g, interest_amount_no.slice(1)); //$ is added here and in dhr117.html template
      html = html.replace(/{{transactiondetails}}/g, transactionelement);
      html = html.replace(/{{intereststartdate}}/g, intereststartdate);
      html = html.replace(/{{interestenddate}}/g, interestenddate);
      html = html.replace(/{{fullname}}/g, fullname);

      request.where.outputfilename = "dhr117-" + commaccountid + " " + Date.now();

      if (format == 'excel') {
        const workbook = new Excel.Workbook();
        const worksheet = workbook.addWorksheet(request.where.outputfilename);
        var imageId2 = workbook.addImage({
          buffer: fs.readFileSync(dhslogopath),
          extension: 'png',
        });
        worksheet.addImage(imageId2, 'A1:B2');
        worksheet.getColumn(4).values = ['DHS 117 Commingled Account History Report'];
        worksheet.getRow(6).values = ['', 'Bank Name', bank_nm, '', '', 'Run Date', rundate];
        worksheet.getRow(7).values = ['', 'Open Date', open_dt, '', '', 'Close Date', close_dt];
        worksheet.getRow(8).values = ['', 'Account Number', account_no_tx, '', '', accounttypestr, account_type_nm];
        worksheet.getRow(9).values = ['', 'Account Status', status_nm, '', '', totalbalancestr, total_balance_no];
        let row = 10;
        const boldarray = ['D1', 'B6', 'F6', 'B7', 'F7', 'B8', 'F8', 'B9', 'F9'];
        const boldalparray = ['B', 'C', 'D', 'E'];
        const borderarray = ['B6', 'C6', 'F6', 'G6', 'B7', 'C7', 'F7', 'B8', 'C8', 'F8', 'B9', 'C9', 'F9', 'G9']
        if (close_dt) {
          borderarray.push('G7');
        }
        if (Array.isArray(transactiondetails)) {
          transactiondetails.forEach(element => {
            total_balance_no = currencyCheck(element.total_balance_no);
            interest_amount_no = currencyCheck(element.interest_amount_no);
            row += 1;
            boldalparray.forEach(ele => {
              boldarray.push(ele + row);
              borderarray.push(ele + row);
            });
            worksheet.getRow(row).values = ['', 'Client ID', 'Client Name', 'Sub-account Number', accounttypestr, totalbalancestr]
            row += 1;
            boldalparray.forEach(ele => {
              borderarray.push(ele + row);
            });
            worksheet.getRow(row).values = ['', util.nullcheck(element.client_id), util.nullcheck(element.clientfullname), util.nullcheck(element.account_no), util.nullcheck(element.account_type_nm), util.nullcheck(total_balance_no)]
            row += 2;
            boldalparray.forEach(ele => {
              boldarray.push(ele + row);
              borderarray.push(ele + row);
            });

            worksheet.getRow(row).values = ['', 'Interest Start Date', 'Interest End Date', 'Amount', 'Entered By']
            row += 1;
            boldalparray.forEach(ele => {
              borderarray.push(ele + row);
            });
            worksheet.getRow(row).values = ['', util.nullcheck(element.interestdetails[0].interest_start_dt), util.nullcheck(element.interestdetails[0].interest_end_dt), util.nullcheck(element.interestdetails[0].interest_amount_no), util.nullcheck(element.interestdetails[0].fullname)]
            row += 2;
          });
        }
        row += 2;
        boldarray.push('A' + row);
        worksheet.getRow(row).values = ['Lump Sum Interest from Commingled Account Interest Transaction (CA0152C)'];
        row += 1;
        boldalparray.forEach(element => {
          boldarray.push(element + row);
          borderarray.push(element + row);
        });
        worksheet.getRow(row).values = ['', 'Interest Start Date', 'Interest End Date', 'Amount', 'Entered By'];
        row += 1;
        boldalparray.forEach(element => {
          borderarray.push(element + row);
        });
        worksheet.getRow(row).values = ['', intereststartdate, interestenddate, interest_amount_no, fullname];
        boldarray.forEach(element => {
          worksheet.getCell(element).font = {
            bold: true
          };
        })

        borderarray.forEach(element => {
          worksheet.getCell(element).border = {
            top: { style: 'thin' },
            left: { style: 'thin' },
            bottom: { style: 'thin' },
            right: { style: 'thin' }
          };
        })
        const fileName = `${request.where.outputfilename}.${request.where.format}`;
        response.setHeader(contenttypestr, spreadsheetcontenttype);
        response.setHeader(contentdispositionstr, attachmentstr + fileName);
        await workbook.xlsx.write(response)
          .then(() => response.end());
      } else {
        const fileName = `${request.where.outputfilename}.${request.where.format}`;
        response.setHeader(contentdispositionstr, attachmentstr + fileName);
        Response = module.exports.generatepdf(request, html, {}, {
          type: 'report',
          res: response
        });
        return Response;
      }
    })
    .catch(err => {
        LOGGER.error(err);
        return err;
    })
};

function child117transactiondetailsCheck(transactiondetails, total_balance_no, interest_amount_no){
  let account_type_nm = '';
  let interestdetails;
  let transactionelement = '';
  if (Array.isArray(transactiondetails)) {
          
    transactiondetails.forEach(element => {
      if (account_type_nm !== '' && util.nullcheck(element.account_type_nm) !== '' && util.nullcheck(element.account_type_nm) !== account_type_nm)  {
      account_type_nm = account_type_nm + ', ' + util.nullcheck(element.account_type_nm);
      } else if (account_type_nm === '' && util.nullcheck(element.account_type_nm) !== '') {
        account_type_nm = util.nullcheck(element.account_type_nm);
      }
      interestdetails = element.interestdetails;
      total_balance_no = currencyCheck(element.total_balance_no);
      interest_amount_no = currencyCheck(element.interest_amount_no);

      transactionelement += '<div class="col-xs-12 m-t-30"><table><tr><th>Client ID</th><th>Client Name</th><th>Sub-account Number</th><th>Account Type</th><th>Total Balance</th> </tr><tr>' +
        '<td>' + util.nullcheck(element.client_id) + '</td>' + '<td align="right">' + util.nullcheck(element.clientfullname) + '</td>' + '<td align="right">' + util.nullcheck(element.account_no) + '</td>' + '<td align="right">'+ util.nullcheck(element.account_type_nm)+ usdtag + util.nullcheck(total_balance_no) + '</td> </tr></table>  </div><div class="col-xs-12 m-t-30"> <table><tr><th>Interest Start Date</th><th>Interest End Date</th><th>Amount</th> <th>Entered By</th> </tr>' 
        if (Array.isArray(interestdetails)){
          interestdetails.forEach(detail => {
            const amount_no = detail.interest_amount_no ? detail.interest_amount_no : '0.00';
            transactionelement += '<tr><td>' + util.nullcheck(detail.interest_start_dt) + '</td>' + '<td align="right">' + util.nullcheck(detail.interest_end_dt) + '</td> <td align="right">$' + util.nullcheck(amount_no) + '</td>' + '<td align="right">' + util.nullcheck(detail.fullname) + '</td> </tr>';
          })
        }
        transactionelement += '</table></div>';
         LOGGER.debug(transactionelement)
    });
  
  }
  return {
    account_type_nm,
    transactionelement,
    total_balance_no, 
    interest_amount_no
  }
}


module.exports.intakeProcessForm = function (request) {
  let reqjson = {};

  var html = fs.readFileSync('./documenttemplates/intake_process_form.html', 'utf8');
  reqjson = {
    root_template_path_style: app.baseurl,
    root_template_path_image: app.baseurl
  };
  request.where.outputfilename = 'intakeprocessform';
  return module.exports.generatepdf(request, html, reqjson);
};

//commom method to generate pdg from html
// No reqjson means there is no intake context at all; otherwise an intakeserviceid
// missing from the request is taken from reqjson when it carries one.
function gpResolveIntakeServiceId(reqjson, intakeserviceid) {
  if (!reqjson) {
    return null;
  }
  if (!util.nullcheck(intakeserviceid)) {
    return 'intakeserviceid' in reqjson ? reqjson.intakeserviceid : null;
  }
  return intakeserviceid;
}

function gpBuildRequestData(request, documentkey, destFileName, intakeserviceid) {
  const requestData = {
    "intakenumber": request.where.intakenumber,
    "intakeservicerequestevaluationid": null,
    "documenttemplatekey": documentkey,
    "documentpath": app.dataSources.localstorage.settings.accessurl + destFileName,
    "intakeserviceid": intakeserviceid
  };
  if (request.where.paymentid) {
    requestData.paymentid = request.where.paymentid;
  }
  return requestData;
}

// Report mode streams the PDF straight back on the caller's response object
// instead of persisting it.
async function gpStreamReportResponse(report, reqjson, html, css, options) {
  const pdfBuffer = await pdfGenerator(reqjson, html, css, options);
  if (!report.res.headersSent) {
    report.res.setHeader('Content-Type', 'application/pdf');
    report.res.setHeader('Content-Length', pdfBuffer.length);
    report.res.end(pdfBuffer);
  }

  report.res.json = () => report.res;
  report.res.jsonp = () => report.res;
  report.res.send = () => report.res;
}

// Writes the PDF under conname and resolves only once the stream has closed, so
// the caller never sees requestData before the file is fully flushed.
async function gpWritePdfToDisk(conname, destFileName, requestData, reqjson, html, css, options) {
  if (!fs.existsSync(conname)) {
    fs.mkdirSync(conname);
  }
  const res = fs.createWriteStream(conname + '/' + destFileName);
  try {
    const pdfBuffer = await pdfGenerator(reqjson, html, css, options);
    return await new Promise(resolve => {
      res.write(pdfBuffer);
      res.end();
      res.on('close', function () {
        resolve(requestData);
      });
    });
  } catch (err) {
    res.destroy();
    throw err;
  }
}

module.exports.generatepdf = async function (request, html, reqjson, report = null) {

  const documentkey = request.documntkey;
  const intakeserviceid = gpResolveIntakeServiceId(reqjson, request.where.intakeserviceid);

  reqjson = await getstateInfo(reqjson);

  const css = app.baseurl + cssurl;
  const conname = app.dataSources.localstorage.settings.root + '/docs';
  LOGGER.debug(conname + "conname");
  const destFileName = request.where.outputfilename + '-' + Date.now() + '.pdf';
  LOGGER.debug(app.baseurl + headerurl);

  const options = gpgetOptions(documentkey, report, request, reqjson);

  if (report && report.type === 'report') {
    return gpAftergenratePdf(report, await gpStreamReportResponse(report, reqjson, html, css, options));
  }

  const requestData = gpBuildRequestData(request, documentkey, destFileName, intakeserviceid);
  return gpAftergenratePdf(report, await gpWritePdfToDisk(conname, destFileName, requestData, reqjson, html, css, options));
};

function gpAftergenratePdf(report, requestData){
  if (report && report.type === 'report') {
    return requestData;
  } else {
    return app.models.Evaluationdocument.add(requestData, (err, data) => {
        err ? reject(err) : resolve(data);
      })
      .then(async data => {
        const documentpath = data.documentpath;
        if (requestData.paymentid) {
          var sql = "update restitutionpaymentflatfilecontent set documentpath=$1 where restitutionpaymentflatfilecontentid=$2"

          try {
            await util.executeDBQuery(sql, [documentpath, requestData.paymentid]);
          } catch (err) {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
          }
        }
        return data;

      }).then(data => {
        return data;
      })
  }
}

function gpgetOptions(documentkey, report, request, reqjson){
  let options ={};
  let htmlPageFooter = '';
  const isheaderrequired = request.where.isheaderrequired;
  options = isheaderrequired ? {
    "margin-top": "30mm",
    "margin-bottom": "25mm",
    "pageSize": 'A4',
    "header-html": app.baseurl + headerurl,
    "footer-html": app.baseurl + "/footer.html",
    "user-style-sheet": app.baseurl + cssurl,
    "debug": true
  } : {
    "pageSize": 'A4',
    "user-style-sheet": app.baseurl + cssurl
  };
  if (documentkey && documentkey.length > 0 && documentkey[0] === 'safecareplan')
  {
    options["margin-top"] = "10mm";
    options["margin-bottom"] = "15mm";
  }
  else{
    htmlPageFooter = app.baseurl + "/pagefooter.html";
  }
  if (documentkey === 'OffHistory') {
    options = {
      "orientation": 'Landscape',
      "margin-top": "30mm",
      "margin-bottom": "25mm",
      "pageSize": 'A4',
      "header-html": app.baseurl + headerurl,
      "footer-html": app.baseurl + "/footer.html",
      "user-style-sheet": app.baseurl + cssurl,
      "debug": true
    }
  }

  if (documentkey === 'child114report') {
    options = {
      "orientation": 'Landscape',
      "pageSize": 'A3',
      "debug": true
    }
  }
  if (documentkey === 'intakereport') {
    options = {
      "orientation": 'Landscape',
      "margin-top": "25mm",
      "margin-bottom": "15mm",
      "pageSize": 'A4',
      "header-html": app.baseurl + "/intakereport-header.html",
      "footer-html": app.baseurl + "/intakereport-footer.html",
      "user-style-sheet": app.baseurl + cssurl,
      "debug": true
    }
  }
 
  if(report && report.type === 'report'){
    options.orientation = reqjson.landscape ? 'Landscape' : 'Portrait';
        if (request.pageNumberFooter) {
          options['footer-html'] = htmlPageFooter;
        }
  }
  options["enable-local-file-access"] = true;
  return options;
}

module.exports.cinaForm = function (request, res) {
  let reqjson = {};
  request.isNotEncrpt = true;
  return app.models.Cinapetition.list(request).then((response) => {
    return new Promise((resolve, reject) => {     
      let witness = '';
      let cinasibling = '';
      let cinasubpoenad = '';
      let parent1 = [];
      let parent2 = [];
      if (response && response.data && response.data.length > 0) {
        reqjson = response.data[0];
        witness = response.petitionwitness;
        cinasibling = response.cinasibling;
        cinasubpoenad = response.cinasubpoenad;
        parent1 = arrayCheck(response.parent1details);
        parent2 = arrayCheck(response.parent2details);
      }
      if (parent1) {
        reqjson.parent1name = parent1.firstname + ' ' + parent1.lastname;
        reqjson.parent1nameid = parent1.cjamspid;
        reqjson.parent1nameaddress = '';
        reqjson.parent1namedob = util.formatDate(parent1.dob, '/');
        reqjson.parent1namessn = parent1.ssnno;
      }


      if (parent2) {
        reqjson.parent2name = parent2.firstname + ' ' + parent2.lastname;
        reqjson.parent2nameid = parent2.cjamspid;
        reqjson.parent2nameaddress = '';
        reqjson.parent2namedob = util.formatDate(parent2.dob, '/');
        reqjson.parent2namessn = parent2.ssnno;
      }

      reqjson.childdob = util.formatDate(reqjson.childdob, '/');

      reqjson.daterequestcompleted = util.formatDate(reqjson.daterequestcompleted, '/');
      reqjson.childinsheltercareon = util.formatDate(reqjson.childinsheltercareon, '/');
      reqjson.dateofemergencysheltercare = util.formatDate(reqjson.dateofemergencysheltercare, '/');
      reqjson.familymeetingdate = util.formatDate(reqjson.familymeetingdate, '/');
      reqjson.dateofremoval = util.formatDate(reqjson.dateofremoval, '/');
   

      reqjson.daterequestcompleted = util.formatDate(reqjson.daterequestcompleted, '/');
      reqjson.childinsheltercareon = util.formatDate(reqjson.childinsheltercareon, '/');
      reqjson.dateofemergencysheltercare = util.formatDate(reqjson.dateofemergencysheltercare, '/');
      reqjson.caseworkerphonenumber = util.formatPhoneNumber(reqjson.caseworkerphonenumber, '/');
      reqjson.supervisorphonenumber = util.formatPhoneNumber(reqjson.supervisorphonenumber, '/');

      reqjson = setCinaTableData(cinasibling, witness, cinasubpoenad, reqjson);

      var html = fs.readFileSync('./documenttemplates/cinaform.html', 'utf8');
      request.where.outputfilename = 'CINA_FORM.pdf';
      
      module.exports.generatepdf(request, html, reqjson, { type: 'report', res: res });
      resolve(res);
    });
  });
};

function setCinaTableData(cinasibling, witness, cinasubpoenad, reqjson) {
  let siblingsGrid = '';
  let witnessGrid = '';
  let subpoenaedGrid = '';
  if (cinasibling && cinasibling.length) {
    cinasibling.forEach(sib => {
      siblingsGrid += `
        <tr>
          <td>${sib.siblingname}</td>
          <td>${checkYes(sib.issibinginchildcare)}</td>
          <td>${sib.siblingcps}</td>
          <td>${sib.siblingchildwelfareservices}</td>
          <td>${sib.sibingcina}</td>
          <td>${sib.siblingrelationshipstatus}</td>
        </tr>
      `;
    });
  }

  if (witness && witness.length) {
    witness.forEach(wit => {
      witnessGrid += `
      <tr>
        <td>${wit.firstname}&nbsp${wit.lastname}</td>
        <td>${wit.petitionwitnessaddress}</td>
      </tr>
    `;
    });
  }

  if (cinasubpoenad && cinasubpoenad.length) {
    cinasubpoenad.forEach(sub => {
      subpoenaedGrid += `
      <tr>
        <td>${sub.institution}</td>
        <td>${sub.custodianname}</td>
        <td>${sub.recorddesc}</td>
        <td>${sub.address}</td>
        <td>${sub.personto}</td>
      </tr>
    `;
    });
  }
  reqjson.siblingsGrid = siblingsGrid;
  reqjson.witnessGrid = witnessGrid;
  reqjson.subpoenaedGrid = subpoenaedGrid;
  return reqjson;
}

module.exports.servicePlanPDF = function (request,response) {
  LOGGER.debug("request",request);
  var reqjson = {};
  var id = request.where.snapshotid;
  var type = request.where.type;
  let goals = '';
  let candidacys = '';
  let goalhtml = ``;

  let spcandidacy = '';
  let spcandidacytraditional = '';
  let traditionalEligibilityHTML = '';
  let visitationplans = '';
  let vpclients = '';
  let serviceplansignatures = '';
  const sql = "SELECT * FROM getserviceplanpdf($1,$2)";

  return new Promise((resolve,reject) => {
    response.on('data',function (chunk) {
      LOGGER.debug('BODY: ' + chunk);
    });
    util.executeDBQuery(sql,[id,type])
      .then(data => {
        if (data.length > 0) {
          LOGGER.debug("data ::: ",data);
          var html = '';
          html = type === 'IHSFP' ? fs.readFileSync('./documenttemplates/serviceplanInHome.html','utf8') : fs.readFileSync('./documenttemplates/serviceplanOutHome.html','utf8');

          reqjson = data[0].getserviceplanpdf[0];
          LOGGER.debug('reqjson :::::::::',reqjson);
          //LOGGER.debug('reqjson :::::::::',reqjson.startdate);
          //reqjson.legalGuardian = reqjson.legalGuardian
          //reqjson.
          reqjson.startdate = util.formatDate(reqjson.startdate);
          reqjson.enddate = util.formatDate(reqjson.enddate);
          goals = reqjson.goal;
          candidacys = reqjson.candidacys;
          visitationplans = reqjson.visitationplans;

          request.where.outputfilename = 'ServicePlan' + type;

          goalhtml += getgoalsHtml(goals,request);
          spcandidacy += getspcandidacy(candidacys, reqjson, request);
          spcandidacytraditional += getspcandidatestraditional(candidacys, reqjson, request);


          //   else {
          //     spcandidacytraditional += `
          //   <tr>
          //     <td colspan="10" class="text-center">
          //       No Child Records found-132
          //     </td>
          //   </tr>
          // `;
          //   }

          traditionalEligibilityHTML =
            `
      <div class="col-xs-12">
          <h4 class="text-left"><b>Traditional Eligibility Definition</b></h4>
          <p>
            There are factors that place the child at serious risk of removal and absent effective preventive services the plan is placement into foster care.
          </p>
                      <table class="table table-bordered">
                          <thead>
                              <tr>
                                  <th style="width: 10%">Client ID</th>
                                  <th style="width: 20%">Client Name</th>
                                  <th style="width: 10%">*Candidacy Determination (Yes/No)</th>
                                  <th style="width: 10%">*Date of Candidacy Determination</th>
                                  <th style="width: 20%">*Candidacy Determination Criteria</th>
                                  <th style="width: 40%">*EBP Referral Made</th>
                              </tr>
                          </thead>
                          <tbody>`
            + spcandidacytraditional +
            `</tbody>
                      </table>
                  </div>
      `

          if (visitationplans && visitationplans.length > 0) {
            visitationplans.forEach(visitation => {
              visitation.visitationplanclients.forEach(vpclient => {
                vpclients += `
              <li>${getFullName(vpclient.person)}</li>
              `;
              });
              visitation.visitationplanclientstext = vpclients;
              vpclients = '';
            });
          }
          serviceplansignatures = getserviceplansignatures(reqjson,type);
          reqjson.goalhtml = goalhtml;
          reqjson.serviceplansignatures = serviceplansignatures;
          reqjson.serviceplancandidacy = spcandidacy;
          reqjson.serviceplancandidacytraditional = spcandidacytraditional;
          if(spcandidacytraditional !== ''){
          reqjson.traditionalEligibilityHTML = traditionalEligibilityHTML;
          }
          const Response1 = request.where.zippdf ? module.exports.generatepdf(request,html,reqjson,{ type: 'report',res: response }) : module.exports.generatepdf(request,html,reqjson);
          resolve(Response1);
        }
      })
      .catch(err => {
        LOGGER.error(err);
        reject(err);
      })
  })
    .then(data => data)
    .catch(err => {
      LOGGER.error(err);
      return err;
    })
};
function getspcandidatestraditional(candidacys, reqjson, request){
  let spcandidacytraditional = '';

  if ((candidacys && candidacys.candidatestraditional && candidacys.candidatestraditional.length > 0) || (reqjson.snapshotdata && reqjson.snapshotdata.candidatesObj && reqjson.snapshotdata.candidatesObj.candidatestraditional && reqjson.snapshotdata.candidatesObj.candidatestraditional.length > 0)) {
    const cadidateTradCond = ((reqjson.snapshotdata && reqjson.snapshotdata.serviceplancandidacy && reqjson.snapshotdata.serviceplancandidacy && reqjson.snapshotdata.serviceplancandidacy.length > 0) ? reqjson.snapshotdata.serviceplancandidacy : candidacys.candidatestraditional);
    const cTraditional = (reqjson.snapshotdata && reqjson.snapshotdata.candidatesObj && reqjson.snapshotdata.candidatesObj.candidatestraditional && reqjson.snapshotdata.candidatesObj.candidatestraditional.length > 0) ? reqjson.snapshotdata.candidatesObj.candidatestraditional : cadidateTradCond;
    let isOld = false;
      if (reqjson && reqjson.snapshotdata && reqjson.snapshotdata.serviceplancandidacy) {
        isOld = true;
      }
    
    cTraditional.forEach(candidacy => {
      oldCandidacyCheck(isOld, candidacy, reqjson, request);
        spcandidacytraditional += `
  <tr>
    <td> ${candidacy.id}
    </td>
    <td> ${candidacy.name}
    </td>
    <td>
    ${checkYes(candidacy.candidacy === "1")}
    </td>
    <td>
      ${dateCheck(candidacy.candidacydate)}
    </td>
    <td>${candidacy?.details.split(' | ').join(', ')}</td>
    <td>
      <table style="width: 100%">
        <tr>
          <td>
            ${candidacy?.ebp?.isebpreferralmade}
          </td>
        </tr>
        <tr>
          <td>
            ${getcandidacyutilized(candidacy)}
          </td>
        </tr>
        <tr>
        <td>
          ${getcandidacyReason(candidacy)}
        </td>
      </tr>
        <tr>
            <td>
              ${emptyStrCheck(candidacy?.ebp?.utilizedtypes)}
            </td>
          </tr>
        <tr>
          <td>
            ${getCandidacyAdditionInfo(candidacy)}
          </td>
        </tr>
        <tr>
          <td>
            ${emptyStrCheck(candidacy?.ebp?.notes)}
          </td>
        </tr>
        <tr>
          <td>
            ${getCandidacyUtilizedTypes(candidacy)}
          </td>
        </tr>
      </table>
    </td>
  </tr>
  `;
    });
  }
  return spcandidacytraditional;
}

function oldCandidacyCheck(isOld, candidacy, reqjson, request){
  if (isOld) {
    if (!candidacy.details && reqjson?.snapshotdata?.involvedpersons) {
      const temp = reqjson.snapshotdata.involvedpersons.find((ip) => ip.id === candidacy.id);
      if (temp && temp.imminentrisks) {
        candidacy.imminentrisks = temp.imminentrisks;
        const details = [];
        if(request?.riskList) {
          candidacy.imminentrisks.forEach((element) => {
              details.push(request?.riskList?.find((e) => (e.ref_key === element)).value_text);
          });
        }
        candidacy.details = details.join('|');
      }
      else{
        candidacy.details = '';
      }
    }
  }
}

function getspcandidacy(candidacys, reqjson, request) {
  let spcandidacy = '';
  const candcyCheck = (reqjson.snapshotdata && reqjson.snapshotdata.candidatesObj && reqjson.snapshotdata.candidatesObj.candidates && reqjson.snapshotdata.candidatesObj.candidates.length > 0);
  const candcyCheck2 =  (reqjson.snapshotdata.candidatesObj && reqjson.snapshotdata.serviceplancandidacy && reqjson.snapshotdata.serviceplancandidacy.length > 0);
  if (candidacys && candidacys.candidates.length > 0 || candcyCheck || candcyCheck2) {
      const candiadteCond = (reqjson.snapshotdata && reqjson.snapshotdata.serviceplancandidacy && reqjson.snapshotdata.serviceplancandidacy && reqjson.snapshotdata.serviceplancandidacy.length > 0) ? reqjson.snapshotdata.serviceplancandidacy : candidacys.candidates;
      const candidatesInfo = candcyCheck ? reqjson.snapshotdata.candidatesObj.candidates : candiadteCond;
      let isOld = false;
        if (reqjson && reqjson.snapshotdata && reqjson.snapshotdata.serviceplancandidacy) {
          isOld = true;
        }
      
      candidatesInfo.forEach(candidacy => {
          oldCandidacyCheck(isOld, candidacy, reqjson, request);

          spcandidacy += `
          <tr>
            <td> ${candidacy.id}
            </td>
            <td> ${candidacy.name}
            </td>
            <td>
              ${checkYes(candidacy.candidacy === "1")}
            </td>
            <td>
              ${dateCheck(candidacy?.candidacydate)}
            </td>
            <td>${candidacy?.details?.split(' | ').join(', ')}</td>
            <td>
              <table style="width: 100%">
                <tr>
                  <td>
                    ${candidacy?.ebp?.isebpreferralmade}
                  </td>
                </tr>
                <tr>
                  <td>
                    ${getcandidacyutilized(candidacy)}
                  </td>
                </tr>
                <tr>
                    <td>
                      ${getcandidacyReason(candidacy)}
                    </td>
                  </tr>
                <tr>
                    <td>
                      ${emptyStrCheck(candidacy?.ebp?.utilizedtypes)}
                    </td>
                  </tr>
                <tr>
                  <td>
                    ${getCandidacyAdditionInfo(candidacy)}
                  </td>
                </tr>
                <tr>
                  <td>
                    ${emptyStrCheck(candidacy?.ebp?.notes)}
                  </td>
                </tr>
                <tr>
                <td>
                  ${getCandidacyUtilizedTypes(candidacy)}
                </td>
              </tr>
              </table>
            </td>
          </tr>
          `;
    });
  }
  else {
    spcandidacy += `
      <tr>
        <td colspan="10" class="text-center">
          No Child Records found
        </td>
      </tr>
      `;
  }
  return spcandidacy;
}

function getCandidacyUtilizedTypes(candidacy) {
  const cond1 = candidacy?.ebp?.utilizedtypes === 'Healthy Families America' ? 'In-Home Parenting Skills' : '';
  const cond2 = (candidacy?.ebp?.utilizedtypes === 'Functional Family Therapy' || candidacy?.ebp?.utilizedtypes === 'Multisystemic Therapy' || candidacy?.ebp?.utilizedtypes === 'Parent Child Interaction Therapy') ? 'Mental Health Services' : cond1;
  return candidacy?.ebp ? cond2 : '';
}

function getCandidacyAdditionInfo(candidacy){
  const ebpSubCond = candidacy?.ebp?.additionalinfo === 'No' ? 'Waitlisted' : '';
  const ebpCond = candidacy?.ebp?.additionalinfo === 'Yes' ? 'Declined after referral' : ebpSubCond;
  return candidacy?.ebp ? ebpCond : '';
}

function getcandidacyutilized(candidacy){
  const ebpcond = candidacy?.ebp?.utilized === 'Yes' ? 'EBP Utilized' : 'EBP Not Utilized';
  return candidacy?.ebp ? ebpcond : '';
}


function getcandidacyReason(candidacy) {
  const additinalinfo = candidacy?.ebp?.noadditionalinfo ? candidacy.ebp.noadditionalinfo : null;
  const reason = (candidacy.ebp && candidacy.ebp.additionalinfo) ? candidacy.ebp.additionalinfo : additinalinfo;
  let reasonText = '';
  switch (reason) {
    case 'Yesb':
      reasonText = 'Declined before referral';
      break;
    case 'FRS':
      reasonText = 'Family Refused Service';
      break;
    case 'NAL':
      reasonText = 'Not Available at LDSS';
      break;
    case 'SNA':
      reasonText = 'Service Not Appropriate';
      break;
    case 'YNE':
      reasonText = 'Youth Not Eligible';
      break;
    case 'YNEA':
      reasonText = 'Youth Not Eligibility based on Age';
      break;
  }
  return reasonText;
}



function getgoalsHtml(goals,request) {
  let goalhtml = ``;
  let obj = '';
  let act = '';


  if (goals && goals.length) {
    goals.forEach(goal => {
      goalhtml += `
  <div class="row">
      <div class="col-xs-12">
          <h3 class="blue-bg"><b>GOAL</b> : ${util.nullcheck(goal.goalname)}</h3>
      </div>
  </div>
  `;
      goal.splanobjective.forEach(objectiveitem => {
        obj += `
    <div class="row">
      <div class="col-xs-12">
                      <h4 class="grey-med"><strong>OBJECTIVE</strong> : <span>${util.nullcheck(objectiveitem.objectivename)}</span></h4>
                      <strong>STRENGTHS</strong> : <span>${util.nullcheck(objectiveitem.strengths)}</span><br>
                      <strong>NEEDS</strong>     : <span>${util.nullcheck(objectiveitem.needs)}</span><br>
                      <strong>STATUS</strong>    : <span>${util.nullcheck(objectiveitem.status)}</span><br>
                      <strong>COMMENTS</strong>  : <span>${util.nullcheck(objectiveitem.comments)}</span>
    `;
        if (objectiveitem.serviceplanaction && objectiveitem.serviceplanaction.length > 0) {
          obj += `
      <div class="row">
      <div class="col-xs-12">
    `;
        }
        act += getserviceplanaction(objectiveitem,request);

        if (objectiveitem.serviceplanaction && objectiveitem.serviceplanaction.length > 0) {
          obj = obj + act + `
          </div>
      </div>
       `;
        }
        act = ``;
      });
      goalhtml = goalhtml + obj + `
   <br>
  `;
      obj = ``;
    });
  }
  return goalhtml;
}

function getserviceplanaction(objectiveitem,request) {
  let act = '';
  let personinvolvedlist = '';
  let personinvolvedflag = false;
  var personinvolved = request.where.personinvolved;

  objectiveitem.serviceplanaction.forEach(actionitem => {
    personinvolvedflag = false;
    actionitem.serviceplanpersoninvolved.forEach(serviceplanperinvolved => {
      if (serviceplanperinvolved.person && serviceplanperinvolved.person.firstname && serviceplanperinvolved.person.lastname) {
        var fullname = getFullName(serviceplanperinvolved.person)
        personinvolvedlist += `<li>${fullname}</li>`

      }
    })
    if (personinvolved == null || personinvolved.length == 0) {
      personinvolvedflag = true;
    }
    else {
      actionitem.serviceplanpersoninvolved.forEach(serviceplanperinvolved => {
        if (personinvolved.indexOf(serviceplanperinvolved.personinvolved) > -1) {
          personinvolvedflag = true;
        }
      })
    }
    if (personinvolvedflag) {


      act += `
              <table class="table table-bordered">
                <tr>
                    <td><strong>ACTION</strong></td>
                    <td colspan = "4">${util.nullcheck(actionitem.serviceplanactionname)}</td>
                </tr>
                <tr>
                    <td><strong>PERSONS BENEFITING</strong></td>
                    <td><strong>PERSON RESPONSIBILE</strong></td>
                    <td><strong>START DATE</strong></td>
                    <td><strong>END DATE</strong></td>
                    <td><strong>STATUS</strong></td>
                </tr>
                <tr>
                    <td>${util.nullcheck(personinvolvedlist)}</td>
                    <td>${util.nullcheck(actionitem.personresponsible)}</td>
                    <td>${util.formatDate(actionitem.startdate)}</td>
                    <td>${util.formatDate(actionitem.enddate)}</td>  
                    <td>${util.nullcheck(actionitem.status)}</td>
                </tr>
                <tr>
                    <td><strong>COMMENTS</strong></td>
                    <td colspan = "4">${util.nullcheck(actionitem.comments)}</td>
                </tr>
              </table>
                
`;

      personinvolvedlist = '';
    }
  });
  return act;
}

function getserviceplansignatures(reqjson,type) {
  const serviceplansignatures = {}
  var famcount = 0;
  var pdfsignkey = '';
  const signatures = reqjson.signatures;
  if (signatures && signatures.length > 0) {
    signatures.forEach(signature => {
      if ((type === 'IHSFP' && signature.persontypekey === 'CWOOH') || (type === 'OOH' && signature.persontypekey === 'CWIHM')) {
        LOGGER.debug('Signature not applicable for the serviceplan type');
      } else {

        signature.personsigndate = util.formatDate(signature.personsigndate);
        switch (signature.persontypekey) {
          case 'CWOOH':
          case 'CWIHM':
            pdfsignkey = 'CW';
            break;
          case 'FAM':
            famcount += 1;
            pdfsignkey = 'FAM' + famcount;
            break;
          case 'SUP':
            pdfsignkey = 'SUP'
            break;
        }
        serviceplansignatures[pdfsignkey] = signature;
      }
    });
  }
  return serviceplansignatures;
}


module.exports.downloadInvestigationSummaryReport = function (request, investigationsummaryreport) {
  var html = '';
  html = fs.readFileSync('./documenttemplates/investigationFindingsReport.html', 'utf8');
  var reqobj = {
    where : {
      intakenumber : investigationsummaryreport.dsdsobject.da_number,
      intakeserviceid : investigationsummaryreport.dsdsobject.intakeserviceid,
      outputfilename : request.where.name
    },
    documntkey: request.where.documntkey
  };
  investigationsummaryreport.root_template_path_style = config.documenttemplates;

  if(investigationsummaryreport && investigationsummaryreport.investigationFind ){
    investigationsummaryreport.investigationFind.victim_explanation = util.nullcheck(investigationsummaryreport.investigationFind.victim_explanation).replace(/\n/g, '<br>');
    investigationsummaryreport.investigationFind.sibling_explanation = util.nullcheck(investigationsummaryreport.investigationFind.sibling_explanation).replace(/\n/g, '<br>');
    investigationsummaryreport.investigationFind.guardian_explanation = util.nullcheck(investigationsummaryreport.investigationFind.guardian_explanation).replace(/\n/g, '<br>');
    investigationsummaryreport.investigationFind.maltreator_explanation = util.nullcheck(investigationsummaryreport.investigationFind.maltreator_explanation).replace(/\n/g, '<br>');
    investigationsummaryreport.investigationFind.med_assessmnts = util.nullcheck(investigationsummaryreport.investigationFind.med_assessmnts).replace(/\n/g, '<br>');
    investigationsummaryreport.investigationFind.expert_assessmnts = util.nullcheck(investigationsummaryreport.investigationFind.expert_assessmnts).replace(/\n/g, '<br>');
    investigationsummaryreport.investigationFind.law_enforcement_inv = util.nullcheck(investigationsummaryreport.investigationFind.law_enforcement_inv).replace(/\n/g, '<br>');
    investigationsummaryreport.investigationFind.collateral_interviews = util.nullcheck(investigationsummaryreport.investigationFind.collateral_interviews).replace(/\n/g, '<br>');
    investigationsummaryreport.investigationFind.criminal_history_inv = util.nullcheck(investigationsummaryreport.investigationFind.criminal_history_inv).replace(/\n/g, '<br>');
    investigationsummaryreport.investigationFind.home_conditions = util.nullcheck(investigationsummaryreport.investigationFind.home_conditions).replace(/\n/g, '<br>');
  }
  
  investigationsummaryreport.investigationFind.dispositionnarrative = util.nullcheck(investigationsummaryreport.investigationFind.dispositionnarrative).replace(//g, '');
  investigationsummaryreport.reportcomarfindings = util.nullcheck(investigationsummaryreport.reportcomarfindings).replace(//g, '');
  investigationsummaryreport.investigationApprovedDate = '';
  if (investigationsummaryreport.supervisorApprovalDetails && investigationsummaryreport.supervisorApprovalDetails.length) {
    investigationsummaryreport.supervisorApprovalDetails.forEach(item => {
      item.approvedon = item.approvedon ? util.formatDate(item.approvedon , '/') : null;
      if (item.approvedon){
        investigationsummaryreport.investigationApprovedDate = item.approvedon;
      }
    });
  }
  return module.exports.generatepdf(reqobj, html, investigationsummaryreport);
};


module.exports.getYTPpdf = function(request,response) {
  let Response;
  request.where.outputfilename = 'YouthTransitionPlan';
  var html = '';
  const reqjson = {};
  reqjson.completiondate = request.where.selYouth.completiondate ? request.where.selYouth.completiondate : '';
  reqjson.nextduedate = request.where.selYouth.nextduedate ? request.where.selYouth.nextduedate : '';
  reqjson.summary_json = request.where.selYouth.summary_json ? request.where.selYouth.summary_json : {};
  reqjson.youththoughts_json = request.where.selYouth.youththoughts_json ? request.where.selYouth.youththoughts_json : {};
  reqjson.education_json = request.where.selYouth.education_json ? request.where.selYouth.education_json : {};
  reqjson.employment_json = request.where.selYouth.employment_json ? request.where.selYouth.employment_json : {};
  reqjson.moneymanagement_json = request.where.selYouth.moneymanagement_json ? request.where.selYouth.moneymanagement_json : {};
  reqjson.housing_json = request.where.selYouth.housing_json ? request.where.selYouth.housing_json : {};
  reqjson.sracc_json = request.where.selYouth.sracc_json ? request.where.selYouth.sracc_json : {};
  reqjson.health_json = request.where.selYouth.health_json ? request.where.selYouth.health_json : {};
  reqjson.documentation_json = request.where.selYouth.documentation_json ? request.where.selYouth.documentation_json : {};
  html = fs.readFileSync('./documenttemplates/YoutTransitionPlan.html', 'utf8');
  return new Promise((resolve, reject) => {
    if(request.where.zippdf){
      Response = module.exports.generatepdf(request, html, reqjson,{ type: 'report', res: response });
      resolve(Response);
    }
    else{
      Response = module.exports.generatepdf(request, html, reqjson);
      resolve(Response);
    }
  })
  .then(data => data)
  .catch(err => err);
}

module.exports.casePlan2PDF = function (request,response) {
  const caseplandata = request.where.caseplan2data;
  LOGGER.debug("request",request);
  var reqjson = {};
  var html = '';
  var placementinformations = '';
  var placementinfo = '';
  var assessmentinfo = '';
  var educationinfo = '';
  var educationproginfo = '';
  var initialexaminfo = '';
  var annualexaminfo = '';
  var childfollowupexaminfo = '';
  var childmedicationinfo = '';
  var childdbehaviourhealthinfo = '';
  var childdisabilityinfo = '';
  var childeducationinfo = '';
  var childemploymentinfo = '';
  var servicenplantfcflag = 'No';
  var incomeinfo = '';
  var assetinfo = '';
  var serviceLogs = '';
  var isChildInTreatmentFosterCare = '';


  html = fs.readFileSync('./documenttemplates/caseplan2.html','utf8');
  LOGGER.debug('reqjson :::::::::',reqjson);

  let Response;
  request.where.outputfilename = 'CasePlan-2';
  placementinformations = caseplandata.placementinformation ? caseplandata.placementinformation : [];
  serviceLogs = caseplandata.serviceLogs ? caseplandata.serviceLogs : [];
  checkactualDate(serviceLogs);
  childdbehaviourhealthinfo = caseplandata.childdbehaviourhealth ? caseplandata.childdbehaviourhealth[0] : [];
  childeducationinfo = caseplandata.childeducationinformation ? caseplandata.childeducationinformation[0] : [];
  childemploymentinfo = caseplandata.childemploymentinformation ? caseplandata.childemploymentinformation[0] : [];
  isChildInTreatmentFosterCare = checkYes(caseplandata.caseworkerservicesandplan?.cuurentplacetolive?.startsWith('Treatment Foster Care'));
  caseplandata.supportorderflag = checkYes(caseplandata.supportdetails);
  if (caseplandata.caseworkerservicesandplan) {
    if (caseplandata.caseworkerservicesandplan.permanancyplandata) {
      caseplandata.caseworkerservicesandplan.permanancyplandata.isProviderAgree = checkYes(caseplandata.caseworkerservicesandplan.permanancyplandata.isProviderAgree === "1");
      caseplandata.caseworkerservicesandplan.permanancyplandata.isInClosedProximity = checkYes(caseplandata.caseworkerservicesandplan.permanancyplandata.isInClosedProximity === "1");
    }
    if (caseplandata.caseworkerservicesandplan.facetofacecontactdate &&
      !(Array.isArray(caseplandata.caseworkerservicesandplan.facetofacecontactdate))) {
      const arr = [];
      arr.push({ contactdate: caseplandata.caseworkerservicesandplan.facetofacecontactdate })
      caseplandata.caseworkerservicesandplan.facetofacecontactdate = arr;
    }
  }

  LOGGER.debug(placementinformations,'placementinformationplacementinformation');
  placementinformations.forEach(placementinformation => {
    if (placementinformation.serviceid) {
      servicenplantfcflag = checkYes([78,12,11405,11406,11407,11408].includes(placementinformation.serviceid));
    }
  });
  caseplandata.childincomeinfo = incomeinfo;
  caseplandata.serviceLogs = serviceLogs;
  caseplandata.childassetinfo = assetinfo;
  caseplandata.servicenplantfcflag = servicenplantfcflag;
  caseplandata.childemploymentinfo = childemploymentinfo;
  caseplandata.childeducationinfo = childeducationinfo;
  caseplandata.childdisabilityinfo = childdisabilityinfo;
  caseplandata.childdbehaviourhealthinfo = childdbehaviourhealthinfo;
  caseplandata.childmedicationinfo = childmedicationinfo;
  caseplandata.childfollowupexaminfo = childfollowupexaminfo;
  caseplandata.annualexaminfo = annualexaminfo;
  caseplandata.initialexaminfo = initialexaminfo;
  caseplandata.educationinfo = educationinfo;
  caseplandata.educationproginfo = educationproginfo;
  caseplandata.assessmentinfo = assessmentinfo;
  caseplandata.placementinfo = placementinfo;
  caseplandata.isChildInTreatmentFosterCare = isChildInTreatmentFosterCare;

  if (request.where.zippdf) {
    Response = module.exports.generatepdf(request,html,caseplandata,{ type: 'report',res: response });
    return Response;
  }
  else {
    Response = module.exports.generatepdf(request,html,caseplandata);
    return Response;
  }
};

function checkactualDate(serviceLogs) {
  if (Array.isArray(serviceLogs)) {
    serviceLogs.forEach(sl => {
      const _referredServiceList = sl.referredServiceList;
      if (_referredServiceList && _referredServiceList.length > 0) {
        _referredServiceList.forEach(rsl => {
          if (util.nullcheck(rsl.actual_start_date) != '') {
            rsl.actual_start_date = moment(rsl.actual_start_date).format(dtformat);
          }
          if (util.nullcheck(rsl.actual_end_date) != '') {
            rsl.actual_end_date = moment(rsl.actual_end_date).format(dtformat);
          }
        });
      }
    });
  }
}


/**
 * Assessments PDFs
 */
const assessmenttemplatemap = {
  'AOD Form' : './documenttemplates/aod.html',
  'cans-v2' : './documenttemplates/cansf.html',
  'CANS-F' : './documenttemplates/cansf.html',
  'MFIRA' : './documenttemplates/mfira.html',
  'CANS-OUT OF HOME PLACEMENT SERVICE' : './documenttemplates/cans-out.html',
  'PADS Form' : './documenttemplates/aod.html',  
  'SEX TRAFFICKING(CST) SCREENING INTERVIEW' : './documenttemplates/cst.html',
  'PLACEMENT REQUEST FORM - ATTACHMENT A' : './documenttemplates/assessment-placement-request-form.component.html',
   'QUALIFIED INDIVIDUAL (QI) ASSESSMENT - ATTACHMENT B' :'./documenttemplates/QRTPassessmentform.html',
   'FACILITATED MEETING REFERRAL FORM' : './documenttemplates/Facilitated-Meeting-Referral-Form.html'
}


module.exports.assessmentspdf = function (request) { //NOSONAR
  LOGGER.debug("request",request);
  var html = '';
  var { assessmentname,assessmentdata } = request.where;

  html = fs.readFileSync(assessmenttemplatemap[assessmentname],'utf8');
  if(assessmentdata?.aodidentifyForm?.dateassessmentinitiated ) {
    assessmentdata.aodidentifyForm .dateassessmentinitiated  = assessmentdata.aodidentifyForm .dateassessmentinitiated  ? dateCheck(assessmentdata.aodidentifyForm .dateassessmentinitiated, dtformat2 ) : dateCheck(request.where.assessmentdetails.createddate, dtformat2);
  }
  if (assessmentdata?.preliminaryForm && assessmentdata?.preliminaryForm.length > 0) {
    assessmentdata.preliminaryForm.forEach((preliminary) => {
      preliminary.formattedDob = dateCheck(preliminary.dob);
      preliminary.addictiondate = dateCheck(preliminary.addictiondate);
      preliminary.referraldate = dateCheck(preliminary.referraldate);
      preliminary.isclientconsentreferraldate = dateCheck(preliminary.isclientconsentreferraldate);
      preliminary.appearaoddate = dateCheck(preliminary.appearaoddate);
      preliminary.dob = dateCheck(preliminary.dob);
      preliminary.isabusetreatmentdate = dateCheck(preliminary.isabusetreatmentdate);
      preliminary.ischildrenreportabusedate = dateCheck(preliminary.ischildrenreportabusedate);
      preliminary.treatmentdate = dateCheck(preliminary.treatmentdate);
    });
  }
  request.where.outputfilename = request.where.assessmentname;
  if (['cans-v2','CANS-F'].includes(assessmentname)) {
    assessmentdata?.child.forEach((c,ind) => {
      var childname = cansfNameMapping(c.childlist,assessmentdata?.familyYouth_childArray,'childName');
      if (childname) {
        assessmentdata.child[ind].kidName = childname.childNameText;
      }
    })
    assessmentdata?.careGiver.forEach((c,ind) => {
      var caregivername = cansfNameMapping(c.caregiverlist,assessmentdata?.familyYouth_caregiverArray,'caregivername');
      if (caregivername) {
        assessmentdata.careGiver[ind].careGiverName = caregivername.caregivernametext;
      }
    })
  }

  switch (assessmentname) {
    case 'PLACEMENT REQUEST FORM - ATTACHMENT A':
      assessmentdata = request.where.assessmentdetails.submissiondata;
      assessmentdata = getPlacementReqFormPdf(assessmentdata);
      break;

    case 'FACILITATED MEETING REFERRAL FORM':
      html = getFacilitatedMeetingForm(request, html);
      break;

    case 'QUALIFIED INDIVIDUAL (QI) ASSESSMENT - ATTACHMENT B':
      assessmentdata = request.where.assessmentdetails.submissiondata;
      assessmentdata.placementinfo.qiassessmentstartdate = dateCheck(assessmentdata.placementinfo.qiassessmentstartdate);
      assessmentdata.placementinfo.qiassessmentenddate = dateCheck(assessmentdata.placementinfo.qiassessmentenddate);
      assessmentdata.placementinfo.date = dateCheck(assessmentdata.placementinfo.date,'MM/DD/YYYY hh:mm a');
      assessmentdata.placementinfo.dateofftdm = dateCheck(assessmentdata.placementinfo.dateofftdm);

      if (assessmentdata.placementinfo.interviewarray.length) {
        assessmentdata.placementinfo.interviewarray.forEach(data => { 
          data.interviewdate = dateCheck(data.interviewdate); 
        })

      }
      break;

    case 'CANS-OUT OF HOME PLACEMENT SERVICE':
      assessmentdata = request.where.assessmentdetails.submissiondata;
      html = getCansOOHPdf(assessmentdata, html);
      break;
  }

  return module.exports.generatepdf(request,html,assessmentdata);
};

function getFacilitatedMeetingForm(request, html){
  var assessmentdata = request.where.assessmentdetails.submissiondata;
    html = html.replace('{{dateOfReferral}}',(dateCheck(assessmentdata.referralinformation?.dateofreferral)));
    html = html.replace('{{Requestor}}',util.nullcheck(assessmentdata.referralinformation?.requestor));
    html = html.replace('{{requestorcontactaddress}}',util.nullcheck(assessmentdata.referralinformation?.requestoraddress));
    html = html.replace('{{requestorcontactphone}}',util.nullcheck(assessmentdata.referralinformation?.phone) != '' ? util.formatPhoneNumber(assessmentdata.referralinformation.phone) : '');
    html = html.replace('{{requestorcontactemail}}',util.nullcheck(assessmentdata.referralinformation?.email));
    //ChildList Data
    html = getAssessmentChildListData(assessmentdata, html);
    let childspecificdetailsHtml = '';
    if (assessmentdata.referralinformation?.SubChildarray?.length > 0) {
      for (const child of assessmentdata.referralinformation?.SubChildarray) {
        childspecificdetailsHtml += divXs12;
        childspecificdetailsHtml += divRow;
        childspecificdetailsHtml += '<div class="col-xs-12 theme-header-bg"><h4><b>Child Name: ' + util.nullcheck(child.childinfo?.childname) + '&emsp;&emsp;&emsp;&emsp;D.O.B: ';
        childspecificdetailsHtml += (dateCheck(child.childinfo?.dob)) + '&emsp;&emsp;&emsp;CJAMS ID: ' + util.nullcheck(child.childinfo?.cjamsid) + '</b></h4></div><div class="col-xs-12">&nbsp;</div>';
        childspecificdetailsHtml += '<div class="row"><div class="col-xs-12"><table class="table table-bordered table-condensed">';
        childspecificdetailsHtml += '<thead><tr class="row-background"><th width="25%">Current Caregiver(s)</th><th width="45%">Current Caregegiver(s) Contact Information</th><th width="30%">Phone #</th></tr></thead>';
        
        childspecificdetailsHtml += getAssessmentCaregiver(child);

        childspecificdetailsHtml += '</table></div></div>';

        const placementstartdate = dateCheck(child?.providerplacement.placementstartdatetime);

        // Provider Placement
        childspecificdetailsHtml += '<div class="row"><div class="col-xs-12"><label>Current Placement Type: </label> ';

        if (child.programassingement?.length == 0) {
          childspecificdetailsHtml += 'Home - Not Removed';
        }
        else if (child.programassingement?.length > 0 && (child.providerplacement === null || child.providerplacement === '') && (child.livingarrangement === null || child.livingarrangement?.length === 0)) {
          childspecificdetailsHtml += 'Please update the Current Placement or Living Arrangement for the client';
        }
        else if (util.nullcheck(child?.providerplacement?.providerdetails?.providername) !== '') {
          childspecificdetailsHtml += divRow;
          childspecificdetailsHtml += '<div class="col-xs-7"><label>Placement provider name : </label> ' + util.nullcheck(child?.providerplacement?.providerdetails?.providername) + '</div><div class="col-xs-5"><label>Provider ID : </label> ' + util.nullcheck(child?.providerplacement?.providerdetails?.provider_id) + '</div>';
          childspecificdetailsHtml += '<div class="col-xs-7"><label>Placement Address : </label> ' + util.nullcheck(child?.providerplacement?.providerdetails?.address) + '</div><div class="col-xs-5"><label>Start Date : </label> ' + placementstartdate + '</div>';
          childspecificdetailsHtml += '</div>';
        }
        else {
          childspecificdetailsHtml += 'N/A';
        }
        childspecificdetailsHtml += '</div></div>';

        // Living Arrangement 
        childspecificdetailsHtml += getAssessmentLA(child);
        
        childspecificdetailsHtml += getAssessmentresourceparentsinfo(child);

        // Parent Information
        childspecificdetailsHtml += getAssessmentParentInfo(child);

        // Program Assignments
        
        childspecificdetailsHtml += getAssessmentPermancy(child);
        
        childspecificdetailsHtml += getAssessmentSupprotiveInfo(child)
        
        //Supportive Relationships/Resources
       
        childspecificdetailsHtml += getAssessmentReationship(child);
      }
    }
    html = getfamilycommittedtofacilityHtml(assessmentdata, html);

    const familyteamdecisionmeetingsHtml = getFamilyMeetingInfo(assessmentdata);
    
    assessmentdata.familyAccess.option1Date = dateCheck(assessmentdata?.familyAccess?.option1Date);
    assessmentdata.familyAccess.option2Date = dateCheck(assessmentdata?.familyAccess?.option2Date);
    assessmentdata.familyAccess.option3Date = dateCheck(assessmentdata?.familyAccess?.option3Date);

    const isSpecialNeedsRiskFactorSelect = util.nullcheck(assessmentdata.familyAccess?.specialNeedsRiskFactorSelect).toLowerCase() === 'yes';
    const specialNeedsRiskFactorSelectHtml = '<input type="radio" ' + (checkboxCheck(isSpecialNeedsRiskFactorSelect)) + ' >&nbsp;Yes&emsp;<input type="radio"  ' + (checkboxCheck(!isSpecialNeedsRiskFactorSelect)) + ' >&nbsp;No<br>';
    const showSpecialNeedsRiskFactorHtml = checkDisplaystyle(isSpecialNeedsRiskFactorSelect);

    assessmentdata.familyAccess.snrfChildcare = checkboxCheck(assessmentdata?.familyAccess?.snrfChildcare);
    assessmentdata.familyAccess.snrfCourtOrder = checkboxCheck(assessmentdata?.familyAccess?.snrfCourtOrder);
    assessmentdata.familyAccess.snrfLiteracy = checkboxCheck(assessmentdata?.familyAccess?.snrfLiteracy);
    assessmentdata.familyAccess.snrfTransportation = checkboxCheck(assessmentdata?.familyAccess?.snrfTransportation);
    assessmentdata.familyAccess.snrfSafetyConcerns = checkboxCheck(assessmentdata?.familyAccess?.snrfSafetyConcerns);
    assessmentdata.familyAccess.snrfADAConcerns = checkboxCheck(assessmentdata?.familyAccess?.snrfADAConcerns);
    assessmentdata.familyAccess.snrfInterpreter = checkboxCheck(assessmentdata?.familyAccess?.snrfInterpreter);
    assessmentdata.familyAccess.snrfTraumaResponsiveNeeds = checkboxCheck(assessmentdata?.familyAccess?.snrfTraumaResponsiveNeeds);
    assessmentdata.familyAccess.snrfVirtualMeetingNeeds = checkboxCheck(assessmentdata?.familyAccess?.snrfVirtualMeetingNeeds);
    const showOtherMeetingNeeds = checkDisplaystyle(assessmentdata?.familyAccess?.snrfOtherMeetingNeeds);
    assessmentdata.familyAccess.snrfOtherMeetingNeeds = checkboxCheck(assessmentdata?.familyAccess?.snrfOtherMeetingNeeds);

    const showTeamDecisionMeetingsOptions = checkDisplaystyle(assessmentdata?.familyAccess?.familyTeamDecisionMeeting);
    assessmentdata.familyAccess.familyTeamDecisionMeeting = checkboxCheck(assessmentdata?.familyAccess?.familyTeamDecisionMeeting);

    assessmentdata.familyAccess.emergentChildSeperation = checkboxCheck(assessmentdata?.familyAccess?.emergentChildSeperation);
    assessmentdata.familyAccess.consideredChildSeperation = checkboxCheck(assessmentdata?.familyAccess?.consideredChildSeperation);
    assessmentdata.familyAccess.placementChangeStability = checkboxCheck(assessmentdata?.familyAccess?.placementChangeStability);
    assessmentdata.familyAccess.recommendationsPermanencyChange = checkboxCheck(assessmentdata?.familyAccess?.recommendationsPermanencyChange);
    assessmentdata.familyAccess.qrtp = checkboxCheck(assessmentdata?.familyAccess?.qrtp);
    assessmentdata.familyAccess.voluntaryPlacement = checkboxCheck(assessmentdata?.familyAccess?.voluntaryPlacement);
    assessmentdata.familyAccess.placementPlanning = checkboxCheck(assessmentdata?.familyAccess?.placementPlanning);
    assessmentdata.familyAccess.ytp = checkboxCheck(assessmentdata?.familyAccess?.ytp);

    const showFacilitatedFamilyMeetingComments = checkDisplaystyle(assessmentdata?.familyAccess?.facilitatedFamilyMeeting);
    assessmentdata.familyAccess.facilitatedFamilyMeeting = checkboxCheck(assessmentdata?.familyAccess?.facilitatedFamilyMeeting);
    assessmentdata.familyAccess.facilitatormeetingassessmentcompletiondate = dateCheck((assessmentdata?.familyAccess?.facilitatormeetingassessmentcompletiondate), dtformat1);
    assessmentdata.familyAccess.facilitatormeetingassessmentsubmitdate = dateCheck((assessmentdata?.familyAccess?.facilitatormeetingassessmentsubmitdate), dtformat1);

    assessmentdata.familyAccess.facilitatormeetingassessmentapprovaldate = dateCheck((assessmentdata?.familyAccess?.facilitatormeetingassessmentapprovaldate), dtformat1);
    html = html.replace('{{specialNeedsRiskFactorSelectHtml}}',specialNeedsRiskFactorSelectHtml);
    html = html.replace('{{showOtherMeetingNeeds}}',showOtherMeetingNeeds);
    html = html.replace('{{showSpecialNeedsRiskFactorHtml}}',showSpecialNeedsRiskFactorHtml);
    html = html.replace('{{showFacilitatedFamilyMeetingComments}}',showFacilitatedFamilyMeetingComments);

    html = html.replace('{{showTeamDecisionMeetingsOptions}}',showTeamDecisionMeetingsOptions);
    html = html.replace('{{familyteamdecisionmeetingsHtml}}',familyteamdecisionmeetingsHtml);

    html = html.replace('{{childspecificdetailsHtml}}',childspecificdetailsHtml);
    return html;
}

function getAssessmentChildListData(assessmentdata, html){
  let childListHtml = '';
    if (assessmentdata.referralinformation?.childarray?.length > 0) {
      for (const child of assessmentdata.referralinformation?.childarray) {
        childListHtml += '<tr><td width="30%" class="text-sm-b text-vtop">' + util.nullcheck(child.name) + '</td>';
        childListHtml += '<td width="15%" class="text-sm-b text-vtop">' + util.nullcheck(child.cjamsid) + '</td>';
        childListHtml += '<td width="15%" class="text-vtop">' + (dateCheck(child.dob)) + '</td>';
        childListHtml += '<td width="40%" class="text-vtop">' + util.nullcheck(child.address) + tdclosetags;
      }
    }
    html = html.replace('{{childListHtml}}',childListHtml);
    return html;
}

function getfamilycommittedtofacilityHtml(assessmentdata, html){
  const inputRadio = '<input type="radio" ';
  const inputYes = ' >&nbsp;Yes&emsp;' + inputRadio;
  const inputNo = ' >&nbsp;No<br>';
  const familycommittedtofacility = util.nullcheck(assessmentdata.familyAccess?.parentResidingFacility).toLowerCase() === 'yes';
  let familycommittedtofacilityHtml = '';
  familycommittedtofacilityHtml += '<label>Please indicate if parent(s) are committed to a facility of any kind (State hospital or mental health facility; prison; DJS facility; nursing home; etc.)</label><br> ';
  familycommittedtofacilityHtml += inputRadio + (checkboxCheck(familycommittedtofacility)) + inputYes + (checkboxCheck(!familycommittedtofacility)) + inputNo;
  if (familycommittedtofacility) {
    familycommittedtofacilityHtml += '<br><div> ';
    familycommittedtofacilityHtml += '<table class="table table-bordered"><thead class="row-background"><tr><th width="10%">Parent</th><th width="10%">Facility Name</th><th width="10%">Address</th><th width="10%">Contact</th><th width="20%">Comments</th></tr></thead><tbody >';
    if (assessmentdata.familyAccess?.parentFacilityForm?.length > 0) {
      for (const indicateparent of assessmentdata.familyAccess?.parentFacilityForm) {
        familycommittedtofacilityHtml +=
          `<tr ><td>` + indicateparent.name + `</td> <td>` + indicateparent.facilityName + `</td> <td> ` + util.nullcheck(indicateparent.address) + `</td>
                <td>Phone: ` + util.formatPhoneNumber(util.nullcheck(indicateparent.phone)) + `<br> Fax: ` + util.nullcheck(indicateparent.fax) + `<br>
                    Email: ` + util.nullcheck(indicateparent.email) + `</td> <td>` + util.nullcheck(indicateparent.comments) + `</td>
            </tr>`;
      }
    }
    familycommittedtofacilityHtml += '</tbody></table>';
    familycommittedtofacilityHtml += '</div>';
  }

  html = html.replace('{{familycommittedtofacilityHtml}}',familycommittedtofacilityHtml);

  let iswritneededHtml = '';
  const iswritneeded = util.nullcheck(assessmentdata.familyAccess?.isWriteNeeded).toLowerCase() === 'yes';

  iswritneededHtml += '<label>Is a writ needed or any other specific steps taken in order to have parent(s) participate?</label><br> ';
  iswritneededHtml += inputRadio + (checkboxCheck(iswritneeded)) + inputYes + (checkboxCheck(!iswritneeded)) + inputNo;
  if (iswritneeded) {
    iswritneededHtml += '<div> ';
    iswritneededHtml += '<br><label>Comments: </label> ' + util.nullcheck(assessmentdata.familyAccess?.isWriteNeededComments);
    iswritneededHtml += '</div>';
  }
  iswritneededHtml += '</td>';
  html = html.replace('{{iswritneededHtml}}',iswritneededHtml);
  return html;
}

function getFamilyMeetingInfo(assessmentdata){
  let familyteamdecisionmeetingsHtml = '';
      if (assessmentdata.familyAccess?.meetings?.length > 0) {
        for (const familymeeting of assessmentdata.familyAccess?.meetings) {
          familyteamdecisionmeetingsHtml += '<tr> <td  width="15%">' + util.nullcheck(familymeeting.meetingtype) + ' </td>';
          familyteamdecisionmeetingsHtml += tdWidth10 + (dateCheck(familymeeting.meetingdate)) + ' </td>';
          familyteamdecisionmeetingsHtml += tdWidth10 + (dateCheck(familymeeting.meetingdate, 'h:mm a')) + '  </td>';
          familyteamdecisionmeetingsHtml += '<td width="20%">' + util.nullcheck(familymeeting.location) + ' </td>';
          familyteamdecisionmeetingsHtml += tdWidth10 + inputChecboxTag + (dateCheck(util.nullcheck(familymeeting.virtual) === true)) + ' ></td>';
          familyteamdecisionmeetingsHtml += tdWidth10 + inputChecboxTag + (dateCheck(util.nullcheck(familymeeting.inperson) === true)) + ' ></td>';
          familyteamdecisionmeetingsHtml += '<td width="25%">';
          familyteamdecisionmeetingsHtml += util.nullcheck(familymeeting.participants);
          familyteamdecisionmeetingsHtml += tdclosetags;
        }
      }
      else {
        familyteamdecisionmeetingsHtml += '<tr><td colspan="7">None</td></tr>';
      }
      return familyteamdecisionmeetingsHtml;
}

function getPlacementReqFormPdf(assessmentdata){
  if (assessmentdata?.youtheducation) {
    assessmentdata.youtheducation.upcomingdjs = dateCheck(assessmentdata.youtheducation.upcomingdjs);
    assessmentdata.youtheducation.upcominggang = dateCheck(assessmentdata.youtheducation.upcominggang);
    assessmentdata.youtheducation.upcomingelecmonitoring = dateCheck(assessmentdata.youtheducation.upcomingelecmonitoring);
    assessmentdata.youtheducation.upcomingdjscom = dateCheck(assessmentdata.youtheducation.upcomingdjscom);
    assessmentdata.youtheducation.nextmeetingdate = dateCheck(assessmentdata.youtheducation.nextmeetingdate);
  }

  if (assessmentdata?.youthmedical) {
    assessmentdata.youthmedical.physicianlastseendt = dateCheck(assessmentdata.youthmedical.physicianlastseendt);
    assessmentdata.youthmedical.dentistlastseendt = dateCheck(assessmentdata.youthmedical.dentistlastseendt);
    assessmentdata.youthmedical.therapistlastseendt = dateCheck(assessmentdata.youthmedical.therapistlastseendt);

  }
  if (assessmentdata?.youthinformation) {
    assessmentdata.youthinformation.currentplacementdate = dateCheck(assessmentdata.youthinformation.currentplacementdate);
  }
  if (assessmentdata?.youthplacementservice) {
    assessmentdata.youthplacementservice.assessmentcompletiondate = dateCheck(assessmentdata.youthplacementservice.assessmentcompletiondate);
  }
  if (assessmentdata?.placementinfo) {
    assessmentdata.placementinfo.dateofrequest = dateCheck(assessmentdata.placementinfo.dateofrequest);
    assessmentdata.placementinfo.dateofplacement = dateCheck(assessmentdata.placementinfo.dateofplacement);
    assessmentdata.placementinfo.ftdmdate = dateCheck(assessmentdata.placementinfo.ftdmdate);
    assessmentdata.placementinfo.lastftdmdate = dateCheck(assessmentdata.placementinfo.lastftdmdate);
  }
  return assessmentdata;
}

function checkAssessmentRating(assessmentdata){
  assessmentdata.medicalsubmodule = ((assessmentdata.faceLifeForm.medphy_rating === '1' || assessmentdata.faceLifeForm.medphy_rating === '2' || assessmentdata.faceLifeForm.medphy_rating === '3') && assessmentdata.faceLifeForm.medicalmodule && assessmentdata.faceLifeForm.medicalmodule.length) ? cansoutMapping(assessmentdata.faceLifeForm.medicalmodule,200) : '';
    assessmentdata.substanceabusesubmodule = ((assessmentdata.childform.substanceabuse_rating === '1' || assessmentdata.childform.substanceabuse_rating === '2' || assessmentdata.childform.substanceabuse_rating === '3') && assessmentdata.childform.substanceabusemodule && assessmentdata.childform.substanceabusemodule.length) ? cansoutMapping(assessmentdata.childform.substanceabusemodule,300) : '';
    assessmentdata.sexualabusesubmodule = ((assessmentdata.childform.sexaggress_rating === '1' || assessmentdata.childform.sexaggress_rating === '2' || assessmentdata.childform.sexaggress_rating === '3') && assessmentdata.childform.sexualabusemodule && assessmentdata.childform.sexualabusemodule.length) ? cansoutMapping(assessmentdata.childform.sexualabusemodule,400) : '';
    assessmentdata.runawaysubmodule = ((assessmentdata.childform.runaway_rating === '1' || assessmentdata.childform.runaway_rating === '2' || assessmentdata.childform.runaway_rating === '3') && assessmentdata.childform.runawaymodule && assessmentdata.childform.runawaymodule.length) ? cansoutMapping(assessmentdata.childform.runawaymodule,500) : '';
    assessmentdata.firesettingsubmodule = ((assessmentdata.childform.fire_rating === '1' || assessmentdata.childform.fire_rating === '2' || assessmentdata.childform.fire_rating === '3') && assessmentdata.childform.firesettingmodule && assessmentdata.childform.firesettingmodule.length) ? cansoutMapping(assessmentdata.childform.firesettingmodule,600) : '';
  return assessmentdata;
  }

function getCansOOHPdf(assessmentdata, html) {
  if (assessmentdata) {
    assessmentdata.faceLifeForm.datearray.forEach(data => { data.meetingdate = dateCheck(data.meetingdate) })
    assessmentdata = checkAssessmentRating(assessmentdata);
    
    if (assessmentdata.transitionForm.age == 0 || !assessmentdata.transitionForm.age) {
      const age = assessmentdata.faceLifeForm.age;
      const adultage = age.replace('Yrs',' ')
      assessmentdata.transitionForm.adultage = adultage;
    }
    assessmentdata.transitionForm.showoldsection = assessmentdata.transitionForm.showoldsection == undefined || assessmentdata.transitionForm.showoldsection;

    if (assessmentdata.authorizationForm) {
      //To avoid moment.js deprecation warning
      const safetyassessmentapprovaldate = moment(assessmentdata.authorizationForm?.safetyassessmentapprovaldate, 'MM/DD/YYYY h:mm a').format(dtformat);
      html = html.replace('{{authorizationForm.safetyassessmentapprovaldate}}',safetyassessmentapprovaldate);
    }
  }
  return html;
}

function getAssessmentCaregiver(child) {
  let childspecificdetailsHtml = '';
  if (child.currentCareGiver?.length > 0) {
      for (const caregiver of child.currentCareGiver) {
          let caregiveraddress = util.nullcheck(caregiver.address);
          caregiveraddress += checkAddressLine(caregiver.address2, ', ');
          caregiveraddress += checkAddressLine(caregiver.city, ', ');
          caregiveraddress += checkAddressLine(caregiver.state, ', ');
          caregiveraddress += checkAddressLine(caregiver.zipcode, ' - ');

          childspecificdetailsHtml += '<tr><td width="25%">' + util.nullcheck(caregiver.caregivername) + '</td><td width="45%">' + caregiveraddress + '</td><td width="30%">';
          let phonetext = ' ';
          if (caregiver.phoneinfo?.length > 0) {
              for (const phoneitem of caregiver.phoneinfo) {
                  let personphonetypekey = '';
                  switch (phoneitem.personphonetypekey) {
                      case "HM":
                          personphonetypekey = "Home - ";
                          break;
                      case "WK":
                          personphonetypekey = "Work - ";
                          break;
                      case "CL":
                          personphonetypekey = "Cell - ";
                          break;
                      default:
                          personphonetypekey = "Other - ";
                          break;
                  }
                  phonetext += personphonetypekey + util.formatPhoneNumber(phoneitem.phonenumber) + '<br>';
              }
          }
          childspecificdetailsHtml += phonetext + tdclosetags;
      }
      return childspecificdetailsHtml;
  }
childspecificdetailsHtml += '<tr><td colspan="3">N/A</td></tr>';
  return childspecificdetailsHtml;
}

function checkAddressLine(address, str){
  return util.nullcheck(address) !== '' ?  str + util.nullcheck(address) : ''
}

function getAssessmentLA(child) {
  let childspecificdetailsHtml = '';
  childspecificdetailsHtml += divRow;
  if (util.nullcheck(child.livingarrangement?.livingarrangementtypedescription) === '') {
      childspecificdetailsHtml += '<div class="col-xs-12"><label>Living Arrangement Type : </label>  N/A</div>';
  }
  else {
      childspecificdetailsHtml += '<div class="col-xs-12"><label>Living Arrangement</label></div>';
      childspecificdetailsHtml += '<div class="col-xs-12"><table class="table table-bordered table-condensed" width="80%">';
      childspecificdetailsHtml += '<thead class="row-background"><tr><th width="10%">Living Arrangement Type</th><th width="10%">Primary Caregiver Name</th><th width="10%">Address</th><th width="10%">Start Date</th></tr></thead><tbody>';
      if (child?.livingarrangement?.length > 0) {
          for (const la of child?.livingarrangement) {
              let livingarrangementaddress = '';
              livingarrangementaddress = util.nullcheck(la.streetname);
              livingarrangementaddress += checkAddressLine(la.cityname, ', ');
              livingarrangementaddress += checkAddressLine(la.statetypekey, ', ');
              livingarrangementaddress += checkAddressLine(la.zip5no, ' - ');

              let livingarrangementstartdate = '';
              if (util.nullcheck(la.startdatetime) != '') { 
                livingarrangementstartdate = moment(la.startdatetime).format(dtformat); 
              }

              childspecificdetailsHtml += '<tr><td>' + util.nullcheck(la.livingarrangementtypedescription) + '</td><td>' + util.nullcheck(la.primarycaregiver) + '</td>';
              childspecificdetailsHtml += '<td>' + livingarrangementaddress + '</td><td>' + livingarrangementstartdate + tdclosetags;
          }
      }
      childspecificdetailsHtml += '</tbody></table></div>';
  }
  childspecificdetailsHtml += '</div>';
  return childspecificdetailsHtml;
}

function getAssessmentParentInfo(child) {
  let childspecificdetailsHtml = '';
  childspecificdetailsHtml += '<div class="row "><div class="col-xs-12"><label>Parent Information</label></div>';
  childspecificdetailsHtml += divXs12;
  childspecificdetailsHtml += '<table class="table table-bordered"><thead class="row-background"><tr><th width="20%">Parent(s) Name</th><th width="20%">Address</th><th width="20%">Phone</th><th width="15%">Email</th><th width="25%">Preferred Contact Method</th></tr></thead><tbody>';

  if (child.parentsNameForm?.length > 0) {
      for (const parent of child.parentsNameForm) {
          let phonetext = ' ';
          if (parent.phone) {
          for (const phoneitem of parent.phone) {
              phonetext += '<u>' + phoneitem.key + '</u><br> ' + util.formatPhoneNumber(phoneitem.phone) + '<br>';
             }
          }
          childspecificdetailsHtml += `<tr> <td>  ` + util.nullcheck(parent.name) + ` </td> <td> ` + util.nullcheck(parent.address) + `</td>
                                    <td> ` + phonetext + ` </td>  <td>  ` + util.nullcheck(parent.email) + `  </td>
                                    <td>
                                      <div class="col-xs-12">
                                      <table class="table-condensed">
                                        <tr>
                                          <td>
                                            <input type="checkbox" ` + (checkboxCheck(parent.contactHome)) + `> Home 
                                          </td>
                                          <td>
                                          <input type="checkbox" ` + (checkboxCheck(parent.contactWork)) + `> Work
                                          </td>
                                        </tr>
                                        <tr>
                                          <td>    
                                            <input type="checkbox" ` + (checkboxCheck(parent.contactCell)) + `> Cell 
                                          </td>
                                          <td>
                                          <input type="checkbox"` + (checkboxCheck(parent.contactText)) + `> Text
                                          </td>
                                        </tr>
                                        <tr>
                                          <td colspan="2">
                                            <input type="checkbox" ` + (checkboxCheck(parent.contactEmail)) + `> Email
                                          </td>
                                        </tr>
                                      </table>
                                      </div>
                                    </td> 
                                  </tr>`;
      }
  }
  else {
      childspecificdetailsHtml += '<tr><td colspan="6">N/A</td></tr>';
  }
  childspecificdetailsHtml += tableClosetag;
  return childspecificdetailsHtml;
}

function getAssessmentPermancy(child){
  let childspecificdetailsHtml = '';

  // Program Assignments
  childspecificdetailsHtml += '<div class="row "><div class="col-xs-12"><label>Program Assignments</label></div>';
  childspecificdetailsHtml += '<div class="col-xs-12"><table class="table table-bordered table-condensed" width="60%"><thead class="row-background"><th>Program Area</th><th>Sub Program Area</th><th>Start Date</th></thead><tbody>';

  if (child.programassingement?.length > 0) {
    for (const program of child.programassingement) {
      childspecificdetailsHtml += '<tr><td>' + util.nullcheck(program.programname) + '</td><td>' + util.nullcheck(program.subprogramname) + '</td>';

      let programstartdate = '';
      programstartdate = dateCheck(program.startdate)

      childspecificdetailsHtml += '<td>' + programstartdate + tdclosetags;
    }
  }
  else {
    childspecificdetailsHtml += '<tr><td colspan="3">N/A</td></tr>';
  }
  childspecificdetailsHtml += tableClosetag;

  // Permanency Plan
  let planeffectivedate = '';
  planeffectivedate = dateCheck(child.permanencyplans[0]?.establisheddate);

  childspecificdetailsHtml += '<div class="row "><div class="col-xs-12"><label>PERMANENCY PLAN</label></div>';
  childspecificdetailsHtml += `<div class="col-xs-12">
<table class="table table-bordered table-condensed">
<thead class="row-background"><th>Primary Permanency Plan</th><th>Plan Established Date</th><th>Concurrent Permaency Plan</th></thead>
<tbody>
  <tr>`;
  if (util.nullcheck(child.permanencyplans[0]?.establisheddate) != '') {
    childspecificdetailsHtml += `<td>` + util.nullcheck(child.permanencyplans[0]?.primaryplantypedesc) + `</td>
  <td>` + planeffectivedate + `</td>
  <td>` + util.nullcheck(child.permanencyplans[0]?.concurrentpermanencytypedesc) + `</td>`;
  }
  else { childspecificdetailsHtml += ` <td colspan="3">N/A</td>`; }
  childspecificdetailsHtml += ` </tr>
</tbody>
</table>
</div>`;
  childspecificdetailsHtml += '<div class="col-xs-12">&nbsp;</div></div>';

  // Current Legal Status
  childspecificdetailsHtml += '<div class="row "><div class="col-xs-12"><label>LEGAL CUSTODY</label></div>';
  childspecificdetailsHtml += '<div class="col-xs-12"><table class="table table-bordered table-condensed">';
  childspecificdetailsHtml += '<thead class="row-background"><th width="50%">Legal Custody</th><th width="50%">Start Date</th></thead><tbody>';

  if (child.legalcustody?.length > 0) {
    for (const custody of child.legalcustody) {
      let custodystartdate = '';
      custodystartdate = dateCheck(custody.fromdate);
      childspecificdetailsHtml += '<tr><td width="50%">' + util.nullcheck(custody.legalcustodytypedesc) + '</td><td width="50%">' + custodystartdate + tdclosetags;
    }
  }
  else {
    childspecificdetailsHtml += '<tr><td colspan="2">N/A</td></tr>';
  }
  childspecificdetailsHtml += tableClosetag;

  return childspecificdetailsHtml;
}

function getAssessmentSupprotiveInfo(child){
  let childspecificdetailsHtml = '';
  // Order Controlling Conduct
  childspecificdetailsHtml += '<div class="row "><div class="col-xs-12"><label>Order Controlling Conduct</label></div>';
  childspecificdetailsHtml += '<div class="col-xs-12">Order Controlling Conduct: &emsp;<input type="radio" ' + (checkboxCheck(util.nullcheck(child.orderControllingConduct?.toLowerCase() == 'yes'))) + '/>&nbsp;Yes&emsp;<input type="radio" ' + (checkboxCheck(util.nullcheck(child.orderControllingConduct?.toLowerCase() == 'no'))) + '/>&nbsp;No</div>';
  if (util.nullcheck(child.orderControllingConduct?.toLowerCase() == 'yes')) {
    childspecificdetailsHtml += '<div class="col-xs-12">Comments:*</div>';
    childspecificdetailsHtml += divXs12 + util.nullcheck(child.orderControllingConductComments) + ' </div>';
    childspecificdetailsHtml += '<div class="col-xs-12">&nbsp;</div>';
    childspecificdetailsHtml += '<div class="col-xs-12"><div class="row"><div class="col-xs-8"><table class="table table-bordered table-condensed">';
    childspecificdetailsHtml += '<thead class="row-background"><th>Applicable To</th><th>D.O.B</th><th>CJAMS ID</th></thead><tbody>';
    if (child.orderControllingConductApplicableToForm?.length > 0) {
      for (const applicableto of child.orderControllingConductApplicableToForm) {
        childspecificdetailsHtml += '<tr><td>' + util.nullcheck(applicableto?.orderControllingConductApplicableToName) + ' </td><td>' + (dateCheck(applicableto?.dob)) + ' </td><td>' + util.nullcheck(applicableto?.cjamspid) + tdclosetags;
      }
    }
    childspecificdetailsHtml += '</tbody></table></div></div></div>';
  }
  childspecificdetailsHtml += '</div>';

  // Order of Protective Supervision
  childspecificdetailsHtml += '<div class="row "><div class="col-xs-12"><label>Order of Protective Supervision</label></div>';
  childspecificdetailsHtml += '<div class="col-xs-12">Order of Protective Supervision: &emsp;<input type="radio"  ' + (dateCheck(util.nullcheck(child.orderOfProtectingConduct?.toLowerCase() === 'yes'))) + ' />&nbsp;Yes&emsp;<input type="radio"  ' + (dateCheck(util.nullcheck(child.orderOfProtectingConduct?.toLowerCase() == 'no'))) + '/>&nbsp;No</div>';
  if (util.nullcheck(child.orderOfProtectingConduct?.toLowerCase() == 'yes')) {
    childspecificdetailsHtml += '<div class="col-xs-12">Comments:*</div>';
    childspecificdetailsHtml += divXs12 + util.nullcheck(child.protectingConductComments) + ' </div>';
    childspecificdetailsHtml += '<div class="col-xs-12">&nbsp;</div>';
    childspecificdetailsHtml += '<div class="col-xs-12"><div class="row"><div class="col-xs-8">';
    childspecificdetailsHtml += '<table class="table table-bordered table-condensed"><thead class="row-background"><th>Applicable To</th><th>D.O.B</th><th>CJAMS ID</th></thead><tbody>';
    if (child.protectingConductApplicableToForm?.length > 0) {
      for (const applicableto of child.protectingConductApplicableToForm) {
        childspecificdetailsHtml += '<tr><td>' + util.nullcheck(applicableto?.applicableToName) + ' </td><td>' + (dateCheck(applicableto?.dob)) + ' </td><td>' + util.nullcheck(applicableto?.cjamspid) + tdclosetags;
      }
    }
    childspecificdetailsHtml += '</tbody></table></div></div></div>';
  }
  childspecificdetailsHtml += '</div>';

  return childspecificdetailsHtml;
}

function checkDisplaystyle(value){
  return (value) ? 'style="display: visible;"' : 'style="display: none;"';
}

function getAssessmentReationship(child){
  let childspecificdetailsHtml = '';
  let supportiveRelationshipsHtml = '';
  supportiveRelationshipsHtml += `<div class="row">   
                                  <div class="col-xs-12"><label>Supportive Relationships/Resources</label> 
                                  <br>If any needed participants are not listed below, please add them under Person profile / In Household / Other or Collateral.
                                  </div>                              
                                  <div class="col-xs-12">                                    
                                  <table class="table table-bordered table-condensed">                                      
                                  <thead class="row-background">
                                  <th width="15%">Name</th>
                                  <th width="10%">Relationship</th>
                                  <th width="30%">Contact (Address, Phone, Email)</th>
                                  <th width="20%">Family has indicated that attendance is Critical</th>
                                  <th width="25%">Has Worker Made Contact?</th>
                                  </thead> <tbody>`;
  if (child.supportiveRelationshipArray?.length > 0) {
    for (const supportiverelationship of child.supportiveRelationshipArray) {
      supportiveRelationshipsHtml += '<tr>';
      supportiveRelationshipsHtml += '<td  width="15%">' + util.nullcheck(supportiverelationship.supportiveName) + '</td>';
      supportiveRelationshipsHtml += tdWidth10 + (util.nullcheck(supportiverelationship.relationshipTo) !== '' ? util.nullcheck(supportiverelationship.relationshipTo) : util.nullcheck(supportiverelationship.collateralRelationshipTo)) + '</td>';
      supportiveRelationshipsHtml += '<td  width="35%">' + util.nullcheck(supportiverelationship.address);
      let phonetext = ' ';
      if (supportiverelationship.phone?.length > 0) {
        phonetext += '<br><br><u>Phone:</u><br>';
        for (const phoneitem of supportiverelationship.phone) {
          phonetext += phoneitem.key + ' - ' + util.formatPhoneNumber(phoneitem.phone) + '<br>';
        }
      }

      supportiveRelationshipsHtml += phonetext;
      supportiveRelationshipsHtml += getsupportiveEmailTag(supportiverelationship);

      supportiveRelationshipsHtml += '</td>';

      supportiveRelationshipsHtml += '<td width="20%"><input type="radio" ' + (checkboxCheck(util.nullcheck(supportiverelationship.familyHasIndicate) === '1')) + '>&nbsp;Yes<br><input type="radio" ' + (checkboxCheck(util.nullcheck(supportiverelationship.familyHasIndicate) === '2')) + '>&nbsp;No</td>';

      supportiveRelationshipsHtml += '<td width="25%">' + util.nullcheck(supportiverelationship.hasWorker) + '</td>';
      supportiveRelationshipsHtml += '</tr> ';
    }
  }
  else {
    supportiveRelationshipsHtml += '<tr><td colspan="5">N/A</td></tr>';
  }

  supportiveRelationshipsHtml += '</tbody>  </table>  </div> </div></div>';
  childspecificdetailsHtml += supportiveRelationshipsHtml;

  childspecificdetailsHtml += '<div class="col-xs-12"></div>';
  childspecificdetailsHtml += '</div>';
  return childspecificdetailsHtml;
}

function getsupportiveEmailTag(supportiverelationship){
  let email = '';
  if (util.nullcheck(supportiverelationship.email) != '') { email = '<br><u>Email:</u><br>' + util.nullcheck(supportiverelationship.email); }
  return email;
}

function getAssessmentresourceparentsinfo(child) {
  let childspecificdetailsHtml = '';
  // Resource Parents
  childspecificdetailsHtml += '<div class="row "><div class="col-xs-12"><label>Resource Parent(s)</label></div>';
  childspecificdetailsHtml += '<div class="col-xs-12"><table class="table table-bordered table-condensed" width="80%">';
  childspecificdetailsHtml += '<thead><tr class="row-background"><th width="50%">Resource Parent(s)</th><th width="50%">Resource Parent(s) Contact Information</th></tr></thead><tbody>';

  if (child.resourceparentsinfo?.length > 0) {
      for (const resourceparent of child.resourceparentsinfo) {
          childspecificdetailsHtml += '<tr><td width="50%">' + util.nullcheck(resourceparent.resourceparentname) + '</td><td width="50%">' + util.nullcheck(resourceparent.resourceparentaddress) + tdclosetags;
      }
  }
  else {
      childspecificdetailsHtml += '<tr><td colspan="2">N/A</td></tr>';
  }
  childspecificdetailsHtml += tableClosetag;
  // Considered placement at Meeting

  let laConsideredHtml = '';
  if (child.livingarrangementtypeConsidered?.length > 0) {
      for (const laConsidered of child.livingarrangementtypeConsidered) {
          laConsideredHtml += laConsidered + '<br>';
      }
  }

  childspecificdetailsHtml += `<div class="row "><div class="col-md-12"><table class="table table-condensed table-bordered"><thead class="row-background"><th width="50%"><label>Placement Type That May Be Considered at Facilitated Meeting</label></th><th  width="50%"><label>Living Arrangement</label></th></thead><tbody><tr><td width="50%" align-top><table class="table-condensed">
                            <tr><td width="5%">&nbsp;</td><td width="45%"><input type="checkbox" ` + (checkboxCheck(child.plTypeFosterHome)) + `> <span>Foster Home</span></td><td width="10%">&nbsp;</td><td width="40%"><input type="checkbox" ` + ((child.plTypeGroupHome) ? 'checked' : '') + `> <span>Group Home</span></td></tr>
                            <tr><td width="5%">&nbsp;</td><td width="45%"><input type="checkbox" ` + (checkboxCheck(child.plTypeIndLiving)) + `> <span>Independent Living</span></td><td width="10%">&nbsp;</td><td width="40%"><input type="checkbox" ` + ((child.plTypeKinship) ? 'checked' : '') + `> <span>Kinship</span></td></tr>
                            <tr><td width="5%">&nbsp;</td><td width="45%"><input type="checkbox" ` + (checkboxCheck(child.plTypeHomeNotRemoved)) + `> <span>Home - Not Removed</span></td><td width="10%">&nbsp;</td><td width="40%"><input type="checkbox" ` + ((child.plTypeNA) ? 'checked' : '') + `> <span>N/A</span></td></tr>
                            </table></td>
                            <td width="50%" align-top>` + laConsideredHtml + `</td></tr></tbody></table></div></div>`;

  return childspecificdetailsHtml;
}

/**new assment  */

function cansoutMapping(data, id) {
  let submoduleData = ''; 
  if(data && data.length) {
   data.map(item => {
     const radiobuttonid = "mat-radio-group-" + id 
     submoduleData += ` <div class="row mt-10">
                           <div class="col-xs-6">
                               <p class="text-sm-b"> ${util.nullcheck(item.label)} </p>
                           </div>
                           <div class="col-xs-5">
                               <div class="row">
                                   <div class="col-xs-1 md-radiobox">
                                       <label>
                                           <input type="radio" name=${radiobuttonid} ${(item.value === "0") ? 'checked' : '' }>
                                           <span class="md-radiobox-material">
                                               <span class="check"></span>
                                           </span> 0
                                       </label>
                                   </div>
                                   <div class="col-xs-1 md-radiobox">
                                       <label>
                                           <input type="radio" name=${radiobuttonid}  ${(item.value === "1") ? 'checked' : '' }>
                                           <span class="md-radiobox-material">
                                               <span class="check"></span>
                                           </span> 1
                                       </label>
                                   </div>
                                   <div class="col-xs-1 md-radiobox">
                                       <label>
                                           <input type="radio" name=${radiobuttonid}  ${(item.value === "2") ? 'checked' : '' }>
                                           <span class="md-radiobox-material">
                                               <span class="check"></span>
                                           </span> 2
                                       </label>
                                   </div>
                                   <div class="col-xs-1 md-radiobox">
                                       <label>
                                           <input type="radio" name=${radiobuttonid} ${(item.value === "3") ? 'checked' : '' }>
                                           <span class="md-radiobox-material">
                                               <span class="check"></span>
                                           </span> 3
                                       </label>
                                   </div>
                               </div>
                           </div>
                           <div class="col-xs-11">
                              <div class="pl-20">
                                  <p><b> Comments: </b>${util.nullcheck(item.comment)}</p>
                              </div>
                            </div>
                       </div> `

     id = id + 1;
    })
 
  }
  return submoduleData;
}


function cansfNameMapping(id, data, key){
  return data.filter(a => (a[key] === id))[0]
}

module.exports.cpsIntakeReportPDF = function (request) {
  return new Promise((resolve,reject) => {
    LOGGER.debug("request",request);

    let persons = '';
    let approvalStatus = '';

    let sdmKeyData = {
      physicalAbuse: '',
      sexualAbuse: '',
      generalNeglect: '',
      negfp_cargiverintervene: '',
      negab_abandoned: '',
      unattendedChild: '',
      riskofHarm: '',
      negmn_unreasonabledelay: '',
      menab_psycologicalability: '',
      menng_psycologicalability: '',
      ScreenOUT: '',
      Scrnin: '',
      noOverrides: '',
    };

    const mentalInjury = '';

    let OvrScrnout = '';
    let Ovrscrnin = '';
    let finalscreeninOut = '';

    let narrativeFormDataName = '';


    var reqjson = request.where;
    var html = '';
    html = fs.readFileSync('./documenttemplates/cpsintakereport.html','utf8');
    

    if (reqjson.householdMem && reqjson.householdMem.length > 0) {
      reqjson.householdMem.forEach(person => {

        var personalias = emptyStrCheck(person.aliasname);
        personalias = util.nullcheck(personalias);
        persons += `
        <div class="personsdiv">
            <div class="row">
            <div class="col-xs-12 l"><h5>${util.nullcheck(person.fullname)}</h5> </div>
            </div>
            <div class="row">
                <div class="col-xs-3 l"><label>Name:</label> </div>
                <div class="col-xs-3 l"><span> ${util.nullcheck(person.fullname)}</span></div>
                <div class="col-xs-3 l"><label>Alias:</label> </div>
                <div class="col-xs-3 l"><span> ${personalias}</span></div>
            </div>
            <div class="row">
                <div class="col-xs-3 l"><label>DOB:</label> </div>
                <div class="col-xs-3 l"><span>${util.formatDate(person.dob,'/')}</span></div>
                <div class="col-xs-3 l"><label>Gender:</label> </div>
                <div class="col-xs-3 l"><span>${genderCheck(person.gender)}</span></div>
            </div>
            <div class="row">
                <div class="col-xs-3 l"><label>Person ID:</label> </div>
                <div class="col-xs-3 l"><span>${util.nullcheck(person.cjamspid)}</span></div>
            </div>
            <div class="row">
                <div class="col-xs-2"> &nbsp;</div>
            </div>
            <div class="row">
                <div class="col-xs-3 l"><label>Substance-Exposed Newborn:</label> </div>  
                <div class="col-xs-3 l"><input type="checkbox" `+ checkboxCheck(person.drugexposednewbornflag === 1) + ` disabled></div>
                <div class="col-xs-3 l"><label> Fetal Alcohol Spectrum Disorder:</label> </div>
                <div class="col-xs-3 l"><input type="checkbox" `+ checkboxCheck(person.fetalalcoholspctrmdisordflag === 1) + ` disabled></div>
            </div>
            <div class="row">
                <div class="col-xs-3 l"><label>Probation Search Conducted:</label> </div>
                <div class="col-xs-3 l"> <input type="checkbox" `+ checkboxCheck(person.probationsearchconductedflag === 1) + ` disabled></div>
                <div class="col-xs-3 l"><label>Sex Offender Registry Checked:</label> </div>
                <div class="col-xs-3 l"><input type="checkbox"  `+ checkboxCheck(person.sexoffenderregisteredflag === 1) + ` disabled></div>
            </div>
            <div class="row">
                <div class="col-xs-2"> &nbsp;</div>
            </div>
        </div>`
      });
    }
     var intakenumber = getintakenumber(request); 
     const sql1 = 'select * from getsupervisorapprovaldetails($1)';
    return util.executeDBQuery(sql1,[intakenumber])
       .then((result2)=> {
        var supervisorApprovalDetail = result2[0].getsupervisorapprovaldetails;
        let result= supervisorapprovalstatus(reqjson, supervisorApprovalDetail);   
        approvalStatus =result.approvalStatus;
        reqjson.label =result.label;
    
    if (reqjson.sdmFormData) {

      sdmKeyData = getCPSIntakesdmData(reqjson);
      const screenData = getScreenData(reqjson);
      OvrScrnout = screenData.OvrScrnout;
      Ovrscrnin = screenData.Ovrscrnin;
      finalscreeninOut = screenData.finalscreeninOut;
    }

    narrativeFormDataName = getnarrativeFormDataName(reqjson);




    reqjson.householdMem = persons;
    reqjson.root_template_path_style = config.documenttemplates;
    reqjson.cpsResponseType = checkCPSResponseType(reqjson);
    reqjson.probationsearchconductedflag = `<div class="col-xs-3 l"><input type="checkbox" ` + checkboxCheck(reqjson.probationsearchconductedflag === 1) + `  disabled></div>`;
    reqjson.sexoffenderregisteredflag = `<div class="col-xs-3 l"><input type="checkbox" ` + checkboxCheck(reqjson.sexoffenderregisteredflag === 1) + `  disabled></div>`;
    reqjson.approvalStatus = approvalStatus;
    reqjson.gender = genderCheck(reqjson.gender);
    reqjson.dob = util.formatDate(reqjson.dob,'/');
    

    if (reqjson.addressinfo && Array.isArray(reqjson.addressinfo) && reqjson.addressinfo.length > 0) {
      reqjson.address = reqjson.addressinfo[0].address;
      reqjson.city = reqjson.addressinfo[0].city;
      reqjson.state = reqjson.addressinfo[0].state;
      reqjson.zipcode = reqjson.addressinfo[0].zipcode;
    }

    reqjson.aliasname = util.nullcheck(reqjson.aliasname);
    reqjson.Narrative = util.removeBizarreCharacters(util.nullcheck(reqjson.Narrative));
    const sanatizedNarrativeData = clearHtmlSpaces(reqjson.Narrative);
    reqjson.Narrative = sanatizedNarrativeData;
    reqjson.cpsHistoryClearance = util.removeBizarreCharacters(util.nullcheck(reqjson.cpsHistoryClearance));
    const sanatizedcpsHistoryClearanceData = clearHtmlSpaces(reqjson.cpsHistoryClearance);
    reqjson.cpsHistoryClearance = sanatizedcpsHistoryClearanceData;
    reqjson.physicalAbuse = util.nullcheck(sdmKeyData.physicalAbuse);
    reqjson.sexualAbuse = util.nullcheck(sdmKeyData.sexualAbuse);
    reqjson.generalNeglect = util.nullcheck(sdmKeyData.generalNeglect);
    reqjson.negfp_cargiverintervene = util.nullcheck(sdmKeyData.negfp_cargiverintervene);
    reqjson.negab_abandoned = util.nullcheck(sdmKeyData.negab_abandoned);
    reqjson.unattendedChild = util.nullcheck(sdmKeyData.unattendedChild);
    reqjson.riskofHarm = util.nullcheck(sdmKeyData.riskofHarm);
    reqjson.negmn_unreasonabledelay = util.nullcheck(sdmKeyData.negmn_unreasonabledelay);
    reqjson.mentalInjury = util.nullcheck(mentalInjury);
    reqjson.menab_psycologicalability = util.nullcheck(sdmKeyData.menab_psycologicalability);
    reqjson.menng_psycologicalability = util.nullcheck(sdmKeyData.menng_psycologicalability);
    reqjson.ScreenOUT = util.nullcheck(sdmKeyData.ScreenOUT);
    reqjson.Scrnin = util.nullcheck(sdmKeyData.Scrnin);
    reqjson.noOverrides = util.nullcheck(sdmKeyData.noOverrides);
    reqjson.OvrScrnout = util.nullcheck(OvrScrnout);
    reqjson.Ovrscrnin = util.nullcheck(Ovrscrnin);
    reqjson.finalscreeninOut = util.nullcheck(finalscreeninOut);
    reqjson.narrativeFormDataName = util.nullcheck(narrativeFormDataName);
    reqjson.IntakeNumber =util.nullcheck(intakenumber);
    reqjson.RecivedDate = formatreceiveddate(reqjson);
    reqjson.countyId = formatcounty(reqjson);
    reqjson.cpsResponseType= formatresponsetype(reqjson);  
    reqjson.label = formatlabel(reqjson);
    var reqobj = getCPSreqobj(reqjson,request);
    if (reqobj.where.intakeserviceid == null) {
      Response = module.exports.generatepdf(reqobj,html,reqjson);
      return resolve(Response);
    }
    else {
      const sql = 'select * from getquickpersondetails($1,$2,null)';

      return util.executeDBQuery(sql,[reqobj.where.intakeserviceid,'case'])
        .then(data => {
          return data;
        })
        .then(data => {
          const getquickpersondetails = data[0].getquickpersondetails;
          if (getquickpersondetails) {
            const quickPersonHtml = quickCardPersonsDetails(resjson.quickpersondetails,'cps');
            html = html.replace(/{{quickPersonHtml}}/g,util.nullcheck(quickPersonHtml));
          }
          Response = module.exports.generatepdf(reqobj,html,reqjson);
          resolve(Response);
        })
        .catch(err => {
          LOGGER.error(err);
          return err;
        });
    }
  }).catch(err => {
    LOGGER.error(err);
    }); 
  }).catch(err =>{
    util.logError(err)});
};
function supervisorapprovalstatus(reqjson, supervisorApprovalDetail) {
  let approvalStatus = '';
  let label = '';
  if (supervisorApprovalDetail) {
    var submissionhistory = formatsubmissoinhistory(supervisorApprovalDetail);
    if (submissionhistory && submissionhistory.length > 0) {
      submissionhistory.forEach(item => {
        approvalStatus += `<tr>                    
                  <td style="text-align: left;">${util.nullcheck(item.fromname)}</td>
                  <td style="text-align: left;">${util.nullcheck(item.date)}</td>
                  <td style="text-align: left;">${util.nullcheck(item.name)}</td>
                  <td style="text-align: left;">${util.nullcheck(item.dateupdated)}</td>
                  <td style="text-align: left;">${util.nullcheck(item.status)}</td>
                  <td style="text-align: left;">${util.nullcheck(item.intakerecommendation)}</td>
                  <td style="text-align: left;">${util.nullcheck(item.supdecision)}</td>
              </tr>`
      });
    }
  }
  if (reqjson.REFERALSOURCE && reqjson.REFERALSOURCE.label) {
    label = reqjson.REFERALSOURCE.label;
  }
return {label, approvalStatus};
}
function getCPSIntakesdmData(reqjson) {
  let physicalAbuse = '';
  let sexualAbuse = '';
  let generalNeglect = '';
  let negfp_cargiverintervene = '';
  let negab_abandoned = '';
  let unattendedChild = '';
  let riskofHarm = '';
  let negmn_unreasonabledelay = '';
  let menab_psycologicalability = '';
  let menng_psycologicalability = '';
  let ScreenOUT = '';
  let Scrnin = '';
  let noOverrides = '';

  let keys = module.exports.sdmKeys(reqjson.sdmFormData.physicalAbuse);
  if (keys) {
    keys.forEach(key => {
      physicalAbuse += `<div class="row"><div class="col-xs-12 l"><span> ${util.nullcheck(reqjson.sdmJsonData[key])}</span></div></div>`;
    });
  }

  keys = module.exports.sdmKeys(reqjson.sdmFormData.sexualAbuse);
  if (keys) {
    keys.forEach(key => {
      sexualAbuse += `<div class="row"><div class="col-xs-12 l"><span> ${util.nullcheck(reqjson.sdmJsonData[key])}</span></div></div>`;
    });
  }

  keys = module.exports.sdmKeys(reqjson.sdmFormData.generalNeglect);
  if (keys) {
    keys.forEach(key => {
      generalNeglect += `<div class="row"><div class="col-xs-12 l"><span> ${(reqjson.sdmJsonData[key])}</span></div></div>`;
    });
  }

  if (reqjson.sdmFormData.negfp_cargiverintervene) {
    negfp_cargiverintervene += `<div class="row"> <div class="col-xs-3 l"><label>Failure to Protect:</label> </div>  </div> <div class="row"><div class="col-xs-12 l"><span> ${util.nullcheck(reqjson.sdmJsonData['negfp_cargiverintervene'])}</span></div></div>`;
  }

  if (reqjson.sdmFormData.negab_abandoned) {
    negab_abandoned += `<div class="row"> <div class="col-xs-3 l"><label>Abandonment:</label> </div> </div> <div class="row"><div class="col-xs-12 l"><span> ${util.nullcheck(reqjson.sdmJsonData['negab_abandoned'])}</span></div></div>`;
  }

  keys = module.exports.sdmKeys(reqjson.sdmFormData.unattendedChild);
  if (keys) {
    keys.forEach(key => {
      unattendedChild += `<div class="row"><div class="col-xs-12 l"><span> ${util.nullcheck(reqjson.sdmJsonData[key])}</span></div></div>`;
    });
  }

  keys = module.exports.sdmKeys(reqjson.sdmFormData.riskofHarm);
  if (keys) {
    keys.forEach(key => {
      riskofHarm += `<div class="row"><div class="col-xs-12 l"><span> ${util.nullcheck(reqjson.sdmJsonData[key])}</span></div></div>`;
    });
  }

  if (reqjson.sdmFormData.negmn_unreasonabledelay) {
    negmn_unreasonabledelay += `<div class="row">  <div class="col-xs-3 l"><label>Medical Neglect:</label> </div> </div><div class="row"><div class="col-xs-12 l"><span> ${util.nullcheck(reqjson.sdmJsonData['negmn_unreasonabledelay'])}</span></div></div>`;
  }

  if (reqjson.sdmFormData.menab_psycologicalability) {
    menab_psycologicalability += `<div class="row"> <div class="col-xs-3 l"><label>Abuse:</label> </div>  </div><div class="row"><div class="col-xs-12 l"><span> ${util.nullcheck(reqjson.sdmJsonData['menab_psycologicalability'])}</span></div></div>`;
  }

  if (reqjson.sdmFormData.menng_psycologicalability) {
    menng_psycologicalability += `<div class="row"> <div class="col-xs-3 l"><label>Neglect:</label> </div> </div><div class="row"><div class="col-xs-12 l"><span> ${util.nullcheck(reqjson.sdmJsonData['menng_psycologicalability'])}</span></div></div>`;
  }

  if (reqjson.sdmFormData.screeningRecommend === 'ScreenOUT') {
    ScreenOUT += `<div class="row"><div class="col-xs-12 l"><span> ${util.nullcheck(reqjson.sdmJsonData['ScreenOUT'])}</span></div></div>`;
  }

  if (reqjson.sdmFormData.screeningRecommend === 'Scrnin') {
    Scrnin += `<div class="row"><div class="col-xs-12 l"><span> ${util.nullcheck(reqjson.sdmJsonData['Scrnin'])}</span></div></div>`;
  }

  if (reqjson.sdmFormData.scnRecommendOveride !== 'OvrScrnout' && reqjson.sdmFormData.scnRecommendOveride !== 'Ovrscrnin') {
    noOverrides += `<div class="row"><div class="col-xs-12 l"><span>No overrides apply</span></div></div>`;
  }

  return {
    physicalAbuse,
    sexualAbuse,
    generalNeglect,
    negfp_cargiverintervene,
    negab_abandoned,
    unattendedChild,
    riskofHarm,
    negmn_unreasonabledelay,
    menab_psycologicalability,
    menng_psycologicalability,
    ScreenOUT,
    Scrnin,
    noOverrides
  }
}

function getnarrativeFormDataName(reqjson) {
  let narrativeFormDataName = '';
  if (reqjson.narrativeFormData && reqjson.narrativeFormData.IsUnknownReporter) {
    narrativeFormDataName += `<div class="row"><div class="col-xs-12 c"><span> REPORTER IS UNKNOWN</span></div></div>`;
  }
  if (reqjson.narrativeFormData && reqjson.narrativeFormData.IsAnonymousReporter) {
    narrativeFormDataName += `<div class="row"><div class="col-xs-12 c"><span> REPORTER IS ANONYMOUS</span></div></div>`;
  }
  if (reqjson.narrativeFormData && (reqjson.narrativeFormData.Firstname || reqjson.narrativeFormData.Lastname)) {
    narrativeFormDataName += `<div class="row"><div class="col-xs-12 c"><span> ${util.nullcheck(reqjson.narrativeFormData.Firstname)} ${util.nullcheck(reqjson.narrativeFormData.Lastname)}</span></div></div>`;
  }
  return narrativeFormDataName;
}

function getScreenData(reqjson) {
  let OvrScrnout = '';
  let Ovrscrnin = '';
  let finalscreeninOut = '';
  let keys;
  if (reqjson.sdmFormData.scnRecommendOveride === 'OvrScrnout') {
    OvrScrnout += `<div class="row"><div class="col-xs-12 l"><span> ${util.nullcheck(reqjson.sdmJsonData['OvrScrnout'])}</span></div></div>`;
    keys = module.exports.sdmKeys(reqjson.sdmFormData.screenOut);
    if (keys) {
      keys.forEach(key => {
        OvrScrnout += `<div class="row"><div class="col-xs-12 l"><span> - ${util.nullcheck(reqjson.sdmJsonData[key])}</span></div></div> 
										 <div class="row"><div class="col-xs-12 l"><span> - ${util.nullcheck(reqjson.sdmFormData.screenOut.scrnout_description)}</span></div></div>`;
      });
    }
  }

  if (reqjson.sdmFormData.scnRecommendOveride === 'Ovrscrnin') {
    Ovrscrnin += `<div class="row"><div class="col-xs-12 l"><span> ${util.nullcheck(reqjson.sdmJsonData['Ovrscrnin'])}</span></div></div>`;
    keys = module.exports.sdmKeys(reqjson.sdmFormData.screenOut);
    if (keys) {
      keys.forEach(key => {
        Ovrscrnin += `<div class="row"><div class="col-xs-12 l"><span> - ${util.nullcheck(reqjson.sdmJsonData[key])}</span></div></div> 
										<div class="row"><div class="col-xs-12 l"><span> - ${util.nullcheck(reqjson.sdmFormData.screenOut.scrnin_description)}</span></div></div>`;
      });
    }
  }

  if (reqjson.sdmFormData.isfinalscreenin !== null) {
    if (reqjson.sdmFormData.isfinalscreenin === 'false') {
      finalscreeninOut += `<div class="row"><div class="col-xs-12 l"><span> ${util.nullcheck(reqjson.sdmJsonData['isfinalscreeninOut'])}</span></div></div>`;
    }
    if (reqjson.sdmFormData.isfinalscreenin === 'true') {
      finalscreeninOut += `<div class="row"><div class="col-xs-12 l"><span> ${util.nullcheck(reqjson.sdmJsonData['isfinalscreeninIn'])}</span></div></div>`;
    }
  }
  return {
    OvrScrnout,
    Ovrscrnin,
    finalscreeninOut
  }
}

function getCPSreqobj(reqjson,request) {
  return {
    where: {
      intakenumber: reqjson.da_intakenumber ? reqjson.da_intakenumber : reqjson.intake.number,
      intakeserviceid: (reqjson.dsdsActionsSummary ? reqjson.dsdsActionsSummary.intakeserviceid : null),
      outputfilename: 'CPSIntakeReport.pdf'
    },
    documntkey: request.documntkey
  };
}

function checkCPSResponseType(reqjson) {
  return (reqjson && reqjson.intakeSDM && reqjson.intakeSDM.cpsResponseType) ? reqjson.intakeSDM.cpsResponseType : '';
}


module.exports.getcontactslogreport = function (request) {    // NOSONAR
  LOGGER.debug('-------------------entered---------------------');
  var reqjson = request.where;
  var html = '';
  let recording = '';
  html = fs.readFileSync('./documenttemplates/contactslogreport.html','utf8');
  var searchjson = {};
  if (reqjson.searchjson) {
    searchjson = reqjson.searchjson;
  }
  searchjson["pagenumber"] = 1; // unused
  searchjson["pagesize"] = 10;  // unused
  searchjson["servicerequestid"] = emptyStrCheck(reqjson.intakeserviceid);
  searchjson["nolimit"] = true;
  if (!searchjson.sortDir) {
    searchjson.sortDir = 'asc';
  }
  var sql = 'select * from getalldarecordings(\'' + JSON.stringify(searchjson) + '\') ';
  if (searchjson && searchjson.sortBy && searchjson.sortBy == 'personcontacted') {
    sql = sql + " ORDER BY (contactparticipant::json->0->>'firstname') " + searchjson.sortDir;
  } else if (searchjson && searchjson.sortBy && searchjson.sortDir) {
    sql = sql + ' ORDER BY ' + searchjson.sortBy + ' ' + searchjson.sortDir;
  } else {
    sql = sql + ' ORDER BY contactdate desc';
  }
  return util.executeDBQuery(sql,[])
    .then(data => {
      if (data.length > 0) {
        reqjson.recording = data;
        if (reqjson.recording && reqjson.recording.length > 0) {
          reqjson.recording.forEach(record => {
            //calculate duration
            clogcomputedDuration(record);
            //end calculate duration
            var contactdate = formatDate(record.contactdate);
            var recordingdate = formatDate(record.recordingdate);

            const contactparticipant = getclogcontactparticipant(record);

            recording += `<div class="row">
          <table class="table">
            <thead>
                <th>Entered By</th>
                <th>Entry Date</th>
                <th>Authored by</th>
                <th>Contact Date</th>
                <th>Contact Type</th>
                <th>Contact Location</th>
                <th>Contact Status</th>
                <th>Duration</th>
            </thead>
            <tbody>
              <tr>
                <td>${record.author}</td>
                <td>${recordingdate}</td>
                <td>${record.author}</td>
                <td>${contactdate}</td>
                <td>${record.recordingtype}</td>
                <td>${record.recordingsubtype}</td>
                <td>${getclogcontactstatus(record)}</td>
                <td>${record.duration}</td>
              </tr>
            </tbody>
            <tr><td> </td></tr>
            <thead>
                <th colspan="8" style="border-bottom: 0px;border: 0px">Participants: </th>
            </thead>
            ${contactparticipant}
          </table>
      </div>
      `
          });
        }

        reqjson.recording = recording;
        reqjson.currentdate = formatDate(reqjson.currentdate);
        reqjson.da_intakenumber = reqjson.casetype == 'Intake' ? reqjson.intakeserviceid : null;
        reqjson.intakeserviceid = reqjson.casetype == 'Intake' ? null : reqjson.intakeserviceid;

        var reqobj = {
          where: {
            intakenumber: reqjson.da_intakenumber,
            intakeserviceid: reqjson.intakeserviceid,
            outputfilename: 'ContactsLogReport.pdf'
          },
          documntkey: request.documntkey
        };
        reqjson.root_template_path_style = config.documenttemplates;
        Response = module.exports.generatepdf(reqobj,html,reqjson);
        return Response;
      }
    })
    .catch(err => {
        LOGGER.error(err);
        return err;
    })
};

function clogcomputedDuration(record){
  if (record.old_id && record.starttime) {
    const startdate = clogmoment(record.starttime);
    if (startdate && record.totaltime) {
      const totaltime = String(record.totaltime).split(":");
      if (totaltime && Array.isArray(totaltime) && totaltime.length > 1) {
        record.endtime = moment(startdate).add(totaltime[0],'hours').add(totaltime[1],'minutes');
      }
    }
  }
  // Combine the contact date with each time-of-day, parsing with an explicit
  // format so moment does not fall back to js Date(). An unset/unparseable
  // start or end time previously formatted to the literal 'Invalid date' and
  // was concatenated into the input string, which is what triggered the
  // deprecation warning.
  const _contactDate = clogmoment(record.contactdate);
  const _startTime = clogdatetime(_contactDate, record.starttime);
  const _endTime = clogdatetime(_contactDate, record.endtime);
  if (_startTime && _endTime) {
    const computedDuration = moment.duration(_endTime.diff(_startTime));
    if (computedDuration['_data']) {
      record.duration = computedDuration['_data'].hours + ' Hr(s) ' + computedDuration['_data'].minutes + ' Min(s)';
    }
  } else {
    record.duration = '0 Hr(s) 0 Min(s)';
  }
}

// Builds a moment without hitting the deprecated js Date() fallback. Date
// objects and existing moments pass straight through; strings are matched
// against the formats these recordings actually carry.
function clogmoment(value) {
  if (value === undefined || value === null || value === '') {
    return null;
  }
  if (moment.isMoment(value)) {
    return value.isValid() ? value : null;
  }
  if (value instanceof Date) {
    const _date = moment(value);
    return _date.isValid() ? _date : null;
  }
  const parsed = moment(String(value),
    [moment.ISO_8601, dtformat_datetime, dtformat, 'MM/DD/YYYY HH:mm', 'HH:mm:ss', 'HH:mm'], true);
  return parsed.isValid() ? parsed : null;
}

// Returns a moment for contactdate at the given time-of-day, or null when
// either part is missing/unparseable.
function clogdatetime(contactdate, time) {
  if (!contactdate || !contactdate.isValid()) {
    return null;
  }
  const _time = clogmoment(time);
  if (!_time) {
    return null;
  }
  const combined = moment(contactdate.format(dtformat) + ' ' + _time.format('HH:mm:ss'), dtformat_datetime, true);
  return combined.isValid() ? combined : null;
}

function getclogcontactparticipant(record) {
  let contactparticipant = '';
  if (record.contactparticipant && record.contactparticipant.length > 0) {
    record.contactparticipant.forEach(contactprtpnt => {
      const name = (contactprtpnt.lastname || contactprtpnt.firstname) ? (contactprtpnt.firstname + ' ' + contactprtpnt.lastname) : '';
      contactparticipant += `
          <tr>
                <td colspan="8" style="border-bottom: 0px;border: 0px">${name}</td>
          </tr>      
          `;
    });
  }
  return contactparticipant;
}

function getclogcontactstatus(record){
  return (record.contactstatus) ? 'Completed' : 'Attempted';
}

module.exports.sdmKeys = function (obj) {
  if (obj) {
      const sdmObject = [];
      Object.keys(obj).forEach(key => {
          if (obj[key] === true) {
              sdmObject.push(key);
          }
      });
      return sdmObject;
  }
}

module.exports.htmlMapJson = function (html,json) {
  LOGGER.debug("html", html);
  LOGGER.debug("json", json);
  for(var key in json){
    html = html.replace('{{'+key+'}}',json[key]);
  }
  LOGGER.debug(html);
  return html;
};

//caseplansocialhistory
module.exports.caseplansocialhistory = function (request,response) {
  request.documntkey = request.where.documenttemplatekey; 
  let Response;
  
  var html = fs.readFileSync('./documenttemplates/SocialHistory.html', 'utf8');  
  html = html.replace('{{htmlchildname}}', util.nullcheck(request.where.name));
  html = html.replace('{{htmlclientid}}', util.nullcheck(request.where.clientId));
  html = html.replace('{{htmldateofremoval}}', util.nullcheck(request.where.removaldate));
  html = html.replace('{{htmlrace}}', util.nullcheck(request.where.racetypekey));
  html = html.replace('{{htmlsex}}', util.nullcheck(request.where.gender));
  html = html.replace('{{htmlbirthdate}}', util.nullcheck(request.where.dob));
  html = html.replace('{{htmlsecuritynumber}}', util.nullcheck(request.where.ssn));
  html = html.replace('{{htmlreligion}}', util.nullcheck(request.where.religion));
  html = html.replace('{{htmlparent1}}', util.nullcheck(request.where.parent1name));
  html = html.replace('{{htmlparent2}}', util.nullcheck(request.where.parent2name));
  html = html.replace('{{htmlchildplacement}}', util.nullcheck(request.where.removaladd1));
  html = html.replace('{{htmlriskassesmnt}}', util.nullcheck(request.where.riskassessupdatedon));
  html = html.replace('{{htmlsafetyassement}}', util.nullcheck(request.where.safeassessupdatedon));
  html = html.replace('{{htmlreasonableefforts}}', util.nullcheck(request.where.removalinfo));
  html = html.replace('{{htmldescribeplacement}}', util.nullcheck(request.where.placement));
  html = html.replace('{{htmlfamilyhistory}}', util.nullcheck(request.where.familyhistory));
  html = html.replace('{{htmlchildentry}}', util.nullcheck(request.where.childdesc));
  
  request.where.outputfilename = "CasePlanSocialHistory";
  
  if(request.where.zippdf){
    Response = module.exports.generatepdf(request, html, {},{ type: 'report', res: response });
  }
  else{
    Response = module.exports.generatepdf(request, html);
  }
  return Response;
  
 
};



function formatDate(date) {
  var d = new Date(date),
      month = '' + (d.getMonth() + 1),
      day = '' + d.getDate(),
      year = d.getFullYear();

  if (month.length < 2){ 
    month = '0' + month;
  }
  if (day.length < 2){ 
    day = '0' + day;
  }

  return [month, day , year].join('/');
}


//==========================================================================
//  DHR 111 Provider Payment  Detail Report 
module.exports.child111report = function (request,response) {
  var clientid = request.where.clientid;

  const sql = 'select * from getchild111report($1,$2,$3,$4)';
  let Response;
  let childjson = [];
  const format = request.where.format;
  let case_id;
  let case_name;
  let cisclientid;
  let client_id;
  let client_name;
  let from;
  let to;
  let run_date;
  let transactionelement = '';
  let transactionheader = '';

  //  DHR 111 Provider Payment  Detail Report 
  return util.executeDBQuery(sql,[clientid,request.where.date_sw,request.where.date_from,request.where.date_to])
    .then(async data => {
      if (data.length > 0) {
        LOGGER.debug("data[0].child111report :: ",data[0]);
        childjson = JSON.parse(JSON.stringify(data[0]));
        LOGGER.debug("data[1].child111report :: ",childjson.child111report);
        childjson = childjson.child111report;

        if (childjson == null) {
          return { "is_norecord": true };
        }
        case_id = childjson[0].case_id;
        case_name = childjson[0].case_nm;
        client_id = childjson[0].cjamspid;
        cisclientid = emptyStrCheck(childjson[0].cisclientid);
        client_name = childjson[0].personname;
        run_date = new Date();
        from = request.where.date_from;
        to = request.where.date_to;
        LOGGER.debug(run_date);
        LOGGER.debug(case_id);
        request.where.outputfilename = "dhr111-" + clientid;
        
        transactionheader = '<tr>' +
          thPayidTag +
          '<th>PAYMENT DATE</th>' +
          '<th style="min-width:250px">FISCAL CATEGORY</th>' +
          '<th>PROVIDER ID</th>' +
          '<th style="min-width:220px">PAYEE</th>' +
          thpaytypeTag +
          '<th>SERVICE START DATE</th>' +
          '<th>SERVICE END DATE</th>' +
          thgrossAmtTag +
          '<th>RECEIVABLE AMOUNT</th>' +
          thnetAmtTag +
          thcheckTag +
          '<th>CHECK DATE</th>' +
          '<th>CHECK STATUS</th>' +
          '<th>AFS/FMIS PAYMENT STATUS</th>' +
          '</tr>';

          transactionelement += get111transactionelement(childjson, transactionheader)

        var html = ''
        if (format == 'pdf') {
          html = fs.readFileSync('./documenttemplates/dhs111.html','utf8');
        }
        html = html.replace(logopath,app.baseurl);
        html = html.replace(/{{case_id}}/g,case_id);
        html = html.replace(/{{case_name}}/g,case_name);
        html = html.replace(/{{client_id}}/g,client_id);
        html = html.replace(/{{cisclientid}}/g,cisclientid);
        html = html.replace(/{{client_name}}/g,client_name);
        html = html.replace(/{{from}}/g,from);
        html = html.replace(/{{to}}/g,to);
        html = html.replace(/{{run_date}}/g, dateCheck(run_date, dtformat));
        html = html.replace(/{{transactiondetails}}/g,transactionelement);
        html = html.replace(/{{transactionheader}}/g,transactionheader);

        if (format == 'excel') {

          const workbook = new Excel.Workbook();
          const worksheet = workbook.addWorksheet(request.where.outputfilename);
          var imageId2 = workbook.addImage({
            buffer: fs.readFileSync(dhslogopath),
            extension: 'png',
          });
          LOGGER.debug(clientid + "client_id");
          worksheet.addImage(imageId2,'A1:B2');
          worksheet.getCell('E4').value = 'DHS 111 Client Expenditure Report';
          worksheet.getCell('A6').value = 'Case ID:';
          worksheet.getCell('B6').value = case_id;
          worksheet.getCell('A7').value = 'Case Name:';
          worksheet.getCell('B7').value = case_name;
          worksheet.getCell('E6').value = 'Client ID:';
          worksheet.getCell('F6').value = client_id;
          worksheet.getCell('E7').value = 'Client Name:';
          worksheet.getCell('F7').value = client_name;
          worksheet.getCell('I6').value = 'CIS ID:';
          worksheet.getCell('J6').value = cisclientid;
          worksheet.getCell('I7').value = 'Run Date:';
          worksheet.getCell('J7').value = run_date;
          worksheet.getCell('M6').value = 'From:';
          worksheet.getCell('N6').value = from;
          worksheet.getCell('M7').value = 'To:';
          worksheet.getCell('N7').value = to;

          worksheet.getRow(10).values = ['PAYMENT_ID','PAYMENT_DATE','FISCAL_CATEGORY','PROVIDER ID','PAYEE',
            'PAYMENT_TYPE','SERVICE_START_DATE','SERVICE_END_DATE','GROSS_AMOUNT'
            ,'RECEIVABLE_AMOUNT','NET_AMOUNT','CHECK#','CHECK_DATE','CHECK_STATUS','AFS/FMIS PAYMENT_STATUS'];
          let row = 11;
          if (Array.isArray(childjson)) {

            childjson.forEach(element => {
              LOGGER.debug(currencyFormatter.format(element.gross_amount_no,{ code: 'USD' }));
              worksheet.getRow(row).values = [element.payment_id,element.payment_dt,element.fiscal_category,element.provider_id,element.providername,
              element.payment_type_nm,element.final_service_start_dt,element.final_service_end_dt,
              Number(element.gross_amount_no),
              Number(element.receivable_balance_no),
              Number(element.net_amount),
              element.check_no,
              element.check_dt,
              element.check_status,
              element.payment_status];
              worksheet.getCell('I' + row).numFmt = numFmtStr;
              worksheet.getCell('J' + row).numFmt = numFmtStr;
              worksheet.getCell('K' + row).numFmt = numFmtStr;
              row += 1;
            });
          }

          var fileName = `${request.where.outputfilename}.${request.where.format}`;
          response.setHeader(contenttypestr,spreadsheetcontenttype);
          response.setHeader(contentdispositionstr,attachmentstr + fileName);
          if (format === 'excel') {
            await workbook.xlsx.write(response)
              .then(() => response.end());
          } else if (format === 'csv') {
            await workbook.csv.write(response)
              .then(() => response.end());
          }
        } else {
          Response = module.exports.generatepdf(request,html,{ landscape: 'Landscape' },{
            type: 'report',
            res: response
          });
          return Response;
        }
      }
    })
    .catch(err => {
      LOGGER.error(err);
      return err;
    })
};

function get111transactionelement(childjson, transactionheader){
  let transactionelement = '';
  let grosstotal = 0;
  let receivabletotal = 0;
  let nettotal = 0;
  let rowCount = 11
  if (Array.isArray(childjson)) {
    childjson.forEach((element,index) => {
      transactionelement += '<tr><td>' + element.payment_id + '</td><td>' +
        dateCheck(element.payment_dt, dtformat) + '</td><td>' +
        util.nullcheck(element.fiscal_category) + '</td><td>' +
        element.provider_id + '</td><td>' +
        element.providername + '</td><td>' +
        element.payment_type_nm + '</td><td>' +
        dateCheck(element.final_service_start_dt, dtformat) + '</td><td>' +
        dateCheck(element.final_service_end_dt, dtformat) + '</td>' + tdStyleRightTag +
        currencyFormatter.format(element.gross_amount_no,{ code: 'USD' }) + '</td>' + tdStyleRightTag +
        currencyFormatter.format(element.receivable_balance_no,{ code: 'USD' }) + '</td>' + tdStyleRightTag +
        currencyFormatter.format(element.net_amount,{ code: 'USD' }) + '</td><td>' +
        util.nullcheck(element.check_no) + '</td><td>' +
        dateCheck(element.check_dt, dtformat) + '</td><td>' +
        util.nullcheck(element.check_status) + '</td><td>' +
        util.nullcheck(element.payment_status) + tdclosetags;

      grosstotal = grosstotal + parseFloat(util.nullcheck(element.gross_amount_no));
      receivabletotal = receivabletotal + parseFloat(util.nullcheck(element.receivable_balance_no));
      nettotal = nettotal + parseFloat(util.nullcheck(element.net_amount));

      if (index == rowCount) {
        transactionelement += transactionheader;
        rowCount += 15;
      }

    });

    if (transactionelement != '') {
      transactionelement += '<tr><td colspan="8" align="right">Total Client Expenditure</td><td align="right">' +
        currencyFormatter.format(grosstotal,{ code: 'USD' }) + '</td>' + tdStyleRightTag +
        currencyFormatter.format(receivabletotal,{ code: 'USD' }) + '</td>' + tdStyleRightTag +
        currencyFormatter.format(nettotal,{ code: 'USD' }) + '</td><td colspan="4"></td></tr>';
    }
  }
  return transactionelement;
}


//==========================================================================
//  DHS 114 Provider Payment  History Summary Report 
module.exports.child114report = function (request,response) {
  var providerid = request.where.providerid;

  const sql = 'select * from getprovider114report($1,$2,$3,$4)';
  let Response;
  let childjson = [];
  const format = request.where.format;
  let transactionElement = '';
  let transactionHeader = '';
  let provider_id;
  let provider_name;
  let taxid;
  let mail_code_tx;
  let tax_id_type;
  var from;
  var to;
  var run_date;
  var grosstotal = 0;
  var offsettotal = 0;
  var nettotal = 0;

  //  DHS 114 Provider Payment History Summary Report 
  return util.executeDBQuery(sql,[providerid,request.where.date_sw,request.where.date_from,request.where.date_to])
    .then(async data => {
      if (data.length > 0) {
        LOGGER.debug("data[0].child114report :: ",data[0]);
        childjson = JSON.parse(JSON.stringify(data[0]));
        LOGGER.debug("data[1].child114report :: ",childjson.child114report);
        childjson = childjson.child114report;
      }

      if (childjson == null) {
        return { "is_norecord": true };
      }
      if (Array.isArray(childjson)) {
        provider_id = childjson[0].provider_id;
        provider_name = childjson[0].provider_nm;
        taxid = childjson[0].taxid;
        mail_code_tx = childjson[0].mail_code_tx;
        tax_id_type = childjson[0].tax_id_type;
        from = request.where.date_from;
        to = request.where.date_to;
        run_date = childjson[0].run_date;

        request.where.outputfilename = "DHS114-" + providerid;

        transactionHeader = '<tr>' +
          thPayidTag +
          '<th>PAYMENT DATE </th>' +
          '<th> PAYMENT STATUS</th>' +
          '<th>CASE ID</th>' +
          '<th>CASE NAME</th>' +
          '<th>CLIENT ID</th>' +
          '<th>CLIENT NAME</th>' +
          '<th>FISCAL CATEGORY</th>' +
          '<th>SERVICE START DATE</th>' +
          '<th>SERVICE END DATE</th>' +
          '<th> CLIENT GROSS AMOUNT</th>' +
          '<th>RECEIVABLE AMOUNT</th>' +
          '<th>CLIENT NET AMOUNT</th>' +
          '<th>LOCAL DEPARTMENT</th>' +
          thpaytypeTag +
          '<th>CHECK STATUS</th>' +
          thcheckTag +
          '<th>CHECK DATE</th>' +
          thgrossAmtTag +
          '<th>OFFSET AMOUNT</th>' +
          thnetAmtTag +
          '</tr>';
        childjson.forEach((element,index) => {

          transactionElement += '<tr><td>' + element.payment_id + '</td>' +
            ' <td>' + dateCheck(element.payment_dt, dtformat) + '</td>' +
            '<td>' + util.nullcheck(element.payment_status) + '</td>' +
            '<td>' + element.case_id + '</td>' +
            '<td>' + util.nullcheck(element.case_nm) + '</td>' +
            '<td>' + element.client_id + '</td>' +
            '<td>' + element.personname + '</td>' +
            '<td>' + element.fiscal_category + '</td>' +
            '<td>' + dateCheck(element.final_service_start_dt, dtformat) + '</td>' +
            '<td>' + dateCheck(element.final_service_end_dt, dtformat) + '</td>' +
            tdStyleRightTag + currencyFormatter.format(element.client_gross_amount,{ code: 'USD' }) + '</td>' +
            tdStyleRightTag + currencyFormatter.format(element.receivable_amount,{ code: 'USD' }) + '</td>' +
            tdStyleRightTag + currencyFormatter.format(element.client_net_amount,{ code: 'USD' }) + '</td>' +
            '<td>' + element.local_department + '</td>' +
            '<td>' + element.payment_type_nm + '</td>' +
            '<td>' + util.nullcheck(element.check_status) + '</td>' +
            '<td>' + util.nullcheck(element.check_no) + '</td>' +
            '<td>' + dateCheck(element.check_dt, dtformat) + '</td>' +
            tdStyleRightTag + currencyFormatter.format(element.gross_amount,{ code: 'USD' }) + '</td>' +
            tdStyleRightTag + currencyFormatter.format(element.offset_amount,{ code: 'USD' }) + '</td>' +
            tdStyleRightTag + currencyFormatter.format(element.net_amount,{ code: 'USD' }) + '</td>' +
            '</tr>';
          grosstotal = grosstotal + parseFloat(util.nullcheck(element.gross_amount));
          offsettotal = offsettotal + parseFloat(util.nullcheck(element.offset_amount));
          nettotal = nettotal + parseFloat(util.nullcheck(element.net_amount));

        });

        if (transactionElement != '') {
          transactionElement += '<tr><td colspan="18" align="right">Total Client Expenditure</td><td align="right">' +
            currencyFormatter.format(grosstotal,{ code: 'USD' }) + '</td>' + tdStyleRightTag +
            currencyFormatter.format(offsettotal,{ code: 'USD' }) + '</td>' + tdStyleRightTag +
            currencyFormatter.format(nettotal,{ code: 'USD' }) + tdclosetags;
        }
      }

      var html = ''
      if (format == 'pdf') {
        html = fs.readFileSync('./documenttemplates/dhs114.html','utf8');
        html = html.replace(logopath,app.baseurl);
        html = html.replace(/{{provider_id}}/g,provider_id);
        html = html.replace(/{{provider_name}}/g,provider_name);
        html = html.replace(/{{taxid}}/g,taxid);
        html = html.replace(/{{mail_code_tx}}/g,mail_code_tx);
        html = html.replace(/{{tax_id_type}}/g,tax_id_type);
        html = html.replace(/{{from}}/g,from);
        html = html.replace(/{{to}}/g,to);
        html = html.replace(/{{run_date}}/g, dateCheck(run_date, dtformat));
        html = html.replace(/{{transactionElement}}/g,transactionElement);
        html = html.replace(/{{transactionHeader}}/g,transactionHeader);
      }

      if (format == 'excel') {

        const workbook = new Excel.Workbook();
        const worksheet = workbook.addWorksheet(request.where.outputfilename);
        var imageId2 = workbook.addImage({
          buffer: fs.readFileSync(dhslogopath),
          extension: 'png',
        });
        worksheet.addImage(imageId2,'A1:B2');
        worksheet.getCell('C4').value = 'DHS 114 - Provider Payment History - Detail Report';
        worksheet.getCell('B6').value = provideridstr;
        worksheet.getCell('C6').value = provider_id;

        worksheet.getCell('B7').value = providernamestr;
        worksheet.getCell('C7').value = provider_name;

        worksheet.getCell('B8').value = 'Tax ID';
        worksheet.getCell('C8').value = taxid;

        worksheet.getCell('E8').value = 'Mail Code';
        worksheet.getCell('F8').value = mail_code_tx;

        worksheet.getCell('B9').value = 'Tax ID Type';
        worksheet.getCell('C9').value = tax_id_type;

        worksheet.getCell('H6').value = 'Run Date';
        worksheet.getCell('I6').value = run_date;
        worksheet.getCell('H7').value = 'From Date';
        worksheet.getCell('I7').value = from;
        worksheet.getCell('H8').value = 'To Date';
        worksheet.getCell('I8').value = to;

        worksheet.getRow(11).values = ['PAYMENT_ID','PAYMENT_DATE','PAYMENT_STATUS','CASE_ID','CASE_NAME','CLIENT_ID','CLIENT_NAME','FISCAL_CATEGORY','SERVICE_START_DATE','SERVICE_END_DATE','CLIENT_GROSS_AMOUNT','RECEIVABLE_AMOUNT','CLIENT_NET_AMOUNT','LOCAL_DEPARTMENT','PAYMENT_TYPE','CHECK_STATUS','CHECK#','CHECK_DATE','GROSS_AMOUNT','OFFSET_AMOUNT','NET_AMOUNT'];
        let row = 12;
        if (Array.isArray(childjson)) {
          childjson.forEach(element => {

            worksheet.getRow(row).values = [element.payment_id,
            element.payment_dt,element.payment_status,element.case_id
              ,element.case_nm,element.client_id,element.personname,element.fiscal_category,
            element.final_service_start_dt,
            element.final_service_end_dt,
            Number(element.client_gross_amount),
            Number(element.receivable_amount),
            Number(element.client_net_amount)
              ,element.local_department,
            element.payment_type_nm,element.check_status,
            element.check_no,element.check_dt,
            Number(element.gross_amount),
            Number(element.offset_amount),
            Number(element.net_amount)
            ];
            worksheet.getCell('K' + row).numFmt = numFmtStr;
            worksheet.getCell('L' + row).numFmt = numFmtStr;
            worksheet.getCell('M' + row).numFmt = numFmtStr;
            worksheet.getCell('S' + row).numFmt = numFmtStr;
            worksheet.getCell('T' + row).numFmt = numFmtStr;
            worksheet.getCell('U' + row).numFmt = numFmtStr;
            row += 1;
          });
        }

        var fileName = `${request.where.outputfilename}.${request.where.format}`;
        response.setHeader(contenttypestr,spreadsheetcontenttype);
        response.setHeader(contentdispositionstr,attachmentstr + fileName);
        if (format === 'excel') {
         await workbook.xlsx.write(response)
            .then(() => response.end());
        } else if (format === 'csv') {
         await workbook.csv.write(response)
            .then(() => response.end());
        }
      } else {
        Response = module.exports.generatepdf(request,html,{},{
          type: 'report',
          res: response
        });
        return Response;
      }
    })
    .catch(err => {
      LOGGER.error(err);
      return err;
    })
};


//==========================================================================
//  DHR 113 Provider Payment  History Summary Report 
module.exports.child113report = function (request,response) {
  var providerid = request.where.providerid;

  const sql = 'select * from getprovider113report($1,$2,$3,$4)';
  let Response;
  let childjson = [];
  const format = request.where.format;
  let transactionElement = '';
  let transactionHeader = '';

  //  DHR 113 Provider Payment History Detail Report 
  return util.executeDBQuery(sql,[providerid,request.where.date_sw,request.where.date_from,request.where.date_to])
    .then(async (data) => {
      if (data.length > 0) {
        LOGGER.debug("data[0].child113report :: ",data[0]);
        childjson = JSON.parse(JSON.stringify(data[0]));
        LOGGER.debug("data[1].child113report :: ",childjson.child113report);
        childjson = childjson.child113report;
      }
      if (childjson == null) {
        return { "is_norecord": true };
      }
      else {
        let providername = '';
        let taxid = '';
        let mailcode = '';
        let run_date = '';
        let from = '';
        let to = '';
        let tax_id_type = '';
        let acconts_receivable = '';
        if (Array.isArray(childjson)) {

          providername = childjson[0].provider_nm;
          taxid = childjson[0].taxid;
          mailcode = childjson[0].mail_code_tx;
          run_date = new Date();
          from = request.where.date_from;
          to = request.where.date_to;
          tax_id_type = childjson[0].tax_id_type;
          acconts_receivable = childjson[0].acconts_receivable;
          
          LOGGER.debug(run_date);
          request.where.outputfilename = "DHS113-" + providerid;

          transactionHeader = '<tr>' +
            thPayidTag +
            '<th>PAYMENT DATE</th>' +
            thcheckTag +
            '<th>CHECK STATUS </th>' +
            '<th>AFS/FMIS PAYMENT STATUS</th>' +
            thpaytypeTag +
            thgrossAmtTag +
            '<th>OFFSET AMOUNT</th>' +
            thnetAmtTag +
            '</tr>';

            transactionElement += get113transactionElement(childjson)
         


        }

        acconts_receivable = currencyFormatter.format(acconts_receivable,{ code: 'USD' });

        var html = ''
        if (format == 'pdf') {
          html = fs.readFileSync('./documenttemplates/dhs113.html','utf8');
          html = html.replace(logopath,app.baseurl);
          html = html.replace(/{{providerid}}/g,providerid);
          html = html.replace(/{{providername}}/g,providername);
          html = html.replace(/{{taxid}}/g,taxid);
          html = html.replace(/{{mailcode}}/g,mailcode);
          html = html.replace(/{{tax_id_type}}/g,tax_id_type);
          html = html.replace(/{{from}}/g,from);
          html = html.replace(/{{to}}/g,to);
          html = html.replace(/{{acconts_receivable}}/g,acconts_receivable);
          html = html.replace(/{{run_date}}/g, dateCheck(run_date, dtformat));
          html = html.replace(/{{transactionElement}}/g,transactionElement);
          html = html.replace(/{{transactionHeader}}/g,transactionHeader);
        }

        if (format == 'excel') {
          const workbook = await new Excel.Workbook();
          const worksheet = await workbook.addWorksheet(request.where.outputfilename);

          var imageId2 = workbook.addImage({
            buffer: fs.readFileSync(dhslogopath),
            extension: 'png',
          });
          worksheet.addImage(imageId2,'A1:B2');
          worksheet.getCell('D4').value = 'DHS 113 Provider Payment History Summary Report';


          worksheet.getCell('A6').value = provideridstr;
          worksheet.getCell('B6').value = providerid;
          worksheet.getCell('A7').value = providernamestr;
          worksheet.getCell('B7').value = providername;
          worksheet.getCell('A8').value = 'Tax ID';
          worksheet.getCell('B8').value = taxid;
          worksheet.getCell('A9').value = 'Mail Code';
          worksheet.getCell('B9').value = mailcode;

          worksheet.getCell('G6').value = 'Run Date';
          worksheet.getCell('H6').value = run_date;
          worksheet.getCell('G7').value = 'From Date';
          worksheet.getCell('H7').value = from;
          worksheet.getCell('I7').value = 'To Date';
          worksheet.getCell('J7').value = to;
          worksheet.getCell('G8').value = 'Tax ID Type';
          worksheet.getCell('H8').value = tax_id_type;
          worksheet.getCell('G9').value = 'Accounts Receivable';
          worksheet.getCell('H9').value = acconts_receivable;

          worksheet.getRow(11).values = ['PAYMENT_ID','PAYMENT_DATE','CHECK#','CHECK_STATUS','AFS/FMIS PAYMENT STATUS','PAYMENT TYPE','GROSS AMOUNT','OFFSET AMOUNT','NET AMOUNT'];
          let row = 12;
          if (Array.isArray(childjson)) {
            childjson.forEach(element => {

              worksheet.getRow(row).values = [element.payment_id,element.payment_dt,
              element.check_no,element.check_status,element.payment_status,
              element.payment_type_nm,
              Number(element.gross_amount),
              Number(element.offset_amount),
              Number(element.net_amount)];
              worksheet.getCell('G' + row).numFmt = numFmtStr;
              worksheet.getCell('H' + row).numFmt = numFmtStr;
              worksheet.getCell('I' + row).numFmt = numFmtStr;
              row += 1;
            });
          }

          var fileName = `${request.where.outputfilename}.${request.where.format}`;
          response.setHeader(contenttypestr,spreadsheetcontenttype);
          response.setHeader(contentdispositionstr,attachmentstr + fileName);
          await workbook.xlsx.write(response)
              .then(() => response.end());
        } else {
          Response = module.exports.generatepdf(request,html,{ landscape: 'Landscape' },{
            type: 'report',
            res: response
          });
          return Response;
        }

      }
    })
};

function get113transactionElement(childjson){
  let grosstotalnum = 0;
  let offsettotal = 0;
  let nettotalnum = 0;
  let transactionElement = '';
  childjson.forEach((element,index) => {

    transactionElement += '<tr><td>' + element.payment_id + '</td>' +
      ' <td>' + dateCheck(element.payment_dt, dtformat) + '</td>' +
      '<td>' + util.nullcheck(element.check_no) + '</td>' +
      '<td>' + util.nullcheck(element.check_status) + '</td>' +
      '<td>' + util.nullcheck(element.payment_status) + '</td>' +
      '<td>' + element.payment_type_nm + '</td>' +
      tdStyleRightTag + currencyFormatter.format(element.gross_amount,{ code: 'USD' }) + '</td>' +
      tdStyleRightTag + currencyFormatter.format(element.offset_amount,{ code: 'USD' }) + '</td>' +
      tdStyleRightTag + currencyFormatter.format(element.net_amount,{ code: 'USD' }) + '</td>' +
      '</tr>';
    grosstotalnum = grosstotalnum + parseFloat(util.nullcheck(element.gross_amount));
    offsettotal = offsettotal + parseFloat(util.nullcheck(element.offset_amount));
    nettotalnum = nettotalnum + parseFloat(util.nullcheck(element.net_amount));

  });

  if (transactionElement !== '') {
    transactionElement += '<tr><td colspan="6" align="right">Total Client Expenditure</td><td align="right">' +
      currencyFormatter.format(grosstotalnum,{ code: 'USD' }) + '</td>' + tdStyleRightTag +
      currencyFormatter.format(offsettotal,{ code: 'USD' }) + '</td>' + tdStyleRightTag +
      currencyFormatter.format(nettotalnum,{ code: 'USD' }) + tdclosetags;
  }
  return transactionElement;
}

//==========================================================================
//  DHS 115 Provider AR  History  Report 
module.exports.child115report = function (request,response) {
  var providerid = request.where.providerid;

  const sql = 'select * from getchild115report($1,$2,$3,$4)';
  let Response;
  let childjson = [];
  const format = request.where.format;
  
  //  DHS 115 Provider AR  History  Report 
  return util.executeDBQuery(sql,[providerid,request.where.date_sw,request.where.date_from,request.where.date_to])
  .then(async data => {
    if (data.length > 0) {
      LOGGER.debug("data[0].child115report :: ",data[0]);
      childjson = JSON.parse(JSON.stringify(data[0]));
      LOGGER.debug("data[1].child115report :: ",childjson.child115report);
      childjson = childjson.child115report;
    }

  if (childjson == null) {
    return { "is_norecord": true };
  }
  else {
    var run_date = new Date();
    var from = request.where.date_from;
    var to = request.where.date_to;
    request.where.outputfilename = "DHS115-" + providerid;
    if (format == 'excel') {

      const workbook = new Excel.Workbook();
      const worksheet = workbook.addWorksheet(request.where.outputfilename);
      var imageId2 = workbook.addImage({
        buffer: fs.readFileSync(dhslogopath),
        extension: 'png',
      });
      worksheet.addImage(imageId2,'A1:B2');
      worksheet.getCell('D4').value = 'DHS 115 Provider AR History Report';
      var providername = childjson[0].provider_name;
      var taxid = childjson[0].taxid;
      var mailcode = childjson[0].mail_code;
      var provider_ar_status = childjson[0].provider_ar_status;
      var total_balance_due = childjson[0].total_balance_due;
      var collection_responsibility = childjson[0].collection_responsibility;
      worksheet.getCell('A6').value = provideridstr;
      worksheet.getCell('B6').value = providerid;
      worksheet.getCell('A7').value = providernamestr;
      worksheet.getCell('B7').value = providername;
      worksheet.getCell('A8').value = 'Total Balance Due';
      worksheet.getCell('B8').value = total_balance_due;
      worksheet.getCell('A9').value = 'Collection Responsibility';
      worksheet.getCell('B9').value = collection_responsibility;
      worksheet.getCell('D6').value = 'Provider AR Status';
      worksheet.getCell('E6').value = provider_ar_status;
      worksheet.getCell('D7').value = 'Tax Id';
      worksheet.getCell('E7').value = taxid;
      worksheet.getCell('D8').value = 'Mail Code';
      worksheet.getCell('E8').value = mailcode;
      worksheet.getCell('G6').value = 'Run Date';
      worksheet.getCell('H6').value = run_date;
      worksheet.getCell('G7').value = 'From Date';
      worksheet.getCell('H7').value = from;
      worksheet.getCell('I7').value = 'To Date';
      worksheet.getCell('J7').value = to;

      worksheet.getRow(11).values = [
        //        'PROVIDER_ID','PROVIDER_NAME','TAXID','MAIL_CODE','TAX_ID_TYPE','PROVIDER_AR_STATUS',
        'RECEIVABLE_DETAIL_ID','DATE_IDENTIFIED','CLIENT_ID','CLIENT_NAME','LOCAL_DEPARTMENT','ORIGINAL_PAYMENT_ID','FROM_DATE','TO_DATE','OVERPAYMENT_AMOUNT','BALANCE','AR_STATUS','COLLECTION_STATUS','RECEIVABLE_TYPE','FINAL_FISCAL_CATEGORY_CD','RECEIPT_ID','RECEIPT_DATE','PAYMENT_METHOD_CD','PAYMENT_NO_TX','PAYMENT_AMOUNT_NO','COLLECTED_AMOUNT_NO','TRAN_TYPE','FROM_DATE_ARG','TO_DATE_ARG','AR_STATUS_ARG','COLLECTION_STATUS_ARG'];
      let row = 12;

      if (Array.isArray(childjson)) {
        childjson.forEach(element => {
          worksheet.getRow(row).values = [
            //         element.provider_id,element.provider_name,element.taxid, element.mail_code,element.tax_id_type,element.provider_ar_status,
            element.receivable_detail_id,
            element.date_identified,element.client_id,element.client_name,element.local_department,
            element.original_payment_id,element.from_date,
            element.todate,
            Number(element.overpayment_amount),
            Number(element.balance)
            ,element.ar_status,element.collection_status,element.receivable_type,
            element.final_fiscal_category_cd,
            element.receipt_id,element.receipt_dt,element.payment_method_cd,
            element.payment_no_tx,

            Number(element.payment_amount_no),
            Number(element.collected_amount_no)
            ,element.tran_type,
            element.from_date_arg,element.to_date_arg,
            element.ar_status_arg,element.collection_status_arg];
          worksheet.getCell('I' + row).numFmt = numFmtStr;
          worksheet.getCell('J' + row).numFmt = numFmtStr;
          worksheet.getCell('S' + row).numFmt = numFmtStr;
          worksheet.getCell('T' + row).numFmt = numFmtStr;
          row += 1;
        });
      }

      var fileName = `${request.where.outputfilename}.${request.where.format}`;
      response.setHeader(contenttypestr,spreadsheetcontenttype);
      response.setHeader(contentdispositionstr,attachmentstr + fileName);
      if (format === 'excel') {
        await workbook.xlsx.write(response)
          .then(() => response.end());
      } else if (format === 'csv') {
        await workbook.csv.write(response)
          .then(() => response.end());
      }
    } else {
      Response = module.exports.generatepdf(request,html,{},{
        type: 'report',
        res: response
      });
      return Response;
    }

  }
  })
  .catch(err => {
      LOGGER.error(err);
      return err;
  })
};

module.exports.ivefostercarePDF = function (request, response) {

  var reqjson = {};
  var transactionid = request.where.transactionid;
  var type = request.where.type;
  var sql = "SELECT audit.*,p.firstname,p.lastname,sumary.* FROM tb_ive_fostercare_audit audit " +
    " inner join iveincomesumary sumary on sumary.clientid= audit.cjamspid and sumary.removalid=audit.removalid " +
    " inner join person p on audit.cjamspid=p.cjamspid " +
    "  where audit.eligibility_period_id = $1";

  if (type === 'REDETERMINATION') {
    sql = "SELECT audit.*,p.firstname,p.lastname FROM tb_ive_fostercare_audit audit  " +
      " inner join person p on audit.cjamspid=p.cjamspid   " +
      " where audit.eligibility_period_id = $1";
  }

  return util.executeDBQuery(sql,[transactionid])
    .then(data => {
      if (data.length > 0) {
        LOGGER.debug("data ::: ",data);
        reqjson = data[0];

        if (reqjson && reqjson.outputjson && reqjson.outputjson.Objects && reqjson.outputjson.Objects.length) {
          const obj = reqjson.outputjson.Objects[0];
          switch (type) {
            case 'DEEMEDINCOME':
              reqjson = getIVEFCDEMEDINCOME(reqjson,obj);
              break;
            case 'INCOMEASSET':
              reqjson = getIVEFCIncomeAssest(request,obj,reqjson);
              break;
            case 'INITIAL':
              reqjson = getIVEFCInitail(reqjson,obj);
              break;
            case 'REDETERMINATION':
              reqjson = getIVEFCRed(reqjson,obj);
              break;
          }
        }

        let html = '';
        switch (type) {
          case 'DEEMEDINCOME':
            html = fs.readFileSync('./documenttemplates/ivefostercaredeemed.html','utf8');
            request.where.outputfilename = 'ivefostercaredeemed.pdf';
            break;
          case 'INCOMEASSET':
            html = fs.readFileSync('./documenttemplates/ivefostercareincomeasset.html','utf8');
            request.where.outputfilename = 'ivefostercareincomeasset.pdf';
            break;
          case 'INITIAL':
            html = fs.readFileSync('./documenttemplates/ivefostercareinitialeligibility.html','utf8');
            request.where.outputfilename = 'ivefostercareinitialeligibility.pdf';
            break;
          case 'REDETERMINATION':
            html = fs.readFileSync('./documenttemplates/ivefostercareredeterminationeligibility.html','utf8');
            request.where.outputfilename = 'ivefostercareredeterminationeligibility.pdf';
            break;
        }

        return module.exports.generatepdf(request,html,reqjson,{
          type: 'report',
          res: response
        });
      }
    })
    .catch(err => {
        LOGGER.error(err);
        return err;
    })

}

function getIVEFCInitail(reqjson, obj){
  let decisionEligibleReimbursibleFlag = checkboxDisabled;
  let decisionEligibleNonReimbursibleFlag = checkboxDisabled;
  let decisionInEligibleFlag = checkboxDisabled;

  reqjson.afdc_strt_dt = getAFDCEligibilitydate(reqjson);
  reqjson.specialistsubmissiondate = util.formatDate(reqjson.specialistsubmissiondate);
  reqjson.supervisorsubmissiondate = util.formatDate(reqjson.supervisorsubmissiondate);

  if (reqjson.specialistname) {
    reqjson.specialistrole = ivespecialistrole;
  }

  if (reqjson.supervisorname) {
    reqjson.supervisorrole = ivesupervisorrole;
  }


  if (obj.status.FosterCareEligibilityStatus === eligibleReimbursible) {
    decisionEligibleReimbursibleFlag = checkboxDisabledChecked;
  }
  if (obj.status.FosterCareEligibilityStatus === eligibleNonReimbursible) {
    decisionEligibleNonReimbursibleFlag = checkboxDisabledChecked;
  }
  if (obj.status.FosterCareEligibilityStatus === 'Ineligible') {
    reqjson.ive_strt_dt = null;
    decisionInEligibleFlag = checkboxDisabledChecked;
  } else {
    reqjson.ive_strt_dt = getIVEFCIncomeAssestStartdate(obj);
  }

  reqjson.decisionEligibleReimbursible = ` <div class="mt-10 inline-b"><span class="pr-10 p-l-20">` + decisionEligibleReimbursibleFlag + `</span><span class="section-lable">Eligible Reimbursable</span></div> `;
  reqjson.decisionEligibleNonReimbursible = ` <div class="mt-10 inline-b"><span class="pr-10 p-l-20">` + decisionEligibleNonReimbursibleFlag + `</span><span class="section-lable">Eligible Non-Reimbursable</span></div> `;
  reqjson.decisionInEligible = ` <div class="mt-10 inline-b"><span class="pr-10 p-l-20">` + decisionInEligibleFlag + `</span><span class="section-lable">Ineligible</span></div> `;
  var yearsofchildatdoe = Math.abs(moment(reqjson.childphysicalremovaldate).years() - moment(reqjson.dateofbirth).years());
  var monthssofchildatdoe = Math.abs(moment(reqjson.childphysicalremovaldate).months() - moment(reqjson.dateofbirth).months());
  reqjson.ageofthechildatdoe = yearsofchildatdoe + `years ` + monthssofchildatdoe + `months `;
  reqjson.dateofbirth = util.formatDate(reqjson.dateofbirth);
  reqjson.childphysicalremovaldate = util.formatDate(reqjson.childphysicalremovaldate);
  reqjson.dateoffindingctwdecision = util.formatDate(reqjson.dateoffindingctwdecision);

  let ageCalculate;

  const dateofbirthcheck = reqjson.dateofbirth;
  const dateofeligiblitycheck = moment(reqjson.childphysicalremovaldate);


  const years = dateofeligiblitycheck.diff(dateofbirthcheck,'years');
  ageCalculate = years + ' years ';
  ageCalculate += dateofeligiblitycheck.subtract(years,'years').diff(dateofbirthcheck,'months') + ' months';

  reqjson.ageAtELigibility = ageCalculate;

  reqjson.removalFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled ${checkboxCheck(obj.ValidRemoval === 'YES')}/> YES</div></div>` +
    `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled ${checkboxCheck(obj.ValidRemoval === 'NO')}/> NO</div></div>` +
    `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled ${checkboxCheck(obj.ValidRemoval !== 'YES' && obj.ValidRemoval !== 'NO')}/> N/A</div></div>`;

  reqjson.validvpadate = util.formatDate(obj.DateOfValidVPA);
  reqjson.volunteryPlacementFlag = checkboxInputEleDiv(obj.TLCDVPA, 'Date of VPA:' + reqjson.validvpadate, true);

  if (reqjson.typeofvpa === 'EA-VPA') {
    reqjson.volunteryPlacementFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled/> YES</div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> NO</div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled checked/> N/A</div></div>`;
  }

  reqjson.volunteryPlacementEAVPAFlag = checkboxInputEleDiv(obj.EAVPA, 'Date of VPA:' + util.formatDate(obj.DateOfValidVPA), false);

  //clientidofsubjectctwfinding 
  reqjson.relationofsubjectctw = getPerson(reqjson,reqjson.clientidofsubjectctwfinding);
  if (reqjson.relationofsubjectctw && reqjson.relationofsubjectctw.length > 0) {
    reqjson.relationofsubjectctw = reqjson.relationofsubjectctw[0].description;
  }
  reqjson.clientnameofpersonfromwhomchildwasphysicallyremoved = reqjson.inputjson.worksheetData.clientnameofpersonfromwhomchildwasphysicallyremoved;
  reqjson.relationshipofpersonfromwhomchildwasphysicallyremoved = reqjson.inputjson.worksheetData.relationshipofpersonfromwhomchildwasphysicallyremoved;

  reqjson = getIVEFCIRelative(obj, reqjson);

  reqjson.ChildAgeUnder18Flag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled ${checkboxCheck(obj.ChildAgeUnder18 === 'YES')} /> YES </div></div>` +
  `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled ${checkboxCheck(obj.ChildAgeUnder18 !== 'YES')} /> NO</div></div>`;

  reqjson.LDSSReEntryOrDJSEntryFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled ${checkboxCheck(obj.LDSSReEntryOrDJSEntry === 'YES' && obj.ChildAgeUnder18 !== 'YES')}/> YES </div></div>` +
    `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled ${checkboxCheck(obj.LDSSReEntryOrDJSEntry !== 'YES' && obj.ChildAgeUnder18 !== 'YES')} /> NO</div></div>`;

  reqjson.criteria10to21Flag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled/> YES </div></div>` +
    `<div class="row"><div class="col-xs-12 l" style="padding-left: 70px"><input type="checkbox" disabled /> Completing secondary education or a program leading to an equivalent credential</div></div>` +
    `<div class="row"><div class="col-xs-12 l" style="padding-left: 70px"><input type="checkbox" disabled /> Enrolled in an institution that provides post-secondary or vocational education</div></div>` +
    `<div class="row"><div class="col-xs-12 l" style="padding-left: 70px"><input type="checkbox" disabled /> Participate in a program or activity designed to promote or remove barriers to employment</div></div>` +
    `<div class="row"><div class="col-xs-12 l" style="padding-left: 70px"><input type="checkbox" disabled /> Employed for at least 80 hours per month</div></div>` +
    `<div class="row"><div class="col-xs-12 l" style="padding-left: 70px"><input type="checkbox" disabled /> Incapable of doing any of the activities described above due to a medical condition, which incapability is supported by regularly updated written or recorded information in the case plan of the child.</div></div>` +
    `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> NO</div></div>`;

    reqjson = getIVEFCParentinfo(reqjson);

  

  reqjson.AssetsExceed10000Flag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled ${checkboxCheck(obj.AssetsExceed10000 === 'YES')}/> YES </div></div>` +
    `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled ${checkboxCheck(obj.AssetsExceed10000 !== 'YES')}/> NO</div></div>`;

  reqjson.IncomeAssetsWithinAFDCStandardsFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled ${checkboxCheck(obj.IncomeAssetsWithinAFDCStandards === 'YES')}/> YES </div></div>` +
    `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled ${checkboxCheck((obj.IncomeAssetsWithinAFDCStandards !== 'YES'))}/> NO</div></div>`;

  reqjson.childplacementhistoryFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> REMOVAL CLIENT HISTORY REPORT (for DHS staff) </div></div>` +
    `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> ASSIST Database Placement Summary Report (for DJS staff)</div></div>`;


  if (reqjson.dateoffindingctwdecision) {
    reqjson.judicialDeterminationFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled checked/> YES Date of Judicial Finding/Initial Court Order: ` + reqjson.dateoffindingctwdecision + `</div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><span>Who is the subject of the Contrary to the Welfare finding?</span></div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px">Name: ` + reqjson.nameofsubjectctwfinding + `</div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px">Relationship: ` + reqjson.relationofsubjectctw + `</div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled/> NO</div></div>`;
  } else {
    reqjson.judicialDeterminationFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> YES Date of Judicial Finding/Initial Court Order: </div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><span>Who is the subject of the Contrary to the Welfare finding?</span></div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px">Name:</div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px">Relationship:</div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled checked/> NO</div></div>`;
  }

  reqjson.dateofreasonableeffortscourthearingFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled ${checkboxCheck(reqjson.dateofreasonableeffortscourthearing)} /> YES Date of Court Order: ` + getStr(reqjson.dateofreasonableeffortscourthearing, util.formatDate(reqjson.dateofreasonableeffortscourthearing)) + `</div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled ${checkboxCheck(!reqjson.dateofreasonableeffortscourthearing)} /> NO</div></div>`;

  reqjson.specifiedrelativeisctwFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled ${checkboxCheck(obj.SpecifiedRelativeIsCTW === 'YES')} /> YES Name: ` + getStr(obj.SpecifiedRelativeIsCTW === 'YES', reqjson.nameofsubjectctwfinding) + ` Relationship ` + getStr(obj.SpecifiedRelativeIsCTW === 'YES', reqjson.relationofsubjectctw) + ` </div></div>` +
  `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled ${checkboxCheck(obj.SpecifiedRelativeIsCTW !== 'YES')} /> NO</div></div>`;

  reqjson.childphysicalremovaldatecorticon = util.formatDate(reqjson.childphysicalremovaldate);

  reqjson = getIVEFCICiziten(reqjson);

  reqjson = getIVEFCINPlacement(reqjson);

  // Income verification 
  reqjson = getIVEFCIIncomeInfo(reqjson);
  return reqjson;
}

function getIVEFCICiziten(reqjson){
  if (reqjson.uscitizen && reqjson.uscitizen === 'YES') {
    reqjson.uscitizenFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled checked/> YES How verified?</div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled/> NO</div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 70px"><input type="checkbox" disabled /> YES Record Alien Registration</div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 70px"><input type="checkbox" disabled /> NO</div></div>`
  } else {
    reqjson.uscitizenFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> YES How verified?</div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled checked/> NO</div></div>`;
    if (reqjson.qualifiedalien && reqjson.qualifiedalien === 'YES') {
      reqjson.uscitizenFlag = reqjson.uscitizenFlag +
        `<div class="row"><div class="col-xs-12 l" style="padding-left: 70px"><input type="checkbox" disabled checked/> YES Record Alien Registration</div></div>` +
        `<div class="row"><div class="col-xs-12 l" style="padding-left: 70px"><input type="checkbox" disabled/> NO</div></div>`;
    } else {
      reqjson.uscitizenFlag = reqjson.uscitizenFlag +
        `<div class="row"><div class="col-xs-12 l" style="padding-left: 70px"><input type="checkbox" disabled /> YES Record Alien Registration</div></div>` +
        `<div class="row"><div class="col-xs-12 l" style="padding-left: 70px"><input type="checkbox" disabled checked/> NO</div></div>`;
    }
  }
  return reqjson;
}

function getIVEFCIRelative(obj, reqjson){
  const initialReviewPeriodDate = moment(obj.FosterCareReviewPeriodStartDate);
  const SpecifiedRelativeDateChildLastLived = moment(obj.person.specifiedRelative[0].SpecifiedRelativeDateChildLastLivedWith);
  const ChildLivedSP6Months = initialReviewPeriodDate.diff(SpecifiedRelativeDateChildLastLived,'months');

  let lastlivedwithreltive = '';
  let specifiedRelativeData = '';
  if (obj.person.specifiedRelative && obj.person.specifiedRelative.length > 0) {
    obj.person.specifiedRelative.forEach(specifiedRel => {
      var relation = getPerson(reqjson,specifiedRel.SpecifiedRelativeClientID);
      if (relation && relation.length > 0) {
        specifiedRelativeData = specifiedRelativeData + `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"> Name: ` + specifiedRel.SpecifiedRelativeName + ` Relation: ` + relation[0].description + `</div></div>`;
        lastlivedwithreltive = lastlivedwithreltive + `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"> Name: ` + specifiedRel.SpecifiedRelativeName + ` Date child last lived with that specified relative: ` + specifiedRel.SpecifiedRelativeDateChildLastLivedWith + `</div></div>`;
      }
    });
  }

  reqjson.specifiedRelativeData = specifiedRelativeData;

  reqjson.specifiedrelativeFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled ${checkboxCheck(obj.SpecifiedRelativeIsCTW === 'YES')} /> YES`+ getStr(obj.SpecifiedRelativeIsCTW === 'YES', ' Name: ' + reqjson.nameofsubjectctwfinding + ' Relationship ' + reqjson.relationofsubjectctw) + `</div></div>` +
      //specifiedRelativeData +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled ${checkboxCheck(obj.SpecifiedRelativeIsCTW !== 'YES')} /> NO</div></div>`;

      if (ChildLivedSP6Months <= 6 && ChildLivedSP6Months >= 0) {
        reqjson.lastlivedwithreltiveFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled checked/> YES </div></div>` +
          lastlivedwithreltive +
          `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> NO</div></div>`;
      } else {
        reqjson.lastlivedwithreltiveFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled/> YES </div></div>` +
          `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled checked/> NO</div></div>` + lastlivedwithreltive;
      }
      return reqjson;
}

function getIVEFCIIncomeInfo(reqjson){
  if (reqjson.inputjson && reqjson.inputjson.worksheetData && reqjson.inputjson.worksheetData.householdInfo) {
    const incomeandasset = reqjson.inputjson.worksheetData.householdInfo[0].getfinanceincomebycase;
    var incomeinfo = ``;
    var assetinfo = ``;
    if (incomeandasset.length > 0) {
      incomeandasset.forEach((b) => {
        const fullname = (emptyStrCheck(b.firstname)) + ' ' + (emptyStrCheck(b.lastname));
        if (b.getfinanceincome !== null) {
          b.getfinanceincome.forEach((c) => {
            const incomeStat = {
              'E': 'Earned',
              'U': 'Unearned'
            }
            c.earned_sw = incomeStat[c.earned_sw]
            
            incomeinfo = incomeinfo + `<tr>
           <td>`+ (emptyStrCheck(fullname)) + `</td>
           <td>`+ (emptyStrCheck(b.iveincomesumary?.relationshipstatus)) + `</td>
           <td>`+ (emptyStrCheck(b.iveincomesumary?.dateofbirthforincome)) + `</td>
           <td>`+ (emptyStrCheck(b.iveincomesumary?.assistanceunit)) + `</td>
           <td>`+ 'INCOME' + `</td>
           <td>`+ (emptyStrCheck(c.earned_sw)) + `</td>
           <td>`+ (emptyStrCheck(c.verificationtype)) + `</td>
           <td>`+ (currencyCheck(c.monthlyamount)) + `</td>
           </tr>`;
          })
        }
        if (b.getfinanceassets !== null) {
          b.getfinanceassets.forEach((d) => {
            const verifyType = {
              'BBS': 'Bank/Broker Statement',
              'BBV': 'Blue Book (Vehicles)',
              'CNV': 'CARES - Not Verified',
              'CVO': 'CARES Verified - Other',
              'CR': 'Client Reported',
              'LIP': 'Life Insurance Policy',
              'LD': 'Loan Documents',
              'OTH': 'Other',
              'TIT': 'Title'

            }
            d.verificationtypekey = verifyType[d.verificationtypekey];

            assetinfo = assetinfo + `<tr>
          <td>`+ (emptyStrCheck(fullname)) + `</td>
          <td>`+ (emptyStrCheck(b.iveincomesumary?.relationshipstatus)) + `</td>
           <td>`+ (emptyStrCheck(b.iveincomesumary?.dateofbirthforincome)) + `</td>
           <td>`+ (emptyStrCheck(b.iveincomesumary?.assistanceunit)) + `</td>
          <td>`+ 'ASSET' + `</td>
          <td>`+ (emptyStrCheck(d.assettypename)) + `</td>
          <td>`+ emptyStrCheck(d.verificationtypekey) + `</td>
          <td>`+ (currencyCheck(d.amountowed)) + `</td>
          </tr>`;
          })
        }

      });
    }
    reqjson.incomeandassetinfo = incomeinfo + assetinfo;
  }

  const cond1 = reqjson.inputjson && reqjson.inputjson.worksheetData && reqjson.inputjson.worksheetData.infoaboutincomenresources === 'YES';
  const cond2 = reqjson.inputjson && reqjson.inputjson.worksheetData && reqjson.inputjson.worksheetData.infoaboutincomenresources === 'NO';
  const cond3 = reqjson.inputjson && reqjson.inputjson.worksheetData && reqjson.inputjson.worksheetData.infoaboutincomenresources !== 'YES' && reqjson.inputjson.worksheetData.infoaboutincomenresources !== 'NO';

  reqjson.infoaboutincomenresourcesFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled ${checkboxCheck(cond1)}/> YES How verified?` + getStr(cond1,reqjson.inputjson.worksheetData.incomeresourcesverification) + `</div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled ${checkboxCheck(cond2)} /> NO</div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled ${checkboxCheck(cond3)}/>  Not Verified</div></div>`;
  
  return reqjson;
}

function getIVEFCINPlacement(reqjson){
  if (reqjson.inputjson && reqjson.inputjson.worksheetData && reqjson.inputjson.worksheetData.deprivationInfo) {
    reqjson.childjurisdiction = reqjson.inputjson.worksheetData.childjurisdiction;
    const deprivations = reqjson.inputjson.worksheetData.deprivationInfo;
    var deprivationInfo = ``;
    if (deprivations.length > 0) {
      deprivations.forEach((deprivation) => {
        if (reqjson.inputjson.Objects.length > 0 && reqjson.inputjson.Objects[0].householdMember.length > 0) {

          deprivationInfo = deprivationInfo + `<tr>
          <td>`+ (emptyStrCheck(deprivation.nameofhouseholdmember)) + `</td>
          <td>`+ deprivation.childdeprivedofparentalsupport + `</td>
          <td>`+ getDeprevationType(deprivation.deprivationtype) + `</td>
          <td>`+ getReasonAbsence(deprivation.reasonforabsence) + `</td>
          <td>`+ (emptyStrCheck(deprivation.dateofparentdeath)) + `</td>
          <td>`+ (emptyStrCheck(deprivation.dateofincarceration)) + `</td>
          </tr>`;
        }
      });
    }
    reqjson.deprivationInfo = deprivationInfo;
  }

  reqjson.childsplacementFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled ${checkboxCheck(reqjson.inputjson.worksheetData.isdjsordsschild === 'DHS')} /> REMOVAL CLIENT HISTORY REPORT (for DHS staff) </div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled ${checkboxCheck(reqjson.inputjson.worksheetData.isdjsordsschild === 'DJS')} /> ASSIST Database Placement Summary Report (for DJS staff)</div></div>`;

  if (reqjson.inputjson && reqjson.inputjson.worksheetData && reqjson.inputjson.worksheetData.placementInfo) {
    const placementandliving = reqjson.inputjson.worksheetData.placementInfo[0].placement;
    var placementandlivinginfo = ``;
    if (placementandliving.length > 0) {
      placementandliving.forEach((obj) => {
        const livingArrType = {
          'LA': 'Living',
          'PLTR': 'Placement'
        }
        obj.livingarrangementtype = livingArrType[obj.livingarrangementtype];
        placementandlivinginfo = placementandlivinginfo + `<tr>
           <td>`+ (emptyStrCheck(obj.livingarrangementtype)) + `</td>
           <td>`+ obj.placement_type + `</td>
           <td>`+ (emptyStrCheck(obj.provider_nm)) + `</td>
           <td>`+ (emptyStrCheck(obj.provider_address)) + `</td>
           <td>`+ (dateCheck(obj.start_dt)) + `</td>
           <td>`+ (dateCheck(obj.end_dt)) + `</td>
           </tr>`;
      });
    }
    reqjson.placementandlivinginfo = placementandlivinginfo;
  }
  return reqjson;
}

function getIVEFCRed(reqjson,obj) {
  const input = reqjson.inputjson.Objects[0];
  reqjson.dateofbirth = util.formatDate(reqjson.dateofbirth);
  reqjson.childphysicalremovaldate = util.formatDate(reqjson.childphysicalremovaldate);
  reqjson.dateoffindingctwdecision = util.formatDate(reqjson.dateoffindingctwdecision);
  reqjson.specialistsubmissiondate = util.formatDate(reqjson.specialistsubmissiondate);
  reqjson.supervisorsubmissiondate = util.formatDate(reqjson.supervisorsubmissiondate);

  if (reqjson.specialistname) {
    reqjson.specialistrole = ivespecialistrole;
  }

  if (reqjson.supervisorname) {
    reqjson.supervisorrole = ivesupervisorrole;
  }

  reqjson = getIVEFCRSilaInfo(reqjson,obj);

  reqjson = getIVEFCREDPlacement(reqjson);

  if (reqjson.statusjsondata && reqjson.statusjsondata.fosterCareEvents) {
    var fosterCareEventFlag = '';
    reqjson.statusjsondata.fosterCareEvents.forEach((fosterCareEvent) => {
      fosterCareEventFlag = fosterCareEventFlag + `<tr>
              <td>`+ fosterCareEvent.EventStartDate + `</td>
              <td>`+ fosterCareEvent.EventEndDate + `</td>
              <td>`+ fosterCareEvent.EventStatus + `</td>
              <td>`+ fosterCareEvent.EventReason + `</td>
              </tr>`;
    });
    reqjson.fosterCareEventFlag = fosterCareEventFlag;
  }

  if (reqjson.inputjson && reqjson.inputjson.worksheetData) {
    reqjson.childjurisdiction = reqjson.inputjson.worksheetData.childjurisdiction;
    if (!reqjson.childjurisdiction) {
      reqjson.childjurisdiction = '';
    }
  }

  reqjson.childage18to21criteriaFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> YES </div></div>` +
    `<div class="row"><div class="col-xs-12 l" style="padding-left: 70px"><input type="checkbox" disabled /> Completing secondary education or a program leading to an equivalent credential</div></div>` +
    `<div class="row"><div class="col-xs-12 l" style="padding-left: 105px"> Name of school program   Start Date </div></div>` +
    `<div class="row"><div class="col-xs-12 l" style="padding-left: 70px"><input type="checkbox" disabled /> Enrolled in an institution that provides post-secondary or vocational education</div></div>` +
    `<div class="row"><div class="col-xs-12 l" style="padding-left: 105px">Name of institution    Start Date</div></div>` +
    `<div class="row"><div class="col-xs-12 l" style="padding-left: 70px"><input type="checkbox" disabled /> Participate in a program or activity designed to promote or remove barriers to employment</div></div>` +
    `<div class="row"><div class="col-xs-12 l" style="padding-left: 105px">Name of program or activity    Start Date</div></div>` +
    `<div class="row"><div class="col-xs-12 l" style="padding-left: 70px"><input type="checkbox" disabled /> Employed for at least 80 hours per month; or</div></div>` +
    `<div class="row"><div class="col-xs-12 l" style="padding-left: 105px">Name of employer  Start Date  Number of hours  </div></div>` +
    `<div class="row"><div class="col-xs-12 l" style="padding-left: 70px"><input type="checkbox" disabled /> Incapable of doing any of the activities described above due to a medical condition, which incapability is supported by regularly updated written or recorded information in the case plan of the child.</div></div>` +
    `<div class="row"><div class="col-xs-12 l" style="padding-left: 105px">Disability Type        Disability Start Date     Evaluation Date </div></div>` +
    `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> NO</div></div>`;

  reqjson.start_dt = (reqjson.start_dt === null || reqjson.start_dt === '') ? '' : util.formatDate(reqjson.start_dt);
  reqjson.end_dt = (reqjson.end_dt === null || reqjson.end_dt === '') ? '' : util.formatDate(reqjson.end_dt);
  reqjson.insertedon = (reqjson.insertedon === null || reqjson.insertedon === '') ? '' : util.formatDate(reqjson.insertedon);


  var yearsenddate = Math.abs(moment(reqjson.end_dt).years()) + 1;
  var monthenddate = moment(reqjson.end_dt).add(1,"month").format('MMMM');
  reqjson.nextRedeterminationDue = monthenddate + ` ` + yearsenddate;

  reqjson = getIVEFCRdecisionFlag(obj,reqjson);

  reqjson = getIVEFCRCourt(reqjson);

  reqjson = getIVEFCVPAData(reqjson)

  reqjson = getIVEFCSSIData(input,reqjson);
  return reqjson;
}

function getIVEFCRdecisionFlag(obj,reqjson) {
  let decisionEligibleReimbursibleFlag = checkboxDisabled;
  let decisionEligibleNonReimbursibleFlag = checkboxDisabled;
  let decisionInEligibleFlag = checkboxDisabled;

  if (obj.status.FosterCareRedeterminationEligibilityStatusWithEventChange) {
    if (obj.status.FosterCareRedeterminationEligibilityStatusWithEventChange === eligibleReimbursible) {
      decisionEligibleReimbursibleFlag = checkboxDisabledChecked;
    }
    if (obj.status.FosterCareRedeterminationEligibilityStatusWithEventChange === eligibleNonReimbursible) {
      decisionEligibleNonReimbursibleFlag = checkboxDisabledChecked;
    }
    if (obj.status.FosterCareRedeterminationEligibilityStatusWithEventChange === 'Ineligible') {
      decisionInEligibleFlag = checkboxDisabledChecked;
    }
  } else {
    if (obj.status.FosterCareRedeterminationEligibilityStatus === eligibleReimbursible) {
      decisionEligibleReimbursibleFlag = checkboxDisabledChecked;
    }
    if (obj.status.FosterCareRedeterminationEligibilityStatus === eligibleNonReimbursible) {
      decisionEligibleNonReimbursibleFlag = checkboxDisabledChecked;
    }
    if (obj.status.FosterCareRedeterminationEligibilityStatus === 'Ineligible') {
      decisionInEligibleFlag = checkboxDisabledChecked;
    }
  }

  reqjson.decisionEligibleReimbursible = ` <div class="mt-10 inline-b"><span class="pr-10 p-l-20">` + decisionEligibleReimbursibleFlag + `</span><span class="section-lable">Eligible Reimbursable</span></div> `;
  reqjson.decisionEligibleNonReimbursible = ` <div class="mt-10 inline-b"><span class="pr-10 p-l-20">` + decisionEligibleNonReimbursibleFlag + `</span><span class="section-lable">Eligible Non-Reimbursable</span></div> `;
  reqjson.decisionInEligible = ` <div class="mt-10 inline-b"><span class="pr-10 p-l-20">` + decisionInEligibleFlag + `</span><span class="section-lable">Ineligible</span></div> `;
  return reqjson;
}

function getIVEFCRCourt(reqjson){
  if (reqjson.typeofremoval === 'Court_Order') {
    if (reqjson.isiveagencyresponsibleforplacementandcare === 'YES') {
      reqjson.isiveagencyresponsibleforplacementandcareFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled checked/> YES</div></div>` +
        `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> NO</div></div>`;
    } else if (reqjson.isiveagencyresponsibleforplacementandcare === 'NO') {
      reqjson.isiveagencyresponsibleforplacementandcareFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> YES</div></div>` +
        `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled checked/> NO  Date on which the agency lost legal responsibility: ` + reqjson.dateagencylostlegalresponsibility + `</div></div>`;
    } else {
      reqjson.isiveagencyresponsibleforplacementandcareFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> YES</div></div>` +
        `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> NO  Date on which the agency lost legal responsibility: ` + reqjson.dateagencylostlegalresponsibility + `</div></div>`;
    }

    reqjson.childbeeninfostercare12monthormoreFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled ${checkboxCheck(reqjson.childbeeninfostercare12monthormore === 'YES')} /> YES</div></div>` +
    `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled ${checkboxCheck(reqjson.childbeeninfostercare12monthormore === 'NO')} /> NO</div></div>`;

    if (reqjson.dateofjudicialfindingofrefpp) {
      reqjson.dateofjudicialfindingofrefppFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled checked/> YES  Date of court order:` + util.formatDate(reqjson.dateofjudicialfindingofrefpp) + `</div></div>` +
        `<div class="row"><div class="col-xs-12 l" style="padding-left: 70px">1. Was it timely?</div></div>` +
        `<div class="row"><div class="col-xs-12 l" style="padding-left: 105px"><input type="checkbox" disabled checked/> YES </div></div>` +
        `<div class="row"><div class="col-xs-12 l" style="padding-left: 105px"><input type="checkbox" disabled /> NO</div></div>` +
        `<div class="row"><div class="col-xs-12 l" style="padding-left: 70px">2. What is the due date of the subsequent judicial determination of REFPP? ${reqjson.isiveagencyresponsibleforplacementandcare === 'NO' ? '' : util.formatDate(reqjson.dateofsubsequentjudicialfindingofrefpp)} </div></div>` +
        `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled ${checkboxCheck(reqjson.isiveagencyresponsibleforplacementandcare === 'NO')}/> NO Date REFPP due:</div></div>`;
    } else {
      reqjson.dateofjudicialfindingofrefppFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> YES  Date of court order:</div></div>` +
        `<div class="row"><div class="col-xs-12 l" style="padding-left: 70px">1. Was it timely?</div></div>` +
        `<div class="row"><div class="col-xs-12 l" style="padding-left: 105px"><input type="checkbox" disabled /> YES </div></div>` +
        `<div class="row"><div class="col-xs-12 l" style="padding-left: 105px"><input type="checkbox" disabled /> NO</div></div>` +
        `<div class="row"><div class="col-xs-12 l" style="padding-left: 70px">2. What is the due date of the subsequent judicial determination of REFPP? </div></div>` +
        `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled checked/> NO Date REFPP due: ` + util.formatDate(reqjson.dateofsubsequentjudicialfindingofrefpp) + `</div></div>`;
    }

    
  } else {
    reqjson.isiveagencyresponsibleforplacementandcareFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> YES</div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> NO  Date on which the agency lost legal responsibility: </div></div>`;
    reqjson.childbeeninfostercare12monthormoreFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> YES</div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> NO </div></div>`;
    reqjson.dateofjudicialfindingofrefppFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> YES  Date of court order:</div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 70px">1. Was it timely?</div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 105px"><input type="checkbox" disabled /> YES </div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 105px"><input type="checkbox" disabled /> NO</div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 70px">2. What is the due date of the subsequent judicial determination of REFPP? </div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> NO Date REFPP due: </div></div>`;

  }
  return reqjson;
}

function getIVEFCRSilaInfo(reqjson,obj) {
  if (reqjson.end_dt) {
    const yearsofchildatperiodend = Math.abs(moment(reqjson.end_dt).years() - moment(reqjson.dateofbirth).years());
    const monthssofchildatperiodend = Math.abs(moment(reqjson.end_dt).months() - moment(reqjson.dateofbirth).months());
    reqjson.ageatperiodend = yearsofchildatperiodend + `years ` + monthssofchildatperiodend + `months `;
  } else if (reqjson.start_dt) {
    const yearsofchildatperiodend = Math.abs(moment(reqjson.start_dt).years() - moment(reqjson.dateofbirth).years());
    const monthssofchildatperiodend = Math.abs(moment(reqjson.start_dt).months() - moment(reqjson.dateofbirth).months());
    reqjson.ageatperiodend = yearsofchildatperiodend + `years ` + monthssofchildatperiodend + `months `;
  } else {
    reqjson.ageatperiodend = 0;
  }

  reqjson.issilayouthflag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> YES </div></div>` +
    `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> NO</div></div>`;

  if (obj.ChildAgeUnder18 === 'YES') {
    reqjson.ChildAgeUnder18Flag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled checked/> YES </div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> NO</div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><p><b>Note: </b>Please skip to Section II after yes is selected as B and C under section I are not applicable as the child is under the age of 18.</p></div>`;

  } else {
    if (reqjson.inputjson && reqjson.inputjson.worksheetData && reqjson.inputjson.worksheetData.issilayouth === 'YES') {
      reqjson.issilayouthflag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled checked /> YES </div></div>` +
        `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> NO</div></div>`;
      if (reqjson.inputjson.worksheetData && reqjson.inputjson.worksheetData.issillaagreementvalid === 'YES') {
        reqjson.issillaagreementvalidFlag = `<div class="row"> <div class="col-xs-12 l pl-30"><span>Is there a valid SILA agreement?</span></div></div><div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled checked/> YES Date of SILA agreement: ${util.formatDate(reqjson.inputjson.worksheetData.silaagreementdate)} </div></div>` +
          `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> NO</div></div>`;
      } else {
        reqjson.issillaagreementvalidFlag = `<div class="row"> <div class="col-xs-12 l pl-30"><span>Is there a valid SILA agreement?</span></div></div><div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> YES </div></div>` +
          `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled checked/> NO</div></div>`;
      }
    } else if (reqjson.inputjson && reqjson.inputjson.worksheetData && reqjson.inputjson.worksheetData.issilayouth === 'NO') {
      reqjson.issilayouthflag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> YES </div></div>` +
        `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled checked /> NO</div></div>`;
    }
    reqjson.ChildAgeUnder18Flag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled/> YES </div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled checked/> NO</div></div>`;
  }
  return reqjson;
}

function getIVEFCDEMEDINCOME(reqjson,obj) {
  reqjson.ive_strt_dt = getIVEFCIncomeAssestStartdate(obj);
  reqjson.afdc_strt_dt = getAFDCEligibilitydate(reqjson);
  reqjson.NoOfMembersInAU = obj.NoOfMembersInAU;
  reqjson.NoOfMembersNotInAU = obj.NoOfMembersNotInAU;
  reqjson.DeemorGrossEarnedIncome = obj.DeemorGrossEarnedIncome;
  reqjson.DeemorTotalSupportExpenses = obj.DeemorTotalSupportExpenses;
  reqjson.DeemorGrossUnearnedIncome = obj.DeemorGrossUnearnedIncome;
  reqjson.DeemedIncome = obj.DeemedIncome;
  reqjson.StandardOfNeedForNotInAU = obj.StandardOfNeedForNotInAU ? obj.StandardOfNeedForNotInAU : '0';
  reqjson.Dem2 = obj.Dem2 ? obj.Dem2 : '0';
  reqjson.Dem3 = obj.Dem3 ? obj.Dem3 : '0';
  reqjson.Dem4 = obj.Dem4 ? obj.Dem4 : '0';
  reqjson.Dem5 = obj.Dem5 ? obj.Dem5 : '0';
  return reqjson;
}

function getIVEFCIncomeAssestStartdate(obj){
  if (obj.status.FosterCareEligibilityStatus === 'Ineligible') {
    return null;
  } else {
    if (obj && obj?.status && obj?.status?.AFDCEligibilityMonth_ForOutputForm && util.nullcheck(obj?.status?.AFDCEligibilityMonth_ForOutputForm)) {
      var d = new Date(obj?.status?.AFDCEligibilityMonth_ForOutputForm),
        month = '' + (d.getMonth() + 1);
      if (month.length < 2) { month = '0' + month; }
      return [month,d.getFullYear()].join('/');
    }
    return '';
  }  
}

function getAFDCEligibilitydate(reqjson){
  if (reqjson && reqjson?.afdceligibilitymonth && util.nullcheck(reqjson?.afdceligibilitymonth)) {
    var d = new Date(reqjson?.afdceligibilitymonth),
      month = '' + (d.getMonth() + 1);
    if (month.length < 2) { month = '0' + month; }
    return [month,d.getFullYear()].join('/');
  }
  return '';
}

function getIVEFCIncomeAssest(request, obj, reqjson){
    reqjson.childjurisdiction = util.nullcheck(request?.where?.childJurisdiction);
    reqjson.ive_strt_dt = getIVEFCIncomeAssestStartdate(obj);
    reqjson.afdc_strt_dt = getAFDCEligibilitydate(reqjson);
  if (reqjson && reqjson?.income && util.nullcheck(reqjson?.income)) {
    reqjson.income_el = (util.nullcheck(reqjson?.income) == 'CRITERIA_PASSED') ?
      'Child is IV-E Income Eligible' :
      'Child is not IV-E Income Eligible';
  }
  if (reqjson?.specialistname && util.nullcheck(reqjson?.specialistname)) {
    reqjson.specialistrole = 'IV-E Specialist';
  }
  if (reqjson?.supervisorname && util.nullcheck(reqjson?.supervisorname)) {
    reqjson.supervisorrole = 'IV-E Supervisor';
  }
  if (reqjson?.specialistsubmissiondate && util.nullcheck(reqjson?.specialistsubmissiondate)) {
    reqjson.specialistsubmissiondate = util.formatDate(reqjson?.specialistsubmissiondate);
  }
  if (reqjson?.supervisorsubmissiondate && util.nullcheck(reqjson?.supervisorsubmissiondate)) {
    reqjson.supervisorsubmissiondate = util.formatDate(reqjson?.supervisorsubmissiondate);
  }

  reqjson.NoOfMembersInAU = obj.NoOfMembersInAU;
  reqjson.AssetsMarketValue = obj.GrossAssetsMarketValue;
  reqjson.AssetAllowance = obj.AssetAllowance;
  reqjson.GrossEarnedIncome = obj.GrossEarnedIncome;
  reqjson.GrossUnearnedIncome = obj.GrossUnearnedIncome;
  reqjson.GrossIncome = obj.GrossIncome;
  reqjson.GrossIncome185PctForAU = obj.GrossIncome185PctForAU;
  if (obj.Step3IncomeWorkSheet === 'Proceed') {
    reqjson.StandardOfNeedForAUforstep3 = '$' + obj.StandardOfNeedForAU;
    reqjson.GrossIncomeforstep3 = '$ ' + obj.GrossIncome;
  }
  if (obj.Step4IncomeWorkSheet === 'Proceed') {
    reqjson.GrossEarnedIncomeforstep5 = '$' + obj.GrossEarnedIncome
    reqjson.GrossEarnedIncomeMinusWorkExpenses = '$' + obj.GrossEarnedIncomeMinusWorkExpenses
    reqjson.GrossEarnedIncomeMinusOneThird = '$' + obj.GrossEarnedIncomeMinusOneThird
    reqjson.GrossEarnedIncomeMinusChildCareCosts = '$' + obj.GrossEarnedIncomeMinusChildCareCosts
    reqjson.TotalAvailableIncome = '$' + obj.TotalAvailableIncome
    reqjson.StandardOfNeedForAUforstep4 = '$' + obj.StandardOfNeedForAU;
  }
  return reqjson;
}

function getIVEFCParentinfo(reqjson){
  if (reqjson.inputjson.worksheetData && reqjson.inputjson.worksheetData.deprivationInfo) {
    reqjson.parent1id = reqjson.inputjson.worksheetData.deprivationInfo[0]?.parentid;
    var parent1info = getPerson(reqjson,reqjson.parent1id);
    if (reqjson.parent1id && parent1info.length > 0) {
        reqjson.parent1Data = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"> Name: ` + parent1info[0].nameofhouseholdmember + ` Relation: ` + parent1info[0].description + `</div></div>`;
    } else {
      reqjson.parent1Data = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"> Name:  Relation: </div></div>`;
    }
  }


  if (reqjson.inputjson.worksheetData) {
    reqjson.parent2id = reqjson.inputjson.worksheetData.parent2id;
    if (reqjson.parent2id) {
      var parent2info = getPerson(reqjson,reqjson.parent2id);
      if (parent2info.length > 0) {
        reqjson.parent2Data = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"> Name: ` + parent2info[0].nameofhouseholdmember + ` Relation: ` + parent2info[0].description + `</div></div>`;
      }
    } else {
      reqjson.parent2Data = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"> Mandatory note if 2nd parent's signature is not there on VPA: ` + reqjson.inputjson.worksheetData.mandatorynoteonmissing2ndparentsignatureonvpa + ` </div></div>`;
    }
  }


  if (reqjson.typeofremoval === 'Court_Order') {
    reqjson.parent1Data = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"> Name:  Relation: </div></div>`;
    reqjson.parent2Data = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"> Name:  Relation: </div></div>`;

  }
  return reqjson;
}

function getIVEFCREDPlacement(reqjson) {
  var reimbursiblePlacement = true;
  if (reqjson.inputjson && reqjson.inputjson.worksheetData && reqjson.inputjson.worksheetData.placementInfo && reqjson.inputjson.worksheetData.placementInfo.length > 0 &&
    reqjson.inputjson.worksheetData.placementInfo[0].placement && reqjson.inputjson.worksheetData.placementInfo[0].placement.length > 0) {
    reqjson.inputjson.worksheetData.placementInfo[0].placement.forEach(plcmnt => {
      if (plcmnt.isplacementreimbursible === 'Y') {
        reimbursiblePlacement = true;
      } else {
        reimbursiblePlacement = false;
      }
    });
  }

  reqjson.reimbursiblePlacementFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled ${checkboxCheck(reimbursiblePlacement)}/> YES </div></div>` +
    `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled ${checkboxCheck(!reimbursiblePlacement)}/> NO</div></div>`;

  reqjson.childsplacementFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled ${checkboxCheck(reqjson.inputjson.worksheetData.isdjsordsschild === 'DHS')}/> REMOVAL CLIENT HISTORY REPORT (for DHS staff) </div></div>` +
    `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled ${checkboxCheck(reqjson.inputjson.worksheetData.isdjsordsschild === 'DJS')}/> ASSIST Database Placement Summary Report (for DJS staff)</div></div>`;

  if (reqjson.inputjson && reqjson.inputjson.worksheetData && reqjson.inputjson.worksheetData.placementInfo) {
    const placementandliving = reqjson.inputjson.worksheetData.placementInfo[0].placement;
    var placementandlivinginfo = ``;
    if (placementandliving.length > 0) {
      placementandliving.forEach((obj) => {
        const livingArrType = {
          'LA': 'Living',
          'PLTR': 'Placement'
        }
        obj.livingarrangementtype = livingArrType[obj.livingarrangementtype];
        placementandlivinginfo = placementandlivinginfo + `<tr>
           <td>`+ (emptyStrCheck(obj.livingarrangementtype)) + `</td>
           <td>`+ obj.placement_type + `</td>
           <td>`+ (emptyStrCheck(obj.provider_nm)) + `</td>
           <td>`+ emptyStrCheck(obj.provider_address) + `</td>
           <td>`+ (dateCheck(obj.start_dt)) + `</td>
           <td>`+ (dateCheck(obj.end_dt)) + `</td>
           </tr>`;
      });
    }
    reqjson.placementandlivinginfo = placementandlivinginfo;
  }
  return reqjson;
}

function getIVEFCVPAData(reqjson) {
  var redetSeqNum = reqjson.sqnm_sw.split("R");

  switch (Math.abs(redetSeqNum[1])) {
    case 1:
      reqjson.timeLimited = `<div class="row"><div class="col-xs-12 l"><span>E. Is there a judicial finding of the child’s “Contrary to welfare/Best Interest” within 180 calendar days of the
      placement through a VPA? (R1)</span></div></div>`;
      break;
    case 2:
      reqjson.timeLimited = `<div class="row"><div class="col-xs-12 l"><span>E. Is there a judicial finding of the child’s “Reasonable Efforts to Finalize a Permanency Plan” (REFPP) within 12 months
      from initial “Reasonable Efforts were made to prevent removal” (RE)? </span></div></div>`;
      break;
    case 3:
      reqjson.timeLimited = `<div class="row"><div class="col-xs-12 l"><span>E. Is there a judicial finding of the child’s “Reasonable Efforts to Finalize a Permanency Plan” (REFPP) within 12 months 
                from previous “Reasonable Efforts to Finalize a Permanency Plan” (REFPP) or “Reasonable Efforts were made to prevent removal” (RE)? </span></div></div>`;
      break;
    case (Math.abs(redetSeqNum[1]) > 3):
      reqjson.timeLimited = `<div class="row"><div class="col-xs-12 l"><span>E. Is there a judicial finding of the child’s “Reasonable Efforts to Finalize a Permanency Plan” (REFPP) within 12 months
      from previous “Reasonable Efforts to Finalize a Permanency Plan” (REFPP)? </span></div></div>`;
      break;
  }


  if (Math.abs(redetSeqNum[1]) === 1) {
    reqjson.childWithDisabilities = `<div class="row"><div class="col-xs-12 l"><span>F. Is there a judicial finding of the child’s “Best Interest” within 180 calendar days of the placement through a VPA?</span></div></div>`;
  } else if (Math.abs(redetSeqNum[1]) > 1) {
    reqjson.childWithDisabilities = `<div class="row"><div class="col-xs-12 l"><span>F. Is there a judicial finding of the child’s “Best Interest” within 12 months from previous “Best Interest”?</span></div></div>`;
  }


  if (reqjson.typeofremoval === 'Voluntary_Placement_Agreement') {
    if (Math.abs(redetSeqNum[1])) {
      reqjson.timeLimitedFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled ${checkboxCheck(reqjson.inputjson.worksheetData.dateoffindingctwdecision)} /> YES Date of court hearing: ${getStr(reqjson.inputjson.worksheetData.dateoffindingctwdecision, moment(reqjson.inputjson.worksheetData.dateoffindingctwdecision).format(dtformat))}</div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled ${checkboxCheck(!reqjson.inputjson.worksheetData.dateoffindingctwdecision)}/> NO ${getStr(!reqjson.inputjson.worksheetData.dateoffindingctwdecision, '(Child is no longer IV-E eligible)')}</div></div>`;
    } else {
      reqjson.timeLimitedFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> YES Date of court hearing:</div></div>` +
        `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled checked/> NO (Child is no longer IV-E eligible)</div></div>`;
    }

    if (Math.abs(redetSeqNum[1])) {
      if (reqjson.inputjson.worksheetData.dateofcurrentjudicialfindingofbestinterest) {
        reqjson.childWithDisabilitiesFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled checked/> YES Date of court hearing: ${moment(reqjson.inputjson.worksheetData.dateofcourthearing).format(dtformat)}</div></div>` +
          `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> NO</div></div>`;
      } else {
        reqjson.childWithDisabilitiesFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> YES Date of court hearing:</div></div>` +
          `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled checked/> NO (Child is no longer IV-E eligible)</div></div>`;
      }
    } else {
      reqjson.childWithDisabilitiesFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> YES Date of court hearing:</div></div>` +
        `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled checked/> NO (Child is no longer IV-E eligible)</div></div>`;
    }
  } else {
    reqjson.timeLimitedFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> YES Date of court hearing:</div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> NO</div></div>`;

    reqjson.childWithDisabilitiesFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> YES Date of court hearing:</div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> NO</div></div>`;
  }

  reqjson = getIVEFCIDisabilitycheck(reqjson);
  
  return reqjson;
}

function getIVEFCIDisabilitycheck(reqjson){
  if (reqjson.inputjson.worksheetData && reqjson.inputjson.worksheetData.typeofvpa) {
    if (reqjson.inputjson.worksheetData.typeofvpa === 'Time-Limited') {
      reqjson.childWithDisabilitiesFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> YES Date of court hearing:</div></div>` +
        `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> NO</div></div>`;
    } else if (reqjson.inputjson.worksheetData.typeofvpa === 'Child with Disabilities') {
      reqjson.timeLimitedFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> YES Date of court hearing:</div></div>` +
        `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> NO</div></div>`;
    }
  }
  return reqjson;
}

function getIVEFCSSIData(input,reqjson) {
  if (reqjson.childreceivingssiorssaduringreviewperiod === 'YES') {
    reqjson.childreceivingssiorssaduringreviewperiodFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled checked/> YES</div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 70px">What type of benefit? ` + reqjson.typeofbenefit + ` Amount: $` + reqjson.amountofbenefit + ` </div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> NO</div></div>`;

    if (reqjson.istheagencytherepresentativepayee === 'YES') {
      reqjson.istheagencytherepresentativepayeeFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled checked/> YES</div></div>` +
        `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> NO</div></div>`;
    } else if (reqjson.istheagencytherepresentativepayee === 'NO') {
      reqjson.istheagencytherepresentativepayeeFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> YES</div></div>` +
        `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled checked/> NO </div></div>`;
    } else {
      reqjson.istheagencytherepresentativepayeeFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> YES</div></div>` +
        `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled/> NO </div></div>`;
    }

  } else if (reqjson.childreceivingssiorssaduringreviewperiod === 'NO' || reqjson.childreceivingssiorssaduringreviewperiod === null) {
    reqjson.childreceivingssiorssaduringreviewperiodFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> YES</div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 70px">What type of benefit?   Amount: $  </div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled checked/> NO </div></div>`;

    reqjson.istheagencytherepresentativepayeeFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> YES</div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled/> NO </div></div>`;

  } else {
    reqjson.childreceivingssiorssaduringreviewperiodFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> YES</div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 70px">What type of benefit?   Amount: $  </div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> NO </div></div>`;

    reqjson.istheagencytherepresentativepayeeFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> YES</div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled/> NO </div></div>`;
  }


  if (reqjson.hastheagencyoptedtosuspendthessipaymentandclaimive === 'YES') {
    reqjson.hastheagencyoptedtosuspendthessipaymentandclaimiveFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled checked/> YES Date of request to suspend the SSI payment and claim IV-E: ` + util.formatDate(input.DateOfRequestToSuspendTheSSIPaymentAndClaimIVE) + `</div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> NO</div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> N/A</div></div>`;
  } else if (reqjson.hastheagencyoptedtosuspendthessipaymentandclaimive === 'NO') {
    reqjson.hastheagencyoptedtosuspendthessipaymentandclaimiveFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> YES Date of request to suspend the SSI payment and claim IV-E:</div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled checked/> NO </div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> N/A</div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"> Reason for not opting to suspend the SSI payment and claim IV-E : ` + reqjson.inputjson.worksheetData.notefornotsuspendingssi + `</div></div>`;
  } else if (reqjson.hastheagencyoptedtosuspendthessipaymentandclaimive === 'NA') {
    reqjson.hastheagencyoptedtosuspendthessipaymentandclaimiveFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> YES Date of request to suspend the SSI payment and claim IV-E:</div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> NO </div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled checked /> N/A</div></div>`;
  } else {
    reqjson.hastheagencyoptedtosuspendthessipaymentandclaimiveFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> YES Date of request to suspend the SSI payment and claim IV-E:</div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> NO </div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> N/A</div></div>`;
  }

  if (input.HaveThereBeenAnyLapsesInPlacementAndCareResponsibilityToIVEAgency === 'YES') {
    var tempLapses = `<input type="checkbox" disabled ${checkboxCheck(input.TypeOfLapses === 'Temporary')}/> Temporary`;
    var permLapses = `<input type="checkbox" disabled ${checkboxCheck(input.TypeOfLapses === 'Permanent')}/> Permanent`;

    reqjson.HaveThereBeenAnyLapsesInPlacementFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled checked/> YES </div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 70px">` + tempLapses + `  ` + permLapses + `</div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> NO</div></div>`;
  } else if (input.HaveThereBeenAnyLapsesInPlacementAndCareResponsibilityToIVEAgency === 'NO' || input.HaveThereBeenAnyLapsesInPlacementAndCareResponsibilityToIVEAgency === null) {
    reqjson.HaveThereBeenAnyLapsesInPlacementFlag = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled /> YES </div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 70px"><input type="checkbox" disabled/> Temporary  '<input type="checkbox" disabled/> Permanent'</div></div>` +
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled checked/> NO </div></div>`;
  }
  return reqjson;

}

function checkboxInputEleDiv(value, displayTxt = '', showNA = false) {
  let ele = ''
  if (value === 'YES') {
    ele = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" 'disabled' checked/> YES ${displayTxt}</div></div>` + 
    `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" 'disabled' /> NO</div></div>`;
  } else if (value === 'NO') {
      ele = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" 'disabled' /> YES</div></div>` + 
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" 'disabled' checked/> NO</div></div>`;
  } else {
      ele = `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" 'disabled' /> YES</div></div>` + 
      `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" 'disabled' /> NO</div></div>`;
  }
  if(showNA){
    ele += `<div class="row"><div class="col-xs-12 l" style="padding-left: 35px"><input type="checkbox" disabled ${checkboxCheck(value !== 'YES' && value !== 'NO')} /> N/A</div></div>`
  }
  return ele;
}

function getStr(cond, str){
  return cond ? str : '';
}


module.exports.adoptionacaformPDF = function (request,response) {

  var reqjson = {};
  var clientId = request.where.clientId;
  var childjurisdiction = request.where.childJurisdiction;
  var childagency = request.where.childAgency;
  var casenumber = request.where.caseNumber;
  var childname = request.where.childName

  var sql = `select * from tb_ive_adoption_audit tiaa where tiaa.category = 'A' and tiaa.cjamspid = $1 order by  tiaa.insertedon desc limit 1`;

  return util.executeDBQuery(sql, [clientId])
    .then(data => {
      if (data.length > 0) {
        LOGGER.debug("data ::: ",data);

        reqjson = data[0].pagesnapshot;

        reqjson.client_id = clientId;
        reqjson.childjurisdiction = childjurisdiction;
        reqjson.childagency = childagency;
        reqjson.casenumber = casenumber;
        reqjson.childname = childname;
        reqjson.appchildmeetchildstatuscriteriaofsectionia12or3 = data[0].appchildmeetchildstatuscriteriaofsectionia12or3;
        reqjson.appplacementormedicalcriteriaofsectionib12or3 = data[0].appplacementormedicalcriteriaofsectionib12or3;
        reqjson.appthespecialneedscriteriainsecic12aorband3aorb = data[0].appthespecialneedscriteriainsecic12aorband3aorb;

        reqjson.haschildbeenassessedtonotbeanappchild = data[0].haschildbeenassessedtonotbeanappchild;
        reqjson.nonappplacementormedicalcriteriaofsecib12or3 = data[0].nonappplacementormedicalcriteriaofsecib12or3;
        reqjson.nonapplsplneedscriteriainsecic12aorband3aorb = data[0].nonapplsplneedscriteriainsecic12aorband3aorb;
        reqjson.nonappltitleivestandardsofsecid1prioradptionaorbor2ivefcorssiao = data[0].nonappltitleivestandardsofsecid1prioradptionaorbor2ivefcorssiao;

        reqjson.adoptionapplicable = data[0].adoptionapplicable;
        reqjson.adoptionnonapplicable = data[0].adoptionnonapplicable;
        reqjson.applicableandnonapplicable = data[0].applicableandnonapplicable;
        reqjson.neitheranappnornonappchildfortitleivepurposes = data[0].neitheranappnornonappchildfortitleivepurposes;

        reqjson = getAcaSiblinginfo(reqjson);
        reqjson = getAcaminorparentinfo(reqjson);
        reqjson = getacaData(data,reqjson);


        if (reqjson) {
          reqjson.childbirthdate = util.formatDate(reqjson.childbirthdate);
          reqjson.childremovaldate = util.formatDate(reqjson.childremovaldate);
          reqjson.dateoffindingctwdecision = util.formatDate(reqjson.dateoffindingctwdecision);

          reqjson.expectedadoptiondate = util.formatDate(reqjson.expectedadoptiondate);
          reqjson.removalcourtorderdate = util.formatDate(reqjson.removalcourtorderdate);
          reqjson.dateoffirstcourtorderwithctw = util.formatDate(reqjson.dateoffirstcourtorderwithctw);
          reqjson.dtof1stcowithbiorctwfindingifconvtocina = util.formatDate(reqjson.dtof1stcowithbiorctwfindingifconvtocina);
          reqjson.dateofrelinquishment = util.formatDate(reqjson.dateofrelinquishment);

          if (reqjson.applicableandnonapplicable === 'YES') {
            reqjson.applicableandnonapplicable = `<td><input type="checkbox" checked disabled /></td>`;
            reqjson.adoptionnonapplicable = `<td><input type="checkbox" disabled /></td>`;
            reqjson.adoptionapplicable = `<td><input type="checkbox" disabled /></td>`;
          } else {
            reqjson.applicableandnonapplicable = `<td><input type="checkbox" disabled /></td>`;
            reqjson.adoptionapplicable = `<td><input type="checkbox" ${checkboxCheck(reqjson.adoptionapplicable === 'YES')} disabled /></td>`
            reqjson.adoptionnonapplicable = `<td><input type="checkbox" ${checkboxCheck(reqjson.adoptionnonapplicable === 'YES')} disabled /></td>`
          }
          reqjson.neitheranappnornonappchildfortitleivepurposes = `<td><input type="checkbox" ${checkboxCheck(reqjson.neitheranappnornonappchildfortitleivepurposes === 'YES')} disabled /></td>`
          reqjson.childreceivingssiatremovaldisplay = (reqjson.childmeetsssimedicaldisabledeligliblerequirements === 'NO') ?
            `<div class="row">
    <div class="col-xs-12 l"><span>a. Was child receiving SSI at removal or anytime during the current episode?</span> {{childreceivingssiatremoval}} </div>
   </div>` : '';

          reqjson.startdateofreceivingssi = (reqjson.childreceivingssiatremoval === 'YES') ? `<div class="row">
<div class="col-xs-12 l"><span>b. If Yes, on what date did child begin receiving SSI?</span> {{startdateofreceivingssi}} </div>
</div>` : '';
          reqjson = getAcaInputEle(reqjson);

        }

        var html = '';
        html = fs.readFileSync('./documenttemplates/adoptionacaform.html','utf8');
        request.where.outputfilename = 'adoptionacaform.pdf';

        return module.exports.generatepdf(request,html,reqjson,{
          type: 'report',
          res: response
        });
      }
    })
    .catch(err => {
        LOGGER.error(err);
        return err;
    })
}

function getacaData(data,reqjson) {
  if (data[0].adoptiondataincomplete !== null) {
    reqjson.adoptiondataincomplete = data[0].adoptiondataincomplete;
  }

  if (data[0].incompletespecalistname !== null) {
    reqjson.incompletespecalistname = data[0].incompletespecalistname
  }

  if (data[0].decisionsubmissionspecalistname !== null) {
    reqjson.decisionsubmissionspecalistname = data[0].decisionsubmissionspecalistname;
    reqjson.specialistrole = ivespecialistrole;
  }

  if (data[0].decisionresubmissionspecalistname !== null) {
    reqjson.decisionresubmissionspecalistname = data[0].decisionresubmissionspecalistname;
    reqjson.supervisorrole = ivesupervisorrole;
  }

  if (data[0].decisionsubmissionspecalistsignature !== null) {
    reqjson.specialistsignature = data[0].decisionsubmissionspecalistsignature;
  }

  if (data[0].decisionresubmissionspecalistsignature !== null) {
    reqjson.supervisorsignature = data[0].decisionresubmissionspecalistsignature;
  }

  if (reqjson.caseworkername == null) {
    reqjson.caseworkername = '';
  }

  if (reqjson.resubmissioncaseworkername == null) {
    reqjson.resubmissioncaseworkername = '';
  }

  if (reqjson.resubmissiondate !== null) {
    reqjson.resubmissiondate = util.formatDate(reqjson.resubmissiondate);
  }

  if (reqjson.submissiondate !== null) {
    reqjson.submissiondate = util.formatDate(reqjson.submissiondate);
  }


  if (data[0].incompletedate !== null) {
    reqjson.incompletedate = util.formatDate(data[0].incompletedate);
  }

  if (data[0].decisionsubmissiondate !== null) {
    reqjson.decisionsubmissiondate = util.formatDate(data[0].decisionsubmissiondate);
  }

  if (data[0].decisionresubmissiondate !== null) {
    reqjson.decisionresubmissiondate = util.formatDate(data[0].decisionresubmissiondate);
  }
  return reqjson;
}

function getAcaInputEle(reqjson) {

  reqjson.childsivestatusofpreviousadoption = (reqjson.childspreviouslyadopted === 'YES') ? `<div class="col-xs-12 l">
	<h5>
	<u style="font-size: medium;">` + reqjson.childsivestatusofpreviousadoption + `</u>
	</h5>
	</div>` : '';

  reqjson.descriptionofreturnhomemessage = (reqjson.canchildreturntohome === 'NO') ? `<div class="row">
	 <div class="col-xs-12 l" style="padding-left: 35px"><span> If no, explain why child cannot or should not be returned to the home of the parent: <u style="font-size: medium;">` + reqjson.descriptionofreturnhome + `</u></span></div>
  </div>` : '';


  if (reqjson.childreceivingssiatremoval === 'YES') {
    reqjson.dateoffirstcourtorderwithctw = `<div class="row">
		 <div class="col-xs-12 l"><span>b. If Yes, on what date did child begin receiving SSI?</span> {{dateoffirstcourtorderwithctw}} </div>
	  </div>`;
  }

  reqjson.adoptiondataincomplete = `<td><input type="checkbox" ${checkboxCheck(reqjson.adoptiondataincomplete === 'YES')} disabled /></td>`
  reqjson.childagetable1618 = `<td><input type="checkbox" ${checkboxCheck(reqjson.childagetable1618 === true || reqjson.childagetable == 'childagetable1618')} disabled /></td>`
  reqjson.childagetable418 = `<td><input type="checkbox" ${checkboxCheck(reqjson.childagetable418 === true || reqjson.childagetable == 'childagetable418')} disabled /></td>`
  reqjson.childagetable1418 = `<td><input type="checkbox" ${checkboxCheck(reqjson.childagetable1418 === true || reqjson.childagetable == 'childagetable1418')} disabled /></td>`
  reqjson.childagetable218 = `<td><input type="checkbox" ${checkboxCheck(reqjson.childagetable218 === true || reqjson.childagetable == 'childagetable218')} disabled /></td>`
  reqjson.childagetable1218 = `<td><input type="checkbox" ${checkboxCheck(reqjson.childagetable1218 === true || reqjson.childagetable == 'childagetable1218')} disabled /></td>`
  reqjson.childagetable018 = `<td><input type="checkbox" ${checkboxCheck(reqjson.childagetable018 === true || reqjson.childagetable == 'childagetable018')} disabled /></td>`
  reqjson.childagetable1018 = `<td><input type="checkbox" ${checkboxCheck(reqjson.childagetable1018 === true || reqjson.childagetable == 'childagetable1018')} disabled /></td>`
  reqjson.childagetable218dublicate = `<td><input type="checkbox" ${checkboxCheck(reqjson.childagetable218dublicate === true || reqjson.childagetable == 'childagetable218dublicate')} disabled /></td>`
  reqjson.childagetable818 = `<td><input type="checkbox" ${checkboxCheck(reqjson.childagetable818 === true || reqjson.childagetable == 'childagetable818')} disabled /></td>`
  reqjson.childagetable018dublicate = `<td><input type="checkbox" ${checkboxCheck(reqjson.childagetable018dublicate === true || reqjson.childagetable === 'childagetable018dublicate')} disabled /></td>`
  reqjson.childagetable618 = `<td><input type="checkbox" ${checkboxCheck(reqjson.childagetable618 === true || reqjson.childagetable === 'childagetable618')} disabled /></td>`
  reqjson.child617yearsofage = `<td><input type="checkbox" ${checkboxCheck(reqjson.child617yearsofage === true || reqjson.childagetable === 'child617yearsofage')} disabled /></td>`
  reqjson.physicalmentalemotionaldisability = `<td><input type="checkbox" ${checkboxCheck(reqjson.physicalmentalemotionaldisability === true)} disabled /></td>`
  reqjson.emotionaldisturbance = `<td><input type="checkbox" ${checkboxCheck(reqjson.emotionaldisturbance === true)} disabled /></td>`
  reqjson.siblinginformationcheck = `<td><input type="checkbox" ${checkboxCheck(reqjson.siblinginformationcheck === true)} disabled /></td>`
  reqjson.recognizedhighriskofphysicaldisability = `<td><input type="checkbox" ${checkboxCheck(reqjson.recognizedhighriskofphysicaldisability === true)} disabled /></td>`
  reqjson.raceethnicityofchild = `<td><input type="checkbox" ${checkboxCheck(reqjson.raceethnicityofchild === true)} disabled /></td>`
  return reqjson;
}

function getAcaSiblinginfo(reqjson){
	if (reqjson && reqjson.issiblingtochildwhoqualifiesasapplchildbyage === 'YES' && reqjson.adoptionapplicabilitysiblinginfo) {
		const siblings = reqjson.adoptionapplicabilitysiblinginfo;
		var siblinginfo = ``;
		if (siblings.length > 0) {
		  siblings.forEach((adoptionapplicabilitysiblinginfo) => {
			if (reqjson.adoptionapplicabilitysiblinginfo.length > 0) {
			  siblinginfo = siblinginfo + `<tr>
		   <td>`+ (emptyStrCheck(adoptionapplicabilitysiblinginfo.nameofsiblingchild)) + `</td>
		   <td>`+ (emptyStrCheck(adoptionapplicabilitysiblinginfo.nameofsiblingchildsadoptiveplacement)) + `</td>
		   <td>`+ (util.formatDate(adoptionapplicabilitysiblinginfo.dateofsiblingsadoptiondecree)) + `</td>
		   <td>`+ (util.formatDate(adoptionapplicabilitysiblinginfo.dateofsiblingsapplicablechildassessment)) + `</td>
		   <td>`+ (util.nullcheck(adoptionapplicabilitysiblinginfo.childssiblingsapplicabilitystatus)) + `</td>
		   <td>`+ (util.nullcheck(adoptionapplicabilitysiblinginfo.expectedchildadoptiveplacement)) + `</td>
		   <td>`+ (emptyStrCheck(adoptionapplicabilitysiblinginfo.siblingsrelationshipwithchild)) + `</td>
		  
		   </tr>`;
			}
		  });
		  siblinginfo = `<div class="row">
	   <table class="table table-bordered">
		   <tr>
			   <th>Name of sibling child</th>            
			   <th>Name of Sibling child's Adoptive Placement</th>      
			   <th>Date of siblings adoption decree</th>   
			   <th>Date of siblings applicable child assessment</th>   
			   <th>Child's sibling's applicability status</th>   
			   <th>Expected child adoptive placement (Provider ID)</th>
			   <th>Sibling's Relationship with child</th> 
		   </tr>` + siblinginfo +
			`</table>
	</div>`
		}
		reqjson.siblinginfo = siblinginfo;
	  } else {
		reqjson.siblinginfo = '';
	  }

	  if (reqjson && reqjson.siblinginformationcheck === true && reqjson.membersiblinginfo) {
		const membersiblings = reqjson.membersiblinginfo;
		var membersiblinginfo = ``;
		if (membersiblings.length > 0) {
		  membersiblings.forEach((obj) => {
			  membersiblinginfo = membersiblinginfo + `<tr>
		   <td>`+ (emptyStrCheck(obj.nameofsiblingchild)) + `</td>
		   <td>`+ (emptyStrCheck(obj.siblingadoptionstatus)) + `</td>
		   <td>`+ (util.nullcheck(obj.siblingproviderid)) + `</td>
		   <td>`+ (util.formatDate(obj.dateofsiblingsadoptiondecree)) + `</td>
		   <td>`+ (util.formatDate(obj.dateofsiblingsapplicablechildassessment)) + `</td>
		   </tr>`;
		  });
		  membersiblinginfo = `<div class="row" style="padding-top: 10px">
	   <div class="col-xs-12 l">
	   <table class="table table-bordered">
		   <tr>
			   <th>Name of sibling child</th>  
			   <th>Sibling adoption status</th>          
			   <th>Name Of The Sibling Adoption Placement (Provider ID)</th>      
			   <th>Sibling Adoption Decree Date</th>   
			   <th>Sibling Applicable Child Assessment Date</th>   
		   </tr>` + membersiblinginfo +
			`</table>
	   </div>
	</div>`
		}
		reqjson.membersiblinginfo = membersiblinginfo;
	  } else {
		reqjson.membersiblinginfo = '';
	  }

	  return reqjson;
}

function getAcaminorparentinfo(reqjson){
  if (reqjson && reqjson.isthechildresidinginafosterfamilyhome === 'YES' && reqjson.adoptionapplicabilityminorparentinfo) {
    const minorparentdetails = reqjson.adoptionapplicabilityminorparentinfo;
    var minorparentinfo = ``;
    if (minorparentdetails.length > 0) {

      minorparentinfo = `<div class="row">
   <div class="col-xs-12 l">
   <span>Minor Parent Information: </span>
   <br>
   <table class="table table-bordered">
   <tr>
      <td>Minor Parent Name:  </td>
      <td> ${(util.nullcheck(minorparentdetails[0].minorparentname))}</td>
   </tr>
   <tr>
      <td>Birth date of parent:  </td>
      <td> ${(util.formatDate(minorparentdetails[0].birthdateofparent))}</td>
   </tr>
   <tr>
      <td>Removal Type of Minor parent:  </td>
      <td> ${(util.nullcheck(minorparentdetails[0].removaltypeofminorparent))}</td>
   </tr>
   <tr>
      <td>Removal court order date of minor parent </td>
      <td> ${(util.formatDate(minorparentdetails[0].removalcourtorderdateofminorparent))}</td>
   </tr>
   <tr>
      <td>VPA Removal Date of minor parent  </td>
      <td> ${(util.formatDate(minorparentdetails[0].removaldateofminorparent))}</td>
   </tr>
   <tr>
      <td>Minor Parent's current placement Type </td>
      <td> ${util.nullcheck(minorparentdetails[0].minorparentscurrentplacementtype)}</td>
   </tr>

   <tr>
      <td>Child's current placement type</td>
      <td> ${util.nullcheck(minorparentdetails[0].childscurrentplacementtype)}</td>
   </tr>
   <tr>
      <td>Physical address of minor parent</td>
      <td> ${util.nullcheck(minorparentdetails[0].physicaladdressofminorparent)}</td>
   </tr>
   <tr>
      <td>Physical address of child</td>
      <td> ${minorparentdetails[0].physicaladdressofchild}</td>
   </tr>
  </table>
</div>
<div>`

    }
    reqjson.minorparentinfo = minorparentinfo;
  } else {
    reqjson.minorparentinfo = '';
  }
  return reqjson;
}

module.exports.gapeligibilityformPDF = function (request,response) {

  var reqjson = {};
  var clientId = request.where.clientId;
  var eligibilityperiodid = request.where.eligibilityId;

 
  var sql = `select * from tb_ive_gapaudit tbg join tb_eligibility_period tpe on tpe.eligibility_period_id = tbg.eligibility_period_id where tbg.clientid = $1::varchar and tbg.eligibility_period_id = $2`
  return util.executeDBQuery(sql, [clientId, eligibilityperiodid])
    .then(data => {
      if (data.length > 0) {
        LOGGER.debug("data ::: ",data);

        reqjson = data[0];

        reqjson.specialistsubmissiondate = util.formatDate(reqjson.specialistsubmissiondate);
        reqjson.supervisorsubmissiondate = util.formatDate(reqjson.supervisorsubmissiondate);

        reqjson = checkgapRole(reqjson)

        reqjson.client_id = clientId;
        reqjson.appchildmeetchildstatuscriteriaofsectionia12or3 = data[0].appchildmeetchildstatuscriteriaofsectionia12or3;
        reqjson.appplacementormedicalcriteriaofsectionib12or3 = data[0].appplacementormedicalcriteriaofsectionib12or3;
        reqjson.appthespecialneedscriteriainsecic12aorband3aorb = data[0].appthespecialneedscriteriainsecic12aorband3aorb;

        reqjson.haschildbeenassessedtonotbeanappchild = data[0].haschildbeenassessedtonotbeanappchild;
        reqjson.nonappplacementormedicalcriteriaofsecib12or3 = data[0].nonappplacementormedicalcriteriaofsecib12or3;
        reqjson.nonapplsplneedscriteriainsecic12aorband3aorb = data[0].nonapplsplneedscriteriainsecic12aorband3aorb;
        reqjson.nonappltitleivestandardsofsecid1prioradptionaorbor2ivefcorssiao = data[0].nonappltitleivestandardsofsecid1prioradptionaorbor2ivefcorssiao;

        reqjson.adoptionapplicable = data[0].adoptionapplicable;
        reqjson.adoptionnonapplicable = data[0].adoptionnonapplicable;
        reqjson.applicableandnonapplicable = data[0].applicableandnonapplicable;
        reqjson.neitheranappnornonappchildfortitleivepurposes = data[0].neitheranappnornonappchildfortitleivepurposes;
        reqjson.ldssFosterHomeApprover = data[0].pagesnapshot.fosterhomeapprover;
        reqjson.cpaFosterHomeApprover = data[0].pagesnapshot.fosterhomeapprover;

        reqjson.YesIndicatetypeofremoval = data[0].pagesnapshot.yesindicatetypeofremoval;
        reqjson.voluntaryVpa = data[0].pagesnapshot.childremovedbyvpa;

        reqjson.courtOrderbestinterest = data[0].pagesnapshot.childremovedbycrt;
        reqjson.last6monthfiscalpaymentstatus = data[0].pagesnapshot.last6monthfiscalpaymentstatus;

        reqjson = getgapEligData(data, reqjson)

        if (reqjson) {
          reqjson.childbirthdate = util.formatDate(reqjson.dateofbirth);
          reqjson.childremovaldate = util.formatDate(reqjson.childremovaldate);
          reqjson.guardianshipagreementsigneddate = util.formatDate(reqjson.sg_agreementsigneddate);
          reqjson.guardianshipfinalizationdate = util.formatDate(reqjson.guardianshipfinalizationdate);

          reqjson.GAPAgmntPriorFinDate = checkboxInputEle(reqjson.GAPAgmntPriorFinDate);

          reqjson.gapeligibilitystatus1 = `<td><input type="checkbox" ${checkboxCheck(reqjson.gapeligibilitystatus === 'Eligible Reimbursable')} disabled/> </td>`;
          reqjson.gapeligibilitystatus2 = `<td><input type="checkbox" ${checkboxCheck(reqjson.gapeligibilitystatus === 'Ineligible')} disabled /> </td>`;

          reqjson.voluntaryVpa = `<input type="checkbox" ${checkboxCheck(reqjson.voluntaryVpa === true)} disabled>  `
          reqjson.courtOrderbestinterest = `<input type="checkbox" ${checkboxCheck(reqjson.courtOrderbestinterest === true)} disabled>  `
          if (reqjson.YesIndicatetypeofremoval === true) {
            reqjson.YesIndicatetypeofremoval = `<input type = "checkbox" checked disabled/>  `;
            reqjson.NoIndicatetypeofremoval = `<input type = "checkbox"  disabled/>  `;
          } else if (reqjson.YesIndicatetypeofremoval === false) {
            reqjson.YesIndicatetypeofremoval = `<input type = "checkbox" disabled/> `;
            reqjson.NoIndicatetypeofremoval = `<input type = "checkbox" checked disabled/>  `;
          } else {
            reqjson.YesIndicatetypeofremoval = `<input type = "checkbox" disabled/>`;
            reqjson.NoIndicatetypeofremoval = `<input type = "checkbox"  disabled/>`;
          }

          reqjson.ldssFosterHomeApprover = `<td><input type="checkbox" ${checkboxCheck(reqjson.ldssFosterHomeApprover === 'LDSS')} disabled /></td>`
          reqjson.cpaFosterHomeApprover = `<td><input type="checkbox" ${checkboxCheck(reqjson.cpaFosterHomeApprover === 'CPA')} disabled /></td>`
          reqjson.cpa = reqjson.cpaFosterHomeApprover === 'CPA'; 
          reqjson.last6monthfiscalpaymentstatus = checkboxInputEle(reqjson.last6monthfiscalpaymentstatus);
          reqjson.isreunificationremoved = checkboxInputEle(reqjson.isreunificationremoved);
          reqjson.isadoptionremoved = checkboxInputEle(reqjson.isadoptionremoved);
          reqjson.iscgprovidesafe = checkboxInputEle(reqjson.iscgprovidesafe);
          reqjson.isconsultationchildage = checkboxInputEle(reqjson.isconsultationchildage);
          reqjson.isguardianattach = checkboxInputEle(reqjson.isguardianattach);

          if (reqjson.GAPSecA_1 === 'YES') {
            reqjson.GAPSecA_1 = `<div class="col-xs-6 l" style="padding-left: 70px;" >
                  <td><input type="checkbox" checked disabled/> Yes – Date of approval: ` + reqjson.DateOfFullApprovalFP + ` </td>
                  <td><input type="checkbox" disabled /> No </td>
            </div>`;
          } else if (reqjson.GAPSecA_1 === 'NO') {
            reqjson.GAPSecA_1 = `<div class="col-xs-6 l" style="padding-left: 70px;" >
            <td><input type="checkbox" disabled /> Yes </td>
            <td><input type="checkbox" checked disabled /> No</td>
          </div>`;
          } else {
            reqjson.GAPSecA_1 = `<div class="col-xs-6 l" style="padding-left: 70px;" >
            <td><input type="checkbox" disabled /> Yes </td>
            <td><input type="checkbox" disabled /> No </td>
          </div>`;
          }

          reqjson.GAPSecA_2 = `<div class="col-xs-6 l" style="padding-left: 70px;" >
          ${checkboxInputEle(reqjson.GAPSecA_2)}
          </div>`;

          reqjson.GAPSecA_3 = `<div class="col-xs-6 l" style="padding-left: 70px;" >
          ${checkboxInputEle(reqjson.GAPSecA_3)}
          </div>`;

          reqjson.GAPSecA_4 = `<div class="col-xs-6 l" style="padding-left: 70px;" >
                  ${checkboxInputEle(reqjson.GAPSecA_4)}
            </div>`;

          reqjson.GAPSecB1_PG_State = checkboxInputEle(reqjson.GAPSecB1_PG_State);

          reqjson.GAPSecB1_PG_National = checkboxInputEle(reqjson.GAPSecB1_PG_National);

          reqjson.GAPSecB1_HH_National = checkboxInputEle(reqjson.GAPSecB1_HH_National);

          reqjson.GAPSecB1_HH_State = checkboxInputEle(reqjson.GAPSecB1_HH_State);

          reqjson.GAPSecB2_HH_National = checkboxInputEle(reqjson.GAPSecB2_HH_National);

          reqjson.GAPSecB2_HH_State = checkboxInputEle(reqjson.GAPSecB2_HH_State);

          reqjson.GAPSecB1_PG_CAM_OS = checkboxInputEle(reqjson.GAPSecB1_PG_CAM_OS);

          reqjson.GAPSecB1_HH_CAM_OS = checkboxInputEle(reqjson.GAPSecB1_HH_CAM_OS);

          reqjson.GAPSecB1_PG_CAM = checkboxInputEle(reqjson.GAPSecB1_PG_CAM);

          reqjson.GAPSecB1_HH_CAM = checkboxInputEle(reqjson.GAPSecB1_HH_CAM);

        }

        var html = '';
        html = fs.readFileSync('./documenttemplates/gapeligibilityform.html','utf8');
        request.where.outputfilename = 'gapeligibilityform.pdf';

        return module.exports.generatepdf(request,html,reqjson,{
          type: 'report',
          res: response
        });
      }
    })
    .catch(err => {
        LOGGER.error(err);
        return err;
    })
}

function checkgapRole(reqjson){
  if (reqjson.specialistname) {
    reqjson.specialistrole = ivespecialistrole;
  }

  if (reqjson.supervisorname) {
    reqjson.supervisorrole = ivesupervisorrole;
  }
  return reqjson;
}

function getgapEligData(data, reqjson){
  if (data[0].outputjson && data[0].outputjson.Objects[0].person) {
    reqjson.GAPSecA_1 = emptyStrCheck(data[0].outputjson.Objects[0].person.licensedFosterHome[0].GAPSecA_1);
    reqjson.GAPSecB1_PG_State = emptyStrCheck(data[0].outputjson.Objects[0].person.licensedFosterHome[0].State_criminal_history_background_check);
    reqjson.GAPSecB1_PG_National = emptyStrCheck(data[0].outputjson.Objects[0].person.licensedFosterHome[0].FBI_criminal_history_background_check);
    reqjson.GAPSecB1_PG_CAM = checkYes(data[0].outputjson.Objects[0].person.licensedFosterHome[0].Date_Of_Child_abuse_and_maltreatment_data_base_check);
    reqjson.GAPSecB1_PG_CAM_OS = emptyStrCheck(data[0].outputjson.Objects[0].person.licensedFosterHome[0].Applicable_child_welfare_agencies_in_the_previous_states_contacted_to_obtain_child_abuse_and_maltreatment_information);
    reqjson.DateOfFullApprovalFP = emptyStrCheck(data[0].outputjson.Objects[0].person.licensedFosterHome[0].DateOfFullApprovalFP);
    reqjson.GAPSecA_3 = emptyStrCheck(data[0].outputjson.Objects[0].person.GAPSecA_3);
    reqjson.GAPSecA_4 = emptyStrCheck(data[0].outputjson.Objects[0].person.GAPSecA_4);
  }
  if (data[0].outputjson && data[0].outputjson.Objects[0].householdMember) {
    const householdmembers = data[0].outputjson && data[0].outputjson.Objects[0].householdMember;
    if (householdmembers.length > 0) {
      reqjson.GAPSecB1_HH_National = 'YES';
      reqjson.GAPSecB1_HH_State = 'YES';
      reqjson.GAPSecB1_HH_CAM = 'YES';
      reqjson = checkgaphousehold(householdmembers, reqjson);
    }
    else if (data[0].outputjson && data[0].outputjson.Objects[0].secondGuardian) {
      reqjson.GAPSecB1_HH_National = checkYes(data[0].outputjson.Objects[0].secondGuardian.SG_Date_Of_FBI_Criminal_History_Background_Check);
      reqjson.GAPSecB1_HH_State = checkYes(data[0].outputjson.Objects[0].secondGuardian.SG_DateOf_State_criminal_history_background_check);
      reqjson.GAPSecB1_HH_CAM = checkYes(data[0].outputjson.Objects[0].secondGuardian.SG_Date_Of_Child_abuse_and_maltreatment_data_base_check);
      reqjson.GAPSecB1_HH_CAM_OS = checkYes(data[0].outputjson.Objects[0].secondGuardian.SG_Applicable_child_welfare_agencies_in_the_previous_states_contacted_to_obtain_child_abuse_and_maltreatment_information);
    }
  }
  if (data[0].outputjson && data[0].outputjson.Objects[0].applicantInformation) {
    reqjson.GAPSecA_2 = emptyStrCheck(data[0].outputjson.Objects[0].applicantInformation.GAPSecA_2);
  }

  if (data[0].outputjson && data[0].outputjson.Objects[0].GAPAgmntPriorFinDate) {
    reqjson.GAPAgmntPriorFinDate = data[0].outputjson.Objects[0].GAPAgmntPriorFinDate;
  }

  if (data[0].pagesnapshot) {
    reqjson.isreunificationremoved = data[0].pagesnapshot.isreunificationremoved;
    reqjson.isadoptionremoved = data[0].pagesnapshot.isadoptionremoved;
    reqjson.iscgprovidesafe = data[0].pagesnapshot.iscgprovidesafe;
    reqjson.isconsultationchildage = data[0].pagesnapshot.isconsultationchildage;
    reqjson.isguardianattach = data[0].pagesnapshot.isguardianattach;
  }
  return reqjson;
}

function checkgaphousehold(householdmembers, reqjson){
  householdmembers.forEach((h) => {
    if (h.FBI_Criminal_History_Background_Check_HH == 'NO' || h.FBI_Criminal_History_Background_Check_HH == '' || h.FBI_Criminal_History_Background_Check_HH == undefined) {
      reqjson.GAPSecB1_HH_National = 'NO';
    }
    if (h.State_criminal_history_background_check_HH == 'NO' || h.State_criminal_history_background_check_HH == '' || h.State_criminal_history_background_check_HH == undefined) {
      reqjson.GAPSecB1_HH_State = 'NO';
    }
    if (h.Child_abuse_and_maltreatment_data_base_check_HH == 'NO' || h.Child_abuse_and_maltreatment_data_base_check_HH == '' || h.Child_abuse_and_maltreatment_data_base_check_HH == undefined) {
      reqjson.GAPSecB1_HH_CAM = 'NO';
    }
  });
  return reqjson;
}

module.exports.adoptioneligibilityformPDF = function (request,response) {

  var reqjson = {};
  var clientId = request.where.clientId;
  var eligibilityperiodid = request.where.eligibilityId;

  var sql = `select * from tb_ive_adoption_audit where clientid = $1 and eligibility_period_id = $2`;

  var sqlforivedeprivation = `select * from ivepersondeprivation where clientid = $1`;

  var sqlforivrelative = `select * from specifiedrelative spr where spr.toclientid:: character varying = $1`;

  var sqlforiveoutput = `select outputjson from tb_ive_fostercare_audit tifa where tifa.cjamspid:: character varying = $1 order by tifa.updatedon desc limit 1`;


  return new Promise((resolve,reject) => {
    var adpinitialpdfdata = [
      getadoptioninitialworksheetdata(sql, [clientId, eligibilityperiodid]),
      getadoptioninitialworksheetdata(sqlforivedeprivation, [clientId]),
      getadoptioninitialworksheetdata(sqlforivrelative, [clientId]),
      getadoptioninitialworksheetdata(sqlforiveoutput, [clientId])
    ];

    Promise.all(adpinitialpdfdata).then(function (values) {

      var data = values[0];
      var deprivationdata = values[1];
      var specifiedrelativedata = values[2];
      var fostercareoutputjson = values[3];



      if (data.length > 0) {
        LOGGER.debug("data ::: ",data);

        reqjson = data[0].pagesnapshot;

        if (data[0].outputjson && data[0].outputjson.Objects[0]) {
          reqjson.ADP_SecA_1 = emptyStrCheck(data[0].outputjson.Objects[0].ADP_SecA_1);
          reqjson.ADP_SecA_2a = emptyStrCheck(data[0].outputjson.Objects[0].ADP_SecA_2a);
          reqjson.ADP_SecA_2b = emptyStrCheck(data[0].outputjson.Objects[0].ADP_SecA_2b);
          reqjson.ADP_SecA_2c = emptyStrCheck(data[0].outputjson.Objects[0].ADP_SecA_2c);
          reqjson.ADP_Eligible = emptyStrCheck(data[0].outputjson.Objects[0].status.AdoptionAssistance);
          reqjson.ADP_Applicable = emptyStrCheck(data[0].outputjson.Objects[0].ADP_Applicable);
        }

        reqjson = getAdoptionDeprivationInfo(deprivationdata, reqjson);
        reqjson = getAdoptionFCOutput(fostercareoutputjson,reqjson);
        reqjson = getadoptionsibilingInfo(reqjson);
        reqjson = formatAdoptionDates(specifiedrelativedata, reqjson);

        if (reqjson) {
          reqjson.dateofbirth = util.formatDate(reqjson.dateofbirth);
          reqjson.dtofdocforeffortstoplacewithoutasubsidy = util.formatDate(reqjson.dtofdocforeffortstoplacewithoutasubsidy);
          reqjson.childapplicableassessmentdt = util.formatDate(reqjson.childapplicableassessmentdt);

          reqjson.childspreviouslyadopted = checkboxInputEle(reqjson.childspreviouslyadopted);
          reqjson.childreceivingssiatremoval = checkboxInputEle(reqjson.childreceivingssiatremoval);
          reqjson.isthechildresidinginafosterfamilyhome = checkboxInputEle(reqjson.isthechildresidinginafosterfamilyhome);
          reqjson.istheminorparentreceivingivefc = checkboxInputEle(reqjson.istheminorparentreceivingivefc);

          reqjson.adoptionassistancestartdate = util.formatDate(reqjson.adoptionassistancestartdate);

          reqjson  = adoptionAgeCheck(reqjson);

          reqjson.childmeetallmedicaldisabilityrequirementsforssi = checkboxInputEle(reqjson.childmeetallmedicaldisabilityrequirementsforssi);
          reqjson.effortstoplacechildweremade = checkboxInputEle(reqjson.effortstoplacechildweremade);
          reqjson.exceptiongrantedinchildsbestinterests = checkboxInputEle(reqjson.exceptiongrantedinchildsbestinterests);
          reqjson.isreasonforexceptionrecorded = checkboxInputEle(reqjson.isreasonforexceptionrecorded);
          reqjson.unsuccessfulreasonableeffortsstatusrecords = checkboxInputEle(reqjson.unsuccessfulreasonableeffortsstatusrecords);

          reqjson = checkAdoptionTPRData(reqjson);

          reqjson.childspreviouslyadopted = checkboxInputEle(reqjson.childspreviouslyadopted);
          reqjson.childreceivingssiatremoval = checkboxInputEle(reqjson.childreceivingssiatremoval);
          reqjson.isthechildresidinginafosterfamilyhome = checkboxInputEle(reqjson.isthechildresidinginafosterfamilyhome);
          reqjson.istheminorparentreceivingivefc = checkboxInputEle(reqjson.istheminorparentreceivingivefc);


          reqjson = getAdoptionCourtData(reqjson);


          reqjson.wasthechildremovedfromspecifiedrelative = checkboxInputEle(reqjson.wasthechildremovedfromspecifiedrelative, false);
          reqjson.childdeprivedofparentalsupport = checkboxInputEle(reqjson.childdeprivedofparentalsupport, false);
          reqjson.isincomeassetsmet = checkboxInputEle(reqjson.isincomeassetsmet, false);


          reqjson = checkAdoptionchildapplicabilitystatus(reqjson);

          // 8696
          reqjson.ADP_SecA_1 = checkboxInputEle(reqjson.ADP_SecA_1);
          reqjson.ADP_SecA_2a = checkboxInputEle(reqjson.ADP_SecA_2a);
          reqjson.ADP_SecA_2b = checkboxInputEle(reqjson.ADP_SecA_2b);
          reqjson.ADP_SecA_2c = checkboxInputEle(reqjson.ADP_SecA_2c);




          if (reqjson.ADP_Eligible === eligibleReimbursible) {
            reqjson.ADP_Eligible = `<td><input type="checkbox" checked disabled/> Yes </td>
                  <td><input type="checkbox" disabled /> No </td>`;
          } else if (reqjson.ADP_Eligible === 'Ineligible') {
            reqjson.ADP_Eligible = `<td><input type="checkbox" disabled /> Yes </td>
            <td><input type="checkbox" checked disabled /> No</td>`;
          } else {
            reqjson.ADP_Eligible = `<td><input type="checkbox" disabled /> Yes </td>
            <td><input type="checkbox" disabled /> No </td>`;
          }

          reqjson.ADP_Applicable = checkboxInputEle(reqjson.ADP_Applicable);
          reqjson.child617yearsofage = `<td><input type="checkbox" ${checkboxCheck(reqjson.child617yearsofage === true)} disabled /></td>`
          reqjson.physicalmentalemotionaldisability = `<td><input type="checkbox" ${checkboxCheck(reqjson.physicalmentalemotionaldisability === true)} disabled /></td>`
          reqjson.emotionaldisturbance = `<td><input type="checkbox" ${checkboxCheck(reqjson.emotionaldisturbance === true)} disabled /></td>`
          reqjson.siblinginformationcheck = `<td><input type="checkbox" ${checkboxCheck(reqjson.siblinginformationcheck === true)} disabled /></td>`
          reqjson.recognizedhighriskofphysicaldisability = `<td><input type="checkbox" ${checkboxCheck(reqjson.recognizedhighriskofphysicaldisability === true)} disabled /></td>`
          reqjson.raceethnicityofchild = `<td><input type="checkbox" ${checkboxCheck(reqjson.raceethnicityofchild === true)} disabled /></td>`
        }


        var html = '';
        html = fs.readFileSync('./documenttemplates/adoptioneligibilityform.html','utf8');
        request.where.outputfilename = 'adoptioneligibilityform.pdf';

        const Response = module.exports.generatepdf(request,html,reqjson,{
          type: 'report',
          res: response
        });
        resolve(Response);
      }
    }).catch(error => {
      LOGGER.error(error.message)
    });
  });
}

function checkAdoptionchildapplicabilitystatus(reqjson){
  switch(reqjson.childapplicabilitystatus){
    case 'NonApplicable':
      reqjson.childapplicabilitystatus = `<td><input type="checkbox" checked>Applicable Child</td>
      <td><input type="checkbox" checked>Non-Applicable Child</td>
      <td><input type="checkbox">Adoption Applicable and NonApplicable</td>
      <td><input type="checkbox">Neither</td>`;
      reqjson.APP_Assessment = `<td><input type="checkbox" checked/> Yes </td>
      <td><input type="checkbox"/> No </td>`;
      break;
    case 'Adoption Applicable and NonApplicable':
      reqjson.childapplicabilitystatus = `<td><input type="checkbox" checked>Applicable Child</td>
      <td><input type="checkbox">Non-Applicable Child</td>
      <td><input type="checkbox" checked>Adoption Applicable and NonApplicable</td>
      <td><input type="checkbox">Neither</td>`;
      reqjson.APP_Assessment = `<td><input type="checkbox" checked/> Yes </td>
      <td><input type="checkbox"/> No </td>`;
      break;
    case 'Applicable':
      reqjson.childapplicabilitystatus = `<td><input type="checkbox" checked>Applicable Child</td>
      <td><input type="checkbox">Non-Applicable Child</td>
      <td><input type="checkbox">Adoption Applicable and NonApplicable</td>
      <td><input type="checkbox">Neither</td>`;
      reqjson.APP_Assessment = `<td><input type="checkbox" checked/> Yes </td>
      <td><input type="checkbox"/> No </td>`;
      break;
    case 'Neither Applicable or NonApplicable':
      reqjson.childapplicabilitystatus = `<td><input type="checkbox">Applicable Child</td>
      <td><input type="checkbox">Non-Applicable Child</td>
      <td><input type="checkbox">Adoption Applicable and NonApplicable</td>
      <td><input type="checkbox" checked>Neither</td>`;
      reqjson.APP_Assessment = `<td><input type="checkbox" checked/> Yes </td>
      <td><input type="checkbox"/> No </td>`;
      break;
    default:
      reqjson.childapplicabilitystatus = `<td><input type="checkbox">Applicable Child</td>
      <td><input type="checkbox">Non-Applicable Child</td>
      <td><input type="checkbox">Adoption Applicable and NonApplicable</td>
      <td><input type="checkbox">Neither</td>`;
      reqjson.APP_Assessment = `<td><input type="checkbox"/> Yes </td>
      <td><input type="checkbox" checked /> No </td>`;
  }
  return reqjson;
}

function adoptionAgeCheck(reqjson){
  if (reqjson.age < 21) {
    reqjson.age = `<td><input type="checkbox" checked disabled />YES</td>
    <td><input type="checkbox" disabled />NO</td>`;
  } else if (reqjson.age >= 21) {
    reqjson.age = `<td><input type="checkbox" disabled />YES</td>
    <td><input type="checkbox" checked disabled />NO</td>`;
  } else {
    reqjson.age = `<td><input type="checkbox" disabled />YES</td>
    <td><input type="checkbox" disabled />NO</td>`;
  }

  if (reqjson.AFDCEligibilityMonth_ForOutputForm && reqjson.AFDCEligibilityMonth_ForOutputForm !== null) {
    reqjson.AFDCEligibilityMonth_ForOutputForm = reqjson.AFDCEligibilityMonth_ForOutputForm.split('/')[0] + "-" + reqjson.AFDCEligibilityMonth_ForOutputForm.split('/')[2]
  } else {
    reqjson.AFDCEligibilityMonth_ForOutputForm = '';
  }
  return reqjson;
}

function checkAdoptionTPRData(reqjson){
  if (reqjson.tprGrantedtoBothParent === 'YES') {
    reqjson.tprGrantedtoBothParent = `<td><input type="checkbox" checked disabled />YES</td>
    <td><input type="checkbox" disabled />NO</td>`;
    reqjson.displaydateofTpRofParent1 = '';
    reqjson.displaydateofTpRofParent2 = '';
    reqjson.displaynoReasonfornotgranting = '';
  } else if (reqjson.tprGrantedtoBothParent === 'NO') {
    reqjson.tprGrantedtoBothParent = `<td><input type="checkbox" disabled />YES</td>
    <td><input type="checkbox" checked disabled />NO</td>`;
    reqjson.displaydateofTpRofParent1 = ''
    reqjson.displaydateofTpRofParent2 = ''
    reqjson.displaynoReasonfornotgranting = `<div class=col-xs-6 l><span>Reason For Not Granting TPR For Both Parent: ` +
      reqjson.ifnoReasonfornotgrantingTpRforbothparent
      + `</span></div>`
  } else {
    reqjson.tprGrantedtoBothParent = '';
    reqjson.displaydateofTpRofParent1 = '';
    reqjson.displaydateofTpRofParent2 = '';
    reqjson.displaynoReasonfornotgranting = '';
  }

  if (reqjson.canchildreturntohome === 'YES') {
    reqjson.canchildreturntohome = `<td><input type="checkbox" checked disabled />YES</td>
    <td><input type="checkbox" disabled />NO</td>`;
    reqjson.displaydescriptionofreturnhome = '';

  } else if (reqjson.canchildreturntohome === 'NO') {
    reqjson.canchildreturntohome = `<td><input type="checkbox"  disabled />YES</td>
    <td><input type="checkbox" checked disabled />NO</td>`;
    reqjson.displaydescriptionofreturnhome = `<div class="col-xs-6 l">
              <span>Another reason child could not return to parent home (list): ` + reqjson.descriptionofreturnhome + `</span>
          </div>`;
  } else {
    reqjson.canchildreturntohome = `<td><input type="checkbox"  disabled />YES</td>
    <td><input type="checkbox" disabled />NO</td>`;
    reqjson.displaydescriptionofreturnhome = '';
  }
  return reqjson;
}

function getadoptionsibilingInfo(reqjson){
  if(reqjson && reqjson.issiblingtochildwhoqualifiesasapplchildbyage === 'YES' && reqjson.adoptionapplicabilitysiblinginfo){
      const siblings = reqjson.adoptionapplicabilitysiblinginfo;
       var siblinginfo = ``;
       if(siblings.length > 0 ){
        siblings.forEach((adoptionapplicabilitysiblinginfo) => {
         if(reqjson.adoptionapplicabilitysiblinginfo.length > 0) {
          siblinginfo = siblinginfo +  `<tr>
             <td>`+(emptyStrCheck(adoptionapplicabilitysiblinginfo.nameofsiblingchild))+`</td>
             <td>`+(emptyStrCheck(adoptionapplicabilitysiblinginfo.nameofsiblingchildsadoptiveplacement)) +`</td>
             <td>`+(util.formatDate(adoptionapplicabilitysiblinginfo.dateofsiblingsadoptiondecree))+`</td>
             <td>`+(util.formatDate(adoptionapplicabilitysiblinginfo.dateofsiblingsapplicablechildassessment))+`</td>
             <td>`+emptyStrCheck(adoptionapplicabilitysiblinginfo.childssiblingsapplicabilitystatus)+`</td>
             <td>`+emptyStrCheck(adoptionapplicabilitysiblinginfo.expectedchildadoptiveplacement)+`</td>
             <td>`+emptyStrCheck(adoptionapplicabilitysiblinginfo.siblingsrelationshipwithchild) +`</td>
            
             </tr>`;
         }
         });
         siblinginfo = `<div class="row">
         <table class="table table-bordered">
             <tr>
                 <th>Name of sibling child</th>            
                 <th>Name of Sibling child's Adoptive Placement</th>      
                 <th>Date of siblings adoption decree</th>   
                 <th>Date of siblings applicable child assessment</th>   
                 <th>Child's sibling's applicability status</th>   
                 <th>Expected child adoptive placement (Provider ID)</th>
                 <th>Sibling's Relationship with child</th> 
             </tr>` + siblinginfo +
         `</table>
      </div>`
       }
       reqjson.siblinginfo = siblinginfo;
     } else {
       reqjson.siblinginfo = '';
     }
     return reqjson;
}

function getAdoptionDeprivationInfo(deprivationdata, reqjson){
  if (deprivationdata) {
      const deprivations = deprivationdata;
      var deprivationInfo = ``;
      if (deprivations.length > 0) {
        deprivations.forEach((deprivation) => {
          deprivationInfo = deprivationInfo + `<tr>
         <td>`+ (emptyStrCheck(deprivation.nameofhouseholdmember)) + `</td>
         <td>` + emptyStrCheck(deprivation.relationshiptochild) + `</td>
         <td>`+ getDeprevationType(deprivation.deprivationtype) + `</td>
         </tr>`;
        });
        deprivationInfo = `<div class="row">
     <div class="col-xs-12 l">
     <table class="table table-bordered">
         <tr>
             <th>Name of Parent</th> 
             <th>Relationship to child</th>           
             <th>Deprivation Factor</th>    
         </tr>` + deprivationInfo +
          `</table>
     </div>
  </div>`
      }
      reqjson.deprivationInfo = deprivationInfo;
    } else {
      reqjson.deprivationInfo = '';
    }
    return reqjson;
}

function getAdoptionFCOutput(fostercareoutputjson,reqjson) {
  if (fostercareoutputjson && Array.isArray(fostercareoutputjson)) {
      if (fostercareoutputjson[0].outputjson && fostercareoutputjson[0].outputjson.Objects[0]) {
          if (fostercareoutputjson[0].outputjson.Objects[0].status.AFDCEligibilityMonth_ForOutputForm !== null) {
              reqjson.AFDCEligibilityMonth_ForOutputForm = fostercareoutputjson[0].outputjson.Objects[0].status.AFDCEligibilityMonth_ForOutputForm;
          } else {
              reqjson.AFDCEligibilityMonth_ForOutputForm = '';
          }

          if (fostercareoutputjson[0].outputjson.Objects[0].VPASigned === 'YES') {
              reqjson.vpasigned = `<td><input type="checkbox" checked/>Yes</td>
                                  <td><input type="checkbox" />No</td>`;
              reqjson = getAdoptionFCStatus(fostercareoutputjson, reqjson);
          } else if (fostercareoutputjson[0].outputjson.Objects[0].VPASigned === 'NO') {
              reqjson.vpasigned = `<td><input type="checkbox" />Yes</td>
    <td><input type="checkbox" checked/>No</td>`;
              reqjson.FosterCareEligibilityStatus = '';
          } else {
              reqjson.vpasigned = `<td><input type="checkbox" />Yes</td>
                                    <td><input type="checkbox"/>No</td>`;
              reqjson.FosterCareEligibilityStatus = '';
          }

      }

  }
  return reqjson;
}

function getAdoptionFCStatus(fostercareoutputjson, reqjson){
  if (fostercareoutputjson[0].outputjson.Objects[0].status.FosterCareEligibilityStatus === eligibleReimbursible ||
      fostercareoutputjson[0].outputjson.Objects[0].status.FosterCareEligibilityStatus === eligibleNonReimbursible
  ) {
      reqjson.FosterCareEligibilityStatus = `<div class="col-xs-12 l" style="padding-bottom: 10px; padding-left: 23px;">
                                              <span>was the child IV-E eligible at some time during foster care episode?
                                              <td><input type="checkbox" checked/>Yes</td>
                                              <td><input type="checkbox" />No</td>
                                              </span> 
                                              </div>`;
  } else if (fostercareoutputjson[0].outputjson.Objects[0].status.FosterCareEligibilityStatus === 'Ineligible') {
      reqjson.FosterCareEligibilityStatus = `<div class="col-xs-12 l" style="padding-bottom: 10px; padding-left: 23px;">
                                              <span>was the child IV-E eligible at some time during foster care episode?
                                              <td><input type="checkbox" />Yes</td>
                                              <td><input type="checkbox" checked />No</td>
                                              </span> 
                                              </div>`;
  } else {
      reqjson.FosterCareEligibilityStatus = `<div class="col-xs-12 l" style="padding-bottom: 10px; padding-left: 23px;">
                                              <span>was the child IV-E eligible at some time during foster care episode?
                                              <td><input type="checkbox" />Yes</td>
                                              <td><input type="checkbox" />No</td>
                                              </span> 
                                              </div>`;
  }
  return reqjson;
}

function formatAdoptionDates(specifiedrelativedata, reqjson){
  if (specifiedrelativedata && specifiedrelativedata.length > 0) {
    reqjson.nameofremovalhome = specifiedrelativedata[0].specifiedrelativename;
    reqjson.removalrelationship = specifiedrelativedata[0].relationshiptochild;
  } else {
    reqjson.nameofremovalhome = '';
    reqjson.removalrelationship = '';
  }
  
  if (reqjson.dateofadoptionfinalization !== null) {
    reqjson.dateofadoptionfinalization = util.formatDate(reqjson.dateofadoptionfinalization);
  }

  if (reqjson.adoptionparent1signdate !== null) {
    reqjson.adoptionparent1signdate = util.formatDate(reqjson.adoptionparent1signdate);
  }


  if (reqjson.adoptionparent2signdate !== null) {
    reqjson.adoptionparent2signdate = util.formatDate(reqjson.adoptionparent2signdate);
  }

  if (reqjson.adoptionldssdate !== null) {
    reqjson.adoptionldssdate = util.formatDate(reqjson.adoptionldssdate);
  }

  if (reqjson.adoptionpetitiondate !== null) {
    reqjson.adoptionpetitiondate = util.formatDate(reqjson.adoptionpetitiondate);
  }
  return reqjson;
}

function getAdoptionCourtData(reqjson){
  if (reqjson.isuscitizen === 'YES') {
    reqjson.isuscitizen = `<td><input type="checkbox" checked disabled />YES</td>
    <td><input type="checkbox" disabled />NO</td>`;
    reqjson.displayqualifiedalien = '';

  } else if (reqjson.isuscitizen === 'NO') {
    reqjson.isuscitizen = `<td><input type="checkbox"  disabled />YES</td>
    <td><input type="checkbox" checked disabled />NO</td>`;
    if (reqjson.isqualifiedalien === 'YES') {
      reqjson.displayqualifiedalien = `<div class="col-xs-6 l"> 
      Is the child a US Qualified Alien?
       <td><input type="checkbox" checked disabled />YES</td>
       <td><input type="checkbox"  disabled />NO</td>;
      </div> If qualified alien, documentation supporting determination: `;
    } else {
      reqjson.displayqualifiedalien = `<div class="col-xs-6 l"> 
      Is the child a US qualified alien?
       <td><input type="checkbox"  disabled />YES</td>
       <td><input type="checkbox" checked  disabled />NO</td>;
      </div>`;
    }
  } else {
    reqjson.isuscitizen = `<td><input type="checkbox"  disabled />YES</td>
    <td><input type="checkbox" disabled />NO</td>`;
    reqjson.displayqualifiedalien = '';
  }

  if (reqjson.childRemovalDateVpaRemovalDateofminorparentwhenRemovalTypeMinorParentVpa !== null) {
    reqjson.checkcourtorderdate = `<td><input type="checkbox"  disabled />Court order</td>`;
    reqjson.checkvpadate = `<td><input type="checkbox" checked  disabled />VPA</td>`;
    reqjson.displaycourtsection = '';
    reqjson.displayvpasection = `
    <div class="row">
    <div class="col-xs-12 l" style="padding-bottom: 10px; padding-left: 23px;">
          <label>Removal by VPA</label> 
    </div>

    <div class="col-xs-12 l" style="padding-bottom: 10px; padding-left: 23px;">
          <span>Was the VPA signed by the child's parent(s), legal guardian and Agency Representative?
         ${reqjson.vpasigned}
          </span> 
    </div>
    ${reqjson.FosterCareEligibilityStatus}
 </div>`;
  } else {
    reqjson.displayvpasection = '';
  }

  if (reqjson.removalcourtorderdate !== null) {
    reqjson.checkcourtorderdate = `<td><input type="checkbox" checked  disabled />Court order</td>`;
    reqjson.checkvpadate = `<td><input type="checkbox"  disabled />VPA</td>`;
    reqjson.displayvpasection = '';
    reqjson.displaycourtsection =
      `<div class="row">
       <div class="col-xs-12 l" style="padding-bottom: 10px; padding-left: 23px;">
             <label>Removal by Court Order</label> 
       </div>

       <div class="col-xs-12 l" style="padding-bottom: 10px; padding-left: 23px;">
             <span>Did the court order contain a judicial determination of “contrary to the welfare” and “reasonable efforts to prevent removal”
             made within timeframes required by IV-E eligibility?
             <input type="checkbox" checked>Yes
             <input type="checkbox">No
             </span> 
       </div>

       <div class="col-xs-12 l"><span>
       Date of Removal Court Order:` + util.formatDate(reqjson.removalcourtorderdate) + `</span </div>
       <div class="col-xs-12 l"><span>Eligibility (month/year):` + reqjson.AFDCEligibilityMonth_ForOutputForm + `</span></div>
    </div>`;

  } else {
    reqjson.displaycourtsection = '';
  }
  return reqjson;
}

module.exports.iveapprovallistformPDF = function (request,response,_securityusersid) {

  var reqjson = {};
  const securityuserid = _securityusersid;
  const roleTypeKey = request.where.roleTypeKey;
  const page = request.page
  const clientId = request.where.clientId;
  const approvalstatus = request.where.approvalstatus;
  const programtype = request.where.programtype;
  const requestedtouser = request.where.requestedtouser;
  const requestedfromuser = request.where.requestedfromuser;
  const username = request.where.userName;
  const userroledetails = request.where.userRoleType;
  const downloadDate = moment(new Date()).format(dtformat);

  var sql = 'select * from getiveapprovallist($1,$2,$3,$4,$5,$6,$7,$8,$9)';

  return util.executeDBQuery(sql,[securityuserid,roleTypeKey,page,null,clientId,approvalstatus,programtype,requestedtouser,requestedfromuser])
    .then(data => {
      if (data) {
        LOGGER.debug("data ::: ",data);

        reqjson = data;
        reqjson.approvalstatus = approvalstatus;
        reqjson.username = username;
        reqjson.userroledetails = userroledetails;
        reqjson.downloadDate = downloadDate;

        if (reqjson && reqjson.length > 0) {
          const approvalList = reqjson;
          var approvalInfo = ``;
          var rejectedInfo = ``;
          var pendingInfo = ``;

          if (approvalstatus === 'APPROVED') {
            approvalInfo = getInfoTable(approvalList,'APPROVED');
            reqjson.approvalInfo = approvalInfo;
          } else if (approvalstatus === 'REJECTED') {
            rejectedInfo = getInfoTable(approvalList,'REJECTED');
            reqjson.rejectedInfo = rejectedInfo;
          } else {
            approvalList.forEach((obj) => {
              pendingInfo = pendingInfo + `<tr>
                <td>`+ (emptyStrCheck(obj.client_name)) + `</td>
                <td>`+ obj.client_id + `</td>
                <td>`+ obj.requestedfrom + `</td>
                <td>`+ (dateCheck(obj.requestedon)) + `</td>
                <td>`+ obj.requestedto + `</td>
                <td>`+ obj.approval_status + `</td>
                <td>`+ obj.placement_type + `</td>
                <td>`+ getDetermination(obj) + `</td>
                </tr>`;
            });
            pendingInfo = `<div class="row">
            <table class="table table-bordered">
                <tr>
                    <th>Child Name</th>
                    <th>Client ID</th>
                    <th>Requested From</th>
                    <th>Requested On</th>
                    <th>Requested To</th>
                    <th>Approval Status</th>
                    <th>Program Type</th>
                    <th>Review Period</th>
                </tr>` + pendingInfo +
              `</table>
         </div>`
          }
          reqjson.pendingInfo = pendingInfo;
        } else {
          reqjson.norecords = `<div class = "row">
                   <div class="col-xs-10 l"><h3 class="text-center"><label>No Records found! <label></h3></div>
                   </div>
                   `;
        }


        var html = '';
        html = fs.readFileSync('./documenttemplates/iveapprovalsection.html','utf8');
        request.where.outputfilename = 'iveapprovlsection.pdf';

        return  module.exports.generatepdf(request,html,reqjson,{
          type: 'report',
          res: response
        });
      }
    })
    .catch(err => {
      LOGGER.error(err);
      return err;
    })


}

function getDetermination(obj) {
  const detElse = obj.sqnm_sw === 'A' ? 'Adoption Applicability' : 'Redetermination';
  return (obj.sqnm_sw === 'I' ? 'Initial' : detElse);
}

function getInfoTable(approvalList,type) {
  let info = '';
  if (approvalList && approvalList.length > 0) {
    approvalList.forEach((obj) => {
      info = info + `<tr>
				 <td>`+ (emptyStrCheck(obj.client_name)) + `</td>
				 <td>`+ obj.client_id + `</td>
				 <td>`+ obj.requestedfrom + `</td>
				 <td>`+ (dateCheck(obj.requestedon)) + `</td>
				 <td>`+ obj.requestedto + `</td>
				 <td>`+ obj.approval_status + `</td>
				 <td>`+ obj.approvedby + `</td>
				 <td>`+ (dateCheck(obj.approvedon)) + `</td>
				 <td>`+ obj.placement_type + `</td>
				 <td>`+ getDetermination(obj) + `</td>
				 </tr>`;
    });
    info = `<div class="row">
		 <table class="table table-bordered">
				 <tr>
						 <th>Child Name</th>
						 <th>Client ID</th>
						 <th>Requested From</th>
						 <th>Requested On</th>
						 <th>Requested To</th>
						 <th>Approval Status</th>
						 <th>${type === 'APPROVED' ? 'Approved By' : 'Rejected By'}</th>
						 <th>${type === 'APPROVED' ? 'Approved Date' : 'Rejected Date'}</th>
						 <th>Program Type</th>
						 <th>Review Period</th>
				 </tr>` + info +
      `</table>
	</div>`
  }
  return info;
}

// cans summary sheet starts
module.exports.canssummarysheet = function (request, response) {

  request.documntkey = request.where.documenttemplatekey; 
  let Response;
  

  if (request.where.payload) {
       
        let traumadata = '';
        for(const element of request.where.payload.teol){
          traumadata += element && element.length ? element + ' , <br> ' : '';
        }
        traumadata = traumadata.slice(0, -1); 

        const recommendationcol1data = ['Service Intensity Need Level',request.where.payload.si_level];
        const recommendationcol2data = ['QRTP Recommendation', request.where.payload.qrtp_recommendation];
  const recommendation = getCansSummaryGridPerson('recommendation', 'For Use by Qualified Individual (QI) Only', '', '' , recommendationcol1data, recommendationcol2data);
  const usefulstrengths = getCansSummaryGridPerson('', 'Useful Strength', 'Centerpiece of the Plan', 'Strength Used in the Plan' , request.where.payload.cotp , request.where.payload.suitp);
  const potentialstrengths = getCansSummaryGridPerson('', 'Potential Strengths to Develop / Build', 'Consider Strength Development', 'No Strength, Consider Building' , request.where.payload.csd , request.where.payload.nscb);
  const Actionneededyouth = getCansSummaryGridPerson('', 'Actionable Needs', 'Action Needed (Youth)', 'Immediate/Intensive Action Needed (Youth)' , request.where.payload.tss2 , request.where.payload.tss3);
  const Actionneededadult = getCansSummaryGridPerson('', '', 'Emerging Adult Action Needed', 'Emerging Adult Immediate/Intensive Actionable Needed' , request.where.payload.ead2 , request.where.payload.ead3);
  const Actionneededcaregiver = getCansSummaryGridPerson('' ,'', 'Action Needed (Caregiver)', 'Immediate/Intensive Action Needed (Caregiver)' , request.where.payload.pp2 , request.where.payload.pp3);
  
  const traumaexperiences = `<table class="table table-bordered">
  <tr>
      <h4><strong>Trauma Experiences (Over Lifetime)</strong></h4>
  </tr>
  <tr>
      <td>${traumadata}</td>
  </tr>
</table>`

  var html = fs.readFileSync('./documenttemplates/canssummarysheet.html', 'utf8');  
  
  html = html.replace(stylepath, config.documenttemplates);
  
  html = html.replace('{{recommendation}}', util.nullcheck(recommendation));
  html = html.replace('{{usefulstrengths}}', util.nullcheck(usefulstrengths));
  html = html.replace('{{potentialstrengths}}', util.nullcheck(potentialstrengths));
  html = html.replace('{{traumaexperiences}}', util.nullcheck(traumaexperiences));
  html = html.replace('{{Actionneededyouth}}', util.nullcheck(Actionneededyouth));
  html = html.replace('{{Actionneededadult}}', util.nullcheck(Actionneededadult));
  html = html.replace('{{Actionneededcaregiver}}', util.nullcheck(Actionneededcaregiver));



  request.where.outputfilename = "Service_Agreement";
  Response = module.exports.generatepdf(request, html, {}, {type: 'report', res:response }); 

  return Response;
 }



}

function checkCSGPcol(value){
  return value && value.length ? value + ' , <br>' : '';
}

function getCansSummaryGridPerson(displaySection, section, col1name,col2name, col1, col2){
  let usefulstrengths;

  if(displaySection === 'recommendation') {
    usefulstrengths = (col1[1] && col2[1]) ? `<table class="table table-bordered">
      <th colspan="2"><h4><strong>For Use by Qualified Individual (QI) Only</strong></h4></th>
      <tr>
      <td style="border-style: none"><strong>${col1[0]}</strong> :</td>
      <td style="border-style: none">${col1[1]}</td>
      </tr>
      <tr>
      <td style="border-style: none"><strong>${col2[0]}</strong> :</td>
      <td style="border-style: none">${col2[1]}</td>
      </tr>
    </table>` : "";
  } else {
    let col1data = '';
    for(const element of col1){
      col1data += checkCSGPcol(element);
    }
    col1data = col1data.slice(0, -1);
    let col2data = '';
    for(const element of col2){
      col2data += checkCSGPcol(element);
    }
    col2data = col2data.slice(0, -1);

    usefulstrengths = `<table class="table table-bordered">
      <tr>
          <h4><strong>${section}</strong></h4>
      </tr>
      <tr>
      <td><strong>${col1name}</strong></td></strong>
      <td><strong>${col2name}</strong></td>
      </tr>
      <tr>
          <td>${col1data}</td>
          <td>${col2data}</td>
      </tr>
    </table>`;
  }

  return usefulstrengths
  
}
  
// end

// =========================
// CANS-F Summary Sheet (re-labeled)
// =========================
module.exports.cansfsummarysheet = function (request, response) {     // NOSONAR
  request.documntkey = request.where.documenttemplatekey;
  let Response;

  try {
    const p = request?.where?.payload;
    if (!p) {
      return response.status(400).send({ message: 'Missing payload for CANS-F summary sheet.' });
    }

    let imminentRishHtml = "";
    if (Array.isArray(request.where.payload.Imminent_Risk_Criteria_Selected) && request.where.payload.Imminent_Risk_Criteria_Selected.length) {
      request.where.payload.Imminent_Risk_Criteria_Selected.forEach((ele, index) => {
        imminentRishHtml += getAssessmentTableHtml(
          index == 0 ? 'Imminent Risk Criteria Selected' : '',
          ['Child'],
          [ele.ACTION]
        );
      });
    } else {
      imminentRishHtml = getAssessmentTableHtml(
        'Imminent Risk Criteria Selected',
        ['Child'],
        [[]]
      );
    }

    let candidatestraditionalHtml = "";

    const list = request?.where?.payload?.Candidates_Traditional || [];

    if (Array.isArray(list) && list.length) {
      // Flatten names (ACTION) and criteria (IMMEDIATE) across all items
      const names = list.flatMap(e => Array.isArray(e.ACTION) ? e.ACTION : [e.ACTION].filter(Boolean));
      const criteria = list.flatMap(e => Array.isArray(e.IMMEDIATE) ? e.IMMEDIATE : [e.IMMEDIATE].filter(Boolean));

      candidatestraditionalHtml = getCandidacyTableHtml(
        'Imminent Risk Criteria Selected',
        ['Child Name', 'Candidacy Determination Criteria'],
        [names, criteria]              // <-- one render for all rows
      );
    } else {
      candidatestraditionalHtml = getCandidacyTableHtml(
        'Imminent Risk Criteria Selected',
        ['Child Name', 'Candidacy Determination Criteria'],
        [[], []]
      );
    }

    const potentialstrengths = getAssessmentTableHtml(
      'Comprehensive Family Assessment',
      ['Action Needed', 'Immediate/Intensive Action Needed', 'Strengths'],
      [
        request.where.payload.Action_Needed,
        request.where.payload.Immediate_Intensive_Action_Needed,
        request.where.payload.Strength
      ]
    );

    const familyCulture = getAssessmentTableHtml(
      'Family Culture & Identity',
      ['Action Needed', 'Immediate/Intensive Action Needed', 'Strengths'],
      [
        request.where.payload.FAMILY_CULTURE?.Action_Needed,
        request.where.payload.FAMILY_CULTURE?.Immediate_Intensive_Action_Needed,
        request.where.payload.FAMILY_CULTURE?.Strength
      ]
    );

    // Caregiver summary (with minimal blank fallback)
    let family_potential = "";
    if (Array.isArray(request.where.payload.CARE_GIVER_SUMMARY) && request.where.payload.CARE_GIVER_SUMMARY.length) {
      request.where.payload.CARE_GIVER_SUMMARY.forEach((ele, index) => {
        family_potential += getAssessmentTableHtml(
          index == 0 ? 'Comprehensive Caregiver Assessment' : '',
          ['Action Needed', 'Immediate/Intensive Action Needed', 'Strengths', 'Trauma Experiences'],
          [ele.ACTION, ele.IMMEDIATE, ele.STRENGTH, ele.TRAUMA],
          ele.sectionName
        );
      });
    } else {
      family_potential = getAssessmentTableHtml(
        'Comprehensive Caregiver Assessment',
        ['Action Needed', 'Immediate/Intensive Action Needed', 'Strengths', 'Trauma Experiences'],
        [[], [], [], []]
      );
    }

    // Child summary (with minimal blank fallback)
    let child_actionable = "";
    if (Array.isArray(request.where.payload.CHILD_SUMMARY) && request.where.payload.CHILD_SUMMARY.length) {
      request.where.payload.CHILD_SUMMARY.forEach((ele, index) => {
        child_actionable += getAssessmentTableHtml(
          index == 0 ? 'Comprehensive Child Assessment' : '',
          ['Action Needed', 'Immediate/Intensive Action Needed', 'Strengths', 'Trauma Experiences'],
          [ele.ACTION, ele.IMMEDIATE, ele.STRENGTH, ele.TRAUMA],
          ele.sectionName
        );
      });
    } else {
      child_actionable = getAssessmentTableHtml(
        'Comprehensive Child Assessment',
        ['Action Needed', 'Immediate/Intensive Action Needed', 'Strengths', 'Trauma Experiences'],
        [[], [], [], []]
      );
    }

    let html = fs.readFileSync('./documenttemplates/cansfsummarysheet.html', 'utf8');
    html = html.replace(stylepath, config.documenttemplates);

    html = html.replace('{{imminentrisk}}', util.nullcheck(imminentRishHtml));
    html = html.replace('{{candidatestraditionalHtml}}', util.nullcheck(candidatestraditionalHtml));
    html = html.replace('{{recommendation}}', util.nullcheck(potentialstrengths));
    html = html.replace('{{familyCulture}}', util.nullcheck(familyCulture));
    html = html.replace('{{family_potential}}', util.nullcheck(family_potential));
    html = html.replace('{{child_actionable}}', util.nullcheck(child_actionable));

    request.where.outputfilename = 'CANS_F_Summary_Sheet';
    Response = module.exports.generatepdf(request, html, {}, { type: 'report', res: response });
    return Response;
  } catch (err) {
    console.error('cansfsummarysheet error:', err);
    return response.status(500).send({ message: 'Failed to render CANS-F summary sheet.' });
  }
};

function checkAssessmentPcol(value){
  return value && value.length ? value + '  <br>' : '';
}

function getAssessmentTableHtml(section, columns, valuesArray, subHead = "") {
  let headerRow = '';
  let dataRow = '';
  let hasData = false;

  for (let i = 0; i < columns.length; i++) {
    const colName = columns[i];
    const colValues = valuesArray[i] || [];
    let colData = '';

    for (const v of colValues) {
      colData += checkAssessmentPcol(v);
    }

    // remove trailing <br> if present
    if (colData.endsWith('<br>')) {
      colData = colData.slice(0, -4);
    }

    if (colValues.length > 0) hasData = true;

    headerRow += `<th><strong>${colName}</strong></th>`;
    dataRow += `<td>${colData}</td>`;
  }

  // If no data in any column, show a single centered "No data available"
  if (!hasData) {
    dataRow = `<td colspan="${columns.length}" class="text-center text-muted">No data available</td>`;
  }

  const subHeadHtml = subHead
    ? `<tr><td colspan="${columns.length}"><strong>${subHead}</strong></td></tr>`
    : '';

  return `
  <table class="table table-bordered">
    <tr>
      <h4><strong>${section}</strong></h4>
    </tr>
    ${subHeadHtml}
    <tr>${headerRow}</tr>
    <tr>${dataRow}</tr>
  </table>`;

}

function getCandidacyTableHtml(section, columns, valuesArray) {
  const col1 = Array.isArray(valuesArray?.[0]) ? valuesArray[0] : [];
  const col2 = Array.isArray(valuesArray?.[1]) ? valuesArray[1] : [];
  const rows = Math.max(col1.length, col2.length);

  let body = '';
  if (rows) {
    for (let i = 0; i < rows; i++) {
      const v1 = col1[i] ?? '';
      const v2 = col2[i] ?? '';
      body += `<tr><td>${v1 ?? ''}</td><td>${v2 ?? ''}</td></tr>`;
    }
  } else {
    body = `<tr><td colspan="2" class="text-center text-muted">No data available</td></tr>`;
  }

  return `
  <h4><strong>${section}</strong></h4>
  <table class="table table-bordered table-hover sticky-header-table">
    <thead>
      <tr>
        <th class="th-bg3">Child Name</th>
        <th class="th-bg3">Candidacy Determination Criteria</th>
      </tr>
    </thead>
    <tbody>${body}</tbody>
  </table>`;
}
const getadoptioninitialworksheetdata = async (sql, params) => {
  try {
    const data = await util.executeDBQuery(sql, params);
    if (data !== null && typeof data !== 'undefined' && data.length > 0) {
      return data;
    }
    return {};
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
};


module.exports.generatedocx = function (html) {
  return new Promise(async (resolve, reject) => {
    try {
      var docx = HtmlDocx.asBlob(html);
      const buffer = Buffer.from(await docx.arrayBuffer());
      resolve(buffer);
    } catch (err) {
      reject(err);
    }
  });
};


function getPerson(reqjson, clientid){
  if(reqjson.inputjson.worksheetData.getHouseHoldInRule && reqjson.inputjson.worksheetData.getHouseHoldInRule.length > 0 && clientid != null) {
    var householdMember = reqjson.inputjson.worksheetData.getHouseHoldInRule;
    return householdMember.filter(householdM => householdM.involvedclientid?.toString() === clientid?.toString());
  }else{
    return null;
  }
}



function getDeprevationType(value) {

  if(value === 'AB'){
    return 'Absence';
  }else if(value === 'IC'){
    return 'Incapacity';
  }else if(value === 'UNEPWE'){
    return 'Unemployment in Principle Wage Earner';
  }else if(value === 'UNDE'){
    return 'Under Employment';
  }else if(value === 'DOEP'){
    return 'Death of either Parent';
  }else if(value === 'NONE'){
    return 'None';
  }else{
    return 'None';
  }

}

function getReasonAbsence(value) {
  if (value === 'DS'){
    return 'Desertion' ; 
  } else if (value === 'INC'){
    return 'Incarceration'  
  } else if (value === 'PNE'){
    return 'Paternity not established' ; 
  } else if (value === 'OA'){
    return 'Other Absences'; 
  } else if (value === 'NONE'){
    return 'None'; 
  } else {
    return '';
  }
}

function getFullName(person) {
  const nameKeys = [  'prefx' , 'firstname' , 'middlename' , 'lastname' ,'suffix'];
  let name = '';
  if(person){
    nameKeys.forEach(key => {
      if (person.hasOwnProperty(key) && (person[key] !== null) && (person[key] !== 'null') && (person[key] !== '') ) {
        name = name + person[key] + ' ';
      }
    });
    return name;
  }
  return '-';
}


module.exports.contactpdf = async function (request) {
  var entityType =  request.where.entitytype;
  var entitytypesource;

  switch (entityType) {
    case 'intake':
      entitytypesource = 'Intake';
      break;
    case 'intakeservicerequest':
      entitytypesource = 'CPS';
      break;
    case 'servicecase':
      entitytypesource = 'Service Case';
      break;
    case 'adoption':
      entitytypesource = 'Adoption Case';
      break;
  }
  var caseNumber = request.where.caseNumber;
  var entitytypeid = request.where.entitytypeid;
  var sql = 'SELECT * FROM getcontactnotespdf($1,$2,$3)';
  let response;
  let reqjson = {};
  try {
    const data = await util.executeDBQuery(sql, [entityType, entitytypeid, request.where]);
        if (data.length > 0) {
          
          var rescontactnotes = data[0]?.contactnotes || [];
          var casenumber = '';
          var casetype = '';
          var contactblock = '';
          var contactnotedesc = '';
          var draft = '';
          var html = fs.readFileSync('./documenttemplates/contactpdf.html', 'utf8');
          casenumber = caseNumber;
          casetype = entitytypesource;

          

          for (const element of rescontactnotes) {
            const rerescontact = element;
            var contactNotes = clearHtmlSpaces(getContactNotes(rerescontact));   
            contactNotes = contactNotes.replace(/↵/g,'<br>');
            contactNotes = contactNotes.replace(/\n/g,'<br>');
            const personData = getContactPersonData(rerescontact);
            
            var othername = personData.othername;
            var finalfocusperson = personData.focusperson;
            const start_date = moment(rerescontact.starttime);
            const end_date = moment(rerescontact.endtime);
            const duration = moment.duration(end_date.diff(start_date));
            const starttime = personData.starttime;
            const endtime = personData.endtime;
            const traveltime = personData.traveltime;
            draft = personData.draft;
            contactblock = contactblock + `
        <br>
        <table class="table table-bordered">
          <tbody>  
            <tr class="header">
                <th style="width: 20%;"> Contact Date & Time </th>
                <th style="width: 20%;"> Date of Entry, Entered by </th>
                <th style="width: 15%;"> Contact Purpose </th>
                <th style="width: 15%;"> Contact Details </th>
                <th style="width: 15%;"> Person Contacted </th>
                <th style="width: 15%;"> Who is the subject of the contact? </th>
            </tr>
            <tr>
                <td style="width: 20%;"> 
                    <p>Contact Date: <span>${util.nullcheck(util.formatDate(rerescontact.contactdate))}</span> </p> 
                    <p>Start Time: <span>${starttime}</span></p>
                    <p>End Time: <span>${endtime}</span></p>      
                    <p>Contact Duration: ${duration['_data'].hours + ' Hr :' + duration['_data'].minutes + ' Min'} <span></span></p>              
                </td>
                <td style="width: 20%;">
                    <span>${dateCheck(rerescontact.insertedon, dtformat2)}</span>
                    <p class="">
                        <i aria-hidden="true" class="fa fa-user site-color"></i> 
                        ${util.nullcheck(rerescontact.enteredby)} -
                        <span class="text-b"> ${util.nullcheck(rerescontact.teamname)} </span>
                    </p>
                    <h6 class="no-mar pb-10"> ${draft} </h6>
                </td>
                <td style="width: 15%;"><span class="textb"> ${emptyStrCheck(rerescontact.contactpurpose ? rerescontact.contactpurpose.toString() : '')} </span>
                </td>
                <td style="width: 15%;">
                    <h5 class="text-12 mb-5"> Type of Contact :
                        <span class="textb show mt-5">${util.nullcheck(rerescontact.contacttype)}</span>
                    </h5>
                    <h5 class="text-12 mb-5"> Contact Location :
                        <span class="textb show mt-5">${util.nullcheck(rerescontact.contactlocation)}</span>
                    </h5>
                    <h5 class="text-12 mb-5"> Source :
                        <span class="textb show mt-5">${util.nullcheck(rerescontact.entitytypesource)}</span>
                    </h5>
                    ${traveltime}
                </td>
                <td style="width: 15%;">
                  ${othername}
                </td>
                <td style="width: 15%;">
                  ${finalfocusperson}
                </td>
            </tr>
            <tr>
                <td colspan="5">
                    <p class="">
                        <label for="" class="show mb-10"> Contact was Initiated/Received : ${personData.initiationindicator}  </label> <span></span>
                    </p>     
                    <p class="">
                        <label for="" class="show mb-10"> Contact was Attempted/Completed : ${personData.contactstatus} </label> <span></span>
                    </p>    
                </td>
            </tr>
            <tr>
                <td colspan="5">
                    <label for="" class="show mb-10"> Notes : </label>
                    <div class="" style=" width: 100%;"> ${contactNotes} </div>     
                </td>
            </tr>
          </tbody>
        </table>`
          }

          reqjson = {
            root_template_path_style: app.baseurl,
            root_template_path_image: app.baseurl,
            casenumber: casenumber,
            casetype: casetype,
            contactblock: contactblock,
            contactnotedesc: contactnotedesc
          }
        }
      request.where.outputfilename = "contact-notes-pdf";
      response = module.exports.generatepdf(request, html, reqjson);
      return response;
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
};

function getContactNotes(rerescontact) {
  let contactNotes = '';
  let contactdate; 
  let tempcontactdate;
  if (rerescontact != null && rerescontact.contactnotes != null) {
    for (let k = 0; k < rerescontact.contactnotes.length; k++) {
      if (k == 0) {
        contactdate = dateCheck(rerescontact.contactnotes[k].insertedon, dtformat2);
      }
      tempcontactdate = dateCheck(rerescontact.contactnotes[k].insertedon, dtformat2);

      if (k == 0 || contactdate != tempcontactdate) {
        contactdate = tempcontactdate;
        contactNotes = contactNotes +
          '<br>' + util.nullcheck(rerescontact.contactnotes[k].description);
      }
    }
  }
  return contactNotes;
}

function getContactPersonData(rerescontact){
  let personContacted = '';
  let focusperson = '';
  if (rerescontact && rerescontact.personcontact != null) {
    for (let j = 0; j < rerescontact.personcontact?.length; j++) {
      const person = rerescontact.personcontact[j];
      const personName = getFullName(person);
      personContacted = personContacted + `
        <div class="media">
          <div class="media-left">
              <img class="media-object" src="assets/images/icon-avtar.png">
          </div>
          <div class="media-body media-middle">
            <h4 class="media-heading">${personName}</h4>
          </div>
        </div>
        <p class=""> Role : 
            <span class="text-b"> ${person.typedescription} </span>
        </p>`
    }
  }
  if (rerescontact && rerescontact.focusperson && rerescontact.focusperson != null) {
    rerescontact.focusperson = rerescontact.focusperson?.focuspersonjson;
    for (let j = 0; j < rerescontact.focusperson?.length; j++) {
      const person = rerescontact.focusperson[j];
      const personName = getFullName(person);
      focusperson = focusperson + `
        <div class="media">
          <div class="media-left">
              <img class="media-object" src="assets/images/icon-avtar.png">
          </div>
          <div class="media-body media-middle">
            <h4 class="media-heading">${personName}</h4>
          </div>
        </div>`
    }
  }
  return {
    othername: (rerescontact.otherpersonname) ? personContacted + `<div class="media"><div class="media-left"><img class="media-object" src="assets/images/icon-avtar.png"></div><div class="media-body media-middle"><h4 class="media-heading">${rerescontact.otherpersonname}</h4></div></div><p class=""> Role : <span class="text-b">Other</span></p>` : personContacted,
    focusperson,
    starttime: rerescontact.starttime == null ? '' : util.nullcheck(util.formatTime(rerescontact.starttime)),
    endtime: rerescontact.endtime == null ? '' : util.nullcheck(util.formatTime(rerescontact.endtime)),
    traveltime: (rerescontact.traveltime) ? '<h5 class="text-12 mb-5"> Travel Duration : <span class="textb show mt-5"></span>' + (rerescontact.traveltime) + '</span></h5>' : '',
    draft: (rerescontact.draft) ? 'user' : 'system',
    initiationindicator:rerescontact.initiationindicator ? 'Initiated' : 'Received',
    contactstatus: !rerescontact.contactstatus ? 'Attempted' : 'Completed'
  }
}


module.exports.ihs_agreement = function (request,response) {
  request.documntkey = request.where.documenttemplatekey;
  request.intakeserviceid = null;
  var agreementid = request.where.agreementid;
  let Response;
  const sql = 'select * from ihs_agreement($1)';
  return util.executeDBQuery(sql,[agreementid])
    .then(data => {
      if (data.length > 0) {
        let responseval = [];
        responseval = data[0];

        let prticipants = '';
        for (const element of data) {
          prticipants += element.participants && element.participants.length ? element.participants[0].participantsname + ',' : '';
        }
        prticipants = prticipants.slice(0,-1);

        var html = fs.readFileSync('./documenttemplates/agreement.html','utf8');

        html = html.replace(stylepath,config.documenttemplates);
        html = html.replace('{{AgreementDate}}',util.nullcheck(util.formatDate(responseval.agreementdate)));
        html = html.replace('{{Collateral}}',util.nullcheck(responseval.collateral) ? responseval.collateral[0].collateralname : '');
        html = html.replace('{{Participants}}',util.nullcheck(responseval.participants) ? prticipants : '');
        const sanatizedAttentiontxNbspData = clearHtmlSpaces(util.nullcheck(responseval.attentiontx));
        html = html.replace('{{Whyfamily}}',sanatizedAttentiontxNbspData);
        html = html.replace('{{Headofhousehold}}',util.nullcheck(responseval.hoh));
        html = html.replace('{{CaseAssociate}}',util.nullcheck(responseval.associatename));
        html = html.replace('{{SignatureObtained}}',util.nullcheck(responseval.signatureobtained));
        html = html.replace('{{Signeddate}}',util.nullcheck(util.formatDate(responseval.signeddate)));
        html = html.replace('{{Worker}}',util.nullcheck(responseval.workername));
        html = html.replace('{{Supervisor}}',util.nullcheck(responseval.supervisorname));
        html = html.replace('{{status}}',util.nullcheck(responseval.approvalstatustypekey));
        html = html.replace('{{approvaldate}}',(util.formatDate(responseval.approvaldate)));

        request.where.outputfilename = "Service_Agreement";
        Response = module.exports.generatepdf(request,html,{},{ type: 'report',res: response });
      }
      return Response;
    })
    .catch(err => {
      LOGGER.error(err);
      return err;
    })
};

module.exports.ihs_serviceintendedaction = async function (request, response) {
  request.documntkey = request.where.documenttemplatekey;
  request.intakeserviceid = null;
  var serviceintendedactionid = request.where.serviceintendedactionid;
  let Response;
  try {
      const sql = ` select a.* ,
                    concat(p.firstname,' ', p.lastname) as caregivername,
                    b.fullname as updatedbyname,
                    (select s.fullname from userprofile s where s.securityusersid= b.supervisorid  and s.activeflag =1 order by updatedon desc limit 1) as supname,
                    (select  t3.description from  teammemberassignment t
                      inner join teammember t2 on t2.teammemberid = t.teammemberid
                      inner join teammemberroletype t3 on t3.roletypekey = t2.roletypekey
                    where t.securityusersid = b.supervisorid order by t.updatedon desc limit 1) as suptitle,
                    (select ph.phonenumber  from userprofilephonenumber ph where ph.securityusersid= b.supervisorid  and ph.activeflag =1) as supph,
                    (select  t3.description from  teammemberassignment t
                      inner join teammember t2 on t2.teammemberid = t.teammemberid
                      inner join teammemberroletype t3 on t3.roletypekey = t2.roletypekey
                    where t.securityusersid = b.securityusersid limit 1) as userstitle,
                    (select ph.phonenumber  from userprofilephonenumber ph where ph.securityusersid= b.securityusersid  and ph.activeflag =1) as workerph
                    from serviceintendedaction a
                    inner join userprofile b on a.updatedby = b.securityusersid
                    left join person p on p.personid =  a.caregiverid and p.activeflag = 1
                  where a.serviceintendedactionid = $1 and a.activeflag = 1`;
                  
    const data = await util.executeDBQuery(sql, [serviceintendedactionid]);
      if (data.length > 0) {
        let responseval = [];
        responseval = data;
        let name = null
 
        if (responseval[0]?.caregivername != null && responseval[0]?.caregivername != ' ' ){
         
          name =  responseval[0]?.caregivername
        }else {
          
          name =  responseval[0]?.collateral
        }
        

        const date = dateCheck(responseval[0]?.actiondate, dtformat);        
         let html = fs.readFileSync('./documenttemplates/serviceintendedaction.html', 'utf8'); 
        html = html.replace(/{{date}}/g, date ?? string.empty);               
        html = html.replace(/{{caregivername}}/g,  name ?? string.empty);
        html = html.replace('{{addresslineone}}', util.nullcheck(responseval[0]?.addresslineone));       
        html = html.replace('{{addresslinetwo}}', util.nullcheck(responseval[0]?.addresslinetwo));       
        html = html.replace(/{{servicecaseid}}/g, responseval[0]?.servicecaseid);
         html = html.replace('{{SpecificRegulations}}', util.nullcheck(responseval[0]?.specificregulationsupportingdecision));
        html = html.replace(/{{updatedbyname}}/g, responseval[0]?.updatedbyname);          
        html = html.replace('{{workertitle}}', util.nullcheck(responseval[0]?.userstitle));
        html = html.replace('{{workphno}}', util.nullcheck(responseval[0]?.workerph));   
        html = html.replace('{{supervisorname}}', util.nullcheck(responseval[0]?.supname));       
        html = html.replace('{{supervisortitle}}', util.nullcheck(responseval[0]?.suptitle));      
        html = html.replace('{{supervisorphno}}', util.nullcheck(responseval[0]?.supph));
        html = html.replace('{{dsrdes}}', util.nullcheck(responseval[0]?.dsrdes));        
        html = html.replace(/{{servicestofamilieswithchildren}}/g, checkboxCheck(responseval[0]?.servicestofamilieswithchildren));
        html = html.replace(/{{familypreservationservices}}/g, checkboxCheck(responseval[0]?.familypreservationservices));  
        html = html.replace(/{{riskofharmservices}}/g, checkboxCheck(responseval[0]?.riskofharmservices));
        html = html.replace(/{{interagencyfamilypreservationldssbased}}/g, checkboxCheck(responseval[0]?.interagencyfamilypreservationldssbased));
        html = html.replace(/{{requestofanotheragencyroa}}/g, checkboxCheck(responseval[0]?.requestofanotheragencyroa));
        html = html.replace(/{{independentlivingaftercareservices}}/g, checkboxCheck(responseval[0]?.independentlivingaftercareservices));      
        
        html = html.replace(/{{voluntaryplacementrequesttimelimited}}/g, checkboxCheck(responseval[0]?.voluntaryplacementrequesttimelimited));
        html = html.replace(/{{voluntaryplacementrequestchilddisability}}/g, checkboxCheck(responseval[0]?.voluntaryplacementrequestchilddisability));
        html = html.replace(/{{voluntaryplacementrequestenhancedaftercare}}/g, checkboxCheck(responseval[0]?.voluntaryplacementrequestenhancedaftercare));
        html = html.replace(/{{permanencyservices}}/g, checkboxCheck(responseval[0]?.permanencyservices));
        html = html.replace(/{{gapcheckbox}}/g, checkboxCheck(responseval[0]?.gap));
        html = html.replace(/{{adoptionsubsidy}}/g, checkboxCheck(responseval[0]?.adoptionsubsidy));
        html = html.replace(/{{adoptionservices}}/g, checkboxCheck(responseval[0]?.adoptionservices));
        html = html.replace(/{{kinshipnavigationservices}}/g, checkboxCheck(responseval[0]?.kinshipnavigationservices));
        html = html.replace(/{{resourcehomes}}/g, checkboxCheck(responseval[0]?.resourcehomes));
        html = html.replace(/{{interstatecompact}}/g, checkboxCheck(responseval[0]?.interstatecompact));
        html = html.replace(/{{childassessedtobesafe}}/g, checkboxCheck(responseval[0]?.childassessedtobesafe));
        html = html.replace(/{{serviceobjectiveshavebeenachieved}}/g, checkboxCheck(responseval[0]?.serviceobjectiveshavebeenachieved));
        html = html.replace(/{{familynolongerwantsservice}}/g, checkboxCheck(responseval[0]?.familynolongerwantsservice));
        html = html.replace(/{{familyisnotactivelyprogressingtoward}}/g, checkboxCheck(responseval[0]?.familyisnotactivelyprogressingtoward));
        html = html.replace(/{{agencyrelatedcourtinvolvementhasbeenterminated}}/g, checkboxCheck(responseval[0]?.agencyrelatedcourtinvolvementhasbeenterminated));
        html = html.replace(/{{familyhasmovedtoanotherjurisdiction}}/g, checkboxCheck(responseval[0]?.familyhasmovedtoanotherjurisdiction));
        html = html.replace(/{{referralmadetoanotherserviceprogram}}/g, checkboxCheck(responseval[0]?.referralmadetoanotherserviceprogram));
        html = html.replace(/{{familycannotbelocated}}/g, checkboxCheck(responseval[0]?.familycannotbelocated));
        html = html.replace(/{{v_other}}/g, checkboxCheck(responseval[0]?.other));
        html = html.replace(/{{otherspecify}}/g, (responseval[0].otherspecify) ? responseval[0].otherspecify : '');
        html = html.replace(/{{closecase}}/g, checkboxCheck(responseval[0]?.closecase));
        html = html.replace(/{{transfercase}}/g, checkboxCheck(responseval[0]?.transfercase));
        html = html.replace(/{{transfercasespecify}}/g, emptyStrCheck(responseval[0]?.transfercasespecify));
        html = html.replace(/{{actiontobetakenother}}/g, checkboxCheck(responseval[0]?.actiontobetakenother));
        html = html.replace(/{{actiontobetakenspecify}}/g, emptyStrCheck(responseval[0]?.actiontobetakenspecify));

        request.where.outputfilename = "serviceintendedaction";
        Response = module.exports.generatepdf(request, html, {}, { type: 'report', res: response });
      }
      return Response;
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
};


module.exports.safecareplan = function (request,response) {
  request.documntkey = request.where.documenttemplatekey;
  request.intakeserviceid = null;
  request.pageNumberFooter = true;
  var objectid = request.where.objectid;
  var objecttypekey = request.where.objectkey;
  var safecareplanid =request.where.safecareplanid
  let Response;
  LOGGER.info('>>> RESPONSE - POSC Print 10397');
  const sql = 'select * from safecareplandetailsforprint($1, $2,$3)';
  return util.executeDBQuery(sql,[objectid,objecttypekey,safecareplanid])
  .then(data => {
    if (data && data.length > 0 && data[0].safecareplandetails) {
      let responseval = [];
      responseval = data[0].safecareplandetails;
      let html = fs.readFileSync('./documenttemplates/safecareplan.html','utf8');

      const date = dateCheck(util.nullcheck(responseval[0]?.persondetails?.ldss?.safecareplandate));

      html = html.replace('{{ldssname}}',util.nullcheck(responseval[0]?.persondetails?.ldss?.name));
      html = html.replace('{{planDate}}',date);
      html = html.replace('{{unit}}',util.nullcheck(responseval[0]?.persondetails?.ldss?.unit));
      html = html.replace('{{email}}',util.nullcheck(responseval[0]?.persondetails?.ldss?.email));
      html = html.replace('{{phoneno}}',util.nullcheck(responseval[0]?.persondetails?.ldss?.phoneno));

      //Section1
      const section1PersonDataHtml = getSCareSection1(responseval);
      html = html.replace('{{section1PersonDataHtml}}',section1PersonDataHtml);

      //Section2
      let planParticipantsHtml = '';
      let roleCollectionList = []
      if (responseval[0]?.planparticipants?.data?.roleCollectionList != undefined) {
         roleCollectionList = responseval[0]?.planparticipants?.data.roleCollectionList;
         planParticipantsHtml = getplanParticipantsHtml(roleCollectionList);
        
      }
      html = html.replace('{{planParticipantsHtml}}',planParticipantsHtml);
      let PCPHtml = '';
      if (responseval[0]?.planparticipants?.data?.pcpDetails != undefined) {
        let pcpDetails = responseval[0]?.planparticipants?.data.pcpDetails || [];
        PCPHtml = getPCPHtml(pcpDetails);
      }

  if (responseval[0]?.planparticipants?.data?.notRequiredPCPDetails != undefined) {
        let notRequiredPCPDetails = responseval[0]?.planparticipants?.data?.notRequiredPCPDetails || [];
        PCPHtml = getnotRequiredPCPHtml(notRequiredPCPDetails, PCPHtml); 
      }

      html = html.replace('{{PCPHtml}}', PCPHtml);
      // Section - 3
      const section3Html = getSCareSection3(responseval);
      html = html.replace('{{section3Html}}',section3Html);

      // Section - 4 : otherservices
  if (responseval[0]?.otherservices?.referralCurrentServices != undefined) {
        html = getreferralCurrentSection(responseval, html);
      }

      // Section 4 : ESTABLISHED COMMUNITY SUPPORT AND SERVICES
      
      const scsection4 = getSCareSection4(responseval);
      const supportSystemHtml = scsection4.supportSystemHtml;
      const unitedWayHtml = scsection4.unitedWayHtml;
      const housingHtml = scsection4.housingHtml;
      const paroleProbationHtml = scsection4.paroleProbationHtml;
      const familyDrugHtml = scsection4.familyDrugHtml;
      const additionalServicesHtml = scsection4.additionalServicesHtml;
      
      html = html.replace('{{supportSystemHtml}}',supportSystemHtml);
      html = html.replace('{{unitedWayHtml}}',unitedWayHtml);
      html = html.replace('{{housingHtml}}',housingHtml);
      html = html.replace('{{paroleProbationHtml}}',paroleProbationHtml);
      html = html.replace('{{familyDrugHtml}}',familyDrugHtml);
      html = html.replace('{{additionalServicesHtml}}',additionalServicesHtml);

      // Section - 5 : REVIEWED AND DISCUSSED
      const scsection5 = getSCareSection5(responseval);
      const safeSleepingEnvHtml = scsection5.safeSleepingEnvHtml;
      const ecssCopingHtml = scsection5.ecssCopingHtml;
      const ecssHomesafetyHtml = scsection5.ecssHomesafetyHtml;
      const ecssFiresafetyHtml = scsection5.ecssFiresafetyHtml;
      const ecssFireescapeHtml = scsection5.ecssFireescapeHtml;
      
      html = html.replace('{{safeSleepingEnvHtml}}',safeSleepingEnvHtml);
      html = html.replace('{{ecssCopingHtml}}',ecssCopingHtml);
      html = html.replace('{{ecssHomesafetyHtml}}',ecssHomesafetyHtml);
      html = html.replace('{{ecssFiresafetyHtml}}',ecssFiresafetyHtml);
      html = html.replace('{{ecssFireescapeHtml}}',ecssFireescapeHtml);

      //Section-6 : Comments
      html = html.replace('{{comments}}',util.nullcheck(responseval[0]?.comments));

      //Section-7 : DISCLAIMER AND CONSENT FOR SHARING OF POSC AND OTHER INFORMATION
      const justificationData = responseval[0]?.consentform?.data;
      let justificationDataHtml = '';
      
      if (justificationData != null && justificationData != undefined) {

        justificationDataHtml = getjustificationDataHtml(justificationData);

        
      }
      html = html.replace('{{justificationDataHtml}}',justificationDataHtml);

      //Section-8 : Signatures
      html = html.replace('{{recommendedforclosure8}}',checkboxCheck(util.nullcheck(responseval[0]?.recommendedforclosure)));
      html = html.replace('{{insufficientevidencetocourt8}}',checkboxCheck(util.nullcheck(responseval[0]?.insufficientevidencetocourt)));
      html = html.replace('{{familypreservationtransfer8}}',checkboxCheck(util.nullcheck(responseval[0]?.familypreservationtransfer)));
      html = html.replace('{{referredtocps8}}',checkboxCheck(util.nullcheck(responseval[0]?.referredtocps)));
      html = html.replace('{{shelterorder8}}',checkboxCheck(util.nullcheck(responseval[0]?.shelterorder)));
      
      html = getSCareSection8(responseval, html);

      request.where.outputfilename = "safecareplan";
      Response = module.exports.generatepdf(request,html,{},{ type: 'report',res: response });
    }
    return Response;
  })
  .catch(err => {
      LOGGER.error('<< POSC SAFECAREPLAN Error Line 2 >>',err);
      return err;
  })
};

function getplanParticipantsHtml(roleCollectionList){
  let planParticipantsHtml = ''
  for (let participantsData of roleCollectionList) {
    planParticipantsHtml += '<tr><td scope="row">' + util.nullcheck(participantsData?.roledesc) + ' </td>';
    planParticipantsHtml += '<td>' + util.initialCaps(util.nullcheck(participantsData?.personName)) + ' </td>';
    planParticipantsHtml += '<td>' + util.nullcheck(participantsData?.rolephone) + ' </td>';
    planParticipantsHtml += '<td>' + util.nullcheck(participantsData?.roleemail) + tdclosetags;
  }
  return planParticipantsHtml;
}


function getPCPHtml(pcpDetails){
  let PCPHtml = ''
  for (let pcp of pcpDetails) {
    PCPHtml += '<tr><td scope="row">' + util.nullcheck(pcp?.clientName) + ' </td>';
    PCPHtml += '<td>' + util.initialCaps(util.nullcheck(pcp?.isPCP)) + ' </td>';
    PCPHtml += '<td>' + util.nullcheck(pcp?.primaryCareDoctor) + ' </td>';
    PCPHtml += '<td>' + util.nullcheck(pcp?.physicianType) + ' </td>';
    PCPHtml += '<td>' + util.nullcheck(pcp?.email) + ' </td>';
    PCPHtml += '<td>' + util.nullcheck(pcp?.contact) + tdclosetags;
  }
  return PCPHtml;
}



function getnotRequiredPCPHtml(notRequiredPCPDetails, PCPHtml){
  for (let pcp of notRequiredPCPDetails) {
    PCPHtml += '<tr><td scope="row">' + util.nullcheck(pcp?.name) + ' </td>';
    PCPHtml += '<td>' + util.initialCaps(util.nullcheck(pcp?.isPCP)) + ' </td>';
    PCPHtml += '<td>' + util.nullcheck(pcp?.reason) + ' </td>';
    PCPHtml += '<td> </td>';
    PCPHtml += '<td> </td>';
    PCPHtml += '<td>' + tdclosetags;
  }
  return PCPHtml;
}



function getjustificationDataHtml(justificationData){
  let justificationDataHtml = ''
  const divXs2 = ' <div class="col-xs-2">';
  for (let i = 0; i < justificationData?.length; i++) {
    justificationDataHtml += ' <div class="row row-bottom-sp">';
    justificationDataHtml += divXs2 + util.initialCaps(util.nullcheck(justificationData[i]?.personName)) + '</div>';
    justificationDataHtml += divXs2 + util.nullcheck(justificationData[i]?.consent) + '</div>';
    justificationDataHtml += divXs2 + util.nullcheck(justificationData[i]?.background) + '</div>';
    justificationDataHtml += ' <div class="col-xs-3">' + util.nullcheck(justificationData[i]?.releaseofinfo) + '</div>';
    justificationDataHtml += ' <div class="col-xs-3">' + util.nullcheck(justificationData[i]?.reason) + '</div>';
    justificationDataHtml += ' </div>';
  }
  return justificationDataHtml;
}


function getSCareSection1(responseval){
  let section1PersonDataHtml = '';
  if (responseval[0]?.persondetails?.data != undefined) {
    for (var i = 0; i < responseval[0]?.persondetails?.data.length; i++) {
      const scpinputCheckbox = '<div class="checkbox"><input type="checkbox" ';
      const section1PersonData = responseval[0]?.persondetails?.data[i];
      section1PersonDataHtml += '<div class="col-xs-6 row-background"><div class="form-group">Family Member: <label>' + util.nullcheck(section1PersonData?.familymember) + '</label> </div></div>';
      section1PersonDataHtml += '<div class="col-xs-6 row-background"><div class="form-group">Full Name: <label>' + util.initialCaps(util.nullcheck(section1PersonData?.personName)) + '</label> </div></div></div>';
      section1PersonDataHtml += '<div class="col-xs-12"><div  class="col-xs-12"><label>Substance Type</label> </div>';
      section1PersonDataHtml += '<div class="col-xs-12"><div class="col-xs-6 clsheight">Category - OPIOIDS';
      section1PersonDataHtml += scpinputCheckbox + (checkboxCheck(section1PersonData?.selectedOpioids?.indexOf("1") > -1)) + '>Heroin/Schedule I </div> ';
      section1PersonDataHtml += scpinputCheckbox + (checkboxCheck(section1PersonData?.selectedOpioids?.indexOf("2") > -1)) + '>Hydrocodone/Schedule II   </div> ';
      section1PersonDataHtml += scpinputCheckbox + (checkboxCheck(section1PersonData?.selectedOpioids?.indexOf("3") > -1)) + '>Buprenorphine/Schedule II </div> ';
      section1PersonDataHtml += scpinputCheckbox + (checkboxCheck(section1PersonData?.selectedOpioids?.indexOf("4") > -1)) + '>Morphine/Schedule II </div> ';
      section1PersonDataHtml += scpinputCheckbox + (checkboxCheck(section1PersonData?.selectedOpioids?.indexOf("5") > -1)) + '>Fentanyl/Schedule II  </div> ';
      section1PersonDataHtml += scpinputCheckbox + (checkboxCheck(section1PersonData?.selectedOpioids?.indexOf("6") > -1)) + '>Oxycodone/Schedule II  </div> ';
      section1PersonDataHtml += scpinputCheckbox + (checkboxCheck(section1PersonData?.selectedOpioids?.indexOf("7") > -1)) + '>Oxycodone-Percocet/Schedule II  </div> ';
      section1PersonDataHtml += scpinputCheckbox + (checkboxCheck(section1PersonData?.selectedOpioids?.indexOf("8") > -1)) + '>OxyContin/Schedule II </div> ';
      section1PersonDataHtml += scpinputCheckbox + (checkboxCheck(section1PersonData?.selectedOpioids?.indexOf("9") > -1)) + '>Codeine/Schedule II  </div> ';
      section1PersonDataHtml += scpinputCheckbox + (checkboxCheck(section1PersonData?.selectedOpioids?.indexOf("10") > -1)) + '>Methadone/Schedule II  </div></div>  ';
      section1PersonDataHtml += '<div class="col-xs-6 clsheight">Category - STIMULANTS';
      section1PersonDataHtml += scpinputCheckbox + (checkboxCheck(section1PersonData?.selectedStimulants?.indexOf("11") > -1)) + '>Cocaine/Schedule II </div> ';
      section1PersonDataHtml += scpinputCheckbox + (checkboxCheck(section1PersonData?.selectedStimulants?.indexOf("12") > -1)) + '>Methamphetamine/Schedule II  </div> ';
      section1PersonDataHtml += scpinputCheckbox + (checkboxCheck(section1PersonData?.selectedStimulants?.indexOf("13") > -1)) + '>Methylphenidate (Ritalin)/Schedule II  </div>';
      section1PersonDataHtml += scpinputCheckbox + (checkboxCheck(section1PersonData?.selectedStimulants?.indexOf("14") > -1)) + '>Amphetamine/Schedule II </div>  ';
      section1PersonDataHtml += scpinputCheckbox + (checkboxCheck(section1PersonData?.selectedStimulants?.indexOf("15") > -1)) + '>Adderall  </div>  ';
      section1PersonDataHtml += scpinputCheckbox + (checkboxCheck(section1PersonData?.selectedStimulants?.indexOf("16") > -1)) + '>Vyvanse  </div></div> </div>';
      section1PersonDataHtml += '<div class="col-xs-12"><div class="col-xs-6 clsheight">Category - DEPRESSANTS';
      section1PersonDataHtml += scpinputCheckbox + (checkboxCheck(section1PersonData?.selectedDepressants?.indexOf("17") > -1)) + '>Benzodiazepine/Schedule IV  </div>  ';
      section1PersonDataHtml += scpinputCheckbox + (checkboxCheck(section1PersonData?.selectedDepressants?.indexOf("18") > -1)) + '>Valium </div>';
      section1PersonDataHtml += scpinputCheckbox + (checkboxCheck(section1PersonData?.selectedDepressants?.indexOf("19") > -1)) + '>Xanax  </div>  ';
      section1PersonDataHtml += scpinputCheckbox + (checkboxCheck(section1PersonData?.selectedDepressants?.indexOf("20") > -1)) + '>Barbiturates  </div>';
      section1PersonDataHtml += scpinputCheckbox + (checkboxCheck(section1PersonData?.selectedDepressants?.indexOf("21") > -1)) + '>Alcohol  </div>';
      section1PersonDataHtml += '<div style="margin-top:12px;"> </div>';
      section1PersonDataHtml += scpinputCheckbox + (checkboxCheck(section1PersonData?.substanceUse)) + '> No Substance Use </div> </div>';
      section1PersonDataHtml += '<div class="col-xs-6 clsheight">Category - HALLUCINOGENS and OTHER COMPOUNDS';
      section1PersonDataHtml += scpinputCheckbox + (checkboxCheck(section1PersonData?.selectedHallucinogens?.indexOf("22") > -1)) + '>Marijuana/Schedule I  </div> ';
      section1PersonDataHtml += scpinputCheckbox + (checkboxCheck(section1PersonData?.selectedHallucinogens?.indexOf("23") > -1)) + '>Amphetamine/Schedule I-Ecstasy </div>';
      section1PersonDataHtml += scpinputCheckbox + (checkboxCheck(section1PersonData?.selectedHallucinogens?.indexOf("24") > -1)) + '>LSD/Schedule I </div>  ';
      section1PersonDataHtml += scpinputCheckbox + (checkboxCheck(section1PersonData?.selectedHallucinogens?.indexOf("25") > -1)) + '>Ketamine/Schedule III  </div>';
      section1PersonDataHtml += scpinputCheckbox + (checkboxCheck(section1PersonData?.selectedHallucinogens?.indexOf("26") > -1)) + '>Phencyclidine (PCP)/Schedule II  </div>  ';
      section1PersonDataHtml += scpinputCheckbox + (checkboxCheck((util.nullcheck(section1PersonData?.othercategory)) !== '')) + '>Other (Must identify the substance classification and the specific substance i.e., Benzodiazepine-Ativan) ';
      if (util.nullcheck(section1PersonData?.othercategory) != '') {
        section1PersonDataHtml += '<br><label>' + util.nullcheck(section1PersonData?.othercategory) + '</label>';
      }
      section1PersonDataHtml += '<div></div></div></div></div>';

      const dobHTML = 'Date of Birth:  &nbsp; <label>' + util.nullcheck(section1PersonData?.memberDob) + '</label> ';
      if (util.nullcheck(section1PersonData?.familymember) == "Newborn") {
        section1PersonDataHtml += divXs12 + dobHTML + '</div>';
      } else {
        section1PersonDataHtml += '<div class="col-xs-6">' + dobHTML + '</div>' + '<div class="col-xs-6">Contact Number:   &nbsp;  <label>' + util.nullcheck(section1PersonData?.phonenumber) + closelabeldiv;
      }
      section1PersonDataHtml += '<div class="col-xs-12">Address:   &nbsp;  <label>' + util.nullcheck(section1PersonData?.memberAddress) + closelabeldiv;
    }
  }
  return section1PersonDataHtml;
}

function getSCareSection3(responseval) {
  let section3Html = '';
  const spacecheckbox = '&emsp;<input type="checkbox" ';
  const commentLabel = 'Comments: <label>';
  const referralDiv = '<div class="col-xs-4">Referral: <label>';
  const labelNotAttendAppt = 'Did Not Attend Appt. : <label>';
  const labelAppointmentSch = '<div class="col-xs-4">Appointment Scheduled: <label>';
  const labeldateofRef = 'Date of Referral: <label>';
  const labelRefferedto = 'Referred To: <label>';
  const closelabelwithline = ' </label><br>';
  const divRowbottom = '<div class="row row-bottom-sp">';
  const divspacecheckbox = '<div class="col-xs-4">&emsp;<input type="checkbox" ';

  if (responseval[0]?.healthneedsdetails?.memberform != undefined) {
      for (let i = 0; i < responseval[0]?.healthneedsdetails?.memberform.length; i++) {
          const memberdata = responseval[0]?.healthneedsdetails?.memberform[i];
          if (memberdata.familymember == "Newborn") {
              section3Html += '<div><h3>Newborn Health Needs and Referrals</h3>';
              section3Html += divRowbottom;
              section3Html += '<div class="col-xs-4"><label>Newborn Name: ' + util.initialCaps(util.nullcheck(memberdata?.data?.personname)) + closelabeldiv;
              section3Html += '<div class="col-xs-4"><label>Newborn PID#: ' + util.nullcheck(memberdata?.data?.personpid) + closelabeldiv;
              section3Html += '<div class="col-xs-4"><label>Newborn DOB: ' + util.nullcheck(memberdata?.data?.persondob) + closelabeldiv;
              section3Html += '</div>';
              section3Html += '<div class="row row-bottom-sp row-header">';
              section3Html += '<div class="col-xs-4">Needs</div><div class="col-xs-4">Referral Information:</div><div class="col-xs-4">Outcome:</div></div>';
              section3Html += divRowbottom + divspacecheckbox + checkboxCheck(util.nullcheck(memberdata?.data?.exposurewithdrawl)) + '>&nbsp;&nbsp;Exposure and Withdrawal</div>';
              section3Html += referralDiv + util.nullcheck(memberdata?.data?.exprefferal) + closelabelwithline;
              section3Html += labelRefferedto + util.nullcheck(memberdata?.data?.exprefferedto) + closelabelwithline;
              section3Html += labeldateofRef + dateCheck(util.nullcheck(memberdata?.data?.exprefferraldate)) + '</label>';
              section3Html += '</div>' + labelAppointmentSch + util.nullcheck(memberdata?.data?.expapptscheduled) + closelabelwithline;
              section3Html += labelNotAttendAppt + util.nullcheck(memberdata?.data?.expdidnotattend) + '</label> <br>Comments: <label>' + util.nullcheck(memberdata?.data?.expcomments) + closelabeldiv;
              section3Html += '</div>' + divRowbottom + divspacecheckbox + checkboxCheck(util.nullcheck(memberdata?.data?.developmental)) + ' >&nbsp;&nbsp;Developmental';
              section3Html += '</div>' + referralDiv + util.nullcheck(memberdata?.data?.devrefferal) + closelabelwithline;
              section3Html += labelRefferedto + util.nullcheck(memberdata?.data?.devrefferedto) + '</label><br>Date of Referral: <label>' + dateCheck(util.nullcheck(memberdata?.data?.devrefferraldate)) + '</label>';
              section3Html += '</div>' + labelAppointmentSch + util.nullcheck(memberdata?.data?.devapptscheduled) + closelabelwithline;
              section3Html += labelNotAttendAppt + util.nullcheck(memberdata?.data?.devdidnotattend) + closelabelwithline;
              section3Html += commentLabel + util.nullcheck(memberdata?.data?.devcomments) + ' </label></div></div><div class="row row-bottom-sp"><div class="col-xs-4">';
              section3Html += spacecheckbox + checkboxCheck(util.nullcheck(memberdata?.data?.othermed)) + ' >&nbsp;&nbsp;Other Medical Conditions</div>';
              section3Html += referralDiv + util.nullcheck(memberdata?.data?.othermedrefferal) + closelabelwithline;
              section3Html += labelRefferedto + util.nullcheck(memberdata?.data?.othermedrefferedto) + '</label><br>Date of Referral: <label>' + dateCheck(util.nullcheck(memberdata?.data?.othermedrefferraldate)) + '</label>';
              section3Html += '</div>' + labelAppointmentSch + util.nullcheck(memberdata?.data?.othermedapptscheduled) + closelabelwithline;
              section3Html += labelNotAttendAppt + util.nullcheck(memberdata?.data?.othermeddidnotattend) + '</label> <br>Comments: <label>' + util.nullcheck(memberdata?.data?.othermedcomments) + ' </label>';
              section3Html += '</div></div><div class="row row-bottom-sp"><div class="col-xs-4">';
              section3Html += spacecheckbox + checkboxCheck(util.nullcheck(memberdata?.data?.othernewbneeds)) + ' >&nbsp;&nbsp;Other Newborn Needs</div>';
              section3Html += referralDiv + util.nullcheck(memberdata?.data?.othnewbneedrefferal) + closelabelwithline;
              section3Html += labelRefferedto + util.nullcheck(memberdata?.data?.othnewbneedrefferedto) + closelabelwithline;
              section3Html += labeldateofRef + dateCheck(util.nullcheck(memberdata?.data?.othnewbneedrefferraldate)) + '</label>';
              section3Html += '</div>' + labelAppointmentSch + util.nullcheck(memberdata?.data?.othneedmedapptscheduled) + closelabelwithline;
              section3Html += labelNotAttendAppt + util.nullcheck(memberdata?.data?.othbneedmeddidnotattend) + closelabelwithline;
              section3Html += commentLabel + util.nullcheck(memberdata?.data?.otherneedcomments) + ' </label></div>';
              section3Html += divspacecheckbox + checkboxCheck(util.nullcheck(memberdata?.data?.noService)) + '>  &nbsp;&nbsp; No Service Needs/Referrals</div> ';
              section3Html += '<div><label> Reason: </label><lavel> '+ util.nullcheck(memberdata?.data?.noServiceReason)  +'</lavel></div></div></div>';
          }
      }
  }
  if (responseval[0]?.healthneedsdetails?.memberform != undefined) {
      for (let i = 0; i < responseval[0]?.healthneedsdetails?.memberform.length; i++) {
          const memberdata = responseval[0]?.healthneedsdetails?.memberform[i];
          if (memberdata.familymember != "Newborn") {
              const parentOrCargiver = util.nullcheck(memberdata?.familymember);
              const notReasonLabel = 'If Not, Reason: <label>';
              const inputCheckbox = '&emsp;&emsp;<input type="checkbox" class="ml-10" ';
              const divXs4label = '<div class="col-xs-4"><label>';
              section3Html += '<div><h3>' + parentOrCargiver + ' Needs and Referrals</h3>';
              section3Html += divRowbottom;
              section3Html += divXs4label + parentOrCargiver + ' Name: ' + util.initialCaps(util.nullcheck(memberdata?.data?.personname)) + closelabeldiv;
              section3Html += divXs4label + parentOrCargiver + ' PID#: ' + util.nullcheck(memberdata?.data?.personpid) + closelabeldiv;
              section3Html += divXs4label + parentOrCargiver + ' DOB: ' + util.nullcheck(memberdata?.data?.persondob) + '</label></div></div>';
              section3Html += '<div class="row row-bottom-sp row-header"><div class="col-xs-4">Needs</div><div class="col-xs-4">Referral Information:</div><div class="col-xs-4">Outcome:</div></div>';
              section3Html += '<div class="row row-bottom-sp"><div class="col-xs-4">';
              section3Html += spacecheckbox + checkboxCheck(util.nullcheck(memberdata?.data?.aodassessment)) + '> &nbsp;&nbsp;PADS Assessment<br>';
              section3Html += inputCheckbox + checkboxCheck(util.nullcheck(memberdata?.data?.aodconsentobtained)) + '>&nbsp;&nbsp;Consent Obtained</div><div class="col-xs-4">';
              section3Html += 'Referral: <label>' + util.nullcheck(memberdata?.data?.aodreferral) + closelabelwithline;
              section3Html += labelRefferedto + util.nullcheck(memberdata?.data?.refertoaod) + closelabelwithline;
              section3Html += labeldateofRef + dateCheck(util.nullcheck(memberdata?.data?.aodrefdate)) + '</label></div><div class="col-xs-4">';
              section3Html += 'Attended Appointment: <label>' + util.nullcheck(memberdata?.data?.aodapptattend) + closelabelwithline;
              section3Html += notReasonLabel + util.nullcheck(memberdata?.data?.aodreasnforattnd) + closelabelwithline;
              section3Html += commentLabel + util.nullcheck(memberdata?.data?.aodcomments) + closelabeldiv;
              section3Html += '</div><div class="row row-bottom-sp"><div class="col-xs-4">';
              section3Html += spacecheckbox + checkboxCheck(util.nullcheck(memberdata?.data?.rcpmassessment)) + '> &nbsp;&nbsp;Recovery Coach/Peer Mentor</div><div class="col-xs-4">';
              section3Html += 'Referral: <label>' + util.nullcheck(memberdata?.data?.rcpmreferral) + closelabelwithline;
              section3Html += labelRefferedto + util.nullcheck(memberdata?.data?.rcpmrefferedto) + closelabelwithline;
              section3Html += labeldateofRef + dateCheck(util.nullcheck(memberdata?.data?.rcpmdateofref)) + ' </label>';
              section3Html += '</div><div class="col-xs-4">Attended Appointment: <label>' + util.nullcheck(memberdata?.data?.rcpmreferral) + closelabelwithline;
              section3Html += notReasonLabel + util.nullcheck(memberdata?.data?.rcpmreasnforattnd) + closelabelwithline;
              section3Html += commentLabel + util.nullcheck(memberdata?.data?.rcpmcomments) + ' </label></div></div>';
              section3Html += '<div class="row row-bottom-sp"><div class="col-xs-4">';
              section3Html += spacecheckbox + checkboxCheck(util.nullcheck(memberdata?.data?.subuseassessment)) + '> &nbsp;&nbsp;Substance Use Disorder Treatment Services<br>';
              section3Html += inputCheckbox + checkboxCheck(util.nullcheck(memberdata?.data?.subuseconsentobtained)) + '>&nbsp;&nbsp;Consent Obtained';
              section3Html += '</div>' + referralDiv + util.nullcheck(memberdata?.data?.subusereferral) + closelabelwithline;
              section3Html += labelRefferedto + util.nullcheck(memberdata?.data?.subuserefferedto) + closelabelwithline;
              section3Html += labeldateofRef + dateCheck(util.nullcheck(memberdata?.data?.subusedateofref)) + ' </label>';
              section3Html += '</div><div class="col-xs-4">Attended Appointment: <label>' + util.nullcheck(memberdata?.data?.subuseapptattend) + closelabelwithline;
              section3Html += notReasonLabel + util.nullcheck(memberdata?.data?.subusereasnforattnd) + closelabelwithline;
              section3Html += commentLabel + util.nullcheck(memberdata?.data?.subusecomments) + ' </label></div></div><div class="row row-bottom-sp"><div class="col-xs-4">';
              section3Html += spacecheckbox + checkboxCheck(util.nullcheck(memberdata?.data?.mhsassessment)) + '> &nbsp;&nbsp;Mental Health Services<br>';
              section3Html += inputCheckbox + checkboxCheck(util.nullcheck(memberdata?.data?.mhsconsentobtained)) + '>&nbsp;&nbsp;Consent Obtained';
              section3Html += '</div>' + referralDiv + util.nullcheck(memberdata?.data?.mhsreferral) + closelabelwithline;
              section3Html += labelRefferedto + util.nullcheck(memberdata?.data?.mhsrefferedto) + closelabelwithline;
              section3Html += labeldateofRef + dateCheck(util.nullcheck(memberdata?.data?.mhsdateofref)) + closelabeldiv;
              section3Html += '<div class="col-xs-4">Attended Appointment: <label>' + util.nullcheck(memberdata?.data?.mhsapptattend) + closelabelwithline;
              section3Html += notReasonLabel + util.nullcheck(memberdata?.data?.mhsreasnforattnd) + closelabelwithline;
              section3Html += commentLabel + util.nullcheck(memberdata?.data?.mhscomments) + ' </label></div></div><div class="row row-bottom-sp">';
              section3Html += divspacecheckbox + checkboxCheck(util.nullcheck(memberdata?.data?.parskillassessment)) + '> &nbsp;&nbsp;Parenting Skills/Attachment/Bonding';
              section3Html += '</div>' + referralDiv + util.nullcheck(memberdata?.data?.parskillreferral) + closelabelwithline;
              section3Html += labelRefferedto + util.nullcheck(memberdata?.data?.parskillrefferedto) + closelabelwithline;
              section3Html += labeldateofRef + dateCheck(util.nullcheck(memberdata?.data?.parskilldateofref)) + closelabeldiv;
              section3Html += '<div class="col-xs-4">Attended Appointment: <label>' + util.nullcheck(memberdata?.data?.parskillapptattend) + closelabelwithline;
              section3Html += notReasonLabel + util.nullcheck(memberdata?.data?.parskillreasnforattnd) + closelabelwithline;
              section3Html += commentLabel + util.nullcheck(memberdata?.data?.parskillcomments) + ' </label></div></div> <div class="row row-bottom-sp">';
              section3Html += divspacecheckbox + checkboxCheck(util.nullcheck(memberdata?.data?.noService)) + '>  &nbsp;&nbsp; No Service Needs/Referrals</div> ';
              section3Html += '<div><label> Reason: </label><lavel> '+ util.nullcheck(memberdata?.data?.noServiceReason)  +'</lavel></div></div></div>';
          }
      }
  }
  return section3Html;
}

function getSCareSection4(responseval){
  let supportSystemHtml = '';
  let persondetails = null;
  const tdWidth40 = '<td width="40%" style="vertical-align: top;">';
  const tdWidths10 = '<td width="10%" style="vertical-align: top;">';
  const tdWidth50 = '<td width="50%" style="vertical-align: top;">';
  if (responseval[0]?.otherservices?.establishedServices?.supportitemsFormArray != undefined) {
      for (let i = 0; i < responseval[0]?.otherservices?.establishedServices?.supportitemsFormArray.length; i++) {
        const ecssSupportParent = responseval[0]?.otherservices?.establishedServices?.supportitemsFormArray[i];
        persondetails = responseval[0]?.persondetails?.data?.find(x => x.familymember == ecssSupportParent.familymember);
        supportSystemHtml += '<tr>' + tdWidth40 + emptyStrCheck(ecssSupportParent.familymember) + '<br>' + util.initialCaps(persondetails?.personName) + '</td>';
        supportSystemHtml += tdWidths10 + emptyStrCheck(ecssSupportParent.issupportappt) + '</td>';
        supportSystemHtml += tdWidth50 + emptyStrCheck(ecssSupportParent.supportapptdate) + tdclosetags;
      }
    }

    let unitedWayHtml = '';
    if (responseval[0]?.otherservices?.establishedServices?.unitedwayitemsFormArray != undefined) {
      for (let i = 0; i < responseval[0]?.otherservices?.establishedServices?.unitedwayitemsFormArray.length; i++) {
        const ecssUnitedway = responseval[0]?.otherservices?.establishedServices?.unitedwayitemsFormArray[i];
        persondetails = responseval[0]?.persondetails?.data?.find(x => x.familymember == ecssUnitedway.familymember);
        unitedWayHtml += tdWidth40 + emptyStrCheck(ecssUnitedway.familymember) + '<br> ' + util.initialCaps(persondetails?.personName) + '</td>';
        unitedWayHtml += tdWidths10 + emptyStrCheck(ecssUnitedway.isunitedwayappt) + '</td>';
        unitedWayHtml += tdWidth50 + emptyStrCheck(ecssUnitedway.unitedwayapptdate) + tdclosetags;
      }
    }

    let housingHtml = '';
    if (responseval[0]?.otherservices?.establishedServices?.housingitemsFormArray != undefined) {
      for (let i = 0; i < responseval[0]?.otherservices?.establishedServices?.housingitemsFormArray.length; i++) {
        const ecssHousing = responseval[0]?.otherservices?.establishedServices?.housingitemsFormArray[i];
        persondetails = responseval[0]?.persondetails?.data?.find(x => x.familymember == ecssHousing.familymember);
        housingHtml += tdWidth40 + emptyStrCheck(ecssHousing.familymember) + '<br>' + util.initialCaps(persondetails?.personName) + '</td>';
        housingHtml += tdWidths10 + emptyStrCheck(ecssHousing.ishousingappt) + '</td>';
        housingHtml += tdWidth50 + emptyStrCheck(ecssHousing.housingapptdate) + tdclosetags;
      }
    }

    let paroleProbationHtml = '';
    if (responseval[0]?.otherservices?.establishedServices?.paroleitemsFormArray != undefined) {
      for (let i = 0; i < responseval[0]?.otherservices?.establishedServices?.paroleitemsFormArray.length; i++) {
        const ecssParole = responseval[0]?.otherservices?.establishedServices?.paroleitemsFormArray[i];
        persondetails = responseval[0]?.persondetails?.data?.find(x => x.familymember == ecssParole.familymember);
        paroleProbationHtml += tdWidth40 + emptyStrCheck(ecssParole.familymember) + '<br>' + util.initialCaps(persondetails?.personName) + '</td>';
        paroleProbationHtml += tdWidths10 + emptyStrCheck(ecssParole.isparoleappt) + '</td>';
        paroleProbationHtml += tdWidth50 + emptyStrCheck(ecssParole.paroleapptdate) + tdclosetags;
      }
    }

    let familyDrugHtml = '';
    if (responseval[0]?.otherservices?.establishedServices?.drugitemsFormArray != undefined) {
      for (let i = 0; i < responseval[0]?.otherservices?.establishedServices?.drugitemsFormArray.length; i++) {
        const ecssDrug = responseval[0]?.otherservices?.establishedServices?.drugitemsFormArray[i];
        persondetails = responseval[0]?.persondetails?.data?.find(x => x.familymember == ecssDrug.familymember);
        familyDrugHtml += tdWidth40 + emptyStrCheck(ecssDrug.familymember) + '<br>' + util.initialCaps(persondetails?.personName) + '</td>';
        familyDrugHtml += tdWidths10 + emptyStrCheck(ecssDrug.isdrugappt) + '</td>';
        familyDrugHtml += tdWidth50 + emptyStrCheck(ecssDrug.drugapptdate) + tdclosetags;
      }
    }

    const additionalServicesHtml = getSCAdditionalService(responseval);

    return  {
      supportSystemHtml,
      unitedWayHtml,
      housingHtml,
      paroleProbationHtml,
      familyDrugHtml,
      additionalServicesHtml
    }
}

function getSCAdditionalService(responseval){
  let additionalServicesHtml = '';
  let persondetails = null;
  const tdWidth40 = '<td width="40%" style="vertical-align: top;">';
  const tdWidths10 = '<td width="10%" style="vertical-align: top;">';
  const tdWidth50 = '<td width="50%" style="vertical-align: top;">';
    if (responseval[0]?.otherservices?.establishedServices?.additionalitemsFormArray != undefined) {
      for (var i = 0; i < responseval[0]?.otherservices?.establishedServices?.additionalitemsFormArray.length; i++) {
        const ecssAdditional = responseval[0]?.otherservices?.establishedServices?.additionalitemsFormArray[i];
        persondetails = responseval[0]?.persondetails?.data?.find(x => x.familymember == ecssAdditional.familymember);
        additionalServicesHtml += tdWidth40 + emptyStrCheck(ecssAdditional.familymember) + '<br>' + util.initialCaps(persondetails?.personName) + '</td>';
        additionalServicesHtml += tdWidths10 + emptyStrCheck(ecssAdditional.isadditionalappt) + '</td>';
        additionalServicesHtml += tdWidth50 + emptyStrCheck(ecssAdditional.additionalapptdate) + tdclosetags;
      }
    }
    return additionalServicesHtml;
}

function getSCareSection5(responseval) {
  let safeSleepingEnvHtml = '';
  let persondetails = null;

  const divXs4 = '<div class="col-xs-4">';
  if (responseval[0]?.planreviewdetails?.reviewdiscuss?.sleepingitemsFormArray != undefined) {
      for (let i = 0; i < responseval[0]?.planreviewdetails?.reviewdiscuss?.sleepingitemsFormArray.length; i++) {
          const ecssSleepingParent = responseval[0]?.planreviewdetails?.reviewdiscuss?.sleepingitemsFormArray[i];
          persondetails = responseval[0]?.persondetails?.data?.find(x => x.familymember == ecssSleepingParent.familymember);
          safeSleepingEnvHtml += divXs4 + emptyStrCheck(ecssSleepingParent.familymember) + '<br>' + util.initialCaps(persondetails?.personName) + '</div>';
          safeSleepingEnvHtml += divXs4 + emptyStrCheck(ecssSleepingParent.sleepingreviewed) + lineSpaceClose;
          safeSleepingEnvHtml += divXs4 + emptyStrCheck(ecssSleepingParent.sleepingcomments) + lineSpaceClose;
      }
  }

  let ecssCopingHtml = '';
  if (responseval[0]?.planreviewdetails?.reviewdiscuss?.copingitemsFormArray != undefined) {
      for (let i = 0; i < responseval[0]?.planreviewdetails?.reviewdiscuss?.copingitemsFormArray.length; i++) {
          const ecssCoping = responseval[0]?.planreviewdetails?.reviewdiscuss?.copingitemsFormArray[i];
          persondetails = responseval[0]?.persondetails?.data?.find(x => x.familymember == ecssCoping.familymember);
          ecssCopingHtml += divXs4 + emptyStrCheck(ecssCoping.familymember) + '<br>' + util.initialCaps(persondetails?.personName) + '</div>';
          ecssCopingHtml += divXs4 + emptyStrCheck(ecssCoping.copingreviewed) + lineSpaceClose;
          ecssCopingHtml += divXs4 + emptyStrCheck(ecssCoping.copingcomments) + lineSpaceClose;
      }
  }

  let ecssHomesafetyHtml = '';
  if (responseval[0]?.planreviewdetails?.reviewdiscuss?.homesafetyitemsFormArray != undefined) {
      for (let i = 0; i < responseval[0]?.planreviewdetails?.reviewdiscuss?.homesafetyitemsFormArray.length; i++) {
          const ecssHomesafety = responseval[0]?.planreviewdetails?.reviewdiscuss?.homesafetyitemsFormArray[i];
          persondetails = responseval[0]?.persondetails?.data?.find(x => x.familymember == ecssHomesafety.familymember);
          ecssHomesafetyHtml += divXs4 + emptyStrCheck(ecssHomesafety.familymember) + '<br>' + util.initialCaps(persondetails?.personName) + '</div>';
          ecssHomesafetyHtml += divXs4 + emptyStrCheck(ecssHomesafety.homesafetyreviewed) + lineSpaceClose;
          ecssHomesafetyHtml += divXs4 + emptyStrCheck(ecssHomesafety.homesafetycomments) + lineSpaceClose;
      }
  }

  let ecssFiresafetyHtml = '';
  if (responseval[0]?.planreviewdetails?.reviewdiscuss?.firesafetyitemsFormArray != undefined) {
      for (let i = 0; i < responseval[0]?.planreviewdetails?.reviewdiscuss?.firesafetyitemsFormArray.length; i++) {
          const ecssFiresafety = responseval[0]?.planreviewdetails?.reviewdiscuss?.firesafetyitemsFormArray[i];
          persondetails = responseval[0]?.persondetails?.data?.find(x => x.familymember == ecssFiresafety.familymember);
          ecssFiresafetyHtml += divXs4 + emptyStrCheck(ecssFiresafety.familymember) + '<br>' + util.initialCaps(persondetails?.personName) + '</div>';
          ecssFiresafetyHtml += divXs4 + emptyStrCheck(ecssFiresafety.firesafetyreviewed) + lineSpaceClose;
          ecssFiresafetyHtml += divXs4 + emptyStrCheck(ecssFiresafety.firesafetycomments) + lineSpaceClose;
      }
  }

  let ecssFireescapeHtml = '';
  if (responseval[0]?.planreviewdetails?.reviewdiscuss?.fireescapeitemsFormArray != undefined) {
      for (let i = 0; i < responseval[0]?.planreviewdetails?.reviewdiscuss?.fireescapeitemsFormArray.length; i++) {
          const ecssFireescape = responseval[0]?.planreviewdetails?.reviewdiscuss?.fireescapeitemsFormArray[i];
          persondetails = responseval[0]?.persondetails?.data?.find(x => x.familymember == ecssFireescape.familymember);
          ecssFireescapeHtml += divXs4 + emptyStrCheck(ecssFireescape.familymember) + '<br>' + util.initialCaps(persondetails?.personName) + '</div>';
          ecssFireescapeHtml += divXs4 + emptyStrCheck(ecssFireescape.fireescapereviewed) + lineSpaceClose;
          ecssFireescapeHtml += divXs4 + emptyStrCheck(ecssFireescape.fireescapecomments) + lineSpaceClose;
      }
  }

  return {
      safeSleepingEnvHtml,
      ecssCopingHtml,
      ecssHomesafetyHtml,
      ecssFiresafetyHtml,
      ecssFireescapeHtml  
  }

}

function getSCareSection8(responseval, html){
  let signatureReasons = {
    Refused: 'Refused',
    Incarcerated: 'Incarcerated',
    RelocatedOutOfState: 'Relocated Out Of State',
    ManualSignature: 'Manual Signature',
    Other: 'Other',
  }
  let signaturesHtml = '';
    const familyAdultMembers = responseval[0]?.persondetails?.data.filter(x => !x.familymember.includes("Newborn"));
    if (responseval[0]?.signatures?.signatureitemsFormArray != undefined) {
      for (let i = 0; i < responseval[0]?.signatures?.signatureitemsFormArray?.length; i++) {

        const signaturedata = responseval[0]?.signatures?.signatureitemsFormArray[i];
        signaturesHtml += '<tr><td width="20%">' + util.nullcheck(familyAdultMembers[i]?.familymember) + ' Signature:<br> ' + util.initialCaps(util.nullcheck(familyAdultMembers[i]?.personName)) + '</td>';
        signaturesHtml += '<td width="20%"><div class="clsblock signatureimg" style="border: 1px solid #797373; margin-top: 2px;">';
        if (util.nullcheck(signaturedata.signaturevalue) != '') {
          signaturesHtml += '<img src="' + signaturedata.signaturevalue + '" />';
        }
        signaturesHtml += '</td> <td width="40%"> <div> <input type="checkbox"'+ checkboxCheck(util.nullcheck(signaturedata.isSignatureRequired)) +'/> No Signature Obtained </div>';
        signaturesHtml += '<div> Reason For No Signature: '+ util.nullcheck(signatureReasons[signaturedata.reason]) +'</div>';
        signaturesHtml += '<div> Other Reason: '+signaturedata.otherReason+'</div>';
        signaturesHtml += '</td><td width="20%">Date: ' + dateCheck(util.nullcheck(signaturedata.signaturedate)) + tdclosetags;
      }
    }

    html = html.replace('{{signaturesHtml}}',signaturesHtml);

    const ldssSignImage = util.nullcheck(responseval[0]?.signatures?.ldsssign);
    if (ldssSignImage != '') {
      html = html.replace('{{ldssName8}}',util.initialCaps(util.nullcheck(responseval[0]?.caseworkername)));
      html = html.replace('{{ldssSignImage}}', emptyStrCheck(ldssSignImage));
      html = html.replace('{{ldssSignDate}}',dateCheck(util.nullcheck(responseval[0]?.signatures?.ldssdate)));  //SonarQube fix removed unwanted parentheses
      html = html.replace(showLDSSSignature,'');
    }
    else {
      html = html.replace('{{ldssName8}}','');
      html = html.replace('{{ldssSignImage}}','');
      html = html.replace(supervisorSignDate,'');
      html = html.replace(showLDSSSignature,nodisplayStyle);
    }

    const supervisorSignImage = util.nullcheck(responseval[0]?.signatures?.supervisorsign);
    if (supervisorSignImage != '') {
      html = html.replace('{{supervisorName}}',util.initialCaps(util.nullcheck(responseval[0]?.supervisorname)));
      html = html.replace('{{supervisorSignImage}}',emptyStrCheck(supervisorSignImage));
      html = html.replace(supervisorSignDate, dateCheck(util.nullcheck(responseval[0]?.signatures?.supervisordate)));  //SonarQube fix removed unwanted parentheses
      html = html.replace(showLDSSSignature,'');
      html = html.replace('{{showSupervisorSignature}}','');
    }
    else {
      html = html.replace('{{supervisorName}}','');
      html = html.replace('{{supervisorSignImage}}','');
      html = html.replace(supervisorSignDate,'');
      html = html.replace('{{showSupervisorSignature}}',nodisplayStyle);
    }

    if ((util.nullcheck(responseval[0]?.justification) != '')) {
      html = html.replace('{{justificationHtml}}', util.nullcheck(responseval[0]?.justification));
      html = html.replace('{{displayJustification}}','style="display:visible;"');
    }
    else {
      html = html.replace('{{justificationHtml}}','');
      html = html.replace('{{displayJustification}}',nodisplayStyle);
    }

    return html;

}

function getreferralCurrentSection(responseval, html){

  html = html.replace('{{breastfeedingReferral}}',checkboxCheck(util.nullcheck(responseval[0]?.otherservices?.referralCurrentServices?.breastfeedingReferral)));
  html = html.replace('{{infantReferral}}',checkboxCheck(util.nullcheck(responseval[0]?.otherservices?.referralCurrentServices?.infantReferral)));
  html = html.replace('{{childcareReferral}}',checkboxCheck(util.nullcheck(responseval[0]?.otherservices?.referralCurrentServices?.childcareReferral)));
  html = html.replace('{{homeReferral}}',checkboxCheck(util.nullcheck(responseval[0]?.otherservices?.referralCurrentServices?.homeReferral)));

  html = html.replace('{{otherServicesHomeVisitingText}}',util.nullcheck(responseval[0]?.otherservices?.referralCurrentServices?.homeNotes));
  html = html.replace('{{pregnancyReferral}}',checkboxCheck(util.nullcheck(responseval[0]?.otherservices?.referralCurrentServices?.pregnancyReferral)));
  html = html.replace('{{interventionReferral}}',checkboxCheck(util.nullcheck(responseval[0]?.otherservices?.referralCurrentServices?.interventionReferral)));
  html = html.replace('{{birthReferral}}',checkboxCheck(util.nullcheck(responseval[0]?.otherservices?.referralCurrentServices?.birthReferral)));
  html = html.replace('{{publicReferral}}',checkboxCheck(util.nullcheck(responseval[0]?.otherservices?.referralCurrentServices?.publicReferral)));
  html = html.replace('{{parentingReferral}}',checkboxCheck(util.nullcheck(responseval[0]?.otherservices?.referralCurrentServices?.parentingReferral)));
  html = html.replace('{{otherReferral}}',checkboxCheck(util.nullcheck(responseval[0]?.otherservices?.referralCurrentServices?.otherReferral)));
  html = html.replace('{{otherServicesText}}',util.nullcheck(responseval[0]?.otherservices?.referralCurrentServices?.otherNotes));
  html = html.replace('{{breastfeedingCurrent}}',checkboxCheck(util.nullcheck(responseval[0]?.otherservices?.referralCurrentServices?.breastfeedingCurrent)));
  html = html.replace('{{infantCurrent}}',checkboxCheck(util.nullcheck(responseval[0]?.otherservices?.referralCurrentServices?.infantCurrent)));
  html = html.replace('{{childcareCurrent}}',checkboxCheck(util.nullcheck(responseval[0]?.otherservices?.referralCurrentServices?.childcareCurrent)));
  html = html.replace('{{homeCurrent}}',checkboxCheck(util.nullcheck(responseval[0]?.otherservices?.referralCurrentServices?.homeCurrent)));
  html = html.replace('{{pregnancyCurrent}}',checkboxCheck(util.nullcheck(responseval[0]?.otherservices?.referralCurrentServices?.pregnancyCurrent)));
  html = html.replace('{{interventionCurrent}}',checkboxCheck(util.nullcheck(responseval[0]?.otherservices?.referralCurrentServices?.interventionCurrent)));
  html = html.replace('{{birthCurrent}}',checkboxCheck(util.nullcheck(responseval[0]?.otherservices?.referralCurrentServices?.birthCurrent)));
  html = html.replace('{{publicCurrent}}',checkboxCheck(util.nullcheck(responseval[0]?.otherservices?.referralCurrentServices?.publicCurrent)));
  html = html.replace('{{parentingCurrent}}',checkboxCheck(util.nullcheck(responseval[0]?.otherservices?.referralCurrentServices?.parentingCurrent)));
  html = html.replace('{{otherCurrent}}',checkboxCheck(util.nullcheck(responseval[0]?.otherservices?.referralCurrentServices?.otherCurrent)));
  html = html.replace('{{noneIdentified}}',checkboxCheck(util.nullcheck(responseval[0]?.otherservices?.referralCurrentServices?.noneIdentified)));
  html = html.replace('{{noneIdentifiedReason}}',util.nullcheck(responseval[0]?.otherservices?.referralCurrentServices?.noneIdentifiedReason));
  
  return html;

}



module.exports.intakereport =  function (request,response) {    // NOSONAR
  var intakenumber = request.where.intakenumber;
  var caseNumber = request.where.caseNumber;
  var caseDate = request.where.caseDate;
  var servicetype;
  var snapshotid = request.where.snapshotid;
  const isExpungementSuperUser = request.where.isExpungementSuperUser ? request.where.isExpungementSuperUser: 0;
  const iscaseexpunged = request.where.iscaseexpunged ?? 0;
  const sql = 'select * from getintakesnapshotreport($1,$2,$3,$4)';
  const sql1 = 'select * from getsupervisorapprovaldetails($1,$2,$3)';
  let Response;
  let resjson;
  let quickAddPersonDetails = '';

  var sdmObject = [];
  var notinhhelement = '';
  var addendumNarrativeInfo = '';
  var participantelement = '';
  var participantnotinhhelement = '';
  var overallperson = '';
  var screeningDecision = '';
  
  var physicalAbuseObject = '';
  var sexualAbuseObject = '';
  var generalNeglectObject = '';
  var unattendedChildObject = '';
  var riskofHarmObject = '';
  var negfp_cargiverinterveneObject = '';
  var negab_abandonedObject = '';
  var negmn_unreasonabledelayObject = '';
  var ismenab_psycologicalabilityObject = '';
  var ismenng_psycologicalabilityObject = '';
  var screeningDesc = '';
  var scnRecommendOveride = '';
  
  var sourcefullname = '';
  var organization = '';
  var role = '';
  var phonenumber = '';
  var email = '';
  var address = '';
  var isanonymousreporter;
  var isunknownreporter;
  var isacknowledgement;
  var incidentlocation = '';

  return util.executeSecondaryNodeDBQuery(sql,[intakenumber,snapshotid,isExpungementSuperUser,iscaseexpunged])
    .then(data => {
      if (data.length > 0) {
        servicetype = getIRServicetype(data,caseNumber);
        var sdm;
        var general;
        
        var typeOfMaltreatment = [];
        var immediateyesno;

        var persons = [];
        var personelement = '';
        var narrative;
        var incidentdate = '';
        var isapproximate = false;
        var refetypeval;
        resjson = data[0];
        quickAddPersonDetails = quickCardPersonsDetails(resjson.quickpersondetails,'intake');
        refetypeval = {
          ismalpa_suspeciousdeath: 'Suspicious death of a child due to abuse',
          ismalpa_nonaccident: 'Non-accidental physical injury',
          ismalpa_injuryinconsistent: 'Injury inconsistent with explanation',
          ismalpa_insjury: 'Injury that appears suspicious',
          ismalpa_childtoxic: 'Giving child toxic chemicals, alcohol, or drugs',
          ismalpa_caregiver: 'Caregiver action that likely caused injury',
          ismalpa_labortrafficking: 'Labor Trafficking',

          ismalsa_sexualmolestation: 'Sexual molestation of a child by an adult caregiver, family member, or household member',
          ismalsa_sexualact: 'Sexual act(s) among siblings or other children living in the home that is outside of normal exploration',
          ismalsa_sexualexploitation: 'Sexual exploitation of a child by an adult caregiver, family member, or household member',
          ismalsa_physicalindicators: 'Physical, behavioral, or suspicious indicators consistent with sexual abuse',
          ismalsa_sex_trafficking: 'Risk of Sex Trafficking',

          isneggn_suspiciousdeath: 'Suspicious death of a child due to neglect',
          isneggn_signsordiagnosis: 'Signs or diagnosis of non-organic failure to thrive',
          isneggn_inadequatefood: 'Inadequate food/nutrition, or signs of malnutrition',
          isneggn_childdischarged: 'A child is being discharged from a facility and parents refuse to participate in planning for the child',
          isneggn_exposuretounsafe: 'Exposure to unsafe conditions in the home',
          isneggn_inadequateclothing: 'Inadequate clothing or hygiene',
          isneggn_inadequatesupervision: 'Inadequate supervision',
          isnegrh_treatmenthealthrisk: 'Physical treatment of the child poses a significant risk to child health or welfare',

          negfp_cargiverintervene: 'The caregiver does not intervene despite knowledge (or reasonable expectation that the caregiver should have knowledge) that the child is being harmed (includes physical or sexual abuse, neglect, or mental injury) by another person',

          negab_abandoned: 'A child of any age has been abandoned',

          isneguc_leftunsupervised: 'A child of any age who is physically, intellectually, or cognitively disabled is left unsupervised or with responsibilities beyond his or her capabilities',
          isneguc_leftaloneinappropriatecare: 'A child under the age of 8 & has been left alone or in the care of an inappropriate caregiver',
          isneguc_leftalonewithoutsupport: 'A child over the age of 8 & has been left alone without support systems for long periods of time or with responsibilities beyond his or her capabilities',

          ismenab_psycologicalability: 'A child has an observable, identifiable, and substantial impairment of his/her mental or psychological ability to function as a result of an act of a parent, permanent or temporary caregiver, or household or family member.',
          ismenng_psycologicalability: 'A child has an observable, identifiable, and substantial impairment of his/her mental or psychological ability to function as a result of failure to act by a parent, permanent or temporary caregiver, or household or family member',

          isnegrh_priordeath: 'Prior child fatality and a new child in the home',
          isnegrh_exposednewborn: 'Substance Exposed Newborn',
          isnegrh_basicneedsunmet: 'Child\'s basic needs are likely to be unmet due to caregiver impairment',
          isnegrh_sex_offender: "Risk of Sex Abuse by Registered Sex Offender",
          isnegrh_risk_dv: 'Risk of Domestic Violence',
          isnegrh_sex_trafficking: 'Risk of Sex Trafficking',
          isnegrh_fatality_can: 'Previous Fatality or Serious Injury of a Child due to Child Abuse or Neglect',
          isnegrh_indicated_unsub: 'Prior Indicated or Unsub Finding and Child under age 5',
          isnegrh_survivor: 'Adult Survivor of Child Maltreatment',
          isnegrh_birth_match: 'Birth Match',

          isnegrh_domesticviolence: 'Exposure to Domestic Violence in the home',
          isnegrh_sexualperpetrator: 'Known sexual perpetrator has unsupervised or unrestricted access to child',
          isnegmn_unreasonabledelay: 'The unreasonable  delay, refusal, or failure on the part of the caregiver to seek, obtain, and/or maintain necessary medical, dental, or mental health care',

          ScreenOUT: 'Screen out (no maltreatment type is marked)',
          Scrnin: 'Screen in (one or more maltreatment types are marked)',
          OvrScrnout: 'Screen out: One or more maltreatment types are marked, but referral will be screened out (mark all that apply)',
          isscrnoutrecovr_insufficient: 'Insufficient information to locate child/family',
          isscrnoutrecovr_information: 'Information forwarded to another jurisdiction',
          isscrnoutrecovr_historicalinformation: 'Historical information, victim is now an adult, and no children are in the care of alleged perpetrator',
          isscrnoutrecovr_otherspecify: otherStr,
          Ovrscrnin: 'Screen in: No maltreatment type is marked, but referral will be opened and assigned for child protective services (CPS) investigation (mark all that apply)',
          isscrninrecovr_courtorder: 'Court order for an investigation',
          isscrninrecovr_otherspecify: otherStr,
          isfinalscreenin: '',
          isfinalscreeninIn: 'Screen in: At least one maltreatment type or screen-in override is marked AND no screen-out overrides are marked. Complete Section 3, Response Time Decision',
          isfinalscreeninOut: 'Screen out: No maltreatment type is marked AND no screen-in overrides apply',
          Ovr_as_noncps: 'Accept as Non-CPS: Only Risk of Harm type is marked',
          accept_as_noncps: 'Accept as Non-CPS: Only Risk of Harm type is marked',

          isimmed_childfaatility: 'Child fatality or near fatality where abuse/neglect is suspected',
          isimmed_seriousinjury: 'Serious injury to child and other children remain in home',
          isimmed_childleftalone: 'Child left alone/abandoned and requires immediate care. Age of youngest child in years',
          isimmed_allegation: 'Allegation of child abuse or neglect in an out-of-home setting',
          isimmed_otherspecify: otherStr,
          isnoimmed_physicalabuse: 'Physical abuse-response within 24 hours',
          isnoimmed_sexualabuse: 'Sexual abuse-response within 24 hours',
          isnoimmed_neglectresponse: 'Neglect-response within 5 days',
          isnoimmed_mentalinjury: 'Mental injury-response within 5 days',
          isnoimmed_screeninoverride: 'Screen-in Override',
          isImmediateYes: 'Immediate response required based on one or more criteria below',
          isImmediateNo: 'No immediate response criteria exist and allegations include the following'
        };
        
        
        var routeapprovals = filterIRRouterapproval(resjson);

        resjson.jsondata.routeapprovals = routeapprovals;
        sdm = resjson.jsondata.sdm;
        general = resjson.jsondata.General;
        if (Array.isArray(resjson.jsondata.persons)) {
          persons = resjson.jsondata.persons;
        } else if (resjson.jsondata.persondetails != undefined && resjson.jsondata.persondetails != null && Array.isArray(resjson.jsondata.persondetails.Person)) {
          persons = resjson.jsondata.persondetails.Person;
        }
        narrative = resjson.jsondata.narrative;
        resjson.jsondata.General.narrativeUpdatedDate = util.formatDateAndTimeReport(util.nullcheck(general.narrativeUpdatedDate));
        if (Array.isArray(narrative)) {
          incidentlocation = util.nullcheck(narrative[0].incidentlocation) + ""
          incidentdate = util.formatDate(util.nullcheck(narrative[0].incidentdate));
          isapproximate = `<input type="checkbox" ${checkboxCheck(narrative[0].isapproximate)} disabled/>`;
          sourcefullname = util.nullcheck(narrative[0].title) + " "
            + util.nullcheck(narrative[0].Firstname) + " "
            + util.nullcheck(narrative[0].Middlename) + " "
            + util.nullcheck(narrative[0].Lastname);
          organization = narrative[0].organization;
          role = narrative[0].RoleName;
          phonenumber = util.nullcheck(narrative[0].PhoneNumberExt) + '  ' + util.nullcheck(narrative[0].PhoneNumber);
          email = narrative[0].email;
          address = util.nullcheck(general.requesteraddress1) + " "
            + util.nullcheck(general.requesteraddress2) + " "
            + util.nullcheck(general.requestercity) + " "
            + util.nullcheck(general.requestercountyname) + " "
            + util.nullcheck(general.requesterstate) + " "
            + util.nullcheck(general.offenselocation);
          isacknowledgement = `<input type="checkbox" ${checkboxCheck(general.isacknowledgementletter)} disabled/>`;
          isunknownreporter = `<input type="checkbox" ${checkboxCheck(general.IsUnknownReporter)} disabled/>`;
          isanonymousreporter = `<input type="checkbox" ${checkboxCheck(general.IsAnonymousReporter)} disabled/>`;
        }
        addendumNarrativeInfo = '<div class="row"><div class="col-xs-3 section-lable text-right">Created By:</div><div class="col-xs-3 section-value text-left">' + general.addendumNarrativeCreatedByInfo + '</div><div class="col-xs-3 section-lable text-right">Date Created:</div><div class="col-xs-3 section-value text-left">' + util.formatDateAndTimeReport(util.nullcheck(general.addendumNarrativeCreatedAt)) + '</div></div><div class="row"> <div class="col-xs-3 section-lable text-right">Updated By:</div><div class="col-xs-3 section-value text-left">' + general.addendumNarrativeUpdatedByInfo + '</div><div class="col-xs-3 section-lable text-right">Last updated on :</div><div class="col-xs-3 section-value text-left">' + util.formatDateAndTimeReport(util.nullcheck(general.addendumNarrativeUpdatedAt)) + '</div></div>';
        

        //Head Of Household
        const hoh = getIRHOH(resjson, persons);
        screeningDecision = hoh.screeningDecision;

        overallperson = hoh.overallperson; 
        participantelement += hoh.participantelement; 
        participantnotinhhelement += hoh.participantnotinhhelement; 
        email = email || hoh.email; 
        LOGGER.debug(email);
        //Other Participants            
        const otherpart = getIROtherParticpate(persons);
        personelement = otherpart.personelement;
        notinhhelement = otherpart.notinhhelement;
        if(sdm && (sdm.isfinalscreenin == 'true' || sdm.isfinalscreenin) && general.PurposeName == 'Request for services'){
          general.PurposeName = 'Child Protective Services';
        }

        const sdmData = getIRSdmData(sdm, refetypeval);
        typeOfMaltreatment = sdmData.typeOfMaltreatment;
        immediateyesno = sdmData.immediateyesno;
        physicalAbuseObject = sdmData.physicalAbuseObject;
        sexualAbuseObject = sdmData.sexualAbuseObject;
        generalNeglectObject = sdmData.generalNeglectObject;
        unattendedChildObject = sdmData.unattendedChildObject;
        riskofHarmObject = sdmData.riskofHarmObject;
        negfp_cargiverinterveneObject = sdmData.negfp_cargiverinterveneObject;
        negab_abandonedObject = sdmData.negab_abandonedObject;
        negmn_unreasonabledelayObject = sdmData.negmn_unreasonabledelayObject;
        ismenab_psycologicalabilityObject = sdmData.ismenab_psycologicalabilityObject;
        ismenng_psycologicalabilityObject = sdmData.ismenng_psycologicalabilityObject;
        screeningDesc = sdmData.screeningDesc;
        scnRecommendOveride = sdmData.scnRecommendOveride;
        sdmObject = sdmData.sdmObject;
      }
        return util.executeDBQuery(sql1,[intakenumber,isExpungementSuperUser, iscaseexpunged]).then((result2)=> {
          var supervisorApprovalDetail = result2[0].getsupervisorapprovaldetails;
          resjson = supervisorapprovaldetailfn(supervisorApprovalDetail,resjson);
          
      var html = ''
      html = fs.readFileSync('./documenttemplates/intakereport.html','utf8');


      LOGGER.debug(app.baseurl + baseurllogstmt);
      html = html.replace(logopath,app.baseurl);
      html = html.replace(/{{IntakeNumber}}/g,util.nullcheck(resjson.intakenumber));
      html = html.replace(/{{CaseNumber}}/g,util.nullcheck(caseNumber));
      html = html.replace(/{{CaseDate}}/g,util.nullcheck(caseDate));
      html = html.replace(/{{ServiceCase}}/g,util.nullcheck(servicetype));
      const sanatizedNarrativeData = clearHtmlSpaces(general?.Narrative);
      html = html.replace(/{{narrative}}/g,util.nullcheck(sanatizedNarrativeData));
      html = html.replace(/{{Maltreatment}}/g,util.nullcheck(typeOfMaltreatment));
      
        html = !util.nullcheck(sdm) ? html.replace(/{{cpsResponseType}}/g,'') :
                html.replace(/{{cpsResponseType}}/g,util.nullcheck(sdm.cpsResponseType));
                
      html = html.replace(/{{Author}}/g,util.nullcheck(general?.Author));
      html = html.replace(/{{CreatedDate}}/g,util.formatDateAndTimeReport(util.nullcheck(general?.CreatedDate)));
      html = html.replace(/{{RecivedDate}}/g,util.formatDateAndTimeReport(util.nullcheck(general?.RecivedDate)));
      html = html.replace(/{{addendumNarrativeInfo}}/g,util.nullcheck(addendumNarrativeInfo));
      const sanatizedcpsHistoryClearanceData = clearHtmlSpaces(general?.cpsHistoryClearance);
      html = html.replace(/{{cpsHistoryClearance}}/g,util.nullcheck(sanatizedcpsHistoryClearanceData));
      html = html.replace(/{{personelement}}/g,util.nullcheck(personelement));
      html = html.replace(/{{notinhhelement}}/g,util.nullcheck(notinhhelement));
      html = html.replace(/{{inputsourcevalue}}/g,util.nullcheck(general?.communicationDescription));
      html = html.replace(/{{incidentdate}}/g,util.nullcheck(incidentdate));
      html = html.replace(/{{isapproximate}}/g,util.nullcheck(isapproximate));

      html = html.replace(/{{sourcefullname}}/g,util.nullcheck(sourcefullname));
      html = html.replace(/{{organization}}/g,util.nullcheck(organization));
      html = html.replace(/{{role}}/g,util.nullcheck(role));
      html = html.replace(/{{phonenumber}}/g,util.nullcheck(phonenumber));
      html = html.replace(/{{email}}/g,util.nullcheck(email));
      html = html.replace(/{{address}}/g,util.nullcheck(address));
      html = html.replace(/{{isacknowledgement}}/g,util.nullcheck(isacknowledgement));
      html = html.replace(/{{isunknownreporter}}/g,util.nullcheck(isunknownreporter));
      html = html.replace(/{{isanonymousreporter}}/g,util.nullcheck(isanonymousreporter));

      html = html.replace(/{{immediateyesno}}/g,util.nullcheck(immediateyesno));
      html = html.replace(/{{sdmObject}}/g,util.nullcheck(sdmObject));
      html = html.replace(/{{physicalAbuseObject}}/g,util.nullcheck(physicalAbuseObject));
      html = html.replace(/{{sexualAbuseObject}}/g,util.nullcheck(sexualAbuseObject));
      html = html.replace(/{{generalNeglectObject}}/g,util.nullcheck(generalNeglectObject));
      html = html.replace(/{{negfp_cargiverinterveneObject}}/g,util.nullcheck(negfp_cargiverinterveneObject));
      html = html.replace(/{{negab_abandonedObject}}/g,util.nullcheck(negab_abandonedObject));
      html = html.replace(/{{unattendedChildObject}}/g,util.nullcheck(unattendedChildObject));
      html = html.replace(/{{riskofHarmObject}}/g,util.nullcheck(riskofHarmObject));
      html = html.replace(/{{negmn_unreasonabledelayObject}}/g,util.nullcheck(negmn_unreasonabledelayObject));
      html = html.replace(/{{ismenab_psycologicalabilityObject}}/g,util.nullcheck(ismenab_psycologicalabilityObject));
      html = html.replace(/{{ismenng_psycologicalabilityObject}}/g,util.nullcheck(ismenng_psycologicalabilityObject));
      html = html.replace(/{{screeningDesc}}/g,util.nullcheck(screeningDesc));
      html = html.replace(/{{scnRecommendOveride}}/g,util.nullcheck(scnRecommendOveride));
      html = html.replace(/{{finalscreenin}}/g,util.nullcheck(screeningDecision));

      html = html.replace(/{{participantelement}}/g,util.nullcheck(participantelement));
      html = html.replace(/{{participantnotinhhelement}}/g,util.nullcheck(participantnotinhhelement));
      html = html.replace(/{{overallperson}}/g,util.nullcheck(overallperson));
      html = html.replace(/{{overallperson}}/g,util.nullcheck(overallperson));
      html = html.replace(/{{quickAddPersonDetails}}/g,util.nullcheck(quickAddPersonDetails));
      html = html.replace(/{{reasonfordelay}}/g, getIRResonforDelay(resjson));

      request.where.outputfilename = "intakereport";

      resjson.jsondata.physicalAbuseObject = physicalAbuseObject;
      resjson.jsondata.sexualAbuseObject = sexualAbuseObject
      resjson.jsondata.generalNeglectObject = generalNeglectObject
      resjson.jsondata.negfp_cargiverinterveneObject = negfp_cargiverinterveneObject
      resjson.jsondata.negab_abandonedObject = negab_abandonedObject
      resjson.jsondata.unattendedChildObject = unattendedChildObject
      resjson.jsondata.riskofHarmObject = riskofHarmObject;
      resjson.jsondata.negmn_unreasonabledelayObject = negmn_unreasonabledelayObject;
      resjson.jsondata.ismenab_psycologicalabilityObject = ismenab_psycologicalabilityObject;
      resjson.jsondata.ismenng_psycologicalabilityObject = ismenng_psycologicalabilityObject;
      resjson.jsondata.notinhhelement = notinhhelement;
      resjson.jsondata.addendumNarrativeInfo = addendumNarrativeInfo;
      resjson.jsondata.participantnotinhhelement = participantnotinhhelement;
      resjson.jsondata.personelement = personelement;
      resjson.jsondata.narration = util.nullcheck(general?.Narrative) !== '';
      resjson.jsondata.immediateyesno = immediateyesno;
      resjson.jsondata.sdmObject = sdmObject;
      resjson.jsondata.physicalAbuseObject = physicalAbuseObject;
      resjson.jsondata.sexualAbuseObject = sexualAbuseObject;
      resjson.jsondata.generalNeglectObject = generalNeglectObject;
      resjson.jsondata.negfp_cargiverinterveneObject = negfp_cargiverinterveneObject;
      resjson.jsondata.negab_abandonedObject = negab_abandonedObject;
      resjson.jsondata.unattendedChildObject = unattendedChildObject;
      resjson.jsondata.riskofHarmObject = riskofHarmObject;
      resjson.jsondata.negmn_unreasonabledelayObject = negmn_unreasonabledelayObject;
      resjson.jsondata.ismenng_psycologicalabilityObject = ismenng_psycologicalabilityObject;
      resjson.jsondata.overallperson = overallperson;
      resjson.jsondata.screeningDecision = screeningDesc;
      resjson.jsondata.incidentlocation = incidentlocation;
      const sanatizedAddendumNarrativeData = clearHtmlSpaces(resjson?.jsondata?.General?.addendumNarrative);
      resjson.jsondata.General = resjson.jsondata.General || {};
      resjson.jsondata.General.addendumNarrative = util.nullcheck(sanatizedAddendumNarrativeData);


      Response = module.exports.generatepdf(request,html,resjson.jsondata,{
        type: 'report',
        res: response
      });
      return Response;
    })
  })
    .catch(err => {
        LOGGER.error(err);
        return err;
    })
};
function supervisorapprovaldetailfn(supervisorApprovalDetail,resjson) {
  // Fallback to a default object structure if resjson or resjson.jsondata is missing
  resjson = resjson || { jsondata: {} };
  resjson.jsondata = resjson.jsondata || {};
  if(supervisorApprovalDetail){
    var submissionhistory = formatsubmissoinhistory(supervisorApprovalDetail);
    
    resjson.jsondata.submissionhistory = submissionhistory;
    }
    return resjson;
}
function getIRResonforDelay(resjson) {
  let reasonfordelay = '';
  if (resjson?.jsondata?.DAType?.DATypeDetail.length > 0 && resjson?.jsondata?.DAType?.DATypeDetail[0].reason) {
    reasonfordelay = resjson?.jsondata?.DAType?.DATypeDetail[0].reason;
  }
  return reasonfordelay;
}

function formatsubmissoinhistory(submissionhistory){
  submissionhistory = submissionhistory.map(item => {
    item.date = util.formatDateAndTimeReport(util.nullcheck(item.date));
    item.dateupdated=formatapprovaldate(item.typedescription,item.dateupdated)
    item.intakerecommendation =formatdecision(item.intakerecommendation?.toLowerCase());
    item.supdecision =formatdecision(item.supdecision?.toLowerCase());
   return item;
  })
return submissionhistory;
}
function formatapprovaldate(status,dateupdated){
  if(status === 'Accepted' || status === 'Routed to Servicecase' || status === 'Closed' || status ==='Pending Approval' || status ==='In Progress'){
    return util.formatDateAndTimeReport(util.nullcheck(dateupdated));
  } else{
    return '';
  }
}
function formatdecision(screeningDecision){
  switch (screeningDecision) {
    case 'scrnin': screeningDecision = 'Screened In';
      break;
    case 'screenout': screeningDecision = 'Screened Out';
      break;
      case 'dontmetreq' : screeningDecision = 'Need more Information'
    
  }
  return screeningDecision;
}
function getHeadofhouseelement(element,racelement,gender) {
  let headofhouseelement = '';
  const pscflag = `<input type="checkbox" ${checkboxCheck(element.probationsearchconductedflag)} disabled/>`;
  const sexoffenderflag = `<input type="checkbox" ${checkboxCheck(element.sexoffenderregisteredflag)} disabled/>`;
  const hispanicflag = `<input type="checkbox" ${checkboxCheck((element.Ethnicity === 'Hispanic or Latino') || (element.Ethnicity === 'Y'))} disabled/>`;
  const senflag = `<input type="checkbox" ${checkboxCheck(element.drugexposednewbornflag)} disabled/>`;
  const fasdflag = `<input type="checkbox" ${checkboxCheck(element.fetalalcoholspctrmdisordflag)} disabled/>`;
  headofhouseelement += ` 
                            <div class="row">
                                <div class="col-xs-3 section-lable text-right">
                                    Name :
                                </div>
                                <div class="col-xs-3 section-value text-left">
                                `+ util.nullcheck(element.fullName) + `
                                </div>
                                <div class="col-xs-3 section-lable text-right">
                                    CJAMS ID :
                                </div>
                                <div class="col-xs-3 section-value text-left">
                                ` + util.nullcheck(element.cjamspid) + `
                                </div>
                                
                            </div>
                            <div class="row">
                                <div class="col-xs-3 section-lable text-right">
                                    Alias name if any :
                                </div>
                                <div class="col-xs-3 section-value text-left">
                                ` + util.nullcheck(element.aliasname) + `
                                </div>
                                <div class="col-xs-3 section-lable text-right">
                                    Client ID :
                                </div>
                                <div class="col-xs-3 section-value text-left">
                                    
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-3 section-lable text-right">
                                    DOB :
                                </div>
                                <div class="col-xs-3 section-value text-left">
                                ` + util.formatDate(element.Dob) + `
                                </div>
                                <div class="col-xs-3 section-lable text-right">
                                    Marital Status :
                                </div>
                                <div class="col-xs-3 section-value text-left">
                                ` + util.nullcheck(element.maritalstatus) + `
                                </div>

                            </div>
                            <div class="row">
                            <div class="col-xs-3 section-lable text-right">
                                    Race:
                                </div>
                                <div class="col-xs-3 section-value text-left">
                                    ` + util.nullcheck(racelement.replace(/,\s*$/,"")) + `
                                </div>
                                <div class="col-xs-3 section-lable text-right">
                                    Gender :
                                </div>
                                <div class="col-xs-3 section-value text-left">
                                ` + util.nullcheck(gender) + `
                                </div>
                            </div>
                            
                            `;
  if (element.isheadofhousehold === true) {
    headofhouseelement += ` 
                              <div class="row">
                                  <div class="col-xs-3 section-lable text-right">
                                      SSN Provided :
                                  </div>
                                  <div class="col-xs-3 section-value text-left">
                                  ` + (util.nullcheck(element.ssn) == '' ? 'No' : 'Yes') + `
                                  </div>
                              </div>
                              `;
  }
  headofhouseelement += ` 
                            <div class="row">
                                <div class="col-xs-12">
                                    <div class="mt-10 inline-b"><span class="pr-10 p-l-20">`+ pscflag + `</span><span class="section-lable">Judiciary Case Search</span></div>
                                    <div class="mt-10 inline-b"><span class="pr-10 p-l-20">`+ sexoffenderflag + `</span><span class="section-lable">Sex Offender Registry Checked</span></div>
                                    <div class="mt-10 inline-b"><span class="pr-10 p-l-20">`+ hispanicflag + `</span><span class="section-lable">Hispanic</span></div>
                                    <div class="mt-10 inline-b"><span class="pr-10 p-l-20">`+ senflag + `</span><span class="section-lable">Substance Exposed Newborn</span></div>
                                    <div class="mt-10 inline-b"><span class="pr-10 p-l-20">`+ fasdflag + `</span><span class="section-lable">Fetal Alcohol Spectrum Disorder</span></div>
                                </div>
                            </div>
                        `;

  return headofhouseelement;
}

function getIRPhoneDetails(element) {
  let phonedetailsval = '';
  var emailtr = '';
  var email = '';
  if (Array.isArray(element.emaildetails)) {

    element.emaildetails.forEach((item) => {
      email += `<li>` + item.email.toString() + `</li>`;
      emailtr += (item.enddate) ? '' : `<tr><td>Email</td><td>` + item.email.toString() + `</td><td>` + util.formatDate(item.startdate) + `</td></tr>`;
    });
  }

  if (Array.isArray(element.phonedetails)) {

    const contacttr = getIRPhoneEle(element);
    if (contacttr !== '' || emailtr !== '') {
      phonedetailsval += `<div>
      <div class="mt-20">
    <table class="table-theme table-bordered">
      <thead>
        <tr>
          <th>Contact Type</th>
          <th>Contact Details </th>
          <th>Start Date</th>
        </tr>
      </thead>
      <tbody>
         ${contacttr}${emailtr}
        </tbody>
    </table></div>`
    } else {
      phonedetailsval = `<div class="pt-5 text-center">CONTACT INFORMATION WAS NOT PROVIDED</div>`;
    }
  }
  else {
    phonedetailsval = `<div class="pt-5 text-center">CONTACT INFORMATION WAS NOT PROVIDED</div>`;
  }
  return {
    phonedetailsval,
    email
  };
}

function getIRPhoneEle(element) {
  var hmephnumber = '';
  var callnumber = '';
  var worknumber = '';
  var ext = '';
  var ispresent = false;
  var contacttr = '';
  element.phonedetails.forEach((phoneelm) => {
    switch (phoneelm.personphonetypekey) {
      case 'HM':
        hmephnumber += `<li>` + phoneelm.phonenumber.toString() + `</li>`;
        ispresent = true;
        contacttr += (phoneelm.enddate) ? '' : `<tr><td>Home</td><td>` + phoneelm.phonenumber.toString() + `</td><td>` + util.formatDate(phoneelm.startdate) + `</td></tr>`;
        break;
      case 'CL':
        callnumber += `<li>` + phoneelm.phonenumber.toString() + `</li>`;
        if (phoneelm.phoneextension) {
          ext += `<li>` + phoneelm.phoneextension.toString() + `</li>`;
          contacttr += (phoneelm.enddate) ? '' : `<tr><td>Cell</td><td>` + phoneelm.phoneextension.toString() + ` ` + phoneelm.phonenumber.toString() + `</td><td>` + util.formatDate(phoneelm.startdate) + `</td></tr>`;
        } else {
          contacttr += (phoneelm.enddate) ? '' : `<tr><td>Cell</td><td>` + phoneelm.phonenumber.toString() + `</td><td>` + util.formatDate(phoneelm.startdate) + `</td></tr>`;
        }
        ispresent = true;
        break;
      case 'WK':
        worknumber += `<li>` + phoneelm.phonenumber.toString() + `</li>`;
        contacttr += (phoneelm.enddate) ? '' : `<tr><td>Work</td><td>` + phoneelm.phonenumber.toString() + `</td><td>` + util.formatDate(phoneelm.startdate) + `</td></tr>`;
        ispresent = true;
        break;
    }
    LOGGER.debug(ispresent);

  });
  return contacttr;
}

function getIRAddressDetails(element){
  let addresselement= '';
  let schoolelment= '';
  if (Array.isArray(element.addressinfo)) {
    var addresstd = '';
    element.addressinfo.forEach(addresselm => {
      const iscurrentlocation = checkboxCheck(addresselm.currentlocationflag == 1);
      const fulladdress = util.nullcheck(addresselm.address) + ' ' + util.nullcheck(addresselm.address2) + ' ' + util.nullcheck(addresselm.city) + ' ' + util.nullcheck(addresselm.county_desc) + ' ' + util.nullcheck(addresselm.state) + ' ' + util.nullcheck(addresselm.zipcode);
      addresstd += (addresselm.personadrenddate) ? '' :
        '<tr><td>' + util.nullcheck(addresselm.addresstype) + '</td><td>' + util.nullcheck(fulladdress) + '</td>' + '<td>' + inputChecboxTag + iscurrentlocation + ' disabled>' + '</td><td>' +
        inputChecboxTag + iscurrentlocation + ' disabled>' + '</td><td>' + util.nullcheck(util.formatDate(addresselm.addressstartdate)) + tdclosetags;
    });
    if (addresstd !== '') {
      addresselement = `<div class="section-header mt-20">ADDRESS AND CONTACT INFORMATION</div>
<div class="clearfix">
<table class="table-theme table-bordered">
<thead>
  <tr>
    <th>Address Type</th>
    <th>Address </th>
    <th>Current Location</th>
    <th>Default Location</th>
    <th>Start Date</th>
  </tr>
</thead>
<tbody>`+ addresstd + `</tbody>
</table></div>`;
    } else {
      addresselement = `
<div class="section-header mt-20">ADDRESS AND CONTACT INFORMATION</div>
<div class="clearfix">    
<div class="text-center">ADDRESS INFORMATION WAS NOT PROVIDED</div></div>`;
    }
  }
  else {
    addresselement = `
<div class="section-header mt-20">ADDRESS AND CONTACT INFORMATION</div>
<div class="clearfix">    
<div class="text-center">ADDRESS INFORMATION WAS NOT PROVIDED</div>
</div>
`;
  }

  if (Array.isArray(element.schoolname)) {
    schoolelment += `<div class="clearfix">
<table class="table-theme table-bordered mt-20 mb-10">
<thead>
  <tr>
    <th>School Name</th>
    <th>Address </th>
    <th>Contact Info</th>
  </tr>
</thead>
<tbody>
`;
    element.schoolname.forEach(school => {
      schoolelment += `
<tr>                                
    <td>`+ util.nullcheck(school.educationname) + `</td>
    <td>`+ util.nullcheck(school.adresscountydesc) + ' ' + util.nullcheck(school.adrcityname) + ' ' + util.nullcheck(school.statecode) + `</td>
    <td>`+ util.nullcheck(school.adrworkphone) + `</td>
</tr>`
    });
    schoolelment += `</tbody></table></div>`;
  }
  return {addresselement, schoolelment}
}

function getIRphysicalAbuses(sdm, refetypeval) {
  var physicalAbuse;
  var physicalAbuseObject = [];
  let brtag = '';
  if (sdm.physicalAbuse) {
      physicalAbuse = sdm.physicalAbuse;
      Object.keys(physicalAbuse).forEach(key => {
          if (physicalAbuse[key] === true) {
              brtag = (physicalAbuseObject.length != 0) ? '<br>' : '';
              physicalAbuseObject.push(brtag + refetypeval[key]);
          }
      });
      physicalAbuseObject = physicalAbuseObject.toString();
  }
  return physicalAbuseObject;
}

function getIRsexualAbuse(sdm, refetypeval){
  var sexualAbuse;
  var sexualAbuseObject = [];
  let brtag = '';
  if (sdm.sexualAbuse) {
      sexualAbuse = sdm.sexualAbuse;
      Object.keys(sexualAbuse).forEach(key => {
          if (sexualAbuse[key] === true) {
              brtag = (sexualAbuseObject.length != 0) ? '<br>' : '';
              sexualAbuseObject.push(brtag + refetypeval[key]);
          }
      });
      sexualAbuseObject = sexualAbuseObject.toString();
  }
  return sexualAbuseObject;
}

function getIRgenralNeglect(sdm,refetypeval) {
  let generalNeglect;
  let generalNeglectObject = [];
  let brtag = '';
  if (sdm.generalNeglect) {
      generalNeglect = sdm.generalNeglect;
      Object.keys(generalNeglect).forEach(key => {
          if (generalNeglect[key] === true) {
              if (generalNeglectObject.length != 0) {
                  brtag = '<br>';
              }
              else { brtag = '' }
              generalNeglectObject.push(brtag + refetypeval[key]);
          }
      });
  }
  const arGeneralNeglectObject = getIRargenralNeglect(sdm,refetypeval);
generalNeglectObject = generalNeglectObject.concat(arGeneralNeglectObject);      
        generalNeglectObject = generalNeglectObject.toString();
        return generalNeglectObject;
}

function getIRargenralNeglect(sdm,refetypeval){
  let arGeneralNeglect;
  const generalNeglectObject = [];
  let brtag = '';
  if (sdm.arGeneralNeglect) {
      arGeneralNeglect = sdm.arGeneralNeglect;
      Object.keys(arGeneralNeglect).forEach(key => {
        if (arGeneralNeglect[key] === true) {
          if (generalNeglectObject.length != 0) {
            brtag = '<br>';
          }
          else { brtag = '' }
          generalNeglectObject.push(brtag + refetypeval[key]);
        }
      });
    }
    return generalNeglectObject;
}

function getIRunattendedChild(sdm,refetypeval) {
  let unattendedChild;
  let unattendedChildObject = [];
  let brtag = '';
  if (sdm.unattendedChild) {
      unattendedChild = sdm.unattendedChild;
      Object.keys(unattendedChild).forEach(key => {
          if (unattendedChild[key] === true) {
              if (unattendedChildObject.length != 0) {
                  brtag = '<br>';
              }
              else { brtag = '' }
              unattendedChildObject.push(brtag + refetypeval[key]);
          }
      });
      unattendedChildObject = unattendedChildObject.toString();
  }
  return unattendedChildObject;
}

function getIRriskofHarm(sdm,refetypeval) {
  let riskofHarm;
  let riskofHarmObject = [];
  let brtag = '';
  if (sdm.riskofHarm) {
      riskofHarm = sdm.riskofHarm;
      Object.keys(riskofHarm).forEach(key => {
          if (riskofHarm[key] === true) {
              if (riskofHarmObject.length != 0) {
                  brtag = '<br>';
              }
              else { brtag = '' }
              riskofHarmObject.push(brtag + refetypeval[key]);
          }
      });
      riskofHarmObject = riskofHarmObject.toString();
  }
  return riskofHarmObject;
}

function getIRtypeOfMaltreatment(sdm) {
  let typeOfMaltreatment = [];
  if (sdm.ismalpa_suspeciousdeath || sdm.ismalpa_nonaccident
      || sdm.ismalpa_injuryinconsistent || sdm.ismalpa_insjury
      || sdm.ismalpa_childtoxic || sdm.ismalpa_caregiver || sdm.ismalpa_labortrafficking) {
      typeOfMaltreatment.push('Physical Abuse');
  }
  if (sdm.ismalsa_sexualmolestation || sdm.ismalsa_sexualact
      || sdm.ismalsa_sexualexploitation || sdm.ismalsa_physicalindicators
      || sdm.ismalsa_sex_trafficking) {
      typeOfMaltreatment.push('Sexual Abuse');
  }
  if (sdm.isneggn_suspiciousdeath || sdm.isneggn_signsordiagnosis
      || sdm.isneggn_inadequatefood || sdm.isneggn_childdischarged
      || sdm.isneggn_exposuretounsafe || sdm.isneggn_inadequateclothing
      || sdm.isneggn_inadequatesupervision || sdm.isnegrh_treatmenthealthrisk) {
      typeOfMaltreatment.push('General Neglect');
  }
  if (sdm.isnegfp_cargiverintervene || sdm.negfp_cargiverintervene) {
      typeOfMaltreatment.push('Failure to Protect');
  }
  if (sdm.isnegab_abandoned || sdm.negab_abandoned) {
      typeOfMaltreatment.push('Abandonment');
  }
  if (sdm.isneguc_leftunsupervised || sdm.isneguc_leftaloneinappropriatecare
      || sdm.isneguc_leftalonewithoutsupport) {
      typeOfMaltreatment.push('Unattended Child');
  }
  if (sdm.isnegmn_unreasonabledelay) {
      typeOfMaltreatment.push('Medical Neglect');
  }
  if (sdm.ismenab_psycologicalability || sdm.ismenng_psycologicalability) {
      typeOfMaltreatment.push('Mental Injury');
  }
  typeOfMaltreatment = checkIRRiskofharm(sdm,typeOfMaltreatment);
  typeOfMaltreatment = typeOfMaltreatment.toString();
  return typeOfMaltreatment;
}

function getIRRefetypeDetails(sdm, refetypeval){
  let negfp_cargiverinterveneObject = [];
  if (sdm.isnegfp_cargiverintervene || sdm.negfp_cargiverintervene) {
    negfp_cargiverinterveneObject = refetypeval['negfp_cargiverintervene'];
  }
  
  let negab_abandonedObject = [];
  if (sdm.isnegab_abandoned || sdm.negab_abandoned) {
    negab_abandonedObject = refetypeval['negab_abandoned'];
  }

  let negmn_unreasonabledelayObject = [];
  if (sdm.isnegmn_unreasonabledelay) {
    negmn_unreasonabledelayObject = refetypeval['isnegmn_unreasonabledelay'];
  }

  var ismenab_psycologicalabilityObject = [];
  if (sdm.ismenab_psycologicalability) {
    //   ismenab_psycologicalability = sdm.ismenab_psycologicalability;
    // Object.keys(ismenab_psycologicalability).forEach(key => {
    //   if (ismenab_psycologicalability[key] === true) {
    //     if(ismenab_psycologicalabilityObject.length !=0)
    //     {
    //       brtag = '<br>';
    //     }
    //     else{brtag= ''}
    ismenab_psycologicalabilityObject = refetypeval['ismenab_psycologicalability'];
    //   }
    // });
    // ismenab_psycologicalabilityObject = ismenab_psycologicalabilityObject.toString();
  }

  var ismenng_psycologicalabilityObject = [];
  if (sdm.ismenng_psycologicalability) {
    //   ismenng_psycologicalability = sdm.ismenng_psycologicalability;
    // Object.keys(ismenng_psycologicalability).forEach(key => {
    //   if (ismenng_psycologicalability[key] === true) {
    //     if(ismenng_psycologicalabilityObject.length !=0)
    //     {
    //       brtag = '<br>';
    //     }
    //     else{brtag= ''}
    ismenng_psycologicalabilityObject = refetypeval['ismenng_psycologicalability'];
    //   }
    // });
    // ismenng_psycologicalabilityObject = ismenng_psycologicalabilityObject.toString();
  }

  var screeningDesc = refetypeval[sdm.screeningRecommend];

  var scnRecommendOveride = '';
  if (sdm.scnRecommendOveride != '') {
    scnRecommendOveride = refetypeval[sdm.scnRecommendOveride];
  }
  else {
    scnRecommendOveride = 'No overrides apply';
  }
  return {
      negfp_cargiverinterveneObject,
      negab_abandonedObject,
      negmn_unreasonabledelayObject,
      ismenab_psycologicalabilityObject,
      ismenng_psycologicalabilityObject,
      screeningDesc,
      scnRecommendOveride
  }
}

function checkIRRiskofharm(sdm,typeOfMaltreatment) {
  if (sdm.isnegrh_priordeath || sdm.isnegrh_exposednewborn
      || sdm.isnegrh_basicneedsunmet || sdm.isnegrh_sex_offender
      || sdm.isnegrh_risk_dv || sdm.isnegrh_fatality_can
      || sdm.isnegrh_indicated_unsub || sdm.isnegrh_survivor
      || sdm.isnegrh_birth_match || sdm.isnegrh_sex_trafficking) {
      typeOfMaltreatment.push('Risk of harm');
  }
  return typeOfMaltreatment;
}

function getIRHOH(resjson, persons) {
  var racelement = '';
  var phonedetailsval = '';
  var headofhouseelement = '';
  var addresselement = '';
  var schoolelment = '';
  var gender;
  var email = '';

  var participantelement = '';
  var participantnotinhhelement = '';
  var overallperson = '';

  const dispo = resjson.jsondata.disposition;
  var screeningDecision = (Array.isArray(dispo) && dispo.length) ? dispo[0].supDisposition : '';
  switch (screeningDecision) {
    case 'Scrnin': screeningDecision = 'Screen in';
      break;
    case 'ScreenOUT': screeningDecision = 'Screen out';
      break;
    default: 
    screeningDecision = '';
  }

  if (resjson.quickpersondetails && resjson.quickpersondetails.length > 0) {
      persons.push(resjson.quickpersondetails[0])
  }

  if (Array.isArray(persons)) {
      persons.forEach(element => {
          racelement = '';
          phonedetailsval = '';
          headofhouseelement = '';
          addresselement = '';
          schoolelment = '';
          if (Array.isArray(element.race)) {
              element.race.forEach((element2) => {
                  racelement += element2.value_text + ', ';
              });
          }

          gender = genderCheck(element.Gender)

          headofhouseelement += getHeadofhouseelement(element,racelement,gender);

          const contactDetails = getIRPhoneDetails(element);
          phonedetailsval += contactDetails.phonedetailsval;
          email = contactDetails.email;

          const addressDetails = getIRAddressDetails(element);
          addresselement = addressDetails.addresselement;
          schoolelment = addressDetails.schoolelment;

          var headerval = '';
          if (element.isheadofhousehold === true) {
              headerval = ``;
              overallperson += headerval + headofhouseelement + addresselement + schoolelment + phonedetailsval;
          } else if (element.ishouseholdmember === 1) {
              headerval = `<div class="section-header mt-20">PARTICIPANTS IN HOUSEHOLD</div>`;
              participantelement += headerval + headofhouseelement + addresselement + schoolelment + phonedetailsval;
          }
          else {
              headerval = `<div class="section-header mt-20">PARTICIPANTS NOT IN HOUSEHOLD</div>`;
              participantnotinhhelement += headerval + headofhouseelement + addresselement + schoolelment + phonedetailsval;
          }
      });
  }
  return {
      overallperson,
      participantelement,
      participantnotinhhelement,
      email,
      screeningDecision
  }
}

function getIRSdmData(sdm, refetypeval) {
  var typeOfMaltreatment = [];
  var immediateyesno;
  var sdmObject = [];
  
  let physicalAbuseObject = '';
  let sexualAbuseObject = '';
  let generalNeglectObject = '';
  let unattendedChildObject = '';
  let riskofHarmObject = '';

  let negfp_cargiverinterveneObject = '';
  let negab_abandonedObject = '';
  let negmn_unreasonabledelayObject = '';
  let ismenab_psycologicalabilityObject = '';
  let ismenng_psycologicalabilityObject = '';
  let screeningDesc = '';
  let scnRecommendOveride = '';

  if (sdm) {
      typeOfMaltreatment = getIRtypeOfMaltreatment(sdm);

      if (sdm.immediate === 'Immediate') {
          immediateyesno = refetypeval.isImmediateYes;
          var immediatelist = [];
          immediatelist = sdm.immediateList;
          Object.keys(immediatelist).forEach(key => {
              if (immediatelist[key] === true) {
                  sdmObject.push(refetypeval[key]);
              }
          });
          sdmObject = sdmObject.toString();
      }
      else if (sdm.immediate === 'No Immediate') {
          immediateyesno = refetypeval.isImmediateNo;
          sdmObject = returnSdmObjectFn(sdm, sdmObject, refetypeval);
      }
      physicalAbuseObject = getIRphysicalAbuses(sdm,refetypeval);
      sexualAbuseObject = getIRsexualAbuse(sdm,refetypeval);
      generalNeglectObject = getIRgenralNeglect(sdm,refetypeval);
      unattendedChildObject = getIRunattendedChild(sdm,refetypeval);
      riskofHarmObject = getIRriskofHarm(sdm,refetypeval);

      const referDetails = getIRRefetypeDetails(sdm,refetypeval);
      negfp_cargiverinterveneObject = referDetails.negfp_cargiverinterveneObject;
      negab_abandonedObject = referDetails.negab_abandonedObject;
      negmn_unreasonabledelayObject = referDetails.negmn_unreasonabledelayObject;
      ismenab_psycologicalabilityObject = referDetails.ismenab_psycologicalabilityObject;
      ismenng_psycologicalabilityObject = referDetails.ismenng_psycologicalabilityObject;
      screeningDesc = referDetails.screeningDesc;
      scnRecommendOveride = referDetails.scnRecommendOveride;
      //finalscreenin
  }
  return {
      typeOfMaltreatment,
      immediateyesno,
      physicalAbuseObject,
      sexualAbuseObject,
      generalNeglectObject,
      sdmObject,
      unattendedChildObject,
      riskofHarmObject,
      negfp_cargiverinterveneObject,
      negab_abandonedObject,
      negmn_unreasonabledelayObject,
      ismenab_psycologicalabilityObject,
      ismenng_psycologicalabilityObject,
      screeningDesc,
      scnRecommendOveride
     }
}

function returnSdmObjectFn(sdm, sdmObject, refetypeval) {
  var noImmediateList = [];
  if (sdm?.noImmediateList) {
    noImmediateList = sdm.noImmediateList;
    Object.keys(noImmediateList).forEach(key => {
      if (noImmediateList[key] === true) {
        sdmObject.push(refetypeval[key]);
      }
    });
    sdmObject = sdmObject.toString();
  }
  else {
    sdmObject = null;
  }
  return sdmObject;
}

function getIRServicetype(data,caseNumber) {
  let servicetype = null;
  if (data[0].jsondata.General?.iAndRsubtype && data[0].jsondata.General?.iAndRsubtype !== '' && caseNumber) {
      const iAndRsubtype = data[0].jsondata.General.iAndRsubtype;
      servicetype = `I&R ${iAndRsubtype.charAt(0).toUpperCase() + iAndRsubtype.slice(1)}`;
  } else if (data[0].jsondata.General?.intakeservice && data[0].jsondata.General?.intakeservice[0]?.description && data[0].jsondata.General?.intakeservice[0]?.description !== '' && caseNumber) {
      const iAndRsubtype = data[0].jsondata.General.intakeservice[0].description;
      servicetype = iAndRsubtype;
  } else if (data[0].jsondata.sdm?.isar && caseNumber) {
      servicetype = 'CPS-AR';

  }
  else if (data[0].jsondata.sdm?.isir && caseNumber) {
      servicetype = 'CPS-IR';
  }
  return servicetype
}

function getIROtherParticpate(persons){
  var gender;
  var rolelement = '';
  let personelement = '';
  let notinhhelement = '';
  let racelement;

  if (Array.isArray(persons)) {
    persons.forEach(element => {

      if (element.isheadofhousehold == undefined && (element.ishouseholdmember == '' || element.ishouseholdmember == undefined)) {
        element.isheadofhousehold = false;
      } else {
        element = checkIRotherPartData(element);
        gender = genderCheck(element.Gender);

        const rEle = checkRoleEle(element);
        rolelement = rEle.rolelement;
        racelement = rEle.racelement;
        
        if (element.ishouseholdmember == 1) {
          personelement += '<tr><td>' + util.nullcheck(element.fullName) + '</td><td>' + util.nullcheck(racelement.replace(/,\s*$/,"")) + '</td><td>' +
            util.formatDate(element.Dob) + '</td><td>' + util.nullcheck(gender) + '</td><td>' + util.nullcheck(rolelement.replace(/,\s*$/,"")) + tdclosetags;
        } else {
          notinhhelement += '<tr><td>' + util.nullcheck(element.fullName) + '</td><td>' + util.nullcheck(racelement.replace(/,\s*$/,"")) + '</td><td>' +
            util.formatDate(element.Dob) + '</td><td>' + util.nullcheck(gender) + '</td><td>' + util.nullcheck(rolelement.replace(/,\s*$/,"")) + tdclosetags;
        }
      }
    });
  }
  return {
    personelement,
    notinhhelement,
    racelement
  }
}

function checkRoleEle(element){
  let rolelement = '';
        element.personRole.forEach((element1) => {
          rolelement += element1.description + ', ';
        });

        let racelement = '';
        if (Array.isArray(element.race)) {
          element.race.forEach((element2) => {
            racelement += element2.value_text + ', ';
          });
          if (element.quickpersonroleconfig && element.quickpersonroleconfig.length > 0) {
            element.quickpersonroleconfig.forEach((element3) => {
              rolelement += element3.description + ', ';
            });
          }
        }
        return {rolelement, racelement}
}

function checkIRotherPartData(element){
  if (element.Gender == undefined) {
    element.Gender = element.gendertypekey;
  }
  if (element.Dob == undefined) {
    element.Dob = element.dob;
  }
  if (element.fullName == undefined) {
    element.fullName = element.fullname;
  }
  if (element.personRole == undefined) {
    element.personRole = [];
  }
  if (element.race == undefined) {
    element.race = [];
  }
  if (element.ishouseholdmember == undefined) {
    element.ishouseholdmember = 1;
  }
  return element;
}

function filterIRRouterapproval(resjson) {
  var routeapprovals = Array.isArray(resjson.approvalinfo) ? resjson.approvalinfo : [];
  routeapprovals = routeapprovals.filter(item => {
      if (['Intake Worker','Supervisor', 'Case Worker'].includes(item.fromrole) && ['Intake Worker','Supervisor', 'Case Worker'].includes(item.torole)) { //CIDM-8864 - Include case worker data also in report
          item.routedon = util.formatDateAndTimeReport(util.nullcheck(item.routedon));
          item.updatedon = util.formatDateAndTimeReport(util.nullcheck(item.updatedon));
          return true;
      }
      return false;
  });
  return routeapprovals;
}


function quickCardPersonsDetails(quickpersondetails,type)  {

  let quickPersonCardHtml = '';

  if (quickpersondetails === null || quickpersondetails === undefined || quickpersondetails.length === 0) {
    return quickPersonCardHtml;
  }

  const header = 'Quick Add Person';
  let content = '';

  const fieldsObjectArray = [
    {
      fieldName: "firstname",
      displayName: "First Name :",
      type: "string"
    },
    {
      fieldName: "lastname",
      displayName: "Last Name :",
      type: "string"
    },
    {
      fieldName: "dob",
      displayName: "Date of Birth :",
      type: "date"
    },
    {
      fieldName: "genderdescription",
      displayName: "Gender :",
      type: "string"
    },
    {
      fieldName: "description",
      displayName: "Role :",
      type: "string"
    }
  ];

  quickpersondetails.forEach((element,recCount) => {

    if (recCount > 0) {
      content += '<hr>';
    }
    content += checkfieldsObjectArray(fieldsObjectArray,element,type);
    content += `</div>`;
  });

  if (type === 'cps') {
    quickPersonCardHtml =
      `
      <div class="personsdiv">
          <div class="gray-bg clearfix">
              <div class="row">
                  <div class="col-xs-12"><h4 class="text-center">${header}</h4></div>
              </div>
          </div>
          ${content}
      </div>
      `
  } else if (type === 'intake') {
    quickPersonCardHtml =
      `
        <div class="section-header mt-20">${header}</div>
        ${content}
        `
  }
  return quickPersonCardHtml;
}

function checkfieldsObjectArray(fieldsObjectArray, element, type){
  let filedName = '';
    let filedKey = '';
    let value = '';
    let fieldType = ''
    let index = 0;
    let content = '';
    fieldsObjectArray.forEach((fieldsObject) => {
        
        filedKey = fieldsObject['fieldName'];
        filedName = fieldsObject['displayName'];
        fieldType = fieldsObject['type'];
        
        if(fieldType === 'date' && element[filedKey]){
            value = util.formatDate(util.nullcheck(element[filedKey]).toLocaleString());
        }
        else if(filedKey === 'description'){
          let rolevalue = '';
           element.quickpersonroleconfig.forEach((obj) => {
            rolevalue += obj.description + ', ';
           })
            
           value = rolevalue
        }else {
            value = util.nullcheck(element[filedKey]);
        }
            
        if(index % 2 === 0){
            if(index > 0){
              content +=`</div>`;                
            }
            content +=`<div class="row">`;
        }

        if(type === 'intake'){
          content += 
              `<div class="col-xs-3 section-lable text-right">${filedName}</div>
              <div class="col-xs-3 section-value text-left">${value}</div>`
      }else if(type === 'cps'){
          content += 
              `<div class="col-xs-3 l"><label>${filedName}</label> </div>
              <div class="col-xs-3 l"><span> ${value}</span></div>`
      } 
      index++;
    });
    return content;
}

module.exports.assessment = function (request,response) {
  let Response;
  return new Promise((resolve,reject) => {
    var html = ''
    html = fs.readFileSync('./documenttemplates/assessment.html','utf8');

    var assessmenttable;
    if (request.where.assessment.description === 'SAFE-C OHP') {

      assessmenttable = `<table class="table-bordered">                
			<thead>
				<tr>
					<th>CHILD’S CLIENT ID</th>
					<th>ASSESSMENTS</th>
					<th>DATE ASSESSMENT INITIATED</th>
					<th>CHILD'S NAME</th>
					<th>PLACEMENT</th>
					<th>ASSESSMENT COMPLETION DATE</th>
					<th>DECISION</th>
					<th>UPDATED DATE</th>
					<th>STATUS</th>
				</tr>
			</thead>`;

      assessmenttable += intakassessmentView(request);
      assessmenttable += `</table>`;
    } else if(request.where.assessment.description === 'Quick Youth Indicators for Trafficking (QYIT)') {
      assessmenttable = `<table class="table-bordered" style="width: 100%">                
			<thead>
				<tr>
					<th>CPS ID/CASE ID</th>
					<th>ASSESSMENTS</th>
          <th>CHILD'S NAME</th>
					<th>UPDATED BY</th>
					<th>UPDATED DATE</th>
					<th>STATUS</th>
				</tr>
			</thead>`;

      request.where.assessment.intakassessment.forEach(intakassessmentinfo => {
        var assessmentstatustypekey = intakassessmentinfo.assessmentstatustypekey;
        if (intakassessmentinfo.assessmentstatustypekey == 'InProcess') {
          assessmentstatustypekey = 'In Draft';
        }
        if (intakassessmentinfo.assessmentstatustypekey == 'Review') {
          assessmentstatustypekey = 'In Progress';
        }

        assessmenttable += `
				  <tr>                                
					  <td>`+ util.nullcheck(intakassessmentinfo.servicerequestnumber) + `</td>
					  <td>`+ util.nullcheck(intakassessmentinfo.titleheadertext) + `</td>
            <td>`+ util.nullcheck(intakassessmentinfo.submissiondata.childname) + `</td>
					  <td>`+ util.nullcheck(intakassessmentinfo.username) + `</td>
					  <td>`+ util.nullcheck(intakassessmentinfo.updateddate) + `</td>
					  <td>`+ util.nullcheck(assessmentstatustypekey) + `</td>
				  </tr>`
      });
      assessmenttable += `</table>`;
    }
    else {
      assessmenttable = `<table class="table-bordered" style="width: 100%">                
			<thead>
				<tr>
					<th>CPS ID/CASE ID</th>
					<th>ASSESSMENTS</th>
					<th>UPDATED BY</th>
					<th>UPDATED DATE</th>
					<th>STATUS</th>
				</tr>
			</thead>`;

      request.where.assessment.intakassessment.forEach(intakassessmentinfo => {
        var assessmentstatustypekey = intakassessmentinfo.assessmentstatustypekey;
        if (intakassessmentinfo.assessmentstatustypekey == 'InProcess') {
          assessmentstatustypekey = 'In Draft';
        }
        if (intakassessmentinfo.assessmentstatustypekey == 'Review') {
          assessmentstatustypekey = 'In Progress';
        }

        assessmenttable += `
				  <tr>                                
					  <td>`+ util.nullcheck(intakassessmentinfo.servicerequestnumber) + `</td>
					  <td>`+ util.nullcheck(intakassessmentinfo.titleheadertext) + `</td>
					  <td>`+ util.nullcheck(intakassessmentinfo.username) + `</td>
					  <td>`+ util.nullcheck(intakassessmentinfo.updateddate) + `</td>
					  <td>`+ util.nullcheck(assessmentstatustypekey) + `</td>
				  </tr>`
      });
      assessmenttable += `</table>`;
    }


    LOGGER.debug(app.baseurl + baseurllogstmt);
    html = html.replace(logopath,app.baseurl);
    html = html.replace(/{{assessmenttable}}/g,util.nullcheck(assessmenttable));
    html = html.replace(/{{description}}/g,util.nullcheck(request.where.assessment.description));
    request.where.assessment.intakenumber = request.where.intakenumber;
    request.where.assessment.landscape = 'Landscape';
    request.where.outputfilename = "assessment";


    Response = module.exports.generatepdf(request,html,request.where.assessment,{
      type: 'report',
      res: response
    });
    resolve(Response);

  })

};

function intakassessmentView(request) {
  let assessmenttable = '';
  request.where.assessment.intakassessment.forEach(intakassessmentinfo => {
    var assessmentstatustypekey = intakassessmentinfo.assessmentstatustypekey;
    switch (intakassessmentinfo.assessmentstatustypekey) {
      case 'InProcess':
        assessmentstatustypekey = 'In Draft';
        break;
      case 'Review':
        assessmentstatustypekey = 'In Progress';
        break;
    }

    assessmenttable += `
			<tr>                                
				<td>`+ util.nullcheck(intakassessmentinfo.submissiondata ? intakassessmentinfo.submissiondata.clientid : '') + `</td>
				<td>`+ util.nullcheck(intakassessmentinfo.titleheadertext) + `</td>
				<td>`+ util.nullcheck(intakassessmentinfo.submissiondata ? intakassessmentinfo.submissiondata.dateassessmentinitiated : '') + `</td>
				<td>`+ util.nullcheck(intakassessmentinfo.submissiondata ? intakassessmentinfo.submissiondata.ClientName : '') + `</td>
				<td>`+ util.nullcheck(intakassessmentinfo.submissiondata ? intakassessmentinfo.submissiondata.placementlivingarrangement : '') + `</td>
				<td>`+ util.nullcheck(intakassessmentinfo.submissiondata ? intakassessmentinfo.submissiondata.safetyassessmentcompletiondate : '') + `</td>
				<td>`+ util.nullcheck(intakassessmentinfo.panel45537735365179954RadioField === 'safetydecision1' ? 'Safe' : 'Unsafe') + `</td>
				<td>`+ util.nullcheck(intakassessmentinfo.updateddate) + `</td>
				<td>`+ util.nullcheck(assessmentstatustypekey) + `</td>
			</tr>`
  });
  return assessmenttable;
}

module.exports.gapAgreementPDF = function (request) {
  var documntkey = request.documntkey[0];
  var reqjson = {};
  const responseval = [];
  var Response;
  var reqobj = {
    where: {
      intakenumber: request.where.da_intakenumber,
      intakeserviceid: (request.where.dsdsActionsSummary ? request.where.dsdsActionsSummary.intakeserviceid : null),
      outputfilename: ''
    },
    documntkey: documntkey
  };

  var permanencyplanid = nullCheck(request.where.permanencyplanid_details);
  var objectid = nullCheck(request.where.objectid);
  var objecttype = request.where.objecttype ? request.where.objecttype : '';
  var gapid = nullCheck(request.where.gapid);
  var providerid = nullCheck(request.where.providerid);
  var sql = 'select * from getguardianship($1,$2,$3)';
  var sql3 = 'select * from getadoptiveparents($1)';
  return util.executeDBQuery(sql,[permanencyplanid,objectid,objecttype])
    .then(data => {
      return data;
    })
    .then(data => {
      responseval.tab1 = nullCheck(data[0]);
      const sql2 = 'select * from getgapagreementlist($1, $2, $3, $4, $5)';
      const sql6 = 'select * from getannualreview($1, $2, $3)';
      if (data.length > 0) {
        gapid = nullCheck(responseval.tab1.gapid);
        providerid = nullCheck(responseval.tab1.guardianoneproviderid);
      }
      if (documntkey == 'gapagreementreview') {
        return util.executeDBQuery(sql6,[gapid,objectid,objecttype])
          .then(_data => {
            responseval.tab6 = _data;
            return _data;
          })
          .catch(err => {
            LOGGER.error(err);
            return err;
          })
      } else {
        return util.executeDBQuery(sql2,[gapid,1,10,objectid,objecttype])
          .then(_data => {
            responseval.tab2 = _data[0].getgapagreementlist ? _data[0].getgapagreementlist[0] : null;
            return _data;
          })
          .catch(err => {
            LOGGER.error(err);
            return err;
          })
      }

    }).then(data => {

      return util.executeDBQuery(sql3,[providerid])
        .then(_data => {
          LOGGER.info(_data);
          return _data;
        })
        .catch(err => {
          LOGGER.error(err);
          return err;
        })
    }).then(data => {
      responseval.tab3 = data ? data[0].getadoptiveparents[0] : null;

      if (data.length > 0) {
        LOGGER.debug("data.length- ",data.length);
        var html = '';

        var gac = gapagreementPDFCheck(html,reqjson,reqobj,responseval,request)
        reqobj = gac.reqobj;
        html = gac.html;
        reqjson = gac.reqjson;

        return new Promise((resolve,_reject) => {
          Response = module.exports.generatepdf(reqobj,html,reqjson);
          resolve(Response);
        });
      }

    }).then(_responseval => _responseval)
    .catch(err => {
      LOGGER.error(err);
      return err;
    })
};

function gapagreementPDFCheck(html,reqjson,reqobj,responseval,request) {
  var documntkey = request.documntkey[0];
  if (documntkey === 'gapagreement') {
    html = fs.readFileSync('./documenttemplates/gapagreement.html','utf8');
    reqobj.where.outputfilename = 'GAPAgreement';
    reqjson = gacga(responseval,reqjson);

  } else if (documntkey === 'gapagreementrate') {
    html = fs.readFileSync('./documenttemplates/gapagreementrate.html','utf8');
    reqobj.where.outputfilename = 'GAPAgreementRate';

    const rrates = nullCheck(responseval.tab2.agreementrate);
    var ratedetails = ``;
    for (let i in rrates) {
      ratedetails += `<tr>`;
      ratedetails += `<td>` + rrates[i].provider_id + `</td><td>`;
      ratedetails += dateCheck(rrates[i].ratestartdate) + `</td><td>`;
      ratedetails += dateCheck(rrates[i].rateenddate) + `</td><td>`;
      ratedetails += rrates[i].paymentamout + `</td><td>`;
      ratedetails += ((rrates[i].isoverride) ? 'Yes' : 'No');
      ratedetails += `</td><td>` + rrates[i].status + `</td> </tr>`;
    }
    const aprls = nullCheck(responseval.tab2.agreementrate);
    var approvals = ``;
    for (let i in aprls) {
      approvals += `<tr>`;
      approvals += `<td>` + aprls[i].approvedby + `</td><td>`;
      approvals += aprls[i].status + `</td><td>`;
      approvals += dateCheck(aprls[i].ssaapprovaldate) + `</td><td>`;
      approvals += aprls[i].requestedby + `</td><td>`;
      approvals += aprls[i].notes + `</td> </tr>`;
    }
    reqjson = {
      root_template_path_style: app.baseurl,
      root_template_path_image: app.baseurl,
      "clientname": util.nullcheck(responseval.tab1.childname),
      "cjamspid": util.nullcheck(responseval.tab1.cjamspid),
      "clientdob": dateCheck(responseval.tab1.dob),

      "clientgender": util.nullcheck(responseval.tab1.gender),
      "guardianonename": util.nullcheck(responseval.tab3.adoptiveparent1),
      "guardianoneprovid": util.nullcheck(responseval.tab3.providerid),
      "guardianonedob": dateCheck(responseval.tab3.adoptiveparent1dob),
      "guardianonessn": util.nullcheck(responseval.tab3.adoptiveparent1ssn),

      "guardiantwoname": util.nullcheck(responseval.tab3.adoptiveparent2),
      "guardiantwoprovid": util.nullcheck(responseval.tab3.provider_id),
      "guardiantwodob": dateCheck(responseval.tab3.adoptiveparent2dob),
      "guardiantwossn": util.nullcheck(responseval.tab3.adoptiveparent2ssn),

      "ratedetails": ratedetails,
      "approvals": approvals,
    }

  } else if (documntkey === 'gapagreementdc') {
    html = fs.readFileSync('./documenttemplates/gapagreementdc.html','utf8');
    reqobj.where.outputfilename = 'GAPAgreementDisclosureChecklist';
    reqjson = gacgapagreementdc(responseval,request,reqjson)

  } else if (documntkey === 'gapagreementcc') {
    html = fs.readFileSync('./documenttemplates/gapagreementcc.html','utf8');
    reqobj.where.outputfilename = 'GAPAgreementClosingChecklist';
    reqjson = gacgapagreementcc(responseval,request,reqjson);
  } else if (documntkey === 'gapagreementappl') {
    html = fs.readFileSync('./documenttemplates/gapagreementappl.html','utf8');
    reqobj.where.outputfilename = 'GAPAgreementApplication';
    reqjson = gacgapagreementappl(responseval,reqjson);
  } else if (documntkey === 'gapagreementreview') {
    html = fs.readFileSync('./documenttemplates/gapagreementreview.html','utf8');
    reqobj.where.outputfilename = 'GAPAgreementAnnualReviews';
    reqjson = gacgapagreementreview(responseval,reqjson);

  } else if (documntkey === 'gapagreementsuspend') {
    html = fs.readFileSync('./documenttemplates/gapagreementsuspend.html','utf8');
    reqobj.where.outputfilename = 'GAPAgreementSuspension';
    reqjson = gacgapagreementsuspend(responseval,reqjson);

  }
  return {
    html,
    reqjson,
    reqobj
  };
}

function gacgapagreementreview(responseval,reqjson) {
  const reviews = nullCheck(responseval.tab6);
  var reviewdetails = ``;
  for (var i in reviews) {
    reviewdetails += `<tr>`;
    reviewdetails += `<td>` + dateCheck(reviews[i].reviewdate) + `</td> `;
    reviewdetails += ` <td>` + reviews[i].status + `</td>  </tr>`;
  }

  if (responseval.tab6 !== null) {
    reqjson.ischildattendingschool = util.nullcheck(responseval.tab6.ischildattendingschool);
    reqjson.ischilddisability = util.nullcheck(responseval.tab6.ischilddisability);
    reqjson.ischildreacheighteen = util.nullcheck(responseval.tab6.ischildreacheighteen);
    reqjson.ischildwithguardian = util.nullcheck(responseval.tab6.ischildwithguardian);
    reqjson.isdocumentprovided = util.nullcheck(responseval.tab6.isdocumentprovided);
    reqjson.isformcomplete = util.nullcheck(responseval.tab6.isformcomplete);
    reqjson.isguardianresponsible = util.nullcheck(responseval.tab6.isguardianresponsible);
    reqjson.isguardiansupportfinance = util.nullcheck(responseval.tab6.isguardiansupportfinance);
    reqjson.ismanualentry = util.nullcheck(responseval.tab6.ismanualentry);
    reqjson.istrainingenrolled = util.nullcheck(responseval.tab6.istrainingenrolled);
    reqjson.isunemployment = util.nullcheck(responseval.tab6.isunemployment);

  }
  reqjson = {
    root_template_path_style: app.baseurl,
    root_template_path_image: app.baseurl,
    "clientname": util.nullcheck(responseval.tab1.childname),
    "cjamspid": util.nullcheck(responseval.tab1.cjamspid),
    "clientdob": dateCheck(responseval.tab1.dob),

    "clientgender": util.nullcheck(responseval.tab1.gender),
    "guardianonename": util.nullcheck(responseval.tab3.adoptiveparent1),
    "guardianoneprovid": util.nullcheck(responseval.tab3.providerid),
    "guardianonedob": dateCheck(responseval.tab3.adoptiveparent1dob),
    "guardianonessn": util.nullcheck(responseval.tab3.adoptiveparent1ssn),

    "guardiantwoname": util.nullcheck(responseval.tab3.adoptiveparent2),
    "guardiantwoprovid": util.nullcheck(responseval.tab3.provider_id),
    "guardiantwodob": dateCheck(responseval.tab3.adoptiveparent2dob),
    "guardiantwossn": util.nullcheck(responseval.tab3.adoptiveparent2ssn),

    "reviewdetails": reviewdetails,
  }
  return reqjson;
}

function gacgapagreementcc(responseval,request,reqjson) {
  var isservicelogsendate;
  var islaendate;
  isservicelogsendate = nullCheck(request.isservicelogsendate);
  islaendate = nullCheck(request.islaendate);

  if (responseval.tab2 !== null) {
    reqjson.iscomprehensivehomestudy = util.nullcheck(responseval.tab2.iscomprehensivehomestudy);
    reqjson.iscgawardedcustody = util.nullcheck(responseval.tab2.iscgawardedcustody);
    reqjson.isplacementenddate = util.nullcheck(responseval.tab2.isplacementenddate);
    reqjson.islaendate = islaendate;
    reqjson.isservicelogsendate = isservicelogsendate;
  }
  reqjson = {
    root_template_path_style: app.baseurl,
    root_template_path_image: app.baseurl,
    "clientname": util.nullcheck(responseval.tab1.childname),
    "cjamspid": util.nullcheck(responseval.tab1.cjamspid),
    "clientdob": dateCheck(responseval.tab1.dob),

    "clientgender": util.nullcheck(responseval.tab1.gender),
    "guardianonename": util.nullcheck(responseval.tab3.adoptiveparent1),
    "guardianoneprovid": util.nullcheck(responseval.tab3.providerid),
    "guardianonedob": dateCheck(responseval.tab3.adoptiveparent1dob),
    "guardianonessn": util.nullcheck(responseval.tab3.adoptiveparent1ssn),

    "guardiantwoname": util.nullcheck(responseval.tab3.adoptiveparent2),
    "guardiantwoprovid": util.nullcheck(responseval.tab3.provider_id),
    "guardiantwodob": dateCheck(responseval.tab3.adoptiveparent2dob),
    "guardiantwossn": util.nullcheck(responseval.tab3.adoptiveparent2ssn),
  }
  return reqjson;
}

function gacgapagreementdc(responseval,request,reqjson) {
  var strongattachmentsecondaryguardian = nullCheck(request.strongattachmentsecondaryguardian);
  var consultationguardianshiparrangement = nullCheck(request.consultationguardianshiparrangement);
  var strongattachmentprimaryguardian = nullCheck(request.strongattachmentprimaryguardian);

  if (responseval.tab1.gapdisclosure !== null) {
    reqjson.disclosuredate = dateCheck(responseval.tab1.gapdisclosure[0].insertdate);
    reqjson.dateofplanning = dateCheck(responseval.tab1.gapdisclosure[0].dateofplanning);
    reqjson.enteredby = responseval.tab1.gapdisclosure[0].requestedby;
    reqjson.successorguardianname = util.nullcheck(responseval.tab1.successorguardianname);
    reqjson.routingstatus = util.nullcheck(responseval.tab1.gapdisclosure[0].routingstatus);
    reqjson.requestedby = util.nullcheck(responseval.tab1.gapdisclosure[0].requestedby);
    reqjson.approvedby = util.nullcheck(responseval.tab1.gapdisclosure[0].approvedby);
    reqjson.insertdate = dateCheck(responseval.tab1.gapdisclosure[0].insertdate);

    reqjson.orientationmeetingdate = dateCheck(responseval.tab1.gapdisclosure[0].orientationmeetingdate);
    reqjson.isadoptionremoved = booleanCheck(responseval.tab1.gapdisclosure[0].isadoptionremoved);
    reqjson.iscgaftercareservice = booleanCheck(responseval.tab1.gapdisclosure[0].iscgaftercareservice);
    reqjson.iscgattendedorientation = booleanCheck(responseval.tab1.gapdisclosure[0].iscgattendedorientation);
    reqjson.iscgcompleteannualreview = booleanCheck(responseval.tab1.gapdisclosure[0].iscgcompleteannualreview);
    reqjson.iscgcompleteauthorization = booleanCheck(responseval.tab1.gapdisclosure[0].iscgcompleteauthorization)
    reqjson.iscgenteredagreement = booleanCheck(responseval.tab1.gapdisclosure[0].iscgenteredagreement);
    reqjson.iscgparticipategap = booleanCheck(responseval.tab1.gapdisclosure[0].iscgparticipategap);
    reqjson.iscgprovidesafe = booleanCheck(responseval.tab1.gapdisclosure[0].iscgprovidesafe);
    reqjson.ischildplacedsixmonths = booleanCheck(responseval.tab1.gapdisclosure[0].ischildplacedsixmonths);
    reqjson.isconsultationchildage = booleanCheck(responseval.tab1.gapdisclosure[0].isconsultationchildage);
    reqjson.iscourthearingcustody = booleanCheck(responseval.tab1.gapdisclosure[0].iscourthearingcustody);
    reqjson.isguardianattach = booleanCheck(responseval.tab1.gapdisclosure[0].isguardianattach);
    reqjson.isguardiantwoattach = booleanCheck(responseval.tab1.gapdisclosure[0].isguardiantwoattach);
    reqjson.isneedadditionalservices = booleanCheck(responseval.tab1.gapdisclosure[0].isneedadditionalservices);
    reqjson.isothergapfinsupport = booleanCheck(responseval.tab1.gapdisclosure[0].isothergapfinsupport);
    reqjson.isproviderapprovedgap = booleanCheck(responseval.tab1.gapdisclosure[0].isproviderapprovedgap);
    reqjson.isrequirementdiscussed = booleanCheck(responseval.tab1.gapdisclosure[0].isrequirementdiscussed);
    reqjson.isreunificationremoved = booleanCheck(responseval.tab1.gapdisclosure[0].isreunificationremoved);
    reqjson.issuccessorguardianexists = booleanCheck(responseval.tab1.gapdisclosure[0].issuccessorguardianexists);
    reqjson.strongattachmentsecondaryguardian = booleanCheck(strongattachmentsecondaryguardian) || 'NA';
    reqjson.issuspendedfromguardian = booleanCheck(responseval.tab1.gapdisclosure[0].issuspendedfromguardian);
    reqjson.consultationguardianshiparrangement = booleanCheck(consultationguardianshiparrangement) || 'NA';
    reqjson.strongattachmentprimaryguardian = booleanCheck(strongattachmentprimaryguardian) || 'NA';

  }

  reqjson = {
    root_template_path_style: app.baseurl,
    root_template_path_image: app.baseurl,
    "clientname": util.nullcheck(responseval.tab1.childname),
    "cjamspid": util.nullcheck(responseval.tab1.cjamspid),
    "clientdob": dateCheck(responseval.tab1.dob),

    "clientgender": util.nullcheck(responseval.tab1.gender),
    "guardianonename": util.nullcheck(responseval.tab3.adoptiveparent1),
    "guardianoneprovid": util.nullcheck(responseval.tab3.providerid),
    "guardianonedob": dateCheck(responseval.tab3.adoptiveparent1dob),
    "guardianonessn": util.nullcheck(responseval.tab3.adoptiveparent1ssn),

    "guardiantwoname": util.nullcheck(responseval.tab3.adoptiveparent2),
    "guardiantwoprovid": util.nullcheck(responseval.tab3.provider_id),
    "guardiantwodob": dateCheck(responseval.tab3.adoptiveparent2dob),
    "guardiantwossn": util.nullcheck(responseval.tab3.adoptiveparent2ssn),
  }
  return reqjson;
}

function gacgapagreementsuspend(responseval,reqjson) {
  if (responseval.tab1.gapsuspension != null) {
    reqjson.reason = util.nullcheck(responseval.tab1.gapsuspension[0].typedescription);
    reqjson.startdate = dateCheck(responseval.tab1.gapsuspension[0].startdate);
    reqjson.enddate = dateCheck(responseval.tab1.gapsuspension[0].enddate);
    reqjson.notes = util.nullcheck(responseval.tab1.gapsuspension[0].notes);
    reqjson.status = util.nullcheck(responseval.tab1.gapsuspension[0].routingstatus);
  }
  reqjson = {
    root_template_path_style: app.baseurl,
    root_template_path_image: app.baseurl,
    "clientname": util.nullcheck(responseval.tab1.childname),
    "cjamspid": util.nullcheck(responseval.tab1.cjamspid),
    "clientdob": dateCheck(responseval.tab1.dob),

    "clientgender": util.nullcheck(responseval.tab1.gender),
    "guardianonename": util.nullcheck(responseval.tab3.adoptiveparent1),
    "guardianoneprovid": util.nullcheck(responseval.tab3.providerid),
    "guardianonedob": dateCheck(responseval.tab3.adoptiveparent1dob),
    "guardianonessn": util.nullcheck(responseval.tab3.adoptiveparent1ssn),

    "guardiantwoname": util.nullcheck(responseval.tab3.adoptiveparent2),
    "guardiantwoprovid": util.nullcheck(responseval.tab3.provider_id),
    "guardiantwodob": dateCheck(responseval.tab3.adoptiveparent2dob),
    "guardiantwossn": util.nullcheck(responseval.tab3.adoptiveparent2ssn),
  };

  return reqjson;
}

function gacgapagreementappl(responseval,reqjson) {
  if (responseval.tab1 !== null) {
    reqjson = {
      root_template_path_style: app.baseurl,
      root_template_path_image: app.baseurl,
      "clientname": util.nullcheck(responseval.tab1.childname),
      "cjamspid": util.nullcheck(responseval.tab1.cjamspid),
      "clientdob": dateCheck(responseval.tab1.dob),

      "clientgender": util.nullcheck(responseval.tab1.gender),
      "guardianonename": util.nullcheck(responseval.tab1.guardianoneprovidername),
      "guardianoneprovid": util.nullcheck(responseval.tab1.guardianoneproviderid),
      "guardianonedob": dateCheck(responseval.tab1.one_dob_dt),
      "guardianonessn": util.nullcheck(responseval.tab1.one_ssno),

      "guardiantwoname": util.nullcheck(responseval.tab1.guardiantwoprovidername),
      "guardiantwoprovid": util.nullcheck(responseval.tab1.guardiantwoproviderid),
      "guardiantwodob": dateCheck(responseval.tab1.two_dob_dt),
      "guardiantwossn": util.nullcheck(responseval.tab1.two_ssno),
      "applicationenteredby": util.nullcheck(responseval.tab1.applicationenteredby),
      "successorguardianname": util.nullcheck(responseval.tab1.successorguardianname),

      "isapprovedresourceparent": util.nullcheck(responseval.tab1.isapprovedresourceparent),
      "isapprovedkinshipplacement": util.nullcheck(responseval.tab1.isapprovedkinshipplacement),
      "documentsigned": util.nullcheck(responseval.tab1.documentsigned),

      "iscgcompletedannualreconsideration": util.nullcheck(responseval.tab1.iscgcompletedannualreconsideration),
      "iscgenteredagreement": util.nullcheck(responseval.tab1.iscgenteredagreement),
      "isrcgacknowledgedruledoutplans": util.nullcheck(responseval.tab1.isrcgacknowledgedruledoutplans),
      "isrcgagreestoapplyssn": util.nullcheck(responseval.tab1.isrcgagreestoapplyssn),
      "isrcgandcwdiscussedrequirements": util.nullcheck(responseval.tab1.isrcgandcwdiscussedrequirements),
      "isrcgapprovedhomeforsixmonths": util.nullcheck(responseval.tab1.isrcgapprovedhomeforsixmonths),
      "isrcgauthorizedmentalinfo": util.nullcheck(responseval.tab1.isrcgauthorizedmentalinfo),
      "isrcgcompletedprotectiveclearance": util.nullcheck(responseval.tab1.isrcgcompletedprotectiveclearance),
      "isrcgcomprehensivestudycompleted": util.nullcheck(responseval.tab1.isrcgcomprehensivestudycompleted),
      "isrcgguardianshipassistancepayment": util.nullcheck(responseval.tab1.isrcgguardianshipassistancepayment),
      "isrcghavefinancialsupport": util.nullcheck(responseval.tab1.isrcghavefinancialsupport),
      "isrcgnotifybehalfofchild": util.nullcheck(responseval.tab1.isrcgnotifybehalfofchild),
      "isrcgnotifylocaldeptforchanges": util.nullcheck(responseval.tab1.isrcgnotifylocaldeptforchanges),
      "isrcgprovidesupervision": util.nullcheck(responseval.tab1.isrcgprovidesupervision),
      "isrcgshowpermanentcommitment": util.nullcheck(responseval.tab1.isrcgshowpermanentcommitment),
      "isrcgunderstandgacanbeterminated": util.nullcheck(responseval.tab1.isrcgunderstandgacanbeterminated),
      "isrcgunderstandpurpose": util.nullcheck(responseval.tab1.isrcgunderstandpurpose),
      "isrcgwillstablehome": util.nullcheck(responseval.tab1.isrcgwillstablehome),

    };
    if (responseval.tab1.gapapplication !== null) {
      reqjson.guardian1signature = util.nullcheck(responseval.tab1.gapapplication[0].guardian1signature);
      reqjson.guardianonedate = dateCheck(responseval.tab1.gapapplication[0].guardianonedate);
      reqjson.guardian2signature = util.nullcheck(responseval.tab1.gapapplication[0].guardian2signature);
      reqjson.guardiantwodate = dateCheck(responseval.tab1.gapapplication[0].guardiantwodate);
      reqjson.ldssdirectorsignature = util.nullcheck(responseval.tab1.gapapplication[0].ldssdirectorsignature);
      reqjson.ldssdate = dateCheck(responseval.tab1.gapapplication[0].ldssdirectordate);
      reqjson.planmeetingdate = dateCheck(responseval.tab1.gapapplication[0].planmeetingdate);
      reqjson.insertdate = dateCheck(responseval.tab1.gapapplication[0].insertdate);

      reqjson.routingstatus = util.nullcheck(responseval.tab1.gapapplication[0].routingstatus);
      if (responseval.tab1.gapapplication[0].routingstatus == 'Review') {
        reqjson.requestedby = util.nullcheck(responseval.tab1.gapapplication[0].approvedby);
        reqjson.approvedby = util.nullcheck(responseval.tab1.gapapplication[0].requestedby);
      } else {
        reqjson.requestedby = util.nullcheck(responseval.tab1.gapapplication[0].requestedby);
        reqjson.approvedby = util.nullcheck(responseval.tab1.gapapplication[0].approvedby);
      }
      reqjson.comments = util.nullcheck(responseval.tab1.gapapplication[0].comments);
    }
  }
  if (responseval.tab3 !== null) {
    reqjson.guardianonename = util.nullcheck(responseval.tab3.adoptiveparent1);
    reqjson.guardianoneprovid = util.nullcheck(responseval.tab3.providerid);
    reqjson.guardianonedob = dateCheck(responseval.tab3.adoptiveparent1dob);
    reqjson.guardianonessn = util.nullcheck(responseval.tab3.adoptiveparent1ssn);

    reqjson.guardiantwoname = util.nullcheck(responseval.tab3.adoptiveparent2);
    reqjson.guardiantwoprovid = util.nullcheck(responseval.tab3.provider_id);
    reqjson.guardiantwodob = dateCheck(responseval.tab3.adoptiveparent2dob);
    reqjson.guardiantwossn = util.nullcheck(responseval.tab3.adoptiveparent2ssn);
  }
  return reqjson;
}

function gacga(responseval,reqjson) {
  if (responseval.tab2 !== null) {
    const iscsnotifiedtocustodyElse = (responseval.tab2.iscsnotifiedtocustody == '0') ? 'No' : 'NA';
    reqjson = {
      root_template_path_style: app.baseurl,
      root_template_path_image: app.baseurl,
      "clientname": util.nullcheck(responseval.tab1.childname),
      "cjamspid": util.nullcheck(responseval.tab1.cjamspid),
      "clientdob": dateCheck(responseval.tab1.dob),

      "clientgender": util.nullcheck(responseval.tab1.gender),
      "guardianonename": util.nullcheck(responseval.tab3.adoptiveparent1),
      "guardianoneprovid": util.nullcheck(responseval.tab3.providerid),
      "guardianonedob": dateCheck(responseval.tab3.adoptiveparent1dob),
      "guardianonessn": util.nullcheck(responseval.tab3.adoptiveparent1ssn),

      "guardiantwoname": util.nullcheck(responseval.tab3.adoptiveparent2),
      "guardiantwoprovid": util.nullcheck(responseval.tab3.provider_id),
      "guardiantwodob": dateCheck(responseval.tab3.adoptiveparent2dob),
      "guardiantwossn": util.nullcheck(responseval.tab3.adoptiveparent2ssn),

      "guardian1signature": util.nullcheck(responseval.tab2.guardian1signature),
      "guardianonedate": dateCheck(responseval.tab2.guardianonedate),
      "guardian2signature": util.nullcheck(responseval.tab2.guardian2signature),
      "guardiantwodate": dateCheck(responseval.tab2.guardiantwodate),
      "ldssdirectorsignature": util.nullcheck(responseval.tab2.ldssdirectorsignature),
      "ldssdate": dateCheck(responseval.tab2.ldssdate),
      "startdate": dateCheck(responseval.tab2.startdate),
      "enddate": dateCheck(responseval.tab2.enddate),

      "ischildreceivetca": booleanCheck(responseval.tab2.ischildreceivetca),
      "ischildreceivetcaq": responseval.tab2.ischildreceivetca,
      "fianotifieddate": dateCheck(responseval.tab2.fianotifieddate),
      "isfianotified": booleanCheck(responseval.tab2.isfianotified) || 'NA',
      "isfianotifiedq": responseval.tab2.isfianotified,
      "tcaamount": util.nullcheck(responseval.tab2.tcaamount),
      "iscsnotifiedtocustody": (responseval.tab2.iscsnotifiedtocustody == '1') ? 'Yes' : iscsnotifiedtocustodyElse,
      "isrcnotifiedcontact": booleanCheck(responseval.tab2.isrcnotifiedcontact) || 'NA',

      "routingstatus": util.nullcheck(responseval.tab2.routingstatus),
      "requestedby": util.nullcheck(responseval.tab2.approvedby),
      "approvedby": util.nullcheck(responseval.tab2.requestedby),
      "insertdate": dateCheck(responseval.tab2.insertdate),

    };
  } else {
    reqjson = {
      root_template_path_style: app.baseurl,
      root_template_path_image: app.baseurl,
      "clientname": util.nullcheck(responseval.tab1.childname),
      "cjamspid": util.nullcheck(responseval.tab1.cjamspid),
      "clientdob": dateCheck(responseval.tab1.dob),

      "clientgender": util.nullcheck(responseval.tab1.gender),
      "guardianonename": util.nullcheck(responseval.tab3.adoptiveparent1),
      "guardianoneprovid": util.nullcheck(responseval.tab3.providerid),
      "guardianonedob": dateCheck(responseval.tab3.adoptiveparent1dob),
      "guardianonessn": util.nullcheck(responseval.tab3.adoptiveparent1ssn),

      "guardiantwoname": util.nullcheck(responseval.tab3.adoptiveparent2),
      "guardiantwoprovid": util.nullcheck(responseval.tab3.provider_id),
      "guardiantwodob": dateCheck(responseval.tab3.adoptiveparent2dob),
      "guardiantwossn": util.nullcheck(responseval.tab3.adoptiveparent2ssn),
    }
  }
  return reqjson;
}

function checkArrFmt(value){
  return value && value.length > 0 ? value : [];
}

function nullCheck(value) {
  return value ? value : null;
}

function emptyStrCheck(value) {
  return value ? value : '';
}

function booleanCheck(value) {
  const fcond = value === false ? 'No' : '';
  return value === true ? 'Yes' : fcond;
}

function checkYes(value) {
  return value ? 'Yes' : 'No';
}

function arrayCheck(value){
  return value && value.length ? value[0] : null;

}

function dateCheck(value, fmt = dtformat) {
  return value ? moment(value).format(fmt) : '';
}

function checkboxCheck(value){
  return value ? 'checked' : '';
}

function genderCheck(element){
  let gender = '';
  if(element !== null && element !== undefined) {
    switch (element) {
      case 'M' : gender = 'Male';
      break ;
      case 'F' : gender = 'Female';
      break ;
      case 'O' : gender = 'Other';
      break ;
      case 'TG' : gender = 'Transgender';
      break ;
      case 'TGIF' : gender = 'Transgender- Identifies as Female';
      break ;
      case 'TGIM' : gender = 'Transgender- Identifies as Male';
      break ;
      default : gender = 'Unknown';
    }
  }
  return gender; 
}

function checkboxInputEle(value, isDisabled = true) {
  let ele = ''
  if (value === 'YES') {
    ele = `<td><input type="checkbox" checked ${isDisabled ? 'disabled' : ''} /> Yes </td>
			  <td><input type="checkbox" ${isDisabled ? 'disabled' : ''} /> No </td>`;
  } else if (value === 'NO') {
    ele = `<td><input type="checkbox" ${isDisabled ? 'disabled' : ''} /> Yes </td>
		<td><input type="checkbox" checked ${isDisabled ? 'disabled' : ''} /> No</td>`;
  } else {
    ele = `<td><input type="checkbox" ${isDisabled ? 'disabled' : ''} /> Yes </td>
		<td><input type="checkbox" ${isDisabled ? 'disabled' : ''} /> No </td>`;
  }
  return ele;
}
function formatreceiveddate(reqjson){
 return reqjson.da_receiveddate ? util.formatDateAndTimeReport(reqjson.da_receiveddate) :util.formatDateAndTimeReport(reqjson.receivedDate);
  
}
function formatcounty(reqjson){
  return reqjson.countyId ? util.nullcheck(reqjson.countyId): util.nullcheck(reqjson.reportSummaryData?.county?.countyname);
}
function formatresponsetype(reqjson){
  return reqjson?.purposeSelected?.text ? util.nullcheck(reqjson?.purposeSelected?.text):util.nullcheck(reqjson.reportSummaryData?.intakeservicerequesttype?.description);
}
function formatlabel(reqjson){
 return reqjson.reportSummaryData?.intakeservicerequestinputtype?.description ? util.nullcheck(reqjson.reportSummaryData?.intakeservicerequestinputtype?.description) : util.nullcheck(reqjson.label);
}
function getintakenumber(request){
   return request?.where?.intakenumber ? request?.where?.intakenumber :request?.where?.INTAKE_NUMBER;
}
function clearHtmlSpaces(value) {
  if (!value) return '';
  return value.replace(/&nbsp;/g, ' ').trim();
}