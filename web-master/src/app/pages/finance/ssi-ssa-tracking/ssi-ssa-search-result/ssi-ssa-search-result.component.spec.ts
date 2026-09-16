import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { SsiSsaSearchResultComponent } from './ssi-ssa-search-result.component';

describe('SsiSsaSearchResultComponent', () => {
  let component: SsiSsaSearchResultComponent;
  let fixture: ComponentFixture<SsiSsaSearchResultComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ SsiSsaSearchResultComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SsiSsaSearchResultComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
