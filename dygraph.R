interval_value_formatter <- "function(num, opts, seriesName, g, row, col) {
  value = g.getValue(row, col);
  if(value[0] != value[2]) {
    lower = Dygraph.numberValueFormatter(value[0], opts);
    upper = Dygraph.numberValueFormatter(value[2], opts);
    return '[' + lower + ', ' + upper + ']';
  } else {
    return Dygraph.numberValueFormatter(num, opts);
  }
}"

dygraph.func <- function(model, main, height = '400px', width = '100%', ylab = "Monthly Orange bought"){
  graph <- cbind(actuals = model$x, pointfc_mean = model$mean,
                     lower_30 = model$lower[,1], upper_30 = model$upper[,1],
                     lower_50 = model$lower[,2], upper_50 = model$upper[,2],
                     lower_70 = model$lower[,3], upper_70 = model$upper[,3])
  
  dygraph(graph, main = main) %>%
    dySeries(name = "actuals") %>%
    dySeries(name = "pointfc_mean", label = "forecast") %>%
    dySeries(name = c("lower_30", "pointfc_mean", "upper_30"), label = "30% PI") %>%
    dySeries(name = c("lower_50", "pointfc_mean", "upper_50"), label = "50% PI") %>%
    dySeries(name = c("lower_70", "pointfc_mean", "upper_70"), label = "70% PI") %>%
    dyLegend(show = "always", hideOnMouseOut = FALSE, labelsSeparateLines = TRUE) %>%
    dyAxis("y", valueFormatter = interval_value_formatter) %>%
    dyAxis("x", axisLabelFormatter = 'function(d){ var month = d.getMonth().toString().fontsize(3) ;var year = d.getFullYear().toString().fontsize(3); return  year}') %>%
    dyHighlight(highlightCircleSize = 5, 
                highlightSeriesOpts = list(strokeWidth = 2)) %>%
    dyCSS(textConnection(
    ".dygraph-legend { left: 70px !important;
      background-color: rgba(255, 255, 255, 0.5) !important; }
      .dygraph-title {color: navy; font-weight: bold;}
      .dygraph-axis-label {font-size: 11px;}")) %>%
    dyOptions(labelsKMB = "K", axisLineColor = "navy", gridLineColor = "grey", 
              digitsAfterDecimal = 1, colors = c("black", "#FF3399", "#00CCFF", "#33FF00"))
}

