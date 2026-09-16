import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { InfoDisruptionComponent } from './info-disruption.component';

describe('InfoDisruptionComponent', () => {
  let component: InfoDisruptionComponent;
  let fixture: ComponentFixture<InfoDisruptionComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ InfoDisruptionComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(InfoDisruptionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
