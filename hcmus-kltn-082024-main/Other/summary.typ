#align(center)[= *TÓM TẮT KHÓA LUẬN*]
#{ "" } // Trick on first line

*Nội dung:* Xây dựng hệ thống sử dụng trí thông minh nhân tạo vào hệ thống hỗ trợ chẩn đoán bệnh ung thư xương qua hình ảnh của bệnh nhân qua việc thực hiện bài toán phân lớp với các bệnh ung thư xương.

*Phương pháp:* Các ảnh y khoa trong tập dữ liệu sẽ trải qua quá trình tiền xử lý để tạo ra những hình ảnh phù hợp cho việc đào tạo mô hình. Các tập dữ liệu ảnh sau đó sẽ được huấn luyện thông qua các mô hình học nơ ron tích chập phổ biến, mô hình Transformer và mô hình kiến trúc tuần tự kết hợp giữa một mô hình nơ ron tích chập phổ biến và Transformer nguyên bản. Khóa luận này sẽ đánh giá và nhận xét về sự phù hợp của các mô hình này với đề tài nghiên cứu, cũng như đưa phương pháp giải thích qua việc xây dựng bản đồ nhiệt ở mức độ trả lời câu hỏi tại sao lại có kết quả như vậy.

*Kết quả:* Các mô hình kiến trúc nơ-ron tích chập đã thể hiện hiệu quả cao. Cụ thể, kiến trúc EfficientNetV2, với phiên bản mô hình EfficientNetV2B1, đạt độ chính xác 0.8815, điểm AUC 0.9625, độ chuẩn xác 0.8953, độ nhạy 0.8741 và điểm F1 là 0.8240, chứng minh sự phù hợp và hiệu quả của nó trong việc giải quyết các bài toán phân loại. Tuy nhiên, kết quả từ mô hình GC-ViT và mô hình kiến trúc tuần tự kết hợp giữa Transformer thuần túy và kiến trúc EfficientNetV2 còn khá thấp so với kì vọng.