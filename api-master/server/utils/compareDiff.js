const fieldMapping = require("../constants/field-mapping.constants");

function mapDifferences(keyArray) {
  const result = [];
  const seen = {};

  keyArray.forEach(diff => {
    if (fieldMapping.hasOwnProperty(diff) && !seen[diff]) {
      result.push(fieldMapping[diff]);
      seen[diff] = true;
    }
  });

  return result;
}

function compareJSON(val1, val2) {
  const differences = {};

  function compareObj(obj1, obj2, currentPath = '') {
    // If both JSON objects are Arrays, check for differences in objects at corresponding indexes by recursively calling compareObj 
    if (Array.isArray(obj1) && Array.isArray(obj2)) {
      obj1.forEach((value, index) => {
        compareObj(value, obj2[index], `${currentPath}[${index}]`);
      });
      obj2.forEach((value, index) => {
        if (index >= obj1.length) {
          differences[`${currentPath}[${index}]`] = { obj1: undefined, obj2: value };
        }
      });
      // If both are objects are type object, then check if a particular key from object 1 exists in object2 
    } else if (obj1 && typeof obj1 === 'object' &&  obj2 && typeof obj2 === 'object') {
      for (const key in obj1) {
        const newPath = currentPath ? `${currentPath}.${key}` : key;
        compareObj(obj1[key], obj2[key], newPath);
      }
      compareCondObj2(obj1, obj2, currentPath);
      // If objects are not equal then we can directly add them to difference objects
    } else if (obj1 !== obj2) {
      differences[currentPath] = { obj1, obj2 };
    }
  }

  function compareCondObj2(obj1, obj2, currentPath){
    // There might be additional keys in object2 that may exist in object1 in which case we can add this to our differences object with path as the key
    for (const key in obj2) {
      const newPath = currentPath ? `${currentPath}.${key}` : key;
      if (!(key in obj1)) {
        differences[newPath] = { obj1: undefined, obj2: obj2[key] };
      }
    }
  }

  compareObj(val1, val2);
  return differences; // Check for differences.length>0 to check if there are variations in JSON objects.
}

// setNestedValues takes an object, a path as a string, and a value to set at that path.
// It splits the path into parts on '.' characters and then iterates through each part
// Each part is matched for '[]', if it matches then we ensure that an array exists at that key
// If not, we ensure that there is an empty object at that key.
function setNestedValues(obj, path, value) {
  if (path.split('.').length === 1) {
      let current = obj;
      current[path] = value
  } else {
    setNestedValuesMultiple(obj, path, value);
  }
}

function setNestedValuesMultiple(obj,path,value) {
  const parts = path.split('.');
  let current = obj;
  for (let i = 0; i < parts.length; i++) {
    const part = parts[i];
    let match = splitNameAndIndex(part);
    if (match[1] !== undefined) {
      // Handle arrays
      let [key,index] = match;
      current[key] = current[key] || [];
      current = current[key];

      // If it's the last part of the path, set the value; otherwise, prepare for deeper nesting.
      if (i === parts.length - 1) {
        current[index] = value; // Set the value if it's the end of the path
      } else {
        current[index] = current[index] || {}; // Ensure an object exists to continue nesting.
        current = current[index];
      }
    } else {
      // Handle regular objects
      if (i === parts.length - 1) {
        current[part] = value; // Set the value if it's the end of the path
      } else {
        current[part] = current[part] || {}; // Otherwise, ensure the object exists
        current = current[part];
      }
    }
  }
}

function splitNameAndIndex(input) {
  const match = input.match(/^([^\[\]]+)(\[\d+\])?$/);
  return match ? [match[1], match[2] ? parseInt(match[2].slice(1, -1), 10) : undefined] : null;
}

function getJSONDiffObj(myJSONDiff) {
  let diffObj = {};
  for (const key in myJSONDiff) {
    setNestedValues(diffObj, key, myJSONDiff[key].obj1);
  }
  return diffObj;
}

module.exports = {
  compareJSON, getJSONDiffObj, mapDifferences
};