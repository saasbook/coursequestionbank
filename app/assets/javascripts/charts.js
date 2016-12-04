$(document).ready(function() {

   $(".stats").each(function() {
       debugger
       id = $(this).attr('id').split("_")[1];
       overallAttempts = parseInt($(this).find(".overallAttempts").text().trim());
       wrong_cnt = parseInt($(this).find(".allAttemptsWrongAmount").text().trim());
       data_array_str = $(this).find(".entrys_array").text().trim();
       data_array = data_array_str.substring(1, data_array_str.length - 1).split(",");
       first_success = parseInt($(this).find(".first_success_rate").text().trim());
       firstGraph("first_graph_" + id, first_success);
       totalGraph("total_graph_" + id, overallAttempts, wrong_cnt);
       entrysGraph("entrys_graph_" + id, data_array);
       $(this).find(".plain_text").hide();
   })
});

var entrysGraph = function(divId, entryChoice) {
    yData = [];
    for (i = 0; i < entryChoice.length; ++i) {
        yData.push({name: "Entry " + (i + 1), data: [parseInt(entryChoice[i].trim())]});
    }
    Highcharts.chart(divId, {
        chart: {
            type: 'column'
        },
        title: {
            text: ''
        },
        yAxis: {
            type: 'category',
            title: {
                text: 'Attempt Counts'
            }

        },
        xAxis: {
            allowDecimals: false,
            min: 0,
            title: {
                text: 'First Attempt Choices'
            }
        },

        series: yData,

        dataLabels: {
            enabled: true,
            rotation: -90,
            color: '#FFFFFF',
            align: 'right',
            format: '{point.y:.1f}', // one decimal
            y: 10, // 10 pixels down from the top
            style: {
                fontSize: '13px',
                fontFamily: 'Verdana, sans-serif'
            }
        }
    });
}

var totalGraph = function(divId, overallAttempts, wrong_cnt) {
    Highcharts.chart(divId, {
        chart: {
            type: 'bar'
        },
        title: {
            text: ''
        },
        xAxis: {
            categories: [''],
            title: {
                text: 'Choices'
            }
        },
        yAxis: {
            allowDecimals: false,
            min: 0,
            max: overallAttempts,
            title: {
                text: 'Attempts'
            }
        },
        legend: {
            reversed: true
        },
        plotOptions: {
            series: {
                stacking: 'normal'
            }
        },
        series: [{
            name: 'Correct',
            data: [overallAttempts - wrong_cnt]
        }, {
            name: 'Wrong',
            data: [wrong_cnt]
        }]
    });
}

var totalGraph = function(divId, overallAttempts, wrong_cnt) {
    Highcharts.chart(divId, {
        chart: {
            type: 'bar'
        },
        title: {
            text: ''
        },
        xAxis: {
            categories: ['']
        },
        yAxis: {
            allowDecimals: false,
            min: 0,
            max: overallAttempts,
            title: {
                text: 'Overall Attempts Count'
            }
        },
        legend: {
            reversed: true
        },
        plotOptions: {
            series: {
                stacking: 'normal'
            }
        },
        series: [{
            name: 'Correct',
            data: [overallAttempts - wrong_cnt]
        }, {
            name: 'Wrong',
            data: [wrong_cnt]
        }]
    });
}


var firstGraph = function (divId, success_rate) {
    var gaugeOptions = {
        chart: {
            type: 'solidgauge'
        },
        title: {
            text: ''
        },
        pane: {
            center: ['50%', '85%'],
            size: '130%',
            startAngle: -90,
            endAngle: 90,
            background: {
                innerRadius: '60%',
                outerRadius: '100%',
                shape: 'arc'
            },
        },


        // the value axis
        yAxis: {
            stops: [
                [0.1, '#DF5353'], // red
                [0.5, '#DDDF0D'], // yellow
                [0.9, '#55BF3B'] // green
            ],
            lineWidth: 0,
            minorTickInterval: null,
            tickAmount: 2,
            title: {
                y: -70
            },
            labels: {
                y: 16
            }
        },

        plotOptions: {
            solidgauge: {
                dataLabels: {
                    y: 5,
                    borderWidth: 0,
                    useHTML: true
                }
            }
        }
    };

    Highcharts.chart(divId, Highcharts.merge(gaugeOptions, {
        yAxis: {
            title: {
                text: "First Attempt Success"
            },
            min: 0,
            max: 100,
        },


        series: [{
            name: 'First Success',
            data: [first_success],
            dataLabels: {
                format: '<div style="text-align:center"><span style="font-size:20px;color:' +
                ((Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black') + '">{y}</span><br/>' +
                '<span style="font-size:10px;color:silver">%</span></div>'
            },
        }]
    }));
};

