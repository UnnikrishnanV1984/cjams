const objecttype_array = '[object Array]';

const UUID_PATTERN = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

/**
 * Case/service-case ids are uuid columns in Postgres, so an unresolved id is bound
 * as text and the whole statement fails with 22P02 invalid input syntax for type
 * uuid -- which the api rewrites to a bare 400. The values that get here are route
 * params and data-store lookups, so they can be the '0' add/new sentinel, the
 * strings 'null'/'undefined' that the router writes for an absent link value, or
 * undefined when the store was never populated. Use this before sending an id to
 * an endpoint that filters on one.
 */
export const isCaseUuid = (id: any): boolean =>
    typeof id === 'string' && UUID_PATTERN.test(id.trim());

/** A leading origin and/or one-or-more '/api' segments -- the prefix noise below. */
const API_PREFIX_NOISE = /^(?:https?:\/{1,2}[^/]+)?(?:\/api)+/i;

/**
 * documentproperties.s3bucketpathname / personbasicdetails.userphoto are stored as
 * api-root-relative paths ('/attachments/downloadFileFromECMS?docId=...'), and the
 * screens that display them prepend either '/api' or AppConfig.baseUrl -- which
 * already ends in '/api'. Several of those prepends write back into the same shared
 * object the listener re-delivers, so each pass adds another prefix and the value
 * that gets saved is already polluted. The result is a request to
 * '/api/apihttps:/<host>/api/api/attachments/downloadFileFromECMS', which no route
 * serves: loopback#urlNotFound raises a 404 that error-logger rewrites to
 * statusCode 400, so APM shows a bare "HttpError 400, No stack trace".
 *
 * Strip every layer back to the api-root-relative path so prefixing is idempotent
 * and rows that were already saved polluted still resolve.
 */
export const apiResourcePath = (url: any): string => {
    let path = (url === null || url === undefined) ? '' : String(url);
    let stripped = path.replace(API_PREFIX_NOISE, '');
    while (stripped !== path) {
        path = stripped;
        stripped = path.replace(API_PREFIX_NOISE, '');
    }
    return path;
};

export const initializeObject = <TTarget, TSource>(target: TTarget | any, source: TSource | any) => {
    if (target === undefined || source === undefined) {
        return;
    }
    Object.keys(source).forEach(key => {
        target[key] = source[key];
    });
};

export const titleCase = (str: any) => {
    if (str) {
        str = str.toLowerCase().split(' ');
        for (let i = 0; i < str.length; i++) {
            str[i] = str[i].charAt(0).toUpperCase() + str[i].slice(1);
        }
        return str.join(' ');
    } else {
        return '';
    }
};

export const hasMatch = (left: Array<string>, right: Array<string>) => {
    const intersected = right.reduce((acc: any, curr: any) => {
        return [...acc, ...left.filter(item => item.trim().toUpperCase() === curr.trim().toUpperCase())];
    }, []);
    return intersected.length > 0;
};

export const groupBy = (items: any, key: any) =>
    items.reduce(
        (result: any, item: any) => ({
            ...result,
            [item[key]]: [...(result[item[key]] || []), item]
        }),
        {}
    );
export const toMilliSeconds = (h: any, m: any, s: any) => (h * 60 * 60 + m * 60 + s) * 1000;

// Usage
export const dhm = (t: number) => {
    // tslint:disable-next-line:prefer-const
    const cd = 24 * 60 * 60 * 1000;
    // tslint:disable-next-line:prefer-const
    const ch = 60 * 60 * 1000;
    var d = Math.floor(t / cd);
    var h = Math.floor((t - d * cd) / ch),
        m = Math.round((t - d * cd - h * ch) / 60000);
        // tslint:disable-next-line:prefer-const
       const pad = function (n: any) {
            return n < 10 ? '0' + n : n;
        };
    if (m === 60) {
        h++;
        m = 0;
    }
    if (h === 24) {
        d++;
        h = 0;
    }
    return d + ' days : ' + pad(h) + ' hours : ' + pad(m) + ' mins ';
};

export const countdown = (function() {
    const pad = (t: string): any => {
        return (t + '').length < 2 ? pad('0' + t + '') : t;
    };
    return (s: any) => {
        const d = Math.floor(s / (3600 * 24));
        s -= d * 3600 * 24;
        const h = Math.floor(s / 3600);
        s -= h * 3600;
        const m = Math.floor(s / 60);
        s -= m * 60;
        const tmp = [];
        // tslint:disable-next-line:no-unused-expression
        d && tmp.push(d + 'd');
        // tslint:disable-next-line:no-unused-expression
        (d || h) && tmp.push(h + 'h');
        // tslint:disable-next-line:no-unused-expression
        (d || h || m) && tmp.push(m + 'm');
        tmp.push(s + 's');
        return tmp.join(' ');
    };
})();

// Compare two items
const compare = function(item1: any, item2: any) {
    // Get the object type
    const itemType = Object.prototype.toString.call(item1);

    // If an object or array, compare recursively
    if ([objecttype_array, '[object Object]'].indexOf(itemType) >= 0) {
        if (!ObjectUtils.isArrayEqual(item1, item2)) {
            return false;
        }
    } else {
        // If the two items are not the same type, return false
        if (itemType !== Object.prototype.toString.call(item2)) {
            return false;
        }

        // Else if it's a function, convert to a string and compare
        // Otherwise, just compare
        if (itemType === '[object Function]') {
            if (item1.toString() !== item2.toString()) {
                return false;
            }
        } else {
            if (item1 !== item2) {
                return false;
            }
        }
    }
};

const compareInput = function(type: any,valueLen: any,value: any, other: any) {
    // Compare properties
    if (type === objecttype_array) {
        for (let i = 0; i < valueLen; i++) {
            if (compare(value[i], other[i]) === false) {
                return false;
            }
        }
    } else {
        for (const key in value) {
            if (compare(value[key], other[key]) === false) {
                return false;
            }
        }
    }
    return true;
};

export class ObjectUtils {
    static getChildObjectValue = (o: { [key: string]: any }, id: string): { [key: string]: any } | undefined => {
        if (o[id] === id) {
            return o;
        }
        let result, p;
        for (p in o) {
            if (o.hasOwnProperty(p) && typeof o[p] === 'object') {
                if (o[p]) {
                    result = ObjectUtils.getChildObjectValue(o[p], id);
                    if (result) {
                        return result;
                    }
                }
            }
        }
        return result;
    }
    static getNestedObject = (nestedObj: any, pathArr: any) => {
        return pathArr.reduce((obj: any, key: any) => (obj && obj[key] !== 'undefined' ? obj[key] : undefined), nestedObj);
    }
    static removeEmptyProperties = <TSource>(source: TSource | any, removeEmpty: boolean = true, removeNull: boolean = true, removeFalse: boolean = true) => {
        if (source === undefined) {
            return;
        }
        Object.keys(source).forEach((key: any) => {
            if (removeNull && (source[key] === null || source[key] === undefined)) {
                delete source[key];
            }
            if (removeEmpty && source[key] === '') {
                delete source[key];
            }
            if (removeFalse && source[key] === false) {
                delete source[key];
            }
        });
    }

    static objectsAreSame(x: { [x: string]: any; }, y: { [x: string]: any; }) {
        let objectsAreSame = true;
        for (const propertyName in x) {
            if (x[propertyName] !== y[propertyName]) {
                objectsAreSame = false;
                break;
            }
        }
        return objectsAreSame;
    }

    static isArrayEqual(value: string | any[], other: string | any[]) {
        // Get the value type
        const type = Object.prototype.toString.call(value);

        // If the two objects are not the same type, return false
        if (type !== Object.prototype.toString.call(other)) {
            return false;
        }

        // If items are not an object or array, return false
        if ([objecttype_array, '[object Object]'].indexOf(type) < 0) {
            return false;
        }

        // Compare the length of the length of the two items
        const valueLen = type === objecttype_array ? value.length : Object.keys(value).length;
        const otherLen = type === objecttype_array ? other.length : Object.keys(other).length;
        if (valueLen !== otherLen) {
            return false;
        }
        //SonarQube - broke the function to reduce complexity
        if(compareInput(type,valueLen,value, other) === false){
            return false;
        }

        // If nothing failed, return true
        return true;
    }

    static groupBy(array: any[], f: Function) {
        const groups:any = {};
        array.forEach(o => {
            const group = JSON.stringify(f(o));
            groups[group] = groups[group] || [];
            groups[group].push(o);
        });
        return Object.keys(groups).map(group => {
            return groups[group];
        });
    }

    static checkTrueProperty = <TSource>(source: TSource | any, count: number = 0) => {
        if (source === undefined) {
            return 0;
        }
        Object.keys(source).forEach(key => {
            if (source[key] === true) {
                count++;
            }
        });

        return count;
    }
}
