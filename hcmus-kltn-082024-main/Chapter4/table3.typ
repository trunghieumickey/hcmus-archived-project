#show table.cell.where(y: 0): set text(weight: "bold")
#set text(size: 10pt)

#figure(
    table(
      columns: 11,
      fill: (_, y) => if y < 2 { green.lighten(90%) },
      table.header(
        table.cell(rowspan: 2, "Các bộ phận"), 
        table.cell(colspan: 9, "Loại bệnh"),
        table.cell(rowspan: 2, "Tổng dữ liệu"),
        [Sarcom], 
        [Sarcoma],	
        [Đại bào],	
        [Sụn],	
        [Không di căn],	
        [Bọc phồng máu],
        [Bọc xương], 
        [Nguyên bào],	
        [Mô bào sợi],	
      ),
      [Đùi], [379],	[217], [126], [52],	[43],	[28],	[27],	[10],	[0], [882],
      [Cánh tay],	[62],	[0], [39], [55], [0],	[16],	[46],	[0], [0],	[218],
      [Mác], [387],	[0], [22], [12], [0], [0], [0],	[0], [0],	[421],
      [Chày],	[113], [70], [92], [0], [0], [0],	[0], [0],	[0], [275],
      [Quay],	[0], [0],	[80],	[0], [0],	[0], [0],	[0], [12], [92],
    ),
    caption: [Số lượng dữ liệu được sử dụng trong tập dữ liệu Bone_Saigon-OTH_NNHLT_1.0]
  )