// import 'package:flutter/material.dart';
// import 'package:search_it/constants/constants.dart';

// import '../models/chat_message_model.dart';
// import '../widgets/chat_message.dart';
// import '../services/api_service.dart';

// class ConversationScreen extends StatefulWidget {
//   final String? response;

//   const ConversationScreen({super.key, required this.response});

//   @override
//   State<ConversationScreen> createState() => _ConversationScreenState();
// }

// class _ConversationScreenState extends State<ConversationScreen> {
//   bool _isLoading = false;
//   String? result;
//   final _scrollController = ScrollController();
//   final List<ChatMessage> _message = [];
//   final TextEditingController _inputController = TextEditingController();
//   @override
//   void initState() {
//     super.initState();

//     startConversation();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Conversation"),
//       ),
//       body: _isLoading == true
//           ? const Center(
//               child: CircularProgressIndicator(
//                 color: Colors.orange,
//               ),
//             )
//           : Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       children: [
//                         ChatMessageWidget(
//                           text: widget.response!,
//                           messageType: ChatMessageType.user,
//                         ),
//                         Expanded(
//                           child: _buildList(),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           controller: _inputController,
//                           textCapitalization: TextCapitalization.sentences,
//                           style: const TextStyle(
//                             color: Colors.white,
//                           ),
//                           decoration: InputDecoration(
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(25.0),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(25.0),
//                             ),
//                             fillColor: kAppBarColor,
//                             border: InputBorder.none,
//                             filled: true,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             _message.add(
//                               ChatMessage(
//                                 text: _inputController.text,
//                                 chatMessageType: ChatMessageType.user,
//                               ),
//                             );
//                           });
//                           var input = _inputController.text;
//                           _inputController.clear();
//                           Future.delayed(
//                             const Duration(milliseconds: 50),
//                           ).then((value) {
//                             _scrollController.animateTo(
//                               _scrollController.position.maxScrollExtent,
//                               duration: const Duration(milliseconds: 300),
//                               curve: Curves.easeOut,
//                             );
//                           });
//                           generateResponse(input).then((value) {
//                             setState(() {
//                               _message.add(
//                                 ChatMessage(
//                                   text: value,
//                                   chatMessageType: ChatMessageType.bot,
//                                 ),
//                               );
//                             });
//                           });
//                           _inputController.clear();
//                           Future.delayed(
//                             const Duration(milliseconds: 50),
//                           ).then((value) {
//                             _scrollController.animateTo(
//                               _scrollController.position.maxScrollExtent,
//                               duration: const Duration(milliseconds: 300),
//                               curve: Curves.easeOut,
//                             );
//                           });
//                         },
//                         child: Center(
//                           child: Container(
//                             height: 60,
//                             width: 60,
//                             decoration: BoxDecoration(
//                                 color: Colors.orange,
//                                 borderRadius: BorderRadius.circular(30)),
//                             child: const Icon(
//                               Icons.send,
//                               size: 30,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }

//   ListView _buildList() {
//     return ListView.builder(
//       itemCount: _message.length,
//       controller: _scrollController,
//       itemBuilder: (context, index) {
//         var message = _message[index];
//         return ChatMessageWidget(
//           text: message.text,
//           messageType: message.chatMessageType,
//         );
//       },
//     );
//   }

//   Future<void> startConversation() async {
//     setState(() {
//       _isLoading = true;
//     });
//     final String output = await generateResponse(widget.response!);

//     setState(() {
//       result = output;
//       _message.add(
//         ChatMessage(text: result!, chatMessageType: ChatMessageType.bot),
//       );
//       _isLoading = false;
//     });
//   }
// }
