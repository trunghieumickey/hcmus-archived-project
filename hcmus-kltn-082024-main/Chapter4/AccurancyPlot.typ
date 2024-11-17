#import "@preview/plotst:0.2.0": axis, plot, graph_plot, scatter_plot

#let data = ((5.9296, 87.11), (6.9413, 88.15), (8.7806, 87.11), (12.9429, 85.63), (3.0040, 83.70), (23.5812, 75.85), (42.6429, 69.63), (14.7187, 68.15), (20.0285, 69.33))

#let x_axis = axis(min: 0, max: 50, step: 5, location: "bottom", helper_lines: true, title: "Tổng tham số (Triệu)")

#let y_axis = axis(min: 60, max: 95, step: 5, location: "left", helper_lines: true, title: "Độ chính xác (%)")

#let pl = plot(data: data, axes: (x_axis, y_axis))
#scatter_plot(pl, (100%, 65%), caption: "_______________________________________________________")

(5.9296, 87.11), (6.9413, 88.15), (8.7806, 87.11), (12.9429, 85.63)
(3.0040, 83.70)
(23.5812, 75.85), (42.6429, 69.63),
(14.7187, 68.15), (20.0285, 69.33)