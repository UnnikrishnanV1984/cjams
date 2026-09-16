import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { CwSearchComponent } from './cw-search.component';

describe('CwSearchComponent', () => {
  let component: CwSearchComponent;
  let fixture: ComponentFixture<CwSearchComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ CwSearchComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CwSearchComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
