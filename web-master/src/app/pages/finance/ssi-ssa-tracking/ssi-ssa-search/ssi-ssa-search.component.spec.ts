import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { SsiSsaSearchComponent } from './ssi-ssa-search.component';

describe('SsiSsaSearchComponent', () => {
  let component: SsiSsaSearchComponent;
  let fixture: ComponentFixture<SsiSsaSearchComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ SsiSsaSearchComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SsiSsaSearchComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
