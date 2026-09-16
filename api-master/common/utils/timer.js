// LoopBack 3 SAFE timing utility (no bigint, no ES6 requirement)
const commonapi = require('../models/commonapi');
exports.start = function(req) {

  var id =
    req.headers['x-request-id'] ||
    (Date.now() + '-' + Math.random().toString(16).substring(2));

  return {
    id: id,
    t0: process.hrtime()
  };
};

exports.mark = function(timer, label) {
  timer[label] = process.hrtime();
};

function diffMs(start, end) { //NOSONAR
  if (!start || !end) return 0;
  var sec = end[0] - start[0];
  var nano = end[1] - start[1];
  return ((sec * 1000) + (nano / 1000000)).toFixed(1);
}

exports.print = function(timer, req) {

  var preDb = diffMs(timer.t0, timer.t1);
  var db = diffMs(timer.t1, timer.t2);
  var postDb = diffMs(timer.t2, timer.t3);
  var total = diffMs(timer.t0, timer.t3);
  var timerdetails =   '[DBTIMING] id=' + timer.id + ' ' +
    req.method + ' ' + req.originalUrl + ' ' +
    'preDb=' + preDb + 'ms ' +
    'db=' + db + 'ms ' +
    'postDb=' + postDb + 'ms ' +
    'total=' + total + 'ms'

  console.log(timerdetails);

    const externalapidata = {}; 
    externalapidata.details =  {
        objectid: 'timer_details',
        objecttype: 'timer_details',
        updatedby: 'testing',
        insertedby: 'testing'
    }
    externalapidata.resstatus = '';
    externalapidata.request = timerdetails;
    externalapidata.response = null;
    externalapidata.status = 'add';
    let v_externalapilogsid = null;
    commonapi.addupdateexternalapilogs(externalapidata).then(data1 => {
      v_externalapilogsid = data1;  //NOSONAR
    }).catch(err => util.logError(err));
};