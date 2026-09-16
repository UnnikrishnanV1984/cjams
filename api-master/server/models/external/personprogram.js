'use strict';

module.exports = function(PersonProgram) {

  /**
   * Get programs from MD Cloud endpoint and build into response
   *
   * @param  string  id        cjamspid
   * @return array   programs  array of programs
   */
  PersonProgram.getPrograms = async (id) => {
    const app = require('../../../server/server');
    const Person = app.models.Person;
    const mdmId = await Person.getMdmId(id);

    // if no mdmId, return no results
    if(! mdmId) {return [];}

    const EnterpriseSearch = app.models.EnterpriseSearch;
    const response = await EnterpriseSearch.getProgramsByPerson(mdmId);

    // if no response, return no results
    if(! response) {return [];}

    const all = Object.keys(response)
      // get program lists keys
      .filter((key) => key.includes('ProgramList'))
      // use keys to build array of all programs
      .reduce((acc, key) => {
        return acc.concat(response[key]);
      }, []);

    return all.filter((p) => { return p; }).map(program => _transformProgram(program));
  };

  /**
   * Transform to cleaned and presentable program
   *
   * @param  object   MdCloudProgram  from enterprise search
   * @return program  Program         object for program participation
   */
  const _transformProgram = (program) => {
    return {
      irnId: program.name_id,
      source: program.source_id_value,
      program: program.program_cd,
      subProgram: program.program_sub_type,
      status: program.case_status,
      start: program.effective_begin_date,
      end: program.effective_end_date,
      worker: program.case_worker,
      supervisor: program.case_worker_supervisor,
    };
  }
  
  /**
   * Remote endpoint to get programs by cjamspid
   * GET /person/:id/programs
   *
   * @param   id        int     cjamspid
   * @return  programs  array   [Programs]
   */
  PersonProgram.remoteMethod(
    'getPrograms', {
      accepts: [{arg: 'id', type: 'number', required: true}],
      returns: {arg: 'programs', type: 'object', root: true},
      http: {path: '/:id/programs', verb: 'get'},
    }
  );
};
