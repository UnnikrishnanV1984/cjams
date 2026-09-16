import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { InHomeServiceComponent } from './in-home-service.component';

describe('InHomeServiceComponent', () => {
  let component: InHomeServiceComponent;
  let fixture: ComponentFixture<InHomeServiceComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ InHomeServiceComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(InHomeServiceComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
