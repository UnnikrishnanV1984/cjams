import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { FosterCareSearchComponent } from './foster-care-search.component';

describe('FosterCareSearchComponent', () => {
  let component: FosterCareSearchComponent;
  let fixture: ComponentFixture<FosterCareSearchComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ FosterCareSearchComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(FosterCareSearchComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
