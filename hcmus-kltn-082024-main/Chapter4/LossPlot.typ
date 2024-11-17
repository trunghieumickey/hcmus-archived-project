#import "@preview/plotst:0.2.0": axis, plot, graph_plot, scatter_plot

#let data = ((5.9296, 0.8845), (6.9413, 0.6402), (8.7806, 0.7947), (12.9429, 0.8756), (3.0040, 2.7119), (23.5812, 1.8549), (42.6429, 3.5070), (14.7187, 4.9973), (20.0285, 4.8846))

#let x_axis = axis(min: 0, max: 50, step: 5, location: "bottom", helper_lines: true, title: "Tổng tham số (Triệu)")

#let y_axis = axis(min: 0, max: 6, step: 0.5, location: "left", helper_lines: true, title: "Hàm lỗi")

#let pl = plot(data: data, axes: (x_axis, y_axis))
#scatter_plot(pl, (100%, 65%), caption: "_______________________________________________________")

(5.9296, 0.8845), (6.9413, 0.6402), (8.7806, 0.7947), (12.9429, 0.8756)
(3.0040, 2.7119)
(23.5812, 1.8549), (42.6429, 3.5070)
(14.7187, 4.9973), (20.0285, 4.8846)