'use strict';
const xmler = require('xml-js');
const NytdValueTranslator = require('./NytdValueTranslator');

class NytdXml {

  constructor() {

    this.translator = new NytdValueTranslator();

    this.dataFields = {
      file_id: 'CJAMS',
      E1_state: '24',
      file_generation_date: '',
      file_category: 'test',
      E2_report_date: '',
    };

    this.reports = [];
    this._report = [];    // gets set and used by process
    this.tagMap = this.getTagMap();   // maps tagIds to IDs (oldIds)
  }

  getTagMap() {
    const tags = [
      'E1_state',
      'E2_report_date',
      'E3_record_number',
      'E4_date_of_birth',
      'E5_sex',
      'E6_race_american_indian_alaska_native',
      'E7_race_asian',
      'E8_race_black_african_american',
      'E9_race_hawaiian_pacific_islander',
      'E10_race_white',
      'E11_race_unknown',
      'E12_race_declined',
      'E13_hispanic_latino',
      'E14_foster_care_status_services',
      'E15_local_agency',
      'E16_federally_recognized_tribe',
      'E17_adjudicated_delinquent',
      'E18_educational_level',
      'E19_special_education',
      'E20_independent_living_needs_assess',
      'E21_academic_support',
      'E22_post_secondary_educ_support',
      'E23_career_preparation',
      'E24_employment_programs',
      'E25_budget_financial_mgmt',
      'E26_housing_educ_home_mgmt_training',
      'E27_health_educ_risk_prevention',
      'E28_family_support_healthy_marriage_educ',
      'E29_mentoring',
      'E30_supervised_independent_living',
      'E31_room_board_financial_assist',
      'E32_educ_financial_assist',
      'E33_other_financial_assist',
      'E34_outcomes_reporting_status ',
      'E35_date_outcome_data_collection ',
      'E36_foster_care_status_outcomes ',
      'E37_current_full_time_employment',
      'E38_current_part_time_employment',
      'E39_employment_related_skills',
      'E40_social_security',
      'E41_educ_aid',
      'E42_public_financial_assist',
      'E43_public_food_assist',
      'E44_public_housing_assist',
      'E45_other_financial_support',
      'E46_highest_educ_certification',
      'E47_current_enrollment_attendance',
      'E48_connection_adult',
      'E49_homelessness',
      'E50_substance_abuse_referral',
      'E51_incarceration',
      'E52_children',
      'E53_marriage_at_childs_birth',
      'E54_medicaid',
      'E55_other_health_insurance',
      'E56_health_insurance_type_medical',
      'E57_health_insurance_type_mental_health',
      'E58_health_insurance_type_prescription_drugs',
    ];

    return tags.map((tag, index) => {
      const id = index + 1;
      return { id, tag };
    });
  }

  getFormattedDate() {
    const today = new Date();

    const day = ("0" + today.getDate()).slice(-2);
    const month = ("0" + (today.getMonth() + 1)).slice(-2);
    const year = today.getFullYear();
    
    return year + '-' + month +  '-' + day;
  }


  generate(period, reports) {

    this.dataFields['E2_report_date'] = period;
    this.dataFields['file_generation_date'] = this.getFormattedDate();

    this.reports = reports;

    let xml = this.createInit();
    xml = this.addElement(xml, this.createNytdDataSequence());

    return xmler.js2xml(xml);
  }

  generateFields(start, stop) {
    // id/tag/value
    const range = this._report.filter((element) => {
      return (element.id >= start && element.id <= stop);
    });

    return range.map((element) => {
      const name = this._getTagById(element.id);
      const text = this.translateValue(element.id, element.value);

      return this.newElement(name, text);
    });
  }
  
  translateValue(id, value) {
    return this.translator.translate(id, value);
  }

  _getTagById(id) {
    return this.tagMap.find((t) => t.id == id).tag;
  }

  // USED FOR FAKING:

  // generateFields(start, end) {
  //  return [...this._range(start, end)].map(field => this._fakeField(field));
  // }

  // _range(start, end) {
  //     if(start === end) return [start];
  //     return [start, ...this._range(start + 1, end)];
  // }

  // _fakeField(field) {
  //  return this.newElement("E" + field + "_field", "EXAMPLE_" + field + "_FIELD_DATA");
  // }

  createInit() {
    return {
      declaration: {
        attributes: {
          version: '1.0',
          encoding: 'utf-8',
        },
      },
      elements: [],
    };
  }

  createRecord() {
    let record = this.newSequence('record');
    record = this.addElements(record, this.generateFields(3, 13));
    record = this.addElement(record, this.createServedPopulation());
    record = this.addElement(record, this.createBaselineFollowupPopulations());

    return record;
  }

  createDataFields() {
    return Object.keys(this.dataFields).map((field) => {
      return this.newElement(field, this.dataFields[field]);
    });
  }

  createNytdDataSequence() {

    let dataSequence = this.newSequence('tns:nytd_data_file');

    dataSequence = this.addElements(dataSequence, this.createDataFields());

    this.reports.forEach((report) => {
      this._report = report;
      dataSequence = this.addElement(dataSequence, this.createRecord());
    });

    // add attributes to data field
    const attributes = {
      'xmlns:tns': 'http://nytd.acf.hhs.gov',
      'xmlns:xsi': 'http://www.w3.org/2001/XMLSchema-instance',
      'xsi:noNamespaceSchemaLocation': 'nytd_data_file_format.xsd',
      'xsi:schemaLocation': 'http://nytd.acf.hhs.gov nytd_data_file_format.xsd'
    };
    dataSequence = this.addAttributes(dataSequence, attributes);

    // Wrap with data field
    // let dataField = this.newSequence('nytd_data_field');
    // dataField = this.addElement(dataField, dataSequence);

    return dataSequence;
  }

  createServedPopulation() {
    // served population
    let servedPopulation = this.newSequence('served_population');
    servedPopulation = this.addElements(servedPopulation, this.generateFields(14, 33));

    return servedPopulation;
  }

  createBaselineFollowupPopulations() {
    // baseline followup population
    let baselineFollowupPopulations = this.newSequence('baseline_followup_populations');
    baselineFollowupPopulations = this.addElements(baselineFollowupPopulations, this.generateFields(34, 36));
    baselineFollowupPopulations = this.addElement(baselineFollowupPopulations, this.createBaselineFollowupOutcomeSurvey());

    return baselineFollowupPopulations;
  }

  createBaselineFollowupOutcomeSurvey() {
    let baselineFollowupOutcomeSurvey = this.newSequence('baseline_followup_outcome_survey');
    baselineFollowupOutcomeSurvey = this.addElements(baselineFollowupOutcomeSurvey, this.generateFields(37, 58));

    return baselineFollowupOutcomeSurvey;
  }

  addAttribute(element, key, value) {
    if (! element.hasOwnProperty('attributes')) {
      element.attributes = {};
    }

    element.attributes[key] = value;
    
    return element;
  }

  addAttributes(element, object) {

    if (! element.hasOwnProperty('attributes')) {
      element.attributes = {};
    }

    element.attributes = Object.assign(element.attributes, object);
    
    return element;
  }

  addElement(sequence, element) {
    sequence.elements.push(element);
    return sequence;
  }

  addElements(sequence, fields) {
    sequence.elements = sequence.elements.concat(fields);
    return sequence;
  }

  newSequence(name) {
    return {
      type: 'element',
      name,
      elements: [],
    };
  }

  newElement(name, text) {
    const element = this.newSequence(name);
    element.elements.push({
      type: 'text',
      text,
    });
    return element;
  }
}

module.exports = NytdXml;