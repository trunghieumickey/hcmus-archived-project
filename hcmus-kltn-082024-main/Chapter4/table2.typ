#show table.cell.where(y: 0): set text(weight: "bold")
#set text(size: 10pt)

#figure(
    table(
      columns: 8,
      fill: (_, y) => if calc.odd(y) { green.lighten(90%) },
      table.header(
        [Kiến trúc],
        [Hàm lỗi],
        [Chính xác],
        [AUC],
        [Chuẩn xác],
        [Nhạy],
        [F1], 
        [Tổng Tham số]
      ),
      [EfficientNetV2B0],	[0.8845],	[0.8711],	[0.9525],	[0.8854],	[0.8696],	[0.7841], [5929560], 
      [EfficientNetV2B1],	[0.6402],	[0.8815],	[0.9625],	[0.8953],	[0.8741],	[0.8240],	[6941372],
      [EfficientNetV2B2],	[0.7947],	[0.8711],	[0.9588],	[0.8816],	[0.8711],	[0.7482],	[8780646],
      [EfficientNetV2B3],	[0.8756],	[0.8563],	[0.9615],	[0.8662],	[0.8533],	[0.7593], [12942918],
      [MobileNetV2Large],	[2.7119],	[0.8370],	[0.9317],	[0.8395],	[0.8370],	[0.7163],	[3004040],
      [ResNetV2 50], [1.8549], [0.7585], [0.9170], [0.7676], [0.7585], [0.5895],	[23581192],
      [ResNetV2 101],	[3.5070],	[0.6963],	[0.8734],	[0.6985],	[0.6933],	[0.3892],	[42642952],
      [VGG16], [4.9973], [0.6815], [0.8785], [0.6951], [0.6756], [0.5029], [14718792],
      [VGG19], [4.8846], [0.6933], [0.8688], [0.6951], [0.6889], [0.4414],	[20028488],
      [GC-ViT],	[1.5975],	[0.2619],	[0.6381],	[0.0625],	[0.0079],	[0.0830], [50327018],
    ),
    caption: [Kết quả chạy với tập dữ liệu ở bộ phận Đùi]
  )