import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { TitleIveFosterCarComponent } from './title-ive-foster-car.component';

describe('TitleIveFosterCarComponent', () => {
  let component: TitleIveFosterCarComponent;
  let fixture: ComponentFixture<TitleIveFosterCarComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ TitleIveFosterCarComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(TitleIveFosterCarComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
