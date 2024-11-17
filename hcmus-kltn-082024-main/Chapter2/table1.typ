//#set table(stroke: (_, y) => if y > 0 { (top: 0.8pt) })
#show table.cell.where(y: 0): set text(weight: "bold")
#set text(size: 10pt)
#rotate(
  -90deg,
  reflow: true,
  figure(
    table(
      columns: 5,
      fill: (_, y) => if calc.odd(y) { green.lighten(90%) },
      table.header(
        [Nguồn],
        [Năm],
        [Kiến trúc],
        [Tập dữ liệu],
        [Hiệu suất],
      ),
      [@yamamoto2020deep], [2020], [EfficientNet b3], [Hình ảnh X-ray xương bệnh nhân của 1131 bệnh nhân của một bệnh viện (708 ảnh bị bệnh và 423 không bị)], [Độ chính xác: 0.885;\ Độ nhay: 0.887;\ Điểm F1: 0.8943;\ Điểm AUC: 0.9374],
      [@murata2020artificial],[2020], [Mô hình tích chập học sâu], [Hình ảnh X-ray được chụp bằng phương pháp PTLR (Plain thoracolumbar radiography) của 300 bệnh nhân], [Độ chính xác: 0.86;\ Độ nhạy: 0.847;\ Độ đặc hiệu: 0.873], 
      [@ni2023deep], [2023], [Mô hình tích chập học sâu], [675 hình ảnh CT ngực của 109 bệnh nhân vị thành niên và thanh niên với bệnh ung thư xương], [Điểm AUC: 0.76 - 0.79], 
      [@aziz2023novel],[2023],[DensNet-121], [40 toàn bộ hình ảnh slide đã được chọn từ các bệnh nhân bị bệnh ở bệnh viện nhi],[Độ chính xác: 0.8868;\ Điểm AUC: 0.9698], 
      [@vaiyapuri2022design],[2022],[Mô hình tích chập học sâu\ Adaptive Neuro Fuzzy Inference System], [1144 hình ảnh từ dữ liệu về ung thư xương từ UT Southwestern/UT Dallas để đánh giá khối u hoại tử và khả thi], [Điểm AUC: 0.9971],
      [@fakieh2022optimal],[2022], [SqueezeNet], [1000 hình ảnh y sinh học Sarcoma Xương], [Điểm AUC: 0.9922],
    ),
    caption: [Tóm tắt các bài báo về ứng dụng mô hình tích chập vào y khoa]
  )
)