= Kết luận và hướng pháp triển
== Kết luận
#{ "" } // Trick on first line

Khóa luận đã chứng minh khả năng ứng dụng trí tuệ nhân tạo trong việc hỗ trợ chẩn đoán bệnh ung thư xương qua hình ảnh. Điều này được biểu hiện thông qua việc giải quyết các bài toán phân loại bệnh tại các bộ phận cụ thể của cơ thể.

Trong khóa luận, các phương pháp tổng quát để giải quyết vấn đề đã được định nghĩa và đề xuất các cải tiến so với các nghiên cứu trước, bằng việc sử dụng các kiến trúc và mô hình học sâu tiên tiến như các mô hình nơ-ron tích chập khác nhau, kiến trúc Transformer với mô hình GC-ViT, và kiến trúc tuần tự kết hợp mô hình trong EfficientNetV2 với một mô hình Transformer thuần túy. Các kiến trúc này đã hỗ trợ giải quyết vấn đề và đạt được kết quả ấn tượng. Mô hình EfficientNetV2B1 đạt độ chính xác là 0.8815, điểm AUC là 0.9625, độ chuẩn xác là 0.8953, độ nhạy là 0.8741 và điểm F1 là 0.8240 với tổng số tham số gần 6 triệu, chứng minh hiệu quả của mô hình nơ-ron tích chập trong việc phân loại. Các mô hình khác cũng cho thấy kết quả tích cực.

Khóa luận cũng đưa ra phương pháp giải thích kết quả từ các mô hình đã huấn luyện bằng việc sử dụng các phương pháp tạo bản đồ nhiệt để minh họa kết quả, mỗi mô hình có cách hiển thị bản đồ nhiệt đặc trưng và đã được phân tích cụ thể trong khóa luận. Nhóm nghiên cứu đã phát triển và tích hợp thành công các phương pháp này vào hệ thống.

Ngoài ra, khóa luận cũng trả lời các câu hỏi liên quan đến những thách thức gặp phải trong quá trình nghiên cứu, như lý do sử dụng file ảnh giải nén, sự khác biệt về bản đồ nhiệt giữa mô hình nơ-ron tích chập và Transformer, hạn chế trong chỉnh sửa ảnh y khoa, và nhiều vấn đề khác.

== Khó khăn
#{ "" } // Trick on first line

Trong lúc thực hiện khóa luận này, nhóm cũng có một số hạn chế, khó khăn khi thực hiện đề tài này:

- Hiện nay, việc tiếp cận dữ liệu y khoa, đặc biệt là dữ liệu về xương, gặp nhiều khó khăn. Một phần nguyên nhân là do sự thiếu hụt ứng dụng của dữ liệu y khoa trong quá trình khám chữa bệnh. Hơn nữa, dữ liệu về các bệnh mà các nhóm nghiên cứu cần sử dụng không chỉ ít mà còn thiếu tính toàn diện, không đáp ứng đủ điều kiện để tích hợp vào hệ thống. Thêm vào đó, một số hình ảnh không đủ rõ nét, có kích thước không thống nhất, làm tăng thêm khó khăn trong việc sử dụng. Các hình ảnh chụp cũng thường chứa thông tin cá nhân của bệnh nhân. Sự hạn chế trong quản lý dữ liệu y khoa cũng khiến cho việc thu thập hình ảnh y khoa phục vụ nghiên cứu và thực nghiệm trở nên hạn chế. Phần lớn các hình ảnh được sử dụng đều thu thập từ nguồn không chính thống và không đảm bảo chất lượng như những hình ảnh chụp tại bệnh viện.

- Việc không có nhiều kiến thức về các bệnh lý y khoa, đặc biệt là các bệnh lý về xương, khiến cho việc thực hiện khóa luận trở nên khó khăn hơn. Các thành viên phải dành khá nhiều thời gian cho việc nghiên cứu về các bệnh về xương để có thể hiểu được về tập dữ liệu. Đồng thời, sự hiểu biết về y tế là cần thiết để có thể xem được các ảnh y khoa của các bệnh nhân, hiểu được các điểm đặc trưng của các bệnh trên từng bộ phận để đánh nhãn và hiểu được các kết quả mà hệ thống đưa ra.

- Việc bảo mật thông tin về các ảnh y khoa trên cũng rất quan trọng. Bởi vì các ảnh trên đều chứa các thông tin về người bệnh, ngày khám, v.v. Các phương pháp xử lý các thông tin cũng rất quan trọng để bảo mật thông tin bệnh nhân. Ngoài ra, vì tính chất bảo mật của các thông tin bệnh nhân đấy mà xảy ra các góc chụp ảnh, các góc cắt ảnh xấu khiến cho dữ liệu trong tập dữ liệu không được đồng nhất về phương hướng, kích thước. Từ đó, nó dẫn đến sự khó khăn khi đưa chúng vào các mô hình học máy này.

- Không có nhiều thời gian để thực hiện tiếp các kiến trúc mô hình khác, cũng như các đối ưu về hệ thống mà khóa luận đang làm.

- Trong thực nghiệm 2 về phân loại các loại bệnh, hệ thống vẫn đưa ra sai kết quả với một số ảnh thử nghiệm khác với mô hình được huấn luyện.

- Khóa luận chưa có kiểm tra và thực nghiệm với các kiến trúc mô hình khác như các mô hình của kiến trúc Transformer, các kiến trúc mô hình hỗn hợp của Transformer.

== Các định hướng pháp triển
#{ "" } // Trick on first line

- Hệ thống này cần thực nghiệm thêm các kiến trúc mạng, mô hình học khác ngoài các kiến trúc, mô hình được kiểm chứng trong khóa luận. Có thể, các kiến trúc đấy là các mô hình phổ biến, nổi bật khác được phát hiện ở tương lai.

- Áp dụng các phương pháp giải thích kết quả như trí tuệ nhân tạo khả diễn hiện giờ đang được sử dụng khá nhiều nhưng chưa đạt được các thành công nhất định ở một số ngành như trong y khoa chẳng hạn. Chính vì vậy, trong tương lai, khi các phương pháp giải thích kết qua như trí tuệ nhân tạo khả diễn phát triển, việc áp dụng chúng vào các ứng dụng sẽ trở thành một xu hướng và phát triển thêm các phương pháp giải thích khác.

- Về khóa luận này, hệ thống nếu được hoàn thành và thực nghiệm tốt, nó có thể phát triển thành một chương trình chẩn đoán trong các máy xét nghiệm, chẩn đoán để hỗ trợ khám chữa bệnh trong các bệnh viện.