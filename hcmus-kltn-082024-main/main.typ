#set text(
  lang: "vi",
  font: "Times New Roman",
  size: 14pt,
)

#set par(
  leading: .975em,
  first-line-indent: 2em,
  justify: true
)

#set page(
  paper: "a4",
  margin: ( 
    top: 3cm,
    bottom: 3.5cm,
    left:3.5cm,
    right:2cm
  )
)

//title
#include "Title/title.typ"
#pagebreak()

//Đếm lại các trang đầu
#set page(numbering: "i")
#counter(page).update(1)

//Lời Cám ơn
#include "Other/thankyou.typ"
#pagebreak()

//Đề cương
#hide[= *ĐỀ CƯƠNG CHI TIẾT*]
#pagebreak()

//Mục lục
#align(center)[= *MỤC LỤC*]
#{ "" } // Trick on first line

#show outline.entry.where(
  level: 1
): it => {
  v(16pt, weak: true)
  strong(it)
}

#outline(title: none, depth:2, indent: auto)
#pagebreak()

//Các từ ngữ anh việt
#include "Other/Eng_word.typ"
#pagebreak()

//Tóm tắt
#include "Other/summary.typ"
#pagebreak()

//Đếm lại trang
#set page(numbering: "1")
#counter(page).update(1)

#set heading(numbering: (..numbers) => {
  if (numbers.pos().len() == 1) {
    return numbering("Chương 1:", numbers.pos().at(0))
  } else {
    return numbering("1.", ..numbers.pos())
  }
}
)

//Nội dung
#for i in range(1,6) [
  #include "Chapter" + str(i) + "/chapter" + str(i) + ".typ"
  #pagebreak()
]

//Tài liệu liên quan
#bibliography("Reference/ref.bib", style: "ieee")