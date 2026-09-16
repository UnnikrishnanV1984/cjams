import { Component, Input, OnInit } from '@angular/core';
import * as Highcharts from'highcharts';

@Component({
  selector: 'bar-graph',
  templateUrl: './bar-graph.component.html',
  styleUrls: ['./bar-graph.component.scss'],
  standalone: false
})
export class BarGraphComponent implements OnInit {

  constructor() { }
  @Input() chartData:{name?:string,data:number[]}[]=[];
  @Input() categories:string[]=[];
  @Input() colors :string[]=[];

  Highcharts : typeof Highcharts =Highcharts;
  chartOptions:Highcharts.Options={};

  ngOnInit(): void {
    this.buildgraph()
  }
  private buildgraph() {
    this.chartOptions={
      chart:{type:'column'},
      accessibility: { 
        enabled :false },
      title:{text:''},
      xAxis:{
        categories: this.categories,
        title:{text:null}
      },
      yAxis: {
        min:0,
        title:{text:''}
      },
      series:this.chartData as Highcharts.SeriesOptionsType[],
      credits:{enabled:false},
      plotOptions:{
        column:{
          dataLabels:{enabled:false}
        }
      },
      
      colors:this.colors,

      legend : 
      {
        enabled:false
      }
     
    };
  }

}
