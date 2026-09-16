import { AliasDisplayPipe } from './alias-display.pipe';

fdescribe('AliasDisplayPipe', () => {
  let pipe: AliasDisplayPipe;

  beforeEach(() => {
    pipe = new AliasDisplayPipe();
  });

  it('create an instance', () => {
    expect(pipe).toBeTruthy();
  });

  it('check empty string', () => {
    const aliasempty = '';
    expect(pipe.transform(aliasempty)).toBe('');
  });
  
  
  it('check null', () => {
    const aliasnull = null;
    expect(pipe.transform(aliasnull)).toBe('');
  });

  it('check empty array', () => {
    const aliasarray = [];
    expect(pipe.transform(aliasarray)).toBe('');
  });

  it('check empty object', () => {
    const aliasobjectempty = {};
    expect(pipe.transform(aliasobjectempty)).toBe(' ');
  });

  it('check alias json object with blank name elements', () => {
    const aliasobject = [{
      aliasid: null,
      firstname: "",
      lastname: "",
      middlename: "",
      personid: null,
      prefixtypekey: "",
      sfxname: ""
    }, {
      aliasid: null,
      firstname: "",
      lastname: "",
      middlename: "",
      personid: null,
      prefixtypekey: "",
      sfxname: ""
    }
    ];
    expect(pipe.transform(aliasobject)).toBe('');
  });

  it('check alias json object with missing blank and missing name elements', () => {
    const aliasobject = [{
      aliasid: null,
      lastname: "jones",
      middlename: "",
      personid: null,
      prefixtypekey: "",
      sfxname: ""
    },
    {
      aliasid: null,
      firstname: null,
      lastname: "lasta",
      middlename: "",
      personid: null,
      prefixtypekey: "",
      sfxname: ""
    },
    {
      aliasid: null,
      firstname: "firstb",
      lastname: "lastb",
      middlename: "",
      personid: null,
      prefixtypekey: "",
      sfxname: ""
    }, {  }];
    expect(pipe.transform(aliasobject)).toBe('jones, lasta, firstb lastb');
  });
});
