= Thực nghiệm
#{ "" } // Trick on first line

Chương này sẽ trình bày việc thực nghiệm phương pháp đã nêu trên các tập dữ liệu thu nhập được. Các mục đích, môi trường thực nghiệm, các thông số đánh giá mô hình và các kết quả đạt được khi thực hiện khóa luận cũng sẽ được nêu lên trong chương này.

== Mục tiêu
#{ "" } // Trick on first line

Ở thực nghiệm lần này, khóa luận đưa ra các mục tiêu như sau:

- Kiểm chứng các mô hình với tập dữ liệu mà khóa luận sử dụng và đưa ra thông số đánh giá và kết quả của chúng.

- Cho thấy được khả năng tạo bản đồ nhiệt từ các mô hình được huấn luyện trong hệ thống.

- Tìm ra được nguyên nhân tại sao mô hình kiến trúc tuần tự tốt hơn so với việc sử dụng mỗi mô hình nơ-ron tích chập hoặc mô hình Transformer vào trí thông minh nhân tạo.

- Đưa ra được nhận xét tổng thể về phương pháp trên với khóa luận này.

== Tập dữ liệu
#{ "" } // Trick on first line

Khóa luận sẽ sử dụng hai tập dữ liệu để thử nghiệm áp dụng trí thông minh nhân tạo để chẩn đoán bệnh.

=== Tập dữ liệu MURA
#{ "" } // Trick on first line

Tập dữ liệu MURA @rajpurkar2017mura là một tập dữ liệu lớn chứa các hình ảnh X-quang về xương. Các thuật toán sử dụng dữ liệu này có nhiệm vụ xác định xem kết quả chụp X-quang là bình thường hay bất thường. 

Tập dữ liệu MURA là một tập dữ liệu chụp X-quang xương khớp gồm 14,863 tập học từ 12,173 bệnh nhân với tổng số 40,561 hình ảnh X-quang đa góc nhìn @rajpurkar2017mura. Mỗi loại thuộc một trong bảy loại nghiên cứu chụp X-quang chi trên tiêu chuẩn: khuỷu tay, ngón tay, cẳng tay, bàn tay, xương cánh tay, vai và cổ tay. Mỗi nghiên cứu được các bác sĩ X-quang được hội đồng chứng nhận của Bệnh viện Stanford dán nhãn thủ công là bình thường hoặc bất thường tại thời điểm diễn giải X-quang lâm sàng trong môi trường X-quang chẩn đoán từ năm 2001 đến năm 2012 @rajpurkar2017mura.

=== Tập dữ liệu Bone_Saigon-OTH_NNHLT_1.0
#{ "" } // Trick on first line

Khóa luận này sử dụng một tập dữ liệu chứa các hình ảnh X-quang về xương được chụp từ các bệnh nhân tại Bệnh viện Chấn Thương Chỉnh Hình ở Việt Nam, đã được cấp phép, được gọi là tập dữ liệu *Bone_Saigon-OTH_NNHLT_1.0*. 

Đây là tập dữ liệu thu thập từ bệnh viện Chấn Thương Chỉnh Hình do nhóm nghiên cứu của thầy Lý Quốc Ngọc và Th.S Võ Thế Hào thực hiện.

Tập dữ liệu này bao gồm 6809 ảnh X-quang các bệnh về xương của các bệnh nhân được đánh nhãn, chia vị trí bộ phận đã chụp và phân loại bệnh theo các ảnh đó từ các bác sĩ trong bệnh viện. Mỗi loại bệnh đều có các thư mục nhỏ chỉ các bệnh nhỏ của loại bệnh ấy và các vị trí chụp bộ phận có thể mắc bệnh đó. 

Cụ thể, dữ liệu này sau khi được xử lý và sắp sếp với tiêu chí mỗi tập dữ liệu phải có tối thiểu 2 nhãn và mỗi nhãn có ít nhất 10 ảnh, thì ta thu được 5 tập dữ liệu con như sau:

- Tập dữ liệu X-quang đùi có 887 ảnh gồm các nhãn: sarcom (379), sarcoma (217), đại bào (126), sụn (52), k di căn (43), bọc phồng máu (28), bọc xương (27) và nguyên bào (10)

- Tập dữ liệu X-quang cánh tay có 233 ảnh gồm các nhãn: sarcom (62), sụn (55), bọc xương (46), đại bào (39) và bọc phồng máu (16)

- Tập dữ liệu X-quang chày có 308 ảnh gồm các nhãn: sarcom: 113, đại bào (92) và sarcoma (70)

- Tập dữ liệu X-quang mác có 431 ảnh gồm các nhãn: sarcom (387), đại bào (22) và sụn (12)

- Tập dữ liệu X-quang quay có 105 ảnh gồm các nhãn: đại bào (80) và mô bào sợi (12)

#include "table3.typ"

#{ "" } // Trick on first line

Thuật toán sử dụng dữ liệu này rất đa dạng. Trong khóa luận, thuật toán sử dụng dữ liệu này tốt nhất là thuật toán xác định loại bệnh của bộ phận đó thông qua kết quả hình ảnh X-quang của xương của bệnh nhân.

== Chuẩn bị và xử lý dữ liệu
=== Chuẩn bị dữ liệu huấn luyện
#{ "" } // Trick on first line

Cả hai tập dữ liệu đều bao gồm nhiều nhãn và các kích thước ảnh khác nhau. Mỗi tập dữ liệu được sử dụng cho mục đích và bài toán cụ thể, do đó chúng đòi hỏi phương pháp chuẩn bị riêng biệt:

==== Tập dữ liệu MURA
#{ "" } // Trick on first line

Được tổ chức theo từng bộ phận cụ thể, tập dữ liệu MURA đã được phân chia sẵn thành các phần dành cho việc huấn luyện và đánh giá mô hình. Mỗi bệnh nhân trong tập dữ liệu này thường có hai thư mục con là âm tính và dương tính, chứa ảnh tương ứng với tình trạng bệnh. Tuy nhiên, các ảnh không có kích thước chuẩn duy nhất, yêu cầu phải xử lý kích thước ảnh trước khi tiến hành huấn luyện mô hình.

==== Tập dữ liệu Bone_Saigon-OTH_NNHLT_1.0
#{ "" } // Trick on first line

Tập dữ liệu này được phân loại theo bệnh của bệnh nhân và cũng được chia theo bộ phận. Do sự đa dạng của bộ phận và số lớp bệnh, nhóm nghiên cứu đã lựa chọn các bộ phận và số lớp bệnh cụ thể để tập trung vào. Sau quá trình lựa chọn, nhóm tiến hành các bước tiền xử lý cần thiết. Các ảnh trong tập dữ liệu này cũng không có kích thước chuẩn, đòi hỏi phải điều chỉnh kích thước ảnh X-quang trước khi sử dụng. Vì số lượng ảnh còn hạn chế, nhóm áp dụng thuật toán để gia tăng dữ liệu. Khi thực nghiệm, tập dữ liệu này sẽ được chia thành tập huấn luyện và thử nghiệm với tỷ lệ 80/20.

=== Xử lý dữ liệu
#{ "" } // Trick on first line

Trước khi bắt đầu huấn luyện mô hình, cần phải tiền xử lý cả hai tập dữ liệu để thu được những bức ảnh phù hợp với mô hình.

Như đã đề cập trong chương 3, kích thước và đệm của hình ảnh trong cả hai tập dữ liệu sẽ được điều chỉnh theo kích thước mà nhóm lựa chọn. Trong trường hợp này, khóa luận sẽ sử dụng hình ảnh X-quang có kích thước 224 x 224 điểm ảnh cho việc huấn luyện.

Thêm vào đó, do thiếu kiến thức chuyên môn sâu về y khoa, khóa luận này sẽ xác định các bệnh hoặc trạng thái bệnh dựa trên tên thư mục có sẵn trong tập dữ liệu hoặc dựa trên thông tin từ file csv hoặc bảng tính đi kèm để phân loại các bức ảnh X-quang.

=== Gia tăng dữ liệu
#{ "" } // Trick on first line

Khóa luận đã thực hiện nhiều thử nghiệm với tập dữ liệu của bệnh viện và nhận thấy kết quả không mấy khả quan, không phù hợp với số lượng ảnh hiện có. Điều này cho thấy sự cần thiết phải bổ sung thêm dữ liệu để cải thiện chất lượng. Các nghiên cứu như @pu2024advantages cũng chỉ ra rằng việc thiếu dữ liệu y khoa làm cho việc huấn luyện mô hình không hiệu quả, gây ra nhiều lỗi. Do đó, khóa luận cần thực hiện các phương pháp để gia tăng dữ liệu ảnh X-quang, cụ thể là với bộ tập dữ liệu Bone_Saigon-OTH_NNHLT_1.0.

Khóa luận áp dụng thuật toán chỉnh sửa ảnh, như tăng độ sáng của ảnh lên 1.2 hoặc giảm độ sáng của ảnh xuống 0.8 của tất cả ảnh trong tập dữ liệu. Các ảnh đã chỉnh sửa sau đó được thêm vào bộ dữ liệu huấn luyện, làm tăng số lượng dữ liệu gấp ba lần so với ban đầu.

Quá trình chỉnh sửa ảnh y khoa trong việc tăng cường dữ liệu và huấn luyện mô hình được hạn chế để tránh các vấn đề sau:

- *Mất tính chính xác*: Chỉnh sửa quá nhiều hình ảnh X-quang có thể làm mất đi các đặc điểm quan trọng của ảnh, dẫn đến việc mô hình học từ dữ liệu không chính xác. Ngoài ra, các chỉnh sửa có thể tạo ra các thông tin sai lệch, làm cho mô hình học sai và đưa ra các dự đoán không chính xác.

- *Giảm khả năng tổng quát hóa*: Chỉnh sửa quá nhiều có thể làm giảm tính đa dạng của dữ liệu, khiến mô hình khó khăn trong việc tổng quát hóa và áp dụng cho các dữ liệu mới hoặc chưa từng thấy. Ngoài ra, các mô hình huấn luyện có thể bị quá sức với các đặc điểm không thực tế do các chỉnh sửa, dẫn đến hiệu suất kém trên dữ liệu thực tế.

- *Khó khăn trong việc tái tạo kết quả*: Nếu ảnh y khoa bị chỉnh sửa quá nhiều, việc tái tạo các kết quả tương tự trên các bộ dữ liệu khác sẽ trở nên khó khăn, làm giảm tính khả thi của mô hình trong thực tế. Không chỉnh vậy, các chỉnh sửa không nhất quán có thể dẫn đến các kết quả không nhất quán, làm giảm độ tin cậy của mô hình.

- *Ảnh hưởng đến quyết định lâm sàng*: Các mô hình học từ dữ liệu đã bị chỉnh sửa quá nhiều có thể đưa ra các quyết định sai lầm trong chẩn đoán và điều trị của các bác sĩ, ảnh hưởng đến sức khỏe và sự sống còn của bệnh nhân. 

== Tài nguyên huấn luyện mô hình
=== Ngôn ngữ lập trình và công cụ hỗ trợ 
#{ "" } // Trick on first line

Để quá trình huấn luyện mô hình diễn ra suôn sẻ và không gặp lỗi với các hệ thống khác, khóa luận này sẽ áp dụng Google Colab - một dịch vụ Jupyter Notebook do Google cung cấp, cho phép người dùng viết và thực thi mã lệnh ngay trên trình duyệt mà không yêu cầu cài đặt thêm phần mềm. Khóa luận cũng sẽ tận dụng các tài nguyên tính toán hiệu năng cao của Google Colab như GPU T4 để tiến hành huấn luyện.

Khóa luận này sẽ sử dụng Python làm ngôn ngữ lập trình chính, vốn rất phù hợp với môi trường Google Colab. Phiên bản Python được sử dụng là 3.10.

=== Thư viện sử dụng
#{ "" } // Trick on first line

Để thực hiện khóa luận lần này, các thư viện và phiên bản đã được sử dụng để phục vụ cho việc lập trình và xây dựng hệ thống như sau:

- *IPython* (phiên bản 7.34.0): Thư viện cung cấp các công cụ tương tác cho Python, được sử dụng để hiển thị kết quả.

- *google.colab* (phiên bản 1.0.0): Thư viện dành riêng cho môi trường Google Colab, được sử dụng để mount Google Drive.

- *os*: Thư viện cung cấp các hàm để tương tác với hệ điều hành.

- *cv2 (OpenCV)* (phiên bản 4.8.0.76): Thư viện xử lý ảnh và video, được sử dụng để xử lý ảnh và tìm bounding box.

- *numpy* (phiên bản 1.25.2): Thư viện cung cấp các công cụ tính toán số học và ma trận.

- *tensorflow* (v2.15.0): Thư viện học máy, được sử dụng để xây dựng và huấn luyện mô hình.

- *matplotlib* (v3.7.1): Thư viện vẽ đồ thị, được sử dụng để hiển thị hình ảnh và heatmap.

// - Pyqt6: Thư viện dùng để tạo các giao diện cho hệ thống.

=== Mô hình
#{ "" } // Trick on first line

Khóa luận này sử dụng rất nhiều mô hình học để huấn luyện và kiểm tra với các tập dữ liệu được chọn, bao gồm các mô hình từ kiến trúc mạng nơ-ron tích chập như EfficientNetV2, MobileNetV3, ResNetV2, VGG; kiến trúc Transformer với mô hình GC-ViT; mô hình kiến trúc tuần tự giữa một mô hình của kiến trúc EfficientNetV2 và mô hình Transformer thuần túy.

Với kiến trúc EfficientNetV2 có nhiều biến thể mô hình như EfficientNetV2B0, EfficientNetV2B1, EfficientNetV2B2, EfficientNetV2B3. Các biến thể mô hình trên khác nhau về kích thước, số lượng tham số, độ sâu, chiều rộng, hiệu xuất và độ chính xác. Ngoài sử dụng các mô hình của kiến trúc EfficientNetV2, khóa luận còn sử dụng các mô hình huấn luyện chạy trên chính tập dữ liệu thực nghiệm để so sánh với các mô hình đã chọn. Các kiến trúc và mô hình tương ứng sẽ sử dụng thêm là kiến trúc MobileNetV3 với mô hình MobileNetV3Large, kiến trúc ResNetV2 với mô hình ResNetV2 50, ResNetV2 101 và kiến trúc VGG với mô hình VGG16 và VGG19.

Dữ liệu huấn luyện và thực nghiệm được chuẩn hóa với kích thước 224 x 224 điểm ảnh. Các tập dữ liệu được đánh giá dựa trên các chỉ số khác nhau, phù hợp với từng mô hình cụ thể.

== Chỉ số đánh giá
#{ "" } // Trick on first line

Khóa luận này sử dụng một số hệ số đánh giá khi thực nghiệm với các mô hình học máy:

_*1. Độ chính xác:*_ Tỷ lệ phần trăm các mẫu được phân loại đúng.

*Công thức:* $"Độ chính xác" = ("TP" + "TN") / ("TP" + "TP" + "FP" + "FN")$

*Trong đó:*

- _TP (True Positive)_: Số lượng điểm dữ liệu được phân loại chính xác là hình ảnh của bệnh này.

- _TN (True Negative)_: Số lượng điểm dữ liệu được phân loại chính xác không phải là hình ảnh của bệnh này.

- _FP (False Positive)_: Số lượng điểm dữ liệu bị phân loại nhầm là hình ảnh của bệnh này nhưng thực tế là của một bệnh khác.

- _FN (False Negative)_: Số lượng điểm dữ liệu bị phân loại nhầm không phải là hình ảnh của bệnh này trong khi thực sự là của bệnh cần tìm.

#{ "" } // Trick on first line

_*2. AUC*_: Diện tích dưới đường cong ROC, dùng để đo lường hiệu suất khả năng phân loại của mô hình. Hiện nay không có công thức tính toán trực tiếp, được tính toán từ đường cong ROC.

Đường cong ROC là một đường cong biểu diễn hiệu suất phân loại của một mô hình phân loại tại các ngưỡng threshold. Về cơ bản, nó hiển thị tỷ lệ số lượng dự đoán chính xác (TPR) so với tỷ lệ số lượng các dự đoán sai lệch (FPR) đối với các giá trị ngưỡng khác nhau. Các giá trị TPR, FPR được tính như sau:

*Công thức:* $"TPR" = "TP" / ("TP" + "FP")$ ; $"FPR" = "FP" / ("TN" + "FN")$

ROC tìm ra TPR và FPR ứng với các giá tị ngưỡng khác nhau và vẽ biểu đồ để dễ dàng quan sát TPR so với FPR. AUC là chỉ số được tính toán dựa trên đường cong ROC nhằm đánh giá khả năng phân loại của mô hình tốt như thê nào. Phần diện tích nằm dưới đường cong ROC và trên trục hoành chính là AUC, có giá trị nằm trong khoảng [0, 1].

#figure(
  image("image\ROC.drawio.png", width: 80%),
  caption: [Biểu đồ ROC],
)

#{ "" } // Trick on first line

Khi diện tích này càng lớn, đường cong này sẽ dần tiệm cận với đường thẳng y = 1 tương đương với khả năng phân loại của mô hình càng tốt. Còn khi đường cong ROC nằm sát với đường chéo đi qua hai điểm (0, 0) và (1, 1), mô hình sẽ tương đương với một phân loại ngẫu nhiên.

_*3. Độ chuẩn xác*_: Tỷ lệ phần trăm các mẫu được dự đoán đúng bệnh mà thực sự là đúng bệnh đấy. Lý do có tham số đánh giá này bởi vì có một số trường hợp hệ số chính xác lại không phải ánh đúng hiệu quả của mô hình. Giả sử một mô hình dự đoán có tỉ lệ chính xác khá là cao nhưng thực chất mô hình vẫn khá tồi, không đúng kết quả thực nghiệm với hệ số đó. Ngoài ra, đây cũng là một hệ số giúp tính một hệ số khác là *Điểm F1*. Công thức tính độ chuẩn xác được thể hiện như sau.

*Công thức:* $"Độ chuẩn xác" = ("TP") / ("TP" + "FP")$

_*4. Độ nhạy*_: Tỷ lệ phần trăm các mẫu bệnh thực sự được dự đoán là đúng mẫu bệnh đấy.

*Công thức:* $"Độ nhạy" = ("TP") / ("TP" + "FN")$

_*5. Điểm F1*_: Trung bình điều hòa của độ chuẩn xác và độ nhạy, cân bằng giữa hai hệ số này.

*Công thức:*
$"Điểm F1 " = (2* "Độ chuẩn xác" * "Độ nhạy") / ("Độ chuẩn xác" + "Độ nhạy")$

== Các thực nghiệm và kết quả
=== Thực nghiệm 1
==== Nội dung
#{ "" } // Trick on first line

Ở thực nghiệm này, khóa luận sẽ thực nghiệm kiểm tra độ chính xác của kiến trúc EfficientNetV2 với mô hình EfficientNetV2B0 và kiến trúc Transformer với mô hình GC-ViT phiên bản nhỏ với bài toán xác định phân loại trạng thái bệnh qua tập dữ liệu MURA. 

Mục đích của lần thực nghiệm này nhằm xem xét các mô hình học mà khóa luận nêu ra, kiểm tra độ phù hợp của các dòng lệnh của hệ thống cũng như các kết quả mà các mô hình trên đạt được khi huấn luyện.

Khi bắt đầu huấn luyện mô hình, hệ thống sẽ lấy dữ liệu ra khỏi tập dữ liệu theo từng đợt một để không bị tràn bộ nhớ trong. Sau đó, các dữ liệu đó sẽ được đưa vào huấn luyện. Sau khi huấn luyện với đợt dữ liệu đó xong thì dữ liệu đấy sẽ bị xóa đi và thay thế bằng các đợt dữ liệu khác. Hệ thống cứ thực hiện như vậy cho đến khi các dữ liệu trong tập đấy đã được chạy hết.

Tập dữ liệu trong thực nghiệm này được huấn luyện với epoch là 20.

==== Các kết quả đạt được
#{ "" } // Trick on first line

Sau đợt thử nghiệm này, kết quả của hệ thống cho thấy được rằng:
- Với mô hình EfficientNetV2B0 cho được hệ số hàm lỗi là 0.6017 và độ chính xác là 0.7201. Qua đó, kết quả trên cho thấy được kết quả khả quan và hệ thống chạy ổn định với mô hình này.

- Với mô hình GC - ViT cho được hệ số hàm lỗi là 0.6842 và độ chính xác là 0.5358. Qua đó cho thấy được kết quả đúng với những gì nhóm tính toán và đúng với thông số kết quả của chính mô hình đấy trong báo cáo. Ngoài ra, mô hình trên vẫn có thể chạy ổn với hệ thống mà khóa luận thực hiện nhưng phải cần có những cập nhật về lệnh để hạn chế tràn bộ nhớ.

#{ "" } // Trick on first line

Trong thực nghiệm này, khóa luận tạo bản đồ nhiệt trên mô hình nơ-ron tích chập và cho thấy được kết quả tốt. Hệ thống có thể nhận biết được vùng khả nghi ngay cả khi ảnh có bị quay hay một số vấn đề khác mà khóa luận có thử nghiệm qua.

#figure(
  image("image\pic1.png", width: 100%),
  caption: [Ảnh xương ban đầu (Trái) - Ảnh được chồng bản đồ nhiệt (Phải)],
)

#{ "" } // Trick on first line

Thử nghiệm này cho thấy được hệ thống mà khóa luận này thực nghiệm có thể chạy được với hai mô hình trên và đưa ra được các kết quả đúng theo kì vọng đã đặt ra. Tuy nhiên, hệ thống này vẫn cần có một số chỉnh sửa để tránh các trường hợp tràn bộ nhớ khi huấn luyện. 

Thực nghiệm này chỉ là mang tính chất tham khảo trước khi bắt tay sửa chữa và sử dụng vào thực nghiệm chính mà khóa luận này thực hiện.

=== Thực nghiệm 2
==== Nội dung
#{ "" } // Trick on first line

Ở thực nghiệm 2 này, khóa luận sẽ thực hiện với bài toán phát hiện bệnh đối với các mô hình trong kiến trúc EfficientNetV2, GC - ViT và mô hình kiến trúc tuần tự kết hợp giữa mô hình EfficientNetV2 và mô hình Transformer thuần túy. Ngoài các mô hình trên, khóa luận sẽ thực nghiệm với các mô hình khác như là kiến trúc mô hình MobileNetV3 với biến thể lớn, kiến trúc ResNetV2 với mô hình ResNetV2 50, ResNetV2 101 và kiến trúc VGG với mô hình VGG16 và VGG19 với cùng tập dữ liệu mà khóa luận sử dụng.

Bài thực nghiệm này sẽ thực nghiệm trên tập dữ liệu Bone_Saigon-OTH_NNHLT_1.0 đã được gia tăng dữ liệu để việc huấn luyện trở nên tốt hơn. Không chỉ vậy, khóa luận sẽ áp dụng các phương pháp giải thích bằng Grad-CAM cho các mô hình trong kiến trúc EfficientNetV2 để tạo bản đồ nhiệt.

Mục đích của thực nghiệm này nhằm sử dụng các kiến trúc mô hình mới và nổi bật hiện nay để thực nghiệm với tập dữ liệu thực tế và so sáng chúng.  Không chỉ vậy, thực nghiệm này còn kiểm tra khả năng giải thích kết quả tiên đoán của chính mô hình khi áp dụng các phương pháp giải thích vào hệ thống ở mức độ trả lời câu hỏi tại sao lại có kết quả như vậy.

Hệ thống sẽ có một chút khác biệt so với thực nghiệm 1 khi lần này chạy hết dữ liệu của bộ phận đã chọn và chỉnh sửa lại cho phù hợp với bài toán mà thực nghiệm này thực hiện. Tập dữ liệu trong thực nghiệm này được huấn luyện với epoch = 100 và sẽ tự dừng khi hàm lỗi không hay đổi quá nhiều trong 5 lần epoch gần đây của mô hình ấy. Hệ thống sẽ chạy với T4 GPU trong Google Colab.

==== Các kết quả đạt được
#{ "" } // Trick on first line

Sau khi thử nghiệm, nhóm đã ghi nhận và tổng hợp các kết quả và các tham số cần tính và được tổng hợp ở bảng dưới đây.

#include "table2.typ"

#{ "" } // Trick on first line

Qua bảng này, khóa luận thấy rằng các mô hình của kiến trúc EfficientNetV2 đưa ra được các kết quả vượt trội hơn so với các mô hình kiến trúc khác được thực nghiệm trên cùng một tập dữ liệu. Trong các mô hình của kiến trúc EfficientNetV2, mô hình EfficientV2B1 lại là mô hình đưa ra kết quả ấn tượng nhất với độ chính xác lên 0.8815, điểm AUC là 0.9625, độ chuẩn xác là 0.8953, độ nhạy là 0.8741 cùng với điểm F1 là 0.8240 với tổng tham số sử dụng để huấn luyện là gần 6 triệu. Ngoài ra, các mô hình của kiến trúc EfficientNetV2 khác cũng thể hiện tốt không kém gì và cả 4 biến thể mô hình đều đứng ở thứ hạng cao trong số liệu được nêu trên bảng đấy. Qua đó, khóa luận thấy được độ hiệu quả mà các biến thể của mô hình EfficientNetV2 mang lại và phù hợp với bài toán thực nghiệm này.

Ngoài ra, khóa luận có thực nghiệm với mô hình GC-ViT và mô hình kiến trúc tuần tự và cho  một kết quả rất thấp với độ chính xác dưới 50%, rất thấp so với kết quả của các mô hình nơ-ron tích chập đươc nêu ở bảng trên.

Để thể hiện rõ hơn về số liệu của các mô hình liên quan với nhau thì khóa luận có vẽ thêm 2 biểu đồ thể hiện kết quả tham số của các mô hình đấy với tổng tham số đã sử dụng để thực nghiệm với tập dữ liệu này.

#figure(
  image("image\LossPlot.png", width: 100%),
  caption: [Biểu đồ hàm lỗi với các mô hình],
)

#{ "" } // Trick on first line

#figure(
  image("image\AccurancyPlot.png", width: 100%),
  caption: [Biểu đồ độ chính xác với các mô hình],
)

#{ "" } // Trick on first line

Qua hai biểu đồ trên, khóa luận càng thấy rõ hơn sự vượt trội của các mô hình của kiến trúc EfficientNetV2 về cả độ chính xác cũng như hàm lỗi mà mô hình thể hiện trong thực nghiệm so với các mô hình khác. Qua đấy, khóa luận có thể khẳng định rằng với các mô hình của kiến trúc EfficientNetV2 sẽ đưa ra được các kết quả tốt hơn và chuẩn xác hơn so với các mô hình tiệm cận với nó.

Tuy vậy, dù có hiệu suất mô hình cao như vậy nhưng không có các hình ảnh, giải thích trực quan cho kết quả trên thì hệ thống vẫn không thể sử dụng được. Trong thực nghiệm này, khóa luận sử dụng phương pháp Grad-CAM tạo biểu đồ nhiệt cho các mô hình của kiến trúc EfficientNetV2 và đây là kết quả đạt được được thể hiện ở hình dưới đây.

#figure(
  image("image\anh_ket_qua.png", width: 100%),
  caption: [Ảnh gốc và bản đồ nhiệt của ảnh X-quang xương đùi],
)

#{ "" } // Trick on first line

Khi thực nghiệm, các mô hình đều tìm ra được các điểm đặc trưng cho các loại bệnh của bộ phận ấy. Khi chọn một ảnh bất kì, nó sẽ dựa vào những gì đã học để đưa ra các điểm đặt trưng đấy và xác định bệnh, Ở ảnh này, mô hình đã xác định được các điểm đặc trưng nghi ngờ là bệnh sarcom và được thể hiện qua các màu vàng đỏ ngay giữa hình.

#figure(
  image("image\heatmap_bound.png", width: 100%),
  caption: [Bản đồ nhiệt với ảnh X - quang xương với khung đánh dấu điểm nổi trội],
)
#{ "" } // Trick on first line

Khóa luận xây dựng thêm khung đóng các khu vực đặc trưng từ biểu đồ nhiệt trên và cho thấy được vùng cần chú ý với ảnh này. Về kết quả, mô hình trên đoán đúng bệnh mà ảnh này có là bệnh sarcom. Ngoài ra, khóa luận cũng thử nghiệm với các hình ảnh khác và cho kết quả cũng khá khả quan.

== Nhận xét
#{ "" } // Trick on first line

Thực nghiệm đã chỉ ra rằng tất cả các mô hình nơ-ron tích chập đều có khả năng tạo ra bản đồ nhiệt. Các mô hình nơ-ron tích chập đều đạt kết quả tốt trên bộ dữ liệu này, với EfficientNetV2 cho kết quả xuất sắc nhất. MobileNetV3 có kết quả hơi thấp hơn nhưng lại tiêu thụ ít tài nguyên hơn nhiều. Các mô hình nơ-ron tích chập khác không đạt kết quả cao nhưng vẫn tương đương với những gì được trình bày trong các bài báo tham khảo. 

Mặt khác, các mô hình biến đổi trực quan và mô hình kiến trúc tuần tự chỉ đạt kết quả rất thấp (dưới 50%) nhưng vẫn cao hơn đáng kể so với mức dưới đó. Điều này có thể là do mô hình biến đổi trực quan thường cần một lượng dữ liệu lớn để có thể đạt hiệu suất tương đương với mô hình nơ-ron tích chập. Ví dụ, các bộ dữ liệu y khoa mà mô hình biến đổi trực quan đạt kết quả tốt như MURA có 40,561 mẫu và chest-mnist với hơn 112,000 mẫu, trong khi số lượng mẫu hiện tại để huấn luyện mô hình trên là chưa đủ. Tuy nhiên, nếu được triển khai thực tế trong bệnh viện với cơ chế thu thập dữ liệu bảo mật và hiệu quả, mô hình biến đổi trực quan có thể sẽ cho kết quả tốt.

Khóa luận cũng đã thực hiện việc xây dựng bản đồ nhiệt trả lời cho câu hỏi tại sao lại ra kết luận như vậy và chạy khá tốt. Tuy vậy, khóa luận vẫn chưa có thêm được phương pháp GradAR vào mô hình Transformer và mô hình kiến trúc tuần tự nên chưa thêm được cái nhìn tổng quát về các bản đồ nhiệt khác nhau của các mô hình. 

Các kết quả hiện giờ chỉ mới có ở một bộ phận. Các bộ phận khác không đủ dữ liệu chưa có thời gian thực nghiệm nên chưa thể đưa ra được trong khóa luận này.

Khóa luận đã xây dựng ma trận lỗi để chỉ ra rằng một số lớp có thể bị nhầm lẫn lẫn nhau do sự tương đồng trong các triệu chứng bệnh. Điển hình là các nhãn sarcom, sarcoma và đại bào, vì chúng có các biểu hiện triệu chứng trong hình ảnh rất giống nhau. Chẳng hạn, hình 19, cả ảnh gốc và kết quả đều được ghi nhận là Sarcom, nhưng cũng có trường hợp nó được phân loại là đại bào do sự giống nhau trong các dấu hiệu của bệnh.

#figure(
  image("image/confuse_matrix.png", width: 100%),
  caption: [Ma trận lỗi với kết quả các nhãn ở bộ phận đùi],
)

#{ "" } // Trick on first line

Mặc dù có một số trường hợp nhầm lẫn như vậy, hệ thống vẫn thực hiện tốt công việc phân loại với tỷ lệ lỗi thấp, ngay cả khi hình ảnh quá giống nhau đến mức đôi khi ngay cả bác sĩ cũng khó phân biệt.