'use strict';

class NytdValueTranslator {


	constructor() {

		this.translations = {
			nullToBlank: ['*'],
			date: [4,35],
			countyCode: [15],
			withoutGrade: [18],
			toNotApplicable: ['*'],
			toLowercase: ['*'],
			reportingStatus: [34],
			highEduCert: [46]
		}
		
		this.countyCodes = {
			"Allegany": "24001",
			"Anne Arundel": "24003",
			"Baltimore County": "24005",
			"Calvert": "24009",
			"Caroline": "24011",
			"Carroll": "24013",
			"Cecil": "24015",
			"Charles": "24017",
			"Dorchester": "24019",
			"Frederick": "24021",
			"Garrett": "24023",
			"Harford": "24025",
			"Howard": "24027",
			"Kent": "24029",
			"Montgomery": "24031",
			"Prince George's": "24033",
			"Queen Anne's": "24035",
			"St. Mary's": "24037",
			"Somerset": "24039",
			"Talbot": "24041",
			"Washington": "24043",
			"Wicomico": "24045",
			"Worcester": "24047",
			"Baltimore City": "24510",
			"DHS":"centralized unit"
		}

		this.reportingStatuses = {
			"youth participated": "participated",
			"youth declined": "declined",
			// "parent declined": "parent declined",
			"youth incapacitated": "incapacitated",
			// "incarcerated": "incarcerated",
			"runaway/missing": "runaway missing",
			"unable to locate/invite": "unable to locate"
			// "death": "death",
			// "not in sample": "not in sample"
		}

		this.highEduCert = {
			"high school diploma/ged": "high school ged",
			// "vocational certificate": "vocational certificate",
			// "vocational license": "vocational license",
			"associate's degree(e.g., a.a.)": "associate",
			"bachelor's degree(e.g., b.a. or b.s.)": "bachelor"
			// "higher degree": "higher degree",
			// "none of the above": "none of the above",
			// "declined":"declined"
		}
	}

	translate(id, value) {
		let translated = value;

		Object.keys(this.translations).forEach(key => {
			if (this.translations[key].map(v => v.toString()).includes(id) 
					|| this.translations[key].includes('*')) {
				const method = `translate${this.capitalize(key)}`;
				translated = this[method](translated);
			}
		})

		return translated;
	}

	capitalize(value) {
		return value[0].toUpperCase() + value.slice(1); 
    }

	/*
	 * Translate date from mm/dd/yyyy to yyyy-mm-dd format
	 *
	 * @param  date  mm/dd/yyyy string representation of date to be translated
	 * @returns  translateDate  string of date in yyyy-mm-dd
	 */
	translateDate(date) {
		if (date === "") {
			return date;
		}

		// split by delimiter
		const segments = date.split('/');
		// reformat mm/dd/yyyy -> yyyy-mm-dd
		return `${segments[2]}-${segments[0]}-${segments[1]}`
	}


	/*
	 * Elements: 5 - 14
	 */
	translateToLowercase(value) {
		return (value === null || value === undefined ? value : value.toLowerCase());
	}

	/*
	 * Elements: 14
	 */
	translateNullToBlank(value) {
		return (value === null ? "" : value);
	}

	translateCountyCode(value) {
		if (Object.keys(this.countyCodes).includes(value)) {
			return this.countyCodes[value]
		}
		return value;
	}

	translateReportingStatus(value) {
		if (Object.keys(this.reportingStatuses).includes(value)) {
			return this.reportingStatuses[value]
		}
		return value;
	}

	translateHighEduCert(value) {
		if (Object.keys(this.highEduCert).includes(value)) {
			return this.highEduCert[value]
		}
		return value;
	}

	translateWithoutGrade(value) {
		// remove nth grade
		const index = value.toLowerCase().indexOf('th grade')
		if (index && index !== -1) {
			return (value.substring(0, index)).toLowerCase() === 'less than 6' ? 'under 6' : value.substring(0, index);
		// direct translate
		} else if (value.toLowerCase() === 'post secondary education or training') { 
			return 'post secondary'
		} else if (value.toLowerCase() === 'college') {
			return 'college'
		}

		return value
	}

	translateToNotApplicable(value) {
		return (value === 'NA' ? "not applicable" : value);
	}
}

module.exports = NytdValueTranslator;