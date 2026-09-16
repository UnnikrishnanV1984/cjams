'use strict';
const LOGGER = require("log4js").getLogger("caseplanlegacy");
const util = require('../utils/utils');
var fs = require('fs');
var config = require('../../server/config.json');
var app = require('../../server/server');
const pdf = require('../models/pdf');
const btoa = require("btoa");
const roottemplatepath = '{{root_template_path_style}}';
const checkboxhtml = '<input type="checkbox"></input>';
var ds = app.dataSources.hcuewelfare;

module.exports = function (Caseplanlegacy) {
/*Caseplan Legacy List*/    
    Caseplanlegacy.remoteMethod('getcaseplanlegacy', {
        http: {
            path: '/getcaseplanlegacy',
            verb: 'get'
        },
        accepts : [ 
        {
            arg : 'filter',
            type : 'object',
            http : {source : 'query'}
        } ],  
        returns: {
            type : 'object',
            root : true
        } 
    });

    Caseplanlegacy.getcaseplanlegacy =(request)=> {
       
        var sql = 'select * from getcaseplanlegacy($1,$2)';
        
		return util.executeSecondaryNodeDBQuery(sql, [request.where.caseid,request.where.personid]).then((data) => {
            return data[0];
			}).catch((err) => { LOGGER.error('>>>>ERROR:', err); util.logError(err); throw err; });
    };

}

module.exports.getcaseplan3appla = function (request, response) {
   
    var sql = 'select * from getcaseplan3appla($1,$2)';
    
    return util.executeSecondaryNodeDBQuery(sql, [request.where.caseid,request.where.caseplanid]).then((data) => {
        if(data.length > 0){
              let caseplan3appla = {};
              if (data[0].caseplan3appla && data[0].caseplan3appla.length > 0)
                {caseplan3appla = data[0].caseplan3appla[0];}
              var html = fs.readFileSync('./documenttemplates/caseplan3appla.html', 'utf8');
              html = html.replace(roottemplatepath, config.documenttemplates);
              html = html.replace('{{childname}}', util.getFullName(caseplan3appla));
              html = html.replace('{{caseid}}', util.nullcheck(caseplan3appla.caseid));
              html = html.replace('{{timelyassessment}}', util.nullcheck(caseplan3appla.a1));
              html = html.replace('{{permenancyoptions}}', util.nullcheck(caseplan3appla.a2));
              html = html.replace('{{permenantplacement}}', util.nullcheck(caseplan3appla.a3));
              html = html.replace('{{childpreference}}', util.nullcheck(caseplan3appla.a4));
              html = html.replace('{{compellingreason}}', util.nullcheck(caseplan3appla.a5));
              html = html.replace('{{justify}}', util.nullcheck(caseplan3appla.a6));
              html = html.replace('{{supportstructures}}', util.nullcheck(caseplan3appla.a7));
              html = html.replace('{{specialneeds}}', util.nullcheck(caseplan3appla.a8));
              html = html.replace('{{accessefforts}}', util.nullcheck(caseplan3appla.a9));
              html = html.replace('{{selfsufficiency}}', util.nullcheck(caseplan3appla.a10));
              html = html.replace('{{adultpeersupport}}', util.nullcheck(caseplan3appla.a11));
              html = html.replace('{{supportiveservices}}', util.nullcheck(caseplan3appla.a12));
       
           request.where.outputfilename = "Caseplan3appla";
          Response = pdf.generatepdf(request, html, {}, {type: 'report', res:response }); 
            return Response;
          }
    }).catch((err) => { util.logError(err); throw err; });
};


module.exports.caseplan1pdf = function (request,response) {
    LOGGER.debug("request", request);
    var caseid = request.where.caseid;
    var caseplanid = request.where.caseplanid;
    request.documntkey = request.where.documenttemplatekey;
  
    const sql = "select * from getcaseplan1pdf($1,$2)";
  
    return util.executeSecondaryNodeDBQuery(sql, [caseid,caseplanid]).then((data) => {
        if (data.length > 0) {
          var childdata = data[0].getcaseplan1pdf?data[0].getcaseplan1pdf[0]:{};
  
          var html = fs.readFileSync('./documenttemplates/caseplan1.html', 'utf8');
  
           html = html.replace(roottemplatepath, config.documenttemplates);
           html = html.replace('{{root_template_path_image}}', config.documenttemplates);
            childdata.childname = util.getFullName(childdata);
            childdata.cisclientid = util.nullcheck(childdata.cisclientid);
            childdata.cjamspid = util.nullcheck(childdata.cjamspid);
            childdata.racetype = util.nullcheck(childdata.racetype);
            childdata.ssno = util.nullcheck(childdata.ssno);
            var birthplace ='';
            birthplace = util.nullcheck(childdata.hospitalname);
            birthplace = (birthplace != '' )? birthplace + '<br>' : '';
            birthplace = birthplace + util.nullcheck(childdata.cityname);
            birthplace = birthplace +' ' + util.nullcheck( childdata.statetypekey);
            childdata.birthplace = birthplace;
            childdata.gender = util.nullcheck(childdata.gender);
            childdata.dob = util.nullcheck(childdata.dob);
            childdata.removaldate = util.nullcheck(childdata.removaldate);
            childdata.addressatremoval = util.nullcheck(childdata.addressatremoval);
            childdata.safetydate = util.nullcheck(childdata.safetydate);
            childdata.riskdate = util.nullcheck(childdata.riskdate);
            childdata.religion = util.nullcheck(childdata.religion);
            childdata.mothername = util.nullcheck(childdata.mothername);
            childdata.fathername = util.nullcheck(childdata.fathername);
            childdata.placement = util.removeBizarreCharacters(childdata.placement);
            childdata.familyhistory = util.removeBizarreCharacters(childdata.familyhistory);
            childdata.childdesc = util.removeBizarreCharacters(childdata.childdesc);
            childdata.reasonableeffortsremoval = ( childdata?.reasonableeffortsremoval?.length) ? childdata.reasonableeffortsremoval : [];
            childdata.reasonableeffortsplacement = (childdata?.reasonableeffortsplacement?.length) ? childdata.reasonableeffortsplacement : [];
  
          //to generate pdf file
        Response = pdf.generatepdf(request, html, childdata,{ type: 'report', res: response });
        }
        return Response;
    }).catch((err) => { util.logError(err); throw err; });
  };

  module.exports.getcaseplan4ilp = function (request, response) {
    request.documntkey = request.where.documenttemplatekey;
    var sql = 'select * from getcaseplan4ilp($1,$2)';
    return util.executeSecondaryNodeDBQuery(sql, [request.where.caseid, request.where.caseplanid])
    .then(data=>{
      if (data.length > 0) {
        let caseplan4ilp = {};
        if (data[0].caseplan4ilp && data[0].caseplan4ilp.length > 0)
        {caseplan4ilp = data[0].caseplan4ilp[0];}
        var html = fs.readFileSync('./documenttemplates/caseplan4ilp.html', 'utf8');
        html = html.replace(roottemplatepath, config.documenttemplates);
        html = html.replace(/{{childname}}/g,  util.getFullName(caseplan4ilp));
        html = html.replace(/{{caseid}}/g, util.nullcheck(caseplan4ilp.caseid));
        html = html.replace('{{begindate}}', checkDateformat(util.nullcheck(caseplan4ilp.begindate)));
        html = html.replace('{{enddate}}', checkDateformat(util.nullcheck(caseplan4ilp.enddate)));
        html = html.replace('{{planestablished}}', util.nullcheck(caseplan4ilp.planestablished));
        html = html.replace('{{projachievementdate}}', util.nullcheck(caseplan4ilp.projachievementdate));
        html = html.replace('{{fathername}}', util.nullcheck(caseplan4ilp.fathername));
        html = html.replace('{{mothername}}', util.nullcheck(caseplan4ilp.mothername));
        html = html.replace('{{dob}}', util.nullcheck(caseplan4ilp.dob) ? util.formatDate(caseplan4ilp.dob) : '');
        html = html.replace('{{youthchildren}}', util.nullcheck(caseplan4ilp.youthchildren));
        html = html.replace('{{aka}}', util.nullcheck(caseplan4ilp.aka));
        html = html.replace('{{ssn}}', util.nullcheck(caseplan4ilp.ssn));
        html = html.replace('{{homephone}}', util.nullcheck(caseplan4ilp.homephone));
        html = html.replace('{{workphone}}', util.nullcheck(caseplan4ilp.workphone));
        html = html.replace('{{citizenship}}', util.nullcheck(caseplan4ilp.citizenship));
        html = html.replace('{{maritalstatustype}}', util.nullcheck(caseplan4ilp.maritalstatustype));
        html = html.replace('{{dateofdeath}}', checkDateformat(util.nullcheck(caseplan4ilp.dateofdeath)));
        html = html.replace('{{height}}', util.nullcheck(caseplan4ilp.height));
        html = html.replace('{{weight}}', util.nullcheck(caseplan4ilp.weight));
        html = html.replace('{{hair}}', util.nullcheck(caseplan4ilp.hair));
        html = html.replace('{{eyes}}', util.nullcheck(caseplan4ilp.eyes));
        html = html.replace('{{racetype}}', util.nullcheck(caseplan4ilp.racetype));
        html = html.replace('{{skin}}', util.nullcheck(caseplan4ilp.skin));
        html = html.replace('{{glassess}}', util.nullcheck(caseplan4ilp.glassess));
        html = html.replace('{{birthmarks}}', util.nullcheck(caseplan4ilp.birthmarks));
        html = html.replace('{{empaddress}}', util.nullcheck(caseplan4ilp.empaddress));
        html = html.replace('{{income}}', util.nullcheck(caseplan4ilp.income));
        html = html.replace('{{medicalinsurance}}', util.nullcheck(caseplan4ilp.medicalinsurance));
        html = html.replace('{{educationstartdate}}', util.nullcheck(caseplan4ilp.education) ? util.formatDate(caseplan4ilp.education[0].startdate) : '');
        html = html.replace('{{educationenddate}}', util.nullcheck(caseplan4ilp.education) ? util.formatDate(caseplan4ilp.education[0].enddate) : '');
        html = html.replace(/{{agencystartdate}}/g, util.nullcheck(caseplan4ilp.agency) ? util.formatDate(caseplan4ilp.agency[0].startdate) : '');
        html = html.replace(/{{agencyenddate}}/g, util.nullcheck(caseplan4ilp.agency) ? util.formatDate(caseplan4ilp.agency[0].enddate) : '');
        html = html.replace('{{youthsign}}', util.nullcheck(caseplan4ilp.youthsign) );
        html = html.replace('{{goals}}', util.nullcheck(caseplan4ilp.goals));
        html = html.replace('{{ilpgoals}}', util.nullcheck(caseplan4ilp.goals));
        html = html.replace('{{svccompliance}}', util.nullcheck(caseplan4ilp.goals));
        html = setGoalAtrr(html, caseplan4ilp);
            
        request.where.outputfilename = "caseplan4ilp";
        Response = pdf.generatepdf(request, html, {}, { type: 'report', res: response });
      }
      return Response;
    })
    .then(datas => datas)
    .catch(err => util.logError(err));
};

function checkGoalAtrr(caseplan4ilp){
  let data = {
    goal1emp : '[]',
    goal2edu : '[]',
    goal3perp1 : '[]',
    goal4perp2 : '[]'
  }
  if(caseplan4ilp){
    data = {
      goal1emp: caseplan4ilp.employment?caseplan4ilp.employment:[],
      goal2edu: caseplan4ilp.education?caseplan4ilp.education:[],
      goal3perp1: caseplan4ilp.preparation1?caseplan4ilp.preparation1:[],
      goal4perp2: caseplan4ilp.preparation2?caseplan4ilp.preparation2:[]
    }
  }
  return data;
}

function setGoalAtrr(html,caseplan4ilp) {
  var goal1emp = checkGoalAtrr(caseplan4ilp).goal1emp;
  var goal2edu = checkGoalAtrr(caseplan4ilp).goal2edu;
  var goal3perp1 = checkGoalAtrr(caseplan4ilp).goal3perp1;
  var goal4perp2 = checkGoalAtrr(caseplan4ilp).goal4perp2;
  var goalempagencytxt = '';
  var goalempyouthtxt = '';
  var goaleduyouthtxt = '';
  var goaleduagencytxt = '';
  var prep2youthtxt = '';
  var prep2agencytxt = '';
  var prep1youthtxt = '';
  var prep1agencytxt = '';
  goal1emp.forEach(element => {
    if (element.responsibilitytypekey === '6169') {
      goalempyouthtxt += element.tasktx;
      html = html.replace('{{empyouthdt1}}',element.startdate);
      html = html.replace('{{empyouthdt2}}',element.enddate);
    }
    else {
      goalempagencytxt += element.tasktx ? element.tasktx.replace("","'") : element.tasktx;
      html = html.replace('{{empagencydt1}}',element.startdate);
      html = html.replace('{{empagencydt2}}',element.enddate);

    }
  });
  goal2edu.forEach(element => {
    if (element.responsibilitytypekey === '6169') {
      goaleduyouthtxt += element.tasktx;
      html = html.replace('{{eduyouthdt1}}',element.startdate);
      html = html.replace('{{eduyouthdt2}}',element.enddate);
    }
    else {
      goaleduagencytxt += element.tasktx;
      html = html.replace('{{eduagencydt1}}',element.startdate);
      html = html.replace('{{eduagencydt2}}',element.enddate);
    }
  });
  goal3perp1.forEach(element => {
    if (element.responsibilitytypekey === '6169') {
      prep1youthtxt += element.tasktx;
      html = html.replace('{{prep1youthdt1}}',element.startdate);
      html = html.replace('{{prep1youthdt2}}',element.enddate);
    }
    else {
      prep1agencytxt += element.tasktx;
      html = html.replace('{{prep1agencydt1}}',element.startdate);
      html = html.replace('{{prep1agencydt2}}',element.enddate);
    }
  });
  goal4perp2.forEach(element => {
    if (element.responsibilitytypekey === '6169') {
      prep2youthtxt += element.tasktx;
      html = html.replace('{{prep2youthdt1}}',element.startdate);
      html = html.replace('{{prep2youthdt2}}',element.enddate);

    }
    else {
      prep2agencytxt += element.tasktx;
      html = html.replace('{{prep2agencydt1}}',util.nullcheck(element.startdate));
      html = html.replace('{{prep2agencydt2}}',util.nullcheck(element.enddate));
    }
  });
  html = html.replace('{{goaleduagencytxt}}',util.nullcheck(goaleduagencytxt));
  html = html.replace('{{goaleduyouthtxt}}',util.nullcheck(goaleduyouthtxt));
  html = html.replace('{{goalempagencytxt}}',util.nullcheck(goalempagencytxt));
  html = html.replace('{{goalempyouthtxt}}',util.nullcheck(goalempyouthtxt));
  html = html.replace('{{prep2youthtxt}}',util.nullcheck(prep2youthtxt));
  html = html.replace('{{prep2agencytxt}}',util.nullcheck(prep2agencytxt));
  return html;
}

function checkDateformat(date) {
  return date ? util.formatDate(date) : ''
}


module.exports.getcaseplan3agreement = function (request,response) {

  var sql = 'select * from getcaseplan3aggreement($1,$2)';
  return util.executeSecondaryNodeDBQuery(sql,[request.where.caseid,request.where.agreementid])
    .then(data => {
      if (data.length > 0) {
        let caseplan3agreement = [];
        caseplan3agreement = data[0].getcaseplan3aggreement;

        const staffheldflag = util.nullcheck(caseplan3agreement) ? `<input type="checkbox" ${checkboxcheck((caseplan3agreement[0].staffheldflag) === 1)}></input>` : checkboxhtml;
        
        var html = fs.readFileSync('./documenttemplates/caseplan3serviceagreement.html','utf8');
        html = html.replace(roottemplatepath,config.documenttemplates);
        html = getcaseplan3agreement(html,caseplan3agreement);
        html = getconcurpermplanflag(html, caseplan3agreement);
        let plandate = '';
        if (caseplan3agreement && util.formatDate(caseplan3agreement[0].concurpermplandate)) {
          plandate = util.formatDate(caseplan3agreement[0].concurpermplandate);
        } else if (caseplan3agreement[0].permanencyplan && caseplan3agreement[0].permanencyplan[0].projecteddate) {
          plandate = util.formatDate(caseplan3agreement[0].permanencyplan[0].establisheddate);
        }
        html = html.replace('{{concurpermplandate}}',plandate);
        html = html.replace('{{staffheldflag}}',staffheldflag);
        html = getCP3Details(html, caseplan3agreement);

        request.where.outputfilename = "Caseplan3_serviceagreement";
        Response = pdf.generatepdf(request,html,{},{ type: 'report',res: response });

      }
      return Response;
    })
    .then(datas => datas)
    .catch(err => {
      LOGGER.error(err);
      util.logError(err);
      return err;
    })
};

function getconcurpermplanflag(html, caseplan3agreement){
  const concurpermplanflag = util.nullcheck(caseplan3agreement) ? 
                                `<input type="checkbox" ${checkboxcheck((caseplan3agreement[0].concurpermplanflag) === 1)}></input>` : checkboxhtml;
  html = html.replace('{{concurpermplanflag}}',concurpermplanflag);
  return html;
}

function getCP3Details(html, caseplan3agreement){
  html = html.replace('{{staffhelddate}}',util.formatDate(caseplan3agreement) ? caseplan3agreement[0].staffhelddate : '');
  let cp3parenttask = [];
  let c3agencytask = [];
  let permanencyplan = [];
        if(caseplan3agreement){
          cp3parenttask = (caseplan3agreement[0].cp3parenttask ? caseplan3agreement[0].cp3parenttask : []);
          c3agencytask = (caseplan3agreement[0].c3agencytask ? caseplan3agreement[0].c3agencytask : []);
          permanencyplan = (caseplan3agreement[0].permanencyplan ? caseplan3agreement[0].permanencyplan : []);
        }

  var c3parenttasktxt = '';
  cp3parenttask.forEach(element => {
    c3parenttasktxt += "<tr>";
    c3parenttasktxt += "<td>" + util.nullcheck(element.tasktx) + "</td>"
    c3parenttasktxt += "<td>" + util.nullcheck(element.identifieddate) + "</td>"
    c3parenttasktxt += "<td>" + util.nullcheck(element.expectedcompletedate) + "</td>"
    c3parenttasktxt += "</tr>";
  });
  var c3agencytasktxt = '';
  c3agencytask.forEach(element => {
    c3agencytasktxt += "<tr>";
    c3agencytasktxt += "<td>" + util.nullcheck(element.tasktx) + "</td>"
    c3agencytasktxt += "<td>" + util.nullcheck(element.identifieddate) + "</td>"
    c3agencytasktxt += "<td>" + util.nullcheck(element.expectedcompletedate) + "</td>"
    c3agencytasktxt += "</tr>";
  });

  var permanencyplantext = '';
  permanencyplan.forEach(element => {
    permanencyplantext += "<tr>";
    permanencyplantext += "<td>" + (util.nullcheck(element.primaryflag) == '1' ? 'P' : '') + "</td>"
    permanencyplantext += "<td>" + (util.nullcheck(element.secondaryflag) == '1' ? 'S' : '') + "</td>"
    permanencyplantext += "<td>" + util.nullcheck(element.concplan) + "</td>"
    permanencyplantext += "<td>" + util.nullcheck(element.livingarr) + "</td>"
    permanencyplantext += "<td>" + util.nullcheck(element.permlegalstatus) + "</td>"
    permanencyplantext += "<td>" + util.formatDate(element.projecteddate) + "</td>"
    permanencyplantext += "</tr>";
  });
  html = html.replace('{{cp3parenttask}}',util.nullcheck(c3parenttasktxt));
  html = html.replace('{{cp3agencytask}}',util.nullcheck(c3agencytasktxt));
  html = html.replace('{{permanencyplan}}',util.nullcheck(permanencyplantext));

  return html;
}

function getcaseplan3agreement(html, caseplan3agreement){
  html = html.replace('{{childname}}',util.nullcheck(caseplan3agreement) ? util.getFullName(caseplan3agreement[0]) : '');
  html = html.replace('{{completedby}}', util.nullcheck(caseplan3agreement)? caseplan3agreement[0].completedby: '');
  html = html.replace('{{cjamspid}}', util.nullcheck(caseplan3agreement)? caseplan3agreement[0].cjamspid: '');
  html = html.replace('{{cisclientid}}', util.nullcheck(caseplan3agreement)? caseplan3agreement[0].cisclientid: '');
  html = html.replace('{{racetype}}', util.nullcheck(caseplan3agreement)? caseplan3agreement[0].racetype: '');
  html = html.replace('{{gender}}', util.nullcheck(caseplan3agreement)? caseplan3agreement[0].gender: '');
  html = html.replace('{{religion}}',util.nullcheck(caseplan3agreement)? caseplan3agreement[0].religion: '');
  html = html.replace('{{ssnno}}', util.nullcheck(caseplan3agreement)? caseplan3agreement[0].ssnno: '');
  html = html.replace('{{dob}}', util.formatDate(caseplan3agreement)? caseplan3agreement[0].caseid: '');
  html = html.replace('{{fathername}}', util.nullcheck(caseplan3agreement)? caseplan3agreement[0].fathername: '');
  html = html.replace('{{mothername}}', util.nullcheck(caseplan3agreement)? caseplan3agreement[0].mothername: '');
  html = html.replace('{{begindate}}', util.formatDate(caseplan3agreement)? caseplan3agreement[0].begindate: '');
  html = html.replace('{{enddate}}', util.formatDate(caseplan3agreement)? caseplan3agreement[0].enddate: '');
  html = html.replace('{{initialplacement}}', util.nullcheck(caseplan3agreement)? util.nullcheck(caseplan3agreement[0].initialplacement): '');
  html = html.replace('{{continueplacement}}', util.nullcheck(caseplan3agreement)? util.nullcheck(caseplan3agreement[0].continueplacement): '');
  return html;
}


module.exports.caseplan2pdf_old = function (request,response) {
    LOGGER.debug("request", request);
    var reqjson = {};
    var caseid = request.where.caseid;
    var caseplanid = request.where.caseplanid;
    request.documntkey = request.where.documenttemplatekey;
  
    const sql = "select * from getcaseplan2pdf($1,$2)";
    return util.executeSecondaryNodeDBQuery(sql, [caseid,caseplanid])
    .then(data => {
      if (data.length > 0) {
        var childdata = data[0].getcaseplan2pdf?data[0].getcaseplan2pdf[0]:null;
        var details = getCPDetails(childdata);
        var  cp23bservices = details.cp23bservices;
        var  cp2placement = details.cp2placement;
        var  cp2assessment = details.cp2assessment;
        var  cp2cwsrvpl = details.cp2cwsrvpl;
        var  childedu = details.childedu;

        var html = fs.readFileSync('./documenttemplates/caseplan2legacy.html', 'utf8');

        html = html.replace(roottemplatepath, config.documenttemplates);
        html = html.replace('{{root_template_path_image}}', config.documenttemplates);
        html= getchildSection(html, childdata);

        html = getCP23Services(html,cp23bservices);
        var placementtxt ='';
        if (cp2placement && cp2placement.length>0){
        cp2placement.forEach(element => {
          placementtxt += "<tr>";
          placementtxt += "<td>"+ element.placementtype +"</td>"
          placementtxt += "<td>"+ element.placementaddress +"</td>"
          placementtxt += "<td>"+ element.startdate +"</td>"
          placementtxt += "<td>"+ element.enddate +"</td>"
          placementtxt += "<td>"+ element.livingarrangementtype +"</td>"
          placementtxt += "</tr>"; 
       })}
       html = html.replace(/{{cp2placement}}/g, util.nullcheck(placementtxt));
       html = html.replace(/{{removalreason}}/g, util.nullcheck(cp2placement) ? util.nullcheck(cp2placement[0].removalreason): '');
       html = html.replace(/{{removaldate}}/g, util.nullcheck(cp2placement) ? util.nullcheck(cp2placement[0].removaldate): '');
        var assessmenttxt ='';
        cp2assessment.forEach(element => {
          assessmenttxt += "<tr>";
          assessmenttxt += "<td>"+ element.assessmentname +"</td>"
          assessmenttxt += "<td>"+ element.assessmentdate +"</td>"
          assessmenttxt += "<td>"+ element.outcome +"</td>"
          assessmenttxt += "</tr>"; 
       });
       html = html.replace(/{{cp2assessment}}/g, util.nullcheck(assessmenttxt) );
       /*CASEWORKER'S SERVICES AND PLAN  */
        html = getCP2CWService(html, cp2cwsrvpl);
        html = getCP2CWService2(html, cp2cwsrvpl)
        
/*CHILD'S EDUCATION */
       html = getChildEdu(html, childedu);

        //to generate pdf file
      Response = pdf.generatepdf(request, html, reqjson,{ type: 'report', res: response });
      resolve(Response);
      }
    })
    .catch(err => {
        LOGGER.error(err);
        return err;
    })
  };

  function getCP2CWService2(html, cp2cwsrvpl){
    html = html.replace(/{{cwsrvpl19}}/g,util.nullcheck(cp2cwsrvpl) ? util.nullcheck(cp2cwsrvpl[0].cwsrvpl19) : '');
    html = html.replace(/{{cwsrvpl20}}/g,util.nullcheck(cp2cwsrvpl) ? util.nullcheck(cp2cwsrvpl[0].cwsrvpl20) : '');
    html = html.replace(/{{cwsrvpl21}}/g,util.nullcheck(cp2cwsrvpl) ? util.nullcheck(cp2cwsrvpl[0].cwsrvpl21) : '');
    html = html.replace(/{{cwsrvpl22}}/g,util.nullcheck(cp2cwsrvpl) ? util.nullcheck(cp2cwsrvpl[0].cwsrvpl22) : '');
    html = html.replace(/{{cwsrvpl23}}/g,util.nullcheck(cp2cwsrvpl) ? util.nullcheck(cp2cwsrvpl[0].cwsrvpl23) : '');
    html = html.replace(/{{cwsrvpl24_1}}/g,util.nullcheck(cp2cwsrvpl) ? util.nullcheck(cp2cwsrvpl[0].cwsrvpl24_1) : '');
    html = html.replace(/{{cwsrvpl24_2}}/g,util.nullcheck(cp2cwsrvpl) ? util.nullcheck(cp2cwsrvpl[0].cwsrvpl24_2) : '');
    html = html.replace(/{{cwsrvpl25}}/g,util.nullcheck(cp2cwsrvpl) ? util.nullcheck(cp2cwsrvpl[0].cwsrvpl25) : '');
    return html;
  }

  function getCPDetails(childdata){
    var  cp23bservices = null;
    var  cp2placement = null;
    var  cp2assessment = null;
    var  cp2cwsrvpl = null;
    var  childedu = null;
    if (childdata) {
      cp23bservices = childdata.cp23bservices ? childdata.cp23bservices[0] : null;
      cp2placement = childdata.cp2placement ? childdata.cp2placement : null;
      cp2assessment = childdata.cp2assessment ? childdata.cp2assessment : null;
      cp2cwsrvpl = childdata.cp2cwsrvpl ? childdata.cp2cwsrvpl : null;
      childedu = childdata.childedu ? childdata.childedu : null;
    }
    return {
      cp23bservices: cp23bservices,
      cp2placement: cp2placement,
      cp2assessment: cp2assessment,
      cp2cwsrvpl: cp2cwsrvpl,
      childedu: childedu
    }
  }

  function getCP2CWService(html, cp2cwsrvpl){
    html = html.replace(/{{cwsrvpl5}}/g,util.nullcheck(cp2cwsrvpl) ? util.nullcheck(cp2cwsrvpl[0].cwsrvpl5) : '');
    html = html.replace(/{{cwsrvpl6}}/g,util.nullcheck(cp2cwsrvpl) ? util.nullcheck(cp2cwsrvpl[0].cwsrvpl6) : '');
    html = html.replace(/{{cwsrvpl3}}/g,util.nullcheck(cp2cwsrvpl) ? util.nullcheck(cp2cwsrvpl[0].cwsrvpl3) : '');
    html = html.replace(/{{cwsrvpl4_1}}/g,util.nullcheck(cp2cwsrvpl) ? util.nullcheck(cp2cwsrvpl[0].cwsrvpl4_1) : '');
    html = html.replace(/{{cwsrvpl4_2}}/g,util.nullcheck(cp2cwsrvpl) ? util.nullcheck(cp2cwsrvpl[0].cwsrvpl4_2) : '');
    html = html.replace(/{{cwsrvpl4_3}}/g,util.nullcheck(cp2cwsrvpl) ? util.nullcheck(cp2cwsrvpl[0].cwsrvpl4_3) : '');
    html = html.replace(/{{cwsrvpl7}}/g,util.nullcheck(cp2cwsrvpl) ? util.nullcheck(cp2cwsrvpl[0].cwsrvpl7) : '');
    html = html.replace(/{{cwsrvpl10}}/g,util.nullcheck(cp2cwsrvpl) ? util.nullcheck(cp2cwsrvpl[0].cwsrvpl10) : '');
    html = html.replace(/{{cwsrvpl10_1}}/g,util.nullcheck(cp2cwsrvpl) ? util.nullcheck(cp2cwsrvpl[0].cwsrvpl10_1) : '');
    html = html.replace(/{{cwsrvpl11}}/g,util.nullcheck(cp2cwsrvpl) ? util.nullcheck(cp2cwsrvpl[0].cwsrvpl11) : '');
    html = html.replace(/{{cwsrvpl14}}/g,util.nullcheck(cp2cwsrvpl) ? util.nullcheck(cp2cwsrvpl[0].cwsrvpl14) : '');
    html = html.replace(/{{cwsrvpl15}}/g,util.nullcheck(cp2cwsrvpl) ? util.nullcheck(cp2cwsrvpl[0].cwsrvpl15) : '');
    html = html.replace(/{{cwsrvpl16}}/g,util.nullcheck(cp2cwsrvpl) ? util.nullcheck(cp2cwsrvpl[0].cwsrvpl16) : '');
    html = html.replace(/{{cwsrvpl17}}/g,util.nullcheck(cp2cwsrvpl) ? util.nullcheck(cp2cwsrvpl[0].cwsrvpl17) : '');
    html = html.replace(/{{cwsrvpl8}}/g,util.nullcheck(cp2cwsrvpl) ? util.nullcheck(cp2cwsrvpl[0].cwsrvpl8) : '');
    return html;
  }

  function getCP23Services(html, cp23bservices){
    html = html.replace(/{{ishealthPassport}}/g, util.nullcheck(cp23bservices) ? checkBoolean(cp23bservices.ishealthpassport): 'false');
    html = html.replace(/{{isreimbursement}}/g, util.nullcheck(cp23bservices) ? checkBoolean(cp23bservices.isreimbursement): 'false');
    html = html.replace(/{{isemotionalguide}}/g, util.nullcheck(cp23bservices) ? checkBoolean(cp23bservices.isemotionalguide): 'false');
    html = html.replace(/{{isother}}/g, util.nullcheck(cp23bservices) ? checkBoolean(cp23bservices.isother): 'false');
    html = html.replace(/{{othertxt}}/g, util.nullcheck(cp23bservices) ? util.nullcheck(cp23bservices.othertxt): '');
    html = html.replace(/{{isdaycare}}/g, util.nullcheck(cp23bservices) ? checkBoolean(cp23bservices.isdaycare): 'false');
    html = html.replace(/{{istransport}}/g, util.nullcheck(cp23bservices) ? checkBoolean(cp23bservices.istransport): 'false');
    html = html.replace(/{{isfinancesupport}}/g, util.nullcheck(cp23bservices) ? checkBoolean(cp23bservices.isfinancesupport): 'false');
    html = html.replace(/{{isspecialtraining}}/g, util.nullcheck(cp23bservices) ? checkBoolean(cp23bservices.isspecialtraining): 'false');
    html = html.replace(/{{isrespitecare}}/g, util.nullcheck(cp23bservices) ? checkBoolean(cp23bservices.isrespitecare): 'false');
    html = html.replace(/{{ischildneed}}/g, util.nullcheck(cp23bservices) ? checkBoolean(cp23bservices.ischildneed): 'false');
    html = html.replace(/{{isvisitation}}/g, util.nullcheck(cp23bservices) ? checkBoolean(cp23bservices.isvisitation): 'false');
    return html;
  }

  function getchildSection(html, childdata){
    if(util.nullcheck(childdata)) {
      html = checkchildsection(html, childdata);
    } else {
      html = html.replace(/{{childname}}/g, '');
      html = html.replace(/{{cisclientid}}/g, '');
      html = html.replace(/{{cjamspid}}/g, '');
      html = html.replace(/{{gender}}/g, '');
      html = html.replace('{{dob}}', '');
      html = html.replace(/{{servicecasenumber}}/g, '');
      html = html.replace(/{{jurisdiction}}/g, '');
      html = html.replace(/{{caseworker}}/g, '');
    }
    return html;
  }

  function checkchildsection(html, childdata){
    html = html.replace(/{{childname}}/g, childdata.childsection?childdata.childsection[0].childname: '');
    html = html.replace(/{{cisclientid}}/g, childdata.childsection?childdata.childsection[0].cisclientid: '');
    html = html.replace(/{{cjamspid}}/g, childdata.childsection?childdata.childsection[0].cjamspid: '');
    html = html.replace(/{{gender}}/g, childdata.childsection?childdata.childsection[0].gender: '');
    html = html.replace('{{dob}}', childdata.childsection?childdata.childsection[0].dob: '');
    html = html.replace(/{{servicecasenumber}}/g, childdata.childsection?childdata.childsection[0].servicecasenumber: '');
    html = html.replace(/{{jurisdiction}}/g, childdata.childsection?childdata.childsection[0].jurisdiction: '');
    html = html.replace(/{{caseworker}}/g, childdata.childsection?childdata.childsection[0].caseworker: '');
    return html;
  }

function getChildEdu(html,childedu) {
  html = html.replace(/{{closeproximity}}/g,util.nullcheck(childedu) ? util.nullcheck(childedu[0].closeproximity) : '');
  html = html.replace(/{{schooltype}}/g,util.nullcheck(childedu) ? util.nullcheck(childedu[0].schooltype) : '');
  html = html.replace(/{{currentedusetting}}/g,util.nullcheck(childedu) ? util.nullcheck(childedu[0].currentedusetting) : '');
  html = html.replace(/{{schoolname}}/g,util.nullcheck(childedu) ? util.nullcheck(childedu[0].schoolname) : '');
  html = html.replace(/{{specialprogram}}/g,util.nullcheck(childedu) ? util.nullcheck(childedu[0].specialprogram) : '');
  html = html.replace(/{{reportcard}}/g,util.nullcheck(childedu) ? util.nullcheck(childedu[0].reportcard) : '');
  html = html.replace(/{{iepdate}}/g,util.nullcheck(childedu) ? util.nullcheck(childedu[0].iepdate) : '');
  html = html.replace(/{{ieptype}}/g,util.nullcheck(childedu) ? util.nullcheck(childedu[0].ieptype) : '');
  html = html.replace(/{{agelevelflag}}/g,util.nullcheck(childedu) ? util.nullcheck(childedu[0].agelevelflag) : '');
  html = html.replace(/{{behaviorprobflag}}/g,util.nullcheck(childedu) ? checkBoolean(childedu[0].behaviorprobflag) : 'false');
  html = html.replace(/{{peerprobflag}}/g,util.nullcheck(childedu) ? checkBoolean(childedu[0].peerprobflag) : 'false');
  html = html.replace(/{{strengthneed}}/g,util.nullcheck(childedu) ? util.nullcheck(childedu[0].strengthneed) : '');
  html = html.replace(/{{schooladjust}}/g,util.nullcheck(childedu) ? util.nullcheck(childedu[0].schooladjust) : '');
  html = html.replace(/{{extracurricular}}/g,util.nullcheck(childedu) ? util.nullcheck(childedu[0].extracurricular) : '');
  html = html.replace(/{{prgcomments}}/g,util.nullcheck(childedu) ? util.nullcheck(childedu[0].prgcomments) : '');
  return html;
}

function checkBoolean(value){
  return value ? value: 'false';
}

function checkboxcheck(value){
  return value ? 'checked': '';
}

  function hexToBase64(str) {
      return btoa(String.fromCharCode.apply(null,
        str.replace(/\r|\n/g, "").replace(/([\da-fA-F]{2}) ?/g, "0x$1 ").replace(/ +$/, "").split(" "))
    );
} 

  module.exports.caseplan2pdf = function (request,response) {
    LOGGER.debug("request", request);
    var caseid = request.where.caseid;
    var caseplanid = request.where.caseplanid;
  
    const sql = "select * from getcaseplan2legacypdf($1,$2)";
    return new Promise((resolve, reject) => {
      return util.executeSecondaryNodeDBQuery(sql, [caseid,caseplanid]).then((data) => {
        if (data!=null && data.length > 0 && data[0].reportdata != null) {
              var reportdata = data[0].reportdata; 
              var base64resp = hexToBase64(reportdata); 
              
              base64resp= Buffer.from(base64resp, 'base64')
              response.set('Content-Type', 'application/pdf'); 
              response.send(base64resp);
              resolve(response); 
            } else {
                var t= fs.readFileSync('./documenttemplates/caseplan2-nodata.pdf');
                  response.set('Content-Type', 'application/pdf'); 
                  response.send(t);
                  resolve(response); 
                
        } 
    }).catch((err) => { LOGGER.error('>>>>ERROR:', err); util.logError(err); throw err; });
    });
  }


