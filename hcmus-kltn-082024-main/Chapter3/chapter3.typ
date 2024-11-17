= Phương pháp
#{ "" } // Trick on first line

Sau khi xem xét các bài báo liên quan, khóa luận sẽ trình bày phương pháp chung để thực hiện theo đúng mục tiêu và mục đích đã đề ra. Quy trình bao gồm các bước gồm: tiền xử lý, trích xuất đặc trưng, phân lớp và truy xuất kết quả. Quy trình này được minh họa qua hình ảnh sau:

#figure(
  image("images\pp.png", width: 100%),
  caption: [Phương pháp thực hiện],
)

- *Tiền xử lý*: Chỉnh sửa hình ảnh trong tập dữ liệu cho phù hợp với mô hình huấn luyện.

- *Trích xuất đặc trưng*: Sử dụng các kiến trúc mô hình nơ-ron tích chập, Transformer và một số kiến trúc khác để thực hiện.

- *Phân lớp*: Thêm khắc các lớp sau khi chạy mô hình để phân loại các hình ảnh đã được trích xuất đặc trưng.

- *Truy xuất kết quả*: Đưa ra các thông số về kết quả dự đoán của mô hình với tập hình ảnh đã đưa vào, xuất ra bản đồ nhiệt để giải thích cho kết quả mô hình đưa ra.

#{ "" } // Trick on first line

Để đảm bảo phù hợp với mục tiêu và tăng cường khả năng so sánh, khoá luận sử dụng các bộ tập dữ liệu khác nhau để. Mỗi tập dữ liệu đều có cách xử lý và thực hiện riêng để phù hợp với đặc thù của nó. Tuy nhiên, sự khác biệt chủ yếu nằm ở bước tiền xử lý, trong khi các bước còn lại không bị ảnh hưởng. Phương pháp này, cùng với số lượng dữ liệu được sử dụng để thực hiện trong khóa luận, kỳ vọng sẽ mang lại kết quả tương xứng với các mục tiêu mà đề ra.

Phân lớp và phân đoạn là hai bài toán riêng biệt. Khóa luận này chỉ thực hiện bài toán phân lớp mà không phân đoạn. Điều này xuất phát từ thực tế rằng các bác sĩ thường không có đủ thời gian để hỗ trợ việc gán nhãn cho các khối u nghiên cứu. Do đó, hệ thống sẽ tự động phân lớp dựa trên hình ảnh đã được gán nhãn và tự đánh dấu các bệnh thông qua phương pháp giải thích.

== Tiền xử lý
#{ "" } // Trick on first line

Trước khi tiến hành học và huấn luyện trí thông minh nhân tạo, các tập dữ liệu, bao gồm các hình ảnh, cần được chỉnh sửa qua các bước trung gian để phù hợp với quá trình học. Chính lẽ đấy, các dữ liệu sẽ đi qua bước đầu tiên – "Tiền xử lý". Mỗi tập dữ liệu sẽ có cách xử lý ảnh khác nhau. Các tập dữ liệu thu nhập được sẽ được trải qua các bước tiền xử lý như sau:   

#figure(
  image("images/txly.drawio.svg", width: 100%),
  caption: [Tiền xử lý],
)

*Bước 1: Sắp xếp và chuyển đổi định dạng ảnh để lưu trữ*
#{ "" } // Trick on first line

Đầu tiên khóa luận sẽ thực hiện việc nén và tối ưu hóa tập dữ liệu thô (định dạng ảnh là PNG) thành tập dữ liệu tĩnh với định dạng WebP. WebP là một định dạng hình ảnh mới được phát triển bởi Google. Dựa trên nền tảng video VP8, WebP cung cấp hình ảnh chất lượng cao với kích thước nhỏ hơn PNG hoặc JPEG. Nó kết hợp và cải tiến chất lượng tốt nhất của các định dạng JPEG và PNG bằng cách cung cấp tính năng nén ảnh nâng cao. 

Theo nghiên cứu, WebP có những điểm tốt hơn PNG:

- *Kích thước tệp nhỏ hơn*: WebP sử dụng thuật toán nén tốt hơn so với PNG và JPEG. Chính vì vậy, kích thước lưu trữ nhỏ cũng như thời gian đưa ảnh vào bộ nhớ nhanh hơn nhiều so với PNG và JPEG.

- *Chất lượng ảnh tương đương*: Hình ảnh có định dạng WebP cho dù có kích thước ảnh nhỏ hơn nhưng chất lượng hình ảnh vẫn được duy trì tốt. Tránh mất mát dữ liệu khi xử lý ảnh.

- *Tốc độ tải ảnh nhanh hơn*: Tiết kiệm thời gian ảnh được đọc vào bộ nhớ cho phép tăng tốc huấn luyện.
#{ "" } // Trick on first line

Sau đó ảnh sẽ được sắp sếp tuần tự vào các bộ dữ liệu theo từng bộ phận và bệnh nhằm giảm kích thước đường dẫn xuống tối thiểu.

*Bước 2: Đệm và chỉnh sửa kích thước ảnh*

Sau bước 1, nhóm bắt đầu xem từng ảnh và thấy rằng chúng có kích thước khác nhau, gây khó khăn cho việc học máy do đa số mô hình yêu cầu kích thước ổn định và nhất quán. Do đó, bước tiếp theo là đệm và chỉnh sửa kích thước ảnh để giải quyết vấn đề này.

Ảnh sẽ được xử lý qua một hàm đệm để đạt được kích thước mong muốn bằng cách thêm viền đen, đảm bảo kích thước cuối cùng phù hợp với yêu cầu của mô hình. Kích thước cần thiết cho viền đen sẽ được tính toán để đạt được kích thước ảnh mong muốn. Sau khi điều chỉnh, các ảnh sẽ được lưu trữ trong một mảng để sử dụng trong quá trình học máy.

Với hai bước này, ảnh trong bộ dữ liệu sẽ đáp ứng được các yêu cầu cần thiết để tiến hành huấn luyện mô hình học máy.

== Trích xuất đặc trưng và phân lớp
#{ "" } // Trick on first line

Sau khi có được các ảnh dữ liệu đạt yêu cầu để học và luyện mô hình, các ảnh sẽ được trích xuất đặc trưng và phân lớp bằng các mô hình học máy được huấn luyện cho trí thông minh nhân tạo. Khóa luận sẽ sử dụng ba kiến trúc mô hình khác nhau để thực hiện việc này: mô hình nơ-ron tích chập, mô hình Transformer và một mô hình kiến trúc tuần tự kết hợp giữa mô hình nơ-ron tích chập và mô hình Transformer.

=== Mô hình nơ-ron tích chập
#{ "" } // Trick on first line

Mô hình nơ-ron tích chập là mô hình học sâu phổ biến và có ảnh hưởng trong có ảnh hưởng trong thị giác máy tính. Được ra đời vào năm 1980 và phát triển qua các năm, kiến trúc này đã cho thấy sức mạnh và sự vượt trội của nó đối với các mô hình xuất hiện trước đấy. Cho đến hiện tại, dù có nhiều kiến trúc mô hình khác tốt hơn so với mô hình nơ-ron tích chập, nó vẫn cho thấy được sự ổn định với kết quả tốt và sức hút của nó trong các mô hình học sâu.

==== Cấu trúc
#{ "" } // Trick on first line

Hiện nay có nhiều mô hình cho kiến trúc nơ-ron tích chập xuất hiện. Các mô hình nơ-ron tích chập có thể khác nhau nhưng nó có cấu trúc đơn giản gồm hai phần là trích xuất đặc trưng và phân lớp. Ở trích xuất đặc trưng, nó sẽ có các lớp cốt lõi là lớp tích chập, lớp gộp. Còn ở phân loại, nó sẽ có lớp kết nối đầy đủ để thực hiện việc đấy.

#figure(
  image("images/cnn_architecture.svg", width: 100%),
  caption: [Cấu trúc kiến trúc mô hình nơ-ron tích chập],
)

===== Lớp tích chập
#{ "" } // Trick on first line

Đây là lớp đầu tiên được sử dụng để trích xuất các đặc điểm của hình ảnh lúc ban đầu như cạnh, góc, kết cấu. Ở lớp này, chúng ta sẽ có một bức ảnh có kích thước $(h * w * d)$ và một bộ lọc có kích thước $(f_w * f_h * d)$ với $f_w, f_h$ có kích thước cụ thể và $f_w = f_h$. Sau đó, phép toán tích chập sẽ được thực hiện giữa hình ảnh đầu vào và bộ lọc đã nêu trên bằng việc trượt bộ lọc trên hình ảnh đầu vào, tích vô hướng được lấy giữa bộ lọc và các phần của hình ảnh đầu vào theo kích thước của bộ lọc. 

Sau khi thực hiện, nó sẽ ra được các bản đồ đặc trưng $(f_w * f_h)$ đưa ra các thông tin về ảnh. Sau đó, bản đồ này sẽ tiếp tục được đưa vào các lớp khác như lớp tích chập để trích xuất các điểm đặc trưng khác trong hình ảnh.

===== Lớp gộp
#{ "" } // Trick on first line

Lớp gộp thường được sử dụng để giảm kích thước của các bản đồ đặc trưng để giảm bớt số lượng tham số nhưng vẫn giữ lại được những thông tin quan trọng. Nó được thực hiện bằng cách giảm tính liên kết giữa các lớp và điểm độc lập của mỗi bản đồ đặc trưng. Có nhiều loại gộp được sử dụng trong lớp này như là gộp tổng, gộp trung bình hay là gộp lớn nhất.

Trong đó, gộp tổng thường lấy tổng trung bình hoặc lấp phần tử lớp nhất từ ma trận được chia đều trong các bản đồ đặc trưng. Đối với gộp tổng, nó sẽ lấy tổng tất cả các phần tử trong bản đồ đặc trưng đấy để tạo. Còn gộp trung bình, nó giống với gộp lớn nhất nhưng khác chỗ là nó lấy trung bình cộng của các giá trị trong ma trận đấy để đưa ra giá trị phù hợp cho biểu đồ.

===== Lớp kết nối đầy đủ
#{ "" } // Trick on first line

Lớp kết nối đầy đủ sẽ gồm các trọng số và độ lệch cùng với các nơ-ron và được sử dụng để kết nối các nơ-ron giữa hai lớp khác nhau. Các lớp này thường được đặt trước lớp đầu ra và tạo thành một vài lớp cuối cùng của kiến trúc nơ-ron tích chập.

Trong mô hình này, hình ảnh đầu vào từ các lớp trước đó được làm phẳng và đưa vào lớp kết nối đầy đủ này. Sau đó, vectơ phẳng trải qua thêm một vài lớp trên nữa, nơi các phép toán hàm toán học thường diễn ra. Ở giai đoạn này, quá trình phân loại bắt đầu diễn ra và đầu ra sẽ đưa ra các thông số phân lớp cho ảnh đã được đưa vào.

==== Các kiến trúc được sử dụng
#{ "" } // Trick on first line

Khóa luận sẽ sử dụng các mô hình nơ-ron tích chập ổn định và phổ biến hiện nay cho tập dữ liệu được sử dụng. Khóa luận sẽ sử dụng rất nhiều các kiến trúc nơ-ron tích chập khác nhau như kiến trúc mô hình khác như MobileNetV3, các mô hình của kiến trúc mô hình ResNetV2, các mô hình kiến trúc mạng ResNetV2, kiến trúc mạng khối (VGG) và kiến trúc mô hình EfficientNetV2 để thực hiện. Trong đó, kiến trúc mô hình EfficientNetV2 là mô hình ổn định, phổ biến hiện nay và có các điểm vượt trội hơn so với các mô hình khác:

#figure(
  image("images\EfficientNetV2.png", width: 100%),
  caption: [Cấu trúc mô hình EfficientNetV2],
)

- _*Tốc độ huấn luyện nhanh hơn*_: EfficientNetV2 sử dụng cấu trúc Fused-MBConv, kết hợp các phép tính trong các lớp MBConv để giảm tải tính toán và tăng tốc quá trình huấn luyện. Điều này giúp mô hình huấn luyện nhanh hơn so với các mô hình trước đó như EfficientNet và các mô hình khác.

- _*Tối ưu hóa tài nguyên*_: EfficientNetV2 tiếp tục sử dụng phương pháp compound scaling, tối ưu hóa các thông số quan trọng như chiều rộng, chiều sâu và độ phân giải để đạt được hiệu suất tốt với tài nguyên tính toán ít. Điều này giúp mô hình trở nên hiệu quả hơn về mặt tài nguyên so với các mô hình khác như ResNet, DenseNet, và Inception.

- _*Khả năng tổng quát hóa tốt hơn*_: EfficientNetV2 sử dụng Stochastic Depth, cho phép mô hình huấn luyện một lớp với một xác suất bỏ học ngẫu nhiên, từ đó giảm hiện tượng vanishing gradient và cải thiện khả năng học của mô hình. Điều này giúp mô hình tổng quát hóa tốt hơn trên các tập dữ liệu mới và chưa từng thấy.

- _*Kích thước mô hình nhỏ gọn*_: EfficientNetV2 có kích thước mô hình nhỏ hơn so với nhiều mô hình khác, giúp tiết kiệm bộ nhớ và tài nguyên tính toán. Điều này làm cho EfficientNetV2 trở thành lựa chọn lý tưởng cho các ứng dụng trên thiết bị di động và các thiết bị có tài nguyên hạn chế.

=== Mô hình Transformer
==== Cấu trúc
#figure(
  image("images\Transformer_architecture.svg", width: 100%),
  caption: [Cấu trúc mô hình biến đổi trực quan],
)

#{ "" } // Trick on first line

Hình ảnh đầu vào có kích thước là $(h * w * d)$, trong đó h, w và d tượng trưng cho là chiều dài, chiều rộng, kênh màu (RGB). Sau đó, nó được chia thành các mảng hình vuông có kích thước $(p_w * p_h * d)$ với $p_w, p_h$ có kích thước cụ thể và $p_w = p_h$.

Đối với mỗi mảng hình đấy, nó được đẩy qua một toán tử tuyến tính để thu được một vectơ. Vị trí của mảng cũng được chuyển đổi thành một vectơ bằng việc mã hóa vị trí. Hai vector được thêm vào, sau đó được đẩy qua một số bộ mã hóa Transformer.

Cơ chế chú ý trong mô hình biến đổi trực quan liên tục biến đổi các vectơ biểu diễn của các mảng hình ảnh, kết hợp ngày càng nhiều mối quan hệ ngữ nghĩa giữa các mảng hình ảnh trong một hình ảnh. Điều này tương tự như cách trong xử lý ngôn ngữ tự nhiên, khi các vectơ biểu diễn chảy qua một bộ biến đổi, chúng kết hợp ngày càng nhiều mối quan hệ ngữ nghĩa giữa các từ, từ cú pháp đến ngữ nghĩa.

Kiến trúc trên biến một hình ảnh thành một chuỗi các biểu diễn vectơ. Để sử dụng chúng cho các ứng dụng, mô hình cần phải đào tạo thêm một lớp đầu để diễn giải chúng như đầu MLP để diễn giải thành các lớp đầu ra.

==== Kiến trúc được sử dụng
#{ "" } // Trick on first line

Để thử nghiệm với mô hình Transformer, khóa luận tìm hiểu môt số mô hình trên mạng để chọn một mô hình có thể phù hợp với dung lượng, thiết bị mà đang sử dụng để thực nghiệm khóa luận. Cuối cùng, khóa luận đã tìm đến mô hình GC–ViT @hatamizadeh2023global. 

#figure(
  image("images\GCVit.svg", width: 100%),
  caption: [Mô hình GC - ViT @hatamizadeh2023global],
)

#{ "" } // Trick on first line

Mô hình GC-ViT là một mô hình mới được sáng tạo ra giúp tăng cường khả năng dùng tham số và tính toán cho thị giác máy tính @hatamizadeh2023global. Trong mô hình này, các nhà nghiên cứu sử dụng thuật toán bối cảnh toàn cầu tự chú ý, cùng với thuật toán tiêu chuẩn cục bộ tự chú ý để tăng hiệu quả mô hình và các tương tác không gian tầm xa và tầm ngắn mà không cần các hành động tốn kém như tính toán mặt nạ chú ý hoặc dịch chuyển các cửa sổ cục bộ - ở đây là thực hiện ngay là ra kết quả chính xác mà không cần phải tốn thời gian tạo mặt nạ hay dịch chuyển các phân ảnh đã được cắt ra trong lúc học mô hình. Mô hình này đưa ra kết quả tốt khi luyện với tập ảnh ImageNet-1K mà không cần qua luyện lại mô hình, vượt qua những gì mà mô hình khác cùng loại đã thực hiện.

Bước đầu, họ sẽ đưa vào mô hình một hình ảnh có kích thước H x W x 3. Sau đó, họ thực hiện thu nhập các bản vá thông qua lớp tích chập 3 x 3 với bước nhảy là 2 và phần đệm thích hợp. Tiếp đến, những bản vá đó được đưa vào không gian C chiều với một lớp tích chập 3 x 3 khác với bước nhảy 2 khác. Trong mỗi bước GC-ViT sẽ bao gồm các mô đun chú ý cục bộ và chú ý toàn cầu để trích xuất đặc điểm không gian.

Phần cửa sổ nội bộ chú ý thì giống với mô hình Transformer khác. Tuy nhiên, chú ý toàn cục thì trích xuất đặc trung cục bổ thông qua trình tạo truy vấn toàn cầu. 

Trình tạo truy vấn là một mô-đun giống mô hình nơ-ron tích chập, có khả năng trích xuất các đặc điểm từ toàn bộ hình ảnh chỉ một lần ở mỗi giai đoạn. Sau mỗi giai đoạn, độ phân giải không gian giảm đi 2, trong khi số lượng kênh tăng lên 2 thông qua khối mẫu lấy xuống. Các tính năng kết quả được chuyển qua các lớp tuyến tính và tổng hợp trung bình để tạo phần nhúng cho tác vụ xuôi dòng.

=== Mô hình kiến trúc tuần tự
#{ "" } // Trick on first line

Ở mô hình này, khóa luận nghiên cứu về các dạng kết hợp của mô hình Transformer với mô hình nơ-ron tích chập. Sau khi nghiên cứu, khóa luận rút ra được ba dạng kiến trúc chính của mô hình kết hợp này là kiến trúc tuần tự, kiến trúc học tập tổng hợp và kiến trúc hỗn hợp. Để phù hợp với mục tiêu của khóa luận và trang thiết bị hiện có, khóa luận sẽ sử dụng dạng mô hình kiến trúc tuần tự để thực hiện.

#figure(
  image("images\sequen.png", width: 100%),
  caption: [Mô hình kiến trúc tuần tự],
)

#{ "" } // Trick on first line

Đối với dạng mô hình kiến trúc tuần tự, dữ liệu sẽ học tuần tự từng mô hình một để cho ra kết quả mong muốn. Tập dữ liệu sẽ được đưa vào trong mô hình nơ-ron tích chập để thực hiện tìm ra các điểm đặc trưng lúc đầu. Sau đó, chúng ta sẽ sử dụng mô hình Transformer để thực hiện các bước phân loại và các bước khác mà mình mong muốn.

Dạng kiến trúc này có điểm lợi là nó đơn giản, dễ xây dựng và không cần cài nhiều thư viện để sử dụng. Ngoài ra, kiểu mô hình này chạy rất tốt với các khóa luận có vật thể lớn và giúp cải thiện độ chính xác của việc phát hiện đối tượng. Tuy vậy, nó cũng có điểm hại là cần khá nhiều thời gian tính toán, trình tự thực hiện dài, cần dữ liệu lớn và khá là yếu đối với các dữ liệu hình ảnh có vật thể nhỏ.

=== Phân lớp
#{ "" } // Trick on first line

Sau khi thực hiện trích xuất đặc trưng qua các kiến trúc mô hình học, các bản đồ đặc trưng trên sẽ được đem vào lớp Dense và lớp Global Average Pooling để xử lý và xuất ra kết quả.

- _*Lớp Global Average Pooling*_ (GAP): Đây là lớp quan trọng thường được sử dụng trong các kiến mạng nơ-ron tích chập. Nó có tính chất như lớp tổng hợp (lớp gộp) trong các kiến trúc mô hình nơ-ron tích chập cơ bản. Về chức năng chính, nó sẽ thực hiện việc giảm kích thước của các bản đồ đặc trưng xuống một vectơ duy nhất bằng cách tính trung bình các giá trị trên toàn bộ bản đồ. 

- _*Lớp Dense*_: là lớp kết nối đầy đủ, là một thành phần quan trọng trong các mạng nơ-ron nhân tạo. Chức năng chính của lớp Dense là kết nối tất cả các nơ-ron từ lớp trước đó với mỗi nơ-ron trong lớp hiện tại. Lớp Dense được sử dụng ở các lớp cuối cùng của mô hình này để thực hiện các tác vụ phân loại, chẳng hạn như phân loại hình ảnh hoặc dự đoán các nhãn.

#{ "" } // Trick on first line

Với những điều được được tìm hiểu, khóa luận sẽ sử dụng mô hình trong kiến trúc EfficientNetV2 kết hợp với một mô hình Transformer thuần túy để thực hiện luyện cho trí thông minh nhân tạo này.

== Truy xuất kết quả
#{ "" } // Trick on first line

Sau khi thực hiện việc huấn luyện cho trí thông minh nhân tạo, khóa luận sẽ cần có các phương pháp để xem kết quả học của các mô hình đã được huấn luyện để từ đó đưa ra các nhận xét chung với chúng.

Với tất cả các kiến trúc mô hình được sử dụng, khóa luận sẽ cần nó truy xuất ra kết quả là loại bệnh gì cùng với các thông số đánh giá mô hình sử dụng để đánh giá kết quả trên.

Ngoài ra, các mô hình sẽ đưa ra bản đồ nhiệt của riêng mỗi mô hình để trực quan hóa việc học của từng mô hình như thế nào . Mỗi kiến trúc, mỗi mô hình sẽ có phương pháp khác nhau để tạo ra bản đồ nhiệt. Đối với mô hình nơ-ron tích chập, khóa luận sẽ sử dụng phương pháp Grad-CAM để thực hiện truy xuất bản đồ nhiệt. Đối với mô hình Transformer, khóa luận sẽ sử dụng phương pháp GradAR để thực hiện. Còn đối với mô hình kiến trúc tuần tự, nhóm sẽ sử dụng Grad-CAM để thực hiện.

Các biểu đồ nhiệt ở các kiến trúc và các mô hình học có sự khác nhau. Đối với mô hình nơ-ron tích chập, biểu đồ nhiệt được tạo bởi phương pháp Grad-CAM thường thể hiện các kết nối giữa các điểm đặc trưng và vị trí trong không gian ảnh. Đối với mô hình Transformer, biểu đồ nhiệt được tạo qua phương pháp GradAR thể hiện sự tương tác giữa các từ hoặc phần tử trong chuỗi đầu vào. Còn đối với mô hình kiến trúc tuần tự, theo lý thuyết, phương pháp tạo bản đồ nhiệt nên được thực hiện sau mô hình nơ-ron để hiển thị các đặc trưng không gian quan trọng mà mô hình đã học được.

#figure(
  image("images\GradCAM.png", width: 100%),
  caption: [Grad-CAM],
)

#{ "" } // Trick on first line

Về Grad-CAM, nó sẽ hoạt động bao gồm việc tìm ra phần nào của hình ảnh đã đưa mô hình nơ-ron tích chập đi đến quyết định cuối cùng. Phương pháp này bao gồm việc tạo ra các bản đồ nhiệt thể hiện các lớp kích hoạt trên hình ảnh nhận được làm đầu vào. Mỗi lớp kích hoạt được liên kết với một lớp đầu ra cụ thể.

Các lớp này được sử dụng để chỉ ra tầm quan trọng của từng điểm ảnh so với lớp được đề cập bằng cách tăng hoặc giảm cường độ của điểm ảnh.

Bản đồ kích hoạt lớp chỉ định tầm quan trọng cho từng vị trí (x, y) trong lớp tích chập cuối cùng bằng cách tính toán tổ hợp tuyến tính của các kích hoạt, được tính theo trọng số đầu ra tương ứng cho lớp được quan sát. Bản đồ kích hoạt lớp kết quả sau đó được lấy mẫu lại theo kích thước của hình ảnh đầu vào.