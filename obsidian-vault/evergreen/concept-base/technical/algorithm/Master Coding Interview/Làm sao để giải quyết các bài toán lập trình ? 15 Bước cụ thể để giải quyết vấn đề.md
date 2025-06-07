---
profileName: sangtrandev00
postId: 3261
postType: post
categories:
  - 39
---
Bộ câu hỏi cần thiết giúp lập trình viên như tụi mình vượt qua được các vòng phỏng vấn technical interview phức tạp. Đây là thứ mình đang chuẩn bị cho hành trình đó!
How to solve coding problem ?
Những câu hỏi cần phải đặt ra khi đối mặt với các bài toán giải quyết vấn đề
## Người phỏng vấn muốn biết gì về khả năng của bạn ?

**• Analytic Skills** - How can you think through problems and analyze things?
Kỹ năng phân tích vấn đề
**• Coding Skills** - Do you code well, by writing clean, simple, organized, readable code?
Kỹ năng lập trình, viết code sạch, đơn giản, tổ chức, khả năng dễ đọc
**• Technical knowledge** - Do you know the fundamentals of the job you're applying for?
Kiến thức về kỹ thuật, nền tảng để apply vào vị trís
**• Communication skills**: Does your personality match the companies' culture?
Khả năng giao tiếp, phù hợp với văn hoá công ty
## 4 Nguyên tắc

Dưới đây là 4 nguyên tắc mình rút ra được trong quá trình xem video phỏng vấn mẫu của google interview. Mình để link ở bên dưới

Tóm tắt các key (từ khoá) cần phải lưu ý
- **Clarifications**
	- Làm rõ yêu cầu
- **Think outloud**
	- Nói ra những suy nghĩ về vấn đề (Như một cuộc hội thoại)
- **Talk before write**
	- Nói ra các dòng code trước khi thực hiện viết nó
- **Test solution**
	- Sau khi làm bài test xong sẽ luôn có một sự kiểm tra lại với các trường hợp có thể xảy ra

## 15 bước checklist khi giải quyết vấn đề

Chi tiết, Có khoảng 15 nguyên điều cần làm rõ trước khi đưa ra phỏng vấn. Đây là các bước mình thu thập từ khoá học Udemy của anh founder trong khoá Master Coding Interview. Hãy cùng thảo luận nhé.
Từ 4 key ở trên chúng ta có thể chia làm 15 bước nhỏ để đặt câu hỏi và giải quyết vấn đề. Từ đó chúng ta sẽ có sẵn những bước đi trong giao tiếp với người phỏng vấn.
Mình tin rằng đây cũng là tuyệt chiêu vô cùng quan trọng cho việc trình bày vấn đề ở nơi công sở và thuyết phục người khác nên cứ thoải mái follow thôi nào!

1. When the interviewer says the question, write down the key points at the top (i.e. sorted
array). Make sure you have all the details. Show how organized you are.
Nguyên văn ý nghĩa là: Khi người phỏng vấn đặt câu hỏi, hãy. viết ra điểm mấu chốt lên trên (Array đã được sort chưa ? Các phần từ trong array là số ? Float hay Interger ? Có thể toàn tại char không ?)
2. Make sure you double check: What are the inputs? What are the outputs?
Hãy đảm bảo rằng bạn nhấn mạnh, xem kỹ đầu vào (input) và đầu ra output của bài toán là gì ?
Ví dụ trong bài phỏng vấn interview. Ứng cử viên sẽ khẳng định lại các input -> và nói về kết quả (output) trong các trường hợp 
3. What is the most important value of the problem? Do you have time, and space and memory,
etc.. What is the main goal?
	Mục tiêu quan trọng ở đây là gì ? Thời gian ? Bộ nhớ ? Nếu đàu vào input thì chỉ có vài phần tử thì bài toán của mình có thể bỏ qua về time complexity (độ phức tạp về thời gian)
	Xem bài Big O của mình tại đây ! [[Big O là gì ?]]
**How large the array going to have?**
4. Don't be annoying and ask too many questions.
Đừng làm phiền mà hỏi quá nhiều câu hỏi. Chỉ hỏi vừa đủ nhưng đừng ngại đặt câu hỏi cho người phỏng vấn
5. Start with the naive/brute force approach. First thing that comes into mind. It shows that
you're able to think well and critically (you don't need to write this code, just speak about it).
Hãy bắt đầu với cách tiếp cận dễ nhất (Kiểm tra hết các trường hợp với kỹ thuật brute force)
Đừng kỹ trong đầu. Mà hãy nói ra để cho người phỏng vấn biết.
6. Tell them why this approach is not the best (i.e. O(n^2) or higher, not readable, etc...)
 hoặc 0 (n * m)
	Kể cho họ, tại sao cách tiếp cận brute force trên là không hiệu quả. 
	Lúc này kiến thức về BigO được phát huy. 
	Mình sẽ trả lời do độ phức tạp của bài toán sẽ là 0(n^2) chức năng sẽ chậm khi có lượng dataset input lớn!
7. Walk through your approach, comment things and see where you may be able to break things.
		Đi qua cách. tiếp cận của bạn, ghi chú một vài thứ và nhìn thấy nơi bạn có thể sẽ chia nhỏ chúng ra
Any repetition, bottlenecks like O(N^2), or **unnecessary work?** Did you use all the information
the interviewer gave you? Bottleneck is the part of the code with the biggest Big O. Focus on
that. Sometimes this occurs with repeated work as well.

8. Before you start coding, walk through your code and write down the steps you are going to
follow.
	Trước khi bắt đầu code, hãy đi qua đoạn code của bạn và viết xuống từng bước bạn sẽ làm. Như vậy sẽ tốt hơn, cho bạn một cái nhìn tổng thể trước khi code
9. Modularize your code from the very beginning. Break up your code into beautiful small pieces and add just comments if you need to.
Clean code. S.O.L.I.D sẽ được nói đến ở đây. Những đoạn code có thể tách ra thành một hàm chung thì nên tách ra
11. Start actually writing your code now. Keep in mind that the more vou prepare and understand what you need to code, the better the whiteboard will go. So never start a whiteboard interview not being sure of how things are going to work out. That is a recipe for disaster.
**Keep in mind:** A lot of interviews ask questions that you won't be able to fully answer on time.
(So think: What can I show in order to show that I can do this and I am better than other
coders. Break things up in Functions (if you can't remember a method, just make up a function
and you will at least have it there. Write something, and start with the easy part.
	Bắt đầu viết về những dòng code khi bạn đã chuẩn bị và hiểu những gì bạn cần code. 

11. Think about error checks and how you can break this code. Never make assumptions about the input. Assume people are trying to break your code and that Darth Vader is using your function. How will you safeguard it? Always check for false inputs that you don't want. Here is
**a trick:** Comment in the code, the checks that you want to do... write the function, then tell the
interviewer that vou would write tests now to make vour function fail (but vou won't need to
actually write the tests).
Kiem tra đầu vào
Đóng vai trò như một tester, kiểm tra những trường hợp tệ nhất có thể xảy ra!
VD: Can I assume that second input is Number. All the input are arrays?
12. Don't use bad/confusing names like i and i. Write code that reads well.
13. Test your code: Check for no params, 0, undefined, null, massive arrays, async code, etc... Ask
the interviewer if we can make assumption about the code. Can you make the answer return
an error? Poke holes into your solution. Are you repeating yourself?
**Lặp lại của bước 11.** 
14. Finally talk to the interviewer where you would improve the code. Does it work? Are there
different approaches? Is it readable? What would you google to improve? How can
performance be improved? Possibly: Ask the interviewer what was the most interesting
solution you have seen to this problem
Cuối cùng hỏi người phỏng vấn nơi mà bạn có thể cải thiện đoạn code. Có cách tiếp cận khác tốt hơn không ? Nó có dễ đọc hơn hay không ? Bạn có muốn cải thiện nó không ? Hiệu năng có thể được cải thiện
15. If your interviewer is happy with the solution, the interview usually ends here. It is also
common that the interviewer asks you extension questions, such as how you would handle the
problem if the whole input is too large to fit into memory_or if the input arrives as a stream.
This is a common follow-up question at Gopqle, where they care a lot about scale. The answer
is usually a divide-and-conquer approach - perform distributed processing of the data and only
read certain chunks of the input from disk nto memory, write the output back to disk and
combine them later.
	Cuối cùng, nếu người phỏng vấn vui với giải pháp, Người phỏng vấn thường kết thúc ở đây. Tuy nhiên có vài trường hợp, người phỏng vấn sẽ bắt đầu đặt các trường hợp. Giả sử input ở đây rất lớn, ảnh hưởng đến bộ nhớ ? Bạn sẽ làm như thế nào ?
--> Câu trả lời thường sẽ áp dụng chiến lược chia để trị. Chunking (Chia nhỏ thành các tập hợp)
## Những điều cần lưu ý

- Hash Maps are usually the answer to improve Time Complexity.
	- Hash Maps thì thường là đáp án cải thiện độ phức tạp thời gian trong các bài toán. Chúng ta có thể tham khảo đến Hashmap khi sử dụng các bài toán với độ phức tạp là O(n^2)
- If it's a sorted array, use Binary tree to achieve O(log N). Divide and Conquer - Divide a data set
- into smaller chunks and then repeating a process with a subset of data. Binary search is a great example of this
- [Try Sorting your input] Hash tables and precomputed information (i.e. sorted) are some of the best ways to optimize your code
- Look at the **Time** vs **Space tradeoff.** Sometimes storing extra state in memory can help the time. (Runtime)
- If the interviewer is giving you advice/tips/hints. **Follow them**
- Space time tradeoffs: Hash table usually solve this a lot of the times. You use more space, but you can get a time optimization to the process. In programming, you often times can use up a little bit more space to get faster time


---
## Liên quan

#algorithm #data-structure #interview