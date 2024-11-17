= Các công trình liên quan
#{ "" } // Trick on first line

Chương này của khóa luận sẽ giới thiệu các nghiên cứu và bài báo liên quan đến phân lớp ảnh y khoa và giải thích quá trình này thông qua trí tuệ nhân tạo khả diễn. Mục đích là phân tích các phương pháp đã được áp dụng, đánh giá ưu điểm và nhược điểm của chúng, và xác định mức độ khả thi cũng như sự phù hợp để áp dụng vào phương pháp được đề xuất trong khóa luận này.

== Phân lớp ảnh y khoa
=== Mạng nơ-ron tích chập
#{ "" } // Trick on first line

Một bài báo viết về việc áp dụng các biến thể của kiến trúc mạng VGG16 cho trí thông minh nhân tạo để thực hiện chẩn đoán bệnh loãng xương @lee2020evaluation. Các nhà nghiên cứu đã sử dụng tập dữ liệu chụp từ 680 bệnh nhân của một bệnh viện mà họ được phép, thực hiện các bước tiền xử lý để đưa ra tập ảnh phù hợp, thực hiện việc học máy với các mô hình mà họ nghiên cứu và đưa ra các thông số về độ chính xác, độ nhạy và độ đặc hiệu của mỗi mô hình khi được luyện với tập dữ liệu đấy. Với độ chính xác cao nhất là 0.855 khi tập dữ liệu được luyện với mô hình VGG16-TR_FT, họ cho thấy được hiệu quả tốt khi dùng các mô hình tích chập cho việc sàng lọc bệnh loãng xương. Họ nhấn mạnh thêm về các ưu điểm khi sử dụng mô hình trên khi đào tạo với tập dữ liệu nhỏ và sử dụng Grad-CAM để trực quan hóa và hiểu rõ quá trình quyết định của mô hình.

Ở một bài báo khác, Girija Chetty và các cộng sự @chetty2022low sử dụng kiến trúc mạng nơ ron tích chập qua việc sử dụng mô hình 3D UNet để thực hiện phân đoạn các vùng mô khối u trong não từ các ảnh MRI đa chiều. Các tác giả đã sử dụng tập dữ liệu trong cuộc thi BraTS 2018 gồm các bản quét MRI đa phương thức và các nhãn thực tế cơ bản để phân chia khối u não. Mô hình trên đạt được kết quả khá ấn tượng với hệ số Dice đạt 0.9385 trên bộ dữ liệu thử nghiệm độc lập và độ mất Dice là 0.0614 cho thấy được hiệu suất cao trong việc phân chia các vùng khối u não.

#figure(
  image("images\Picture1.png", width: 100%),
  caption: [Mô hình tích chập 3D UNet được đề xuất @chetty2022low],
)

#{ "" } // Trick on first line

Ngoài ra, nhóm còn tìm thấy nhiều bài báo nghiên cứu khác về sử dụng mô hình tích chập vào phân lớp ảnh y khoa và được liệt kê ở bảng dưới đây với các kiểu mô hình, tập dữ liệu sử dụng, phương pháp thực hiện và kết quả thông số đầu ra được nêu ra trong bài báo nghiên cứu đấy. 

#pagebreak()
#include "table1.typ"
#pagebreak()

=== Mạng Transformer
#{ "" } // Trick on first line

Hiện nay, mô hình học sâu Transformer đang ngày càng phát triển và được công nhận rộng rãi không chỉ là trong xử lý ngôn ngữ tự nhiên mà còn được công nhận về giá trị của chúng trong các nhiệm vụ thị giác máy tính thông qua sự xuất hiện của mô hình biến đổi trực quan. Chính vì vậy, đã có rất nhiều bài báo, nghiên cứu so sánh giữa mô hình Transformer và mô hình tích chập. Bài báo chỉ ra rằng biến đổi trực quan tốt hơn mô hình tích chập về mặt xử lý các hình ảnh nhiễu hoặc được tăng cường và quản lý hoạt động tốt hơn do cơ chế tự chú ý làm cho các thông tin hình ảnh tổng thể được tiếp nhận đầy đủ @mauricio2023comparing. 

Mô hình biến đổi trực quan được sử dụng rất nhiều trong xử lý hình ảnh và phân tích các ảnh y tế. Tuy vậy, mô hình đấy cũng có một số vấn đề khiến cho việc áp dụng vào phân tích các hình ảnh y khoa khó thực hiện. Trong một bài báo nói về các ưu điểm về Transformer và các ứng dụng trong y khoa, các nhà nghiên cứu có chỉ ra một số vấn đề cần chú ý khi sử dụng mô hình này là số lượng ảnh y khoa thường không có đủ nhiều nên không thể tối ưu việc học mô hình, thông tin vị trí vùng xác định để thực hiện học của các ảnh y khoa là khác nhau, cơ chế tự chú ý chỉ tác dụng với các bản vá hình ảnh @pu2024advantages. Chính vì vậy, gần đây, các nhà nghiên cứu đã phát triển một kiểu mô hình học mới kết hợp những yếu tố cơ bản của mô hình tích chập vào kiến trúc mô hình Transformer, được gọi là các mô hình hỗn hợp và đạt được hiệu quả cao trong phân đoạn và phân lớp hình ảnh y khoa. 

Có khá nhiều bài báo đưa ra các mô hình hỗn hợp đấy và đưa ra các kết quả khả quan. Một bài báo đưa ra phương pháp áp dụng một mô hình học kết hợp với mô hình Transformer và mô hình Unet để phân đoạn chính xác bệnh và giải quyết các vấn đề về góc cạnh không rõ nét @lv2023artificial. Họ cũng sử dụng một tập dữ liệu hình ảnh MRI Sarcoma xương bệnh nhân được thu thập đưa vào bước tiền xử lý qua các phương pháp sàng lọc dữ liệu thừa, giảm nhiễu ảnh, thực hiện học máy với mô hình kết hợp trên để hỗ trợ xử lý ảnh và phân đoạn ảnh để đưa ra các kết quả hợp lý @lv2023artificial. Với kết quả thông qua tập dữ liệu mà họ sử dụng qua hệ số tương đồng Dice là 0.949, nó cho thấy rằng phương pháp trên cho hiệu quả phân đoạn tốt @lv2023artificial.

#figure(
  image("images\Picture2.png", width: 100%),
  caption: [Phân đoạn hình ảnh y khoa qua mô hình TBNet  @lv2023artificial],
)

#{ "" } // Trick on first line

Ngoài ra, một bài báo cũng sử dụng mô hình kết hợp giữa mô hình kết hợp giữa mô hình Transformer và mô hình Unet tạo ra mô hình "Twin-self and cross-attention vision transformer" (TSCA-ViT) để học 1000 hình ảnh slide bệnh lý đã qua tiền xử lý và đưa ra tỉ lệ độ chính xác là 0.977 @he2023innovative. 

#figure(
  image("images\Picture3.png", width: 86%),
  caption: [Cấu trúc mô hình TSCA - ViT @he2023innovative],
)

#{ "" } // Trick on first line

Không chỉ vậy, một bài báo cũng sử dụng mô hình lai kết hợp ở hai bài báo trên để so sánh với các mô hình học khác với tập dữ liệu gồm 80000 ảnh MRI về bênh từ các bệnh viện ở Trung Quốc với tỉ lệ độ chính xác là 0.95, cho thấy được tiềm năng của mô hình trên @liu2022auxiliary. Họ xây dựng phương pháp phân đoạn Osteosarcoma dựa trên Mạng song phương tổng hợp có hướng dẫn @liu2022auxiliary. Với phương pháp này, nó giải quyết thách thức trong việc phân chia ung thư xương trong hình ảnh MRI, điều này rất quan trọng trong chẩn đoán và điều trị. Không chỉ vậy, phương pháp trên nhằm mục đích đạt được sự cân bằng giữa độ chính xác của phân đoạn và độ phức tạp của mô hình, xem xét các hạn chế về phần cứng.

== Giải thích kết quả phân qua trí tuệ nhân tạo khả diễn 
=== Sự cần thiết của trí tuệ nhân tạo khả diễn
#{ "" } // Trick on first line

Sự tiến bộ nhanh chóng của trí thông minh nhân tạo thông qua việc phát triển các mô hình học máy đã cải thiện đáng kể độ chính xác về kết quả trong các ứng dụng thị giác máy tính như phân tích và nhận dạng vật thể. Phân tích hình ảnh y tế cũng đã tiến bộ với các mô hình học máy tiên tiến hỗ trợ việc phân loại bệnh dựa trên dữ liệu bệnh nhân có sẵn tại các bệnh viện. 

Mặc dù có những tiến bộ trên, trí thông minh nhân tạo vẫn chưa được áp dụng trong khám bệnh lâm sàng. Theo Zachary C. Lipton @lipton2017doctor, một trong những lý do chính là các bác sĩ không thể tin tưởng vào kết quả của mô hình nếu họ không hiểu được cơ sở và nguyên lý đằng sau đó. Hiện nay, các quốc gia, đặc biệt là các quốc gia ở Châu Âu, đã đưa ra luật yêu cầu các ứng dụng trí thông minh nhân tạo phải có khả năng giải thích để người dùng có thể hiểu rõ nguyên nhân của các kết quả, đặc biệt là những ứng dụng có ảnh hưởng đến con người. Điều này đã dẫn đến nhu cầu và yêu cầu bắt buộc phải có kỹ thuật giải thích kết quả của trí thông minh nhân tạo. 

Việc sử dụng trí tuệ nhân tạo khả diễn trong các ứng dụng thị giác máy tính không chỉ nhằm hỗ trợ cho người dùng dễ hiểu về các kết quả mà trí thông minh nhân tạo đề ra mà còn phù hợp với xu hướng trí thông minh nhân tạo của thế giới hiện nay. Ngoài ra, nó còn mở ra một hướng đi mới về việc tạo ra các mô hình học có khả năng giải thích cho các ứng dụng trí thông minh nhân tạo trong tương lai @dw2019darpa.

=== Trí tuệ nhân tạo khả diễn giải thích kết quả tiên đoán trong phân lớp
#{ "" } // Trick on first line

Theo C. Patrício và các đồng nghiệp @patricio2023explainable, để trí tuệ nhân tạo khả diễn có thể giải thích các kết quả chẩn đoán sau khi phân lớp thì có các phương pháp sau:

- *Phương pháp giải thích trực quan*: Sử dụng bản đồ saliency, phương pháp CAM và Grad-CAM để tạo ra các bản đồ trực quan giải thích quyết định của mô hình.

-	*Phương pháp giải thích bằng văn bản*: Tạo ra các báo cáo hoặc khái niệm văn bản để giải thích quyết định của mô hình.

-	*Phương pháp dựa trên ví dụ*: Sử dụng các ví dụ tương tự để giải thích quyết định của mô hình.

-	*Phương pháp dựa trên khái niệm*: Sử dụng các khái niệm cấp cao để giải thích quyết định của mô hình, giúp các bác sĩ dễ dàng hiểu và tương tác với trí thông minh nhân tạo.

#{ "" } // Trick on first line

Còn đối với Van Der Velden và các cộng sự @van2022explainable, họ rút lại xuống còn 3 phương pháp chính là giải thích trực quan, giải thích bằng văn bản và giải thích dựa trên ví dụ. Dù họ có rút lại xuống làm ba phương pháp nhưng nội dung và cách thức của ba phương pháp trên giống với bài viết C. Patrício @patricio2023explainable. Chính vì vậy, có thể dựa vào đó mà đưa ra được các phương pháp chính để trí tuệ nhân tạo khả diễn giải thích kết quả phân loại trong phân lớp hình ảnh y khoa.

=== Trí tuệ nhân tạo khả diễn giúp tăng độ chính xác của kết quả
#{ "" } // Trick on first line

Khi sử dụng trí tuệ nhân tạo khả diễn vào các ứng dụng sử dụng trí thông minh nhân tạo, ngoài giúp cho người dùng có thể hiểu được những gì mà mô hình, thuật toán đã thực hiện mà còn tăng độ chính xác của kết quả mà thuật toán đã đưa ra. Tại sao lại vậy?

-	*Tăng độ hiểu rõ mô hình*: Trí tuệ nhân tạo khả diễn giúp các nhà nghiên cứu và kỹ sư hiểu rõ hơn về cách mà mô hình hoạt động và đưa ra quyết định. Điều này cho phép họ phát hiện và sửa chữa các lỗi hoặc điểm yếu trong mô hình @unknown-author-2020.

-	*Tối ưu hóa mô hình*: Bằng cách cung cấp các giải thích chi tiết về các yếu tố ảnh hưởng đến dự đoán, trí tuệ nhân tạo khả diễn giúp tối ưu hóa các tham số và cấu trúc của mô hình để đạt hiệu suất tốt hơn @unknown-author-no-date.

-	*Tăng cường sự tin tưởng*: Khi các kết quả của trí thông minh nhân tạo được giải thích rõ ràng, người dùng và các chuyên gia có thể tin tưởng hơn vào các quyết định của mô hình, từ đó dễ dàng chấp nhận và áp dụng các kết quả này trong thực tế @unknown-author-no-date.

-	*Phát hiện và sửa chữa lỗi*: Trí tuệ nhân tạo khả diễn giúp phát hiện các lỗi hoặc bất thường trong dữ liệu hoặc mô hình, từ đó có thể sửa chữa kịp thời để cải thiện độ chính xác @unknown-author-no-date.

=== Những phương pháp trí tuệ nhân tạo khả diễn dành cho mạng nơ ron tích chập
#{ "" } // Trick on first line

Có nhiều phương pháp để áp dụng trí tuệ nhân tạo khả diễn vào mô hình tích chập. Theo @van2022explainable, phương pháp giải thích trực quan được sử dụng nhiều nhất và đây là hai phương pháp nổi bật nhất được sử dụng nhiều nhất trong các khảo sát mà họ thu nhập được:

- _*Class Activation Mapping (CAM)*_:
-- *Cách hoạt động*: CAM sử dụng các bản đồ kích hoạt từ các lớp cuối cùng của tích chập để xác định các vùng trong ảnh có liên quan đến một lớp cụ thể.\
-- *Ưu điểm*: Giúp hiểu rõ hơn về cách mô hình phân loại các đối tượng trong ảnh.

- _*Gradient-weighted Class Activation Mapping (Grad-CAM)*_:
-- *Cách hoạt động*: Grad-CAM cải tiến CAM bằng cách sử dụng trọng số gradient để tạo ra các bản đồ nhiệt, hiển thị các vùng ảnh mà mô hình chú ý đến.\
-- *Ưu điểm*: Đặc biệt hữu ích trong các mô hình thị giác máy tính, giúp hiểu rõ các vùng ảnh quan trọng đối với dự đoán.

=== Những phương pháp trí tuệ nhân tạo khả diễn dành cho mô hình Transformer
#{ "" } // Trick on first line

Có một số phương pháp trí tuệ nhân tạo khả diễn được phát triển để giải thích các mô hình kiến trúc Transformer. Theo @ali2022xai, đây là một số phương pháp phổ biến được sử dụng cho kiến trúc mạng này và các ưu điểm về chúng:

- _*Trực quan hóa các đầu chú ý*_:
-- *Cách hoạt động*: Trực quan hóa các đầu chú ý trong mỗi khối Transformer để hiểu cách mô hình phân bổ sự chú ý giữa các từ hoặc các phần của dữ liệu @ali2022xai.\
-- *Ưu điểm*: Giúp hiểu rõ hơn về cách mô hình xử lý thông tin và đưa ra quyết định dựa trên sự chú ý.

- _*Phương pháp Gradient* _:
-- *Cách hoạt động*: Sử dụng thông tin gradient để xác định đóng góp của các đặc trưng đầu vào vào dự đoán của mô hình @ali2022xai.\
-- *Ví dụ*: Grad-CAM có thể được điều chỉnh để sử dụng với các mô hình Transformer.

-	_*Phương pháp Perturbation*_:
-- *Cách hoạt động*: Thay đổi hoặc loại bỏ các phần của đầu vào và quan sát sự thay đổi trong dự đoán của mô hình để xác định các phần quan trọng @ali2022xai.\
-- *Ưu điểm*: Cung cấp cái nhìn sâu sắc về tầm quan trọng của từng phần của đầu vào đối với dự đoán.

- _*Layer-wise Relevance Propagation (LRP)*_:
-- *Cách hoạt động*: Mở rộng phương pháp LRP để áp dụng cho các mô hình Transformer, giúp phân bổ lại sự liên quan của các đặc trưng đầu vào qua các lớp của mô hình @ali2022xai.\
-- *Ưu điểm*: Cung cấp các giải thích nhất quán và chi tiết về cách mô hình đưa ra quyết định.

-	_*Integrated Gradients*_:
-- *Cách hoạt động*: Tính toán gradient tích hợp để xác định đóng góp của từng đặc trưng đầu vào vào dự đoán của mô hình @ali2022xai.\
-- *Ưu điểm*: Giúp hiểu rõ hơn về tác động của từng đặc trưng đến dự đoán của mô hình.

== Thỏa luận
#{ "" } // Trick on first line

Các công trình nghiên cứu và bài báo đã đề cập đến các vấn đề liên quan đến hình ảnh xương. Tuy nhiên, việc phân loại các loại bệnh ung thư xương vẫn còn hạn chế. Đặc biệt, số lượng báo cáo hoặc nghiên cứu vận dụng trí tuệ nhân tạo khả diễn vào phân tích kết quả của hệ thống còn ít, dẫn đến kết quả dù cao nhưng thiếu minh bạch từ mô hình sử dụng, làm giảm tính tin cậy và không đáp ứng được xu hướng phát triển hiện nay.

Các tập dữ liệu được sử dụng trong các nghiên cứu là hình ảnh xương, phản ánh đúng mục tiêu nghiên cứu. Tuy nhiên, các nghiên cứu này chủ yếu tập trung vào phân biệt lành tính hay ác tính mà không đi sâu vào phân loại các bệnh lý cụ thể ở từng bộ phận xương, mặc dù mỗi bộ phận có thể mắc nhiều loại bệnh khác nhau với các triệu chứng tương tự, làm tăng thách thức trong việc phân loại.

Về mặt kiến trúc mạng, hầu hết các bài báo và nghiên cứu đều theo hướng sử dụng một kiến trúc nhất định như mạng nơ-ron tích chập hoặc Transformer và chỉ so sánh chúng với các mô hình cùng loại. Có rất ít nghiên cứu thực hiện so sánh mô hình được chọn với cả hai loại kiến trúc này.

-	*Mạng nơ-ron tích chập*: Đa số các bài báo tìm được sử dụng nhiều mô hình khác nhau để so sánh, và mô hình Unet được sử dụng nhiều trong nghiên cứu do tính tiện lợi và phù hợp với y khoa.

-	*Mạng biến đổi trực quan*: Có ít nghiên cứu sử dụng mô hình Transformer thuần túy, phần lớn là các mô hình mạng lai kết hợp giữa Transformer và mạng nơ-ron tích chập, và cho hiệu suất tốt.

#{ "" } // Trick on first line

Hiện tại, mô hình tích chập áp dụng trí tuệ nhân tạo khả diễn khá nhiều và chưa nhiều ứng dụng trên các kiến trúc Transformer trong các công trình nghiên cứu gần đây. Điều này là do việc triển khai phương pháp trí tuệ nhân tạo khả diễn cho mô hình tích chập dễ triển khai hơn. Mặc dù có nhiều phương pháp trí tuệ nhân tạo khả diễn cho Transformer nhưng chúng ít được sử dụng do khó khăn trong thực hiện nên ít được sử dụng.

Dựa vào những quan sát này, khóa luận có thể khai thấc những thiếu sót để thực hiện trong lần nghiên cứu này.

== Phạm vi thực hiện
#{ "" } // Trick on first line

Dựa trên các công trình nghiên cứu và các bài báo trên, khóa luận này sẽ được giới hạn như sau:

-	Áp dụng kiến trúc mô hình mới, phổ biến và ổn định cho cả mạng nơ-ron tích chập và Transformer. Để tạo điểm khác biệt, khóa luận cũng sẽ giới thiệu một mô hình mới sử dụng kiến trúc tuần tự kết hợp giữa mạng nơ-ron tích chập và Transformer, thông qua việc tích hợp hai kiến trúc mô hình trên đã nêu để so sánh hiệu quả.

-	Sử dụng bộ dữ liệu hình ảnh xương thực tế, được phân chia rõ ràng theo từng bộ phận, để phân loại bệnh theo bộ phận cụ thể.

-	Áp dụng phương pháp giải thích qua tạo bản đồ nhiệt cho mạng nơ-ron tích chập, Transformer và mô hình kết hợp đã nêu.

//#bibliography("../Reference/ref.bib")