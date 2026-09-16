import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { FamilyHistoryCwComponent } from './family-history-cw.component';

describe('FamilyHistoryCwComponent', () => {
  let component: FamilyHistoryCwComponent;
  let fixture: ComponentFixture<FamilyHistoryCwComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ FamilyHistoryCwComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(FamilyHistoryCwComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
