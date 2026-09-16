import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { CpsDocLetterComponent } from './cps-doc-letter.component';

describe('CpsDocLetterComponent', () => {
  let component: CpsDocLetterComponent;
  let fixture: ComponentFixture<CpsDocLetterComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ CpsDocLetterComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CpsDocLetterComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
