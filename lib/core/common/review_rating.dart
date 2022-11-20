// import 'package:flutter/material.dart';

// class ReviewRating extends StatefulWidget {
//   final int rating;
//   const ReviewRating({
//     super.key,
//     required this.rating,
//   });

//   @override
//   State<ReviewRating> createState() => _ReviewRatingState();
// }

// class _ReviewRatingState extends State<ReviewRating> {
//   @override
//   Widget build(BuildContext context) {
//     return widget.rating == 0
//         ? Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               IconButton(
//                 onPressed: () {
//                   setState(() {
//                     rating = 1;
//                   });
//                 },
//                 icon: const Icon(
//                   Icons.star_rounded,
//                   color: Colors.grey,
//                   size: 50,
//                 ),
//               ),
//               IconButton(
//                 onPressed: () {
//                   setState(() {
//                     rating = 2;
//                   });
//                 },
//                 icon: const Icon(
//                   Icons.star_rounded,
//                   color: Colors.grey,
//                   size: 50,
//                 ),
//               ),
//               IconButton(
//                 onPressed: () {
//                   setState(() {
//                     rating = 3;
//                   });
//                 },
//                 icon: const Icon(
//                   Icons.star_rounded,
//                   color: Colors.grey,
//                   size: 50,
//                 ),
//               ),
//               IconButton(
//                 onPressed: () {
//                   setState(() {
//                     rating = 4;
//                   });
//                 },
//                 icon: const Icon(
//                   Icons.star_rounded,
//                   color: Colors.grey,
//                   size: 50,
//                 ),
//               ),
//               IconButton(
//                 onPressed: () {
//                   setState(() {
//                     rating = 5;
//                   });
//                 },
//                 icon: const Icon(
//                   Icons.star_rounded,
//                   color: Colors.grey,
//                   size: 50,
//                 ),
//               ),
//             ],
//           )
//         : rating == 1
//             ? Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   IconButton(
//                     onPressed: () {
//                       setState(() {
//                         rating = 1;
//                       });
//                     },
//                     icon: const Icon(
//                       Icons.star_rounded,
//                       color: Colors.red,
//                       size: 50,
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       setState(() {
//                         rating = 2;
//                       });
//                     },
//                     icon: const Icon(
//                       Icons.star_rounded,
//                       color: Colors.grey,
//                       size: 50,
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       setState(() {
//                         rating = 3;
//                       });
//                     },
//                     icon: const Icon(
//                       Icons.star_rounded,
//                       color: Colors.grey,
//                       size: 50,
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       setState(() {
//                         rating = 4;
//                       });
//                     },
//                     icon: const Icon(
//                       Icons.star_rounded,
//                       color: Colors.grey,
//                       size: 50,
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       setState(() {
//                         rating = 5;
//                       });
//                     },
//                     icon: const Icon(
//                       Icons.star_rounded,
//                       color: Colors.grey,
//                       size: 50,
//                     ),
//                   ),
//                 ],
//               )
//             : rating == 2
//                 ? Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       IconButton(
//                         onPressed: () {
//                           setState(() {
//                             rating = 1;
//                           });
//                         },
//                         icon: const Icon(
//                           Icons.star_rounded,
//                           color: Colors.red,
//                           size: 50,
//                         ),
//                       ),
//                       IconButton(
//                         onPressed: () {
//                           setState(() {
//                             rating = 2;
//                           });
//                         },
//                         icon: const Icon(
//                           Icons.star_rounded,
//                           color: Colors.red,
//                           size: 50,
//                         ),
//                       ),
//                       IconButton(
//                         onPressed: () {
//                           setState(() {
//                             rating = 3;
//                           });
//                         },
//                         icon: const Icon(
//                           Icons.star_rounded,
//                           color: Colors.grey,
//                           size: 50,
//                         ),
//                       ),
//                       IconButton(
//                         onPressed: () {
//                           setState(() {
//                             rating = 4;
//                           });
//                         },
//                         icon: const Icon(
//                           Icons.star_rounded,
//                           color: Colors.grey,
//                           size: 50,
//                         ),
//                       ),
//                       IconButton(
//                         onPressed: () {
//                           setState(() {
//                             rating = 5;
//                           });
//                         },
//                         icon: const Icon(
//                           Icons.star_rounded,
//                           color: Colors.grey,
//                           size: 50,
//                         ),
//                       ),
//                     ],
//                   )
//                 : rating == 3
//                     ? Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 rating = 1;
//                               });
//                             },
//                             icon: const Icon(
//                               Icons.star_rounded,
//                               color: Colors.red,
//                               size: 50,
//                             ),
//                           ),
//                           IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 rating = 2;
//                               });
//                             },
//                             icon: const Icon(
//                               Icons.star_rounded,
//                               color: Colors.red,
//                               size: 50,
//                             ),
//                           ),
//                           IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 rating = 3;
//                               });
//                             },
//                             icon: const Icon(
//                               Icons.star_rounded,
//                               color: Colors.red,
//                               size: 50,
//                             ),
//                           ),
//                           IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 rating = 4;
//                               });
//                             },
//                             icon: const Icon(
//                               Icons.star_rounded,
//                               color: Colors.grey,
//                               size: 50,
//                             ),
//                           ),
//                           IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 rating = 5;
//                               });
//                             },
//                             icon: const Icon(
//                               Icons.star_rounded,
//                               color: Colors.grey,
//                               size: 50,
//                             ),
//                           ),
//                         ],
//                       )
//                     : rating == 4
//                         ? Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               IconButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     rating = 1;
//                                   });
//                                 },
//                                 icon: const Icon(
//                                   Icons.star_rounded,
//                                   color: Colors.red,
//                                   size: 50,
//                                 ),
//                               ),
//                               IconButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     rating = 2;
//                                   });
//                                 },
//                                 icon: const Icon(
//                                   Icons.star_rounded,
//                                   color: Colors.red,
//                                   size: 50,
//                                 ),
//                               ),
//                               IconButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     rating = 3;
//                                   });
//                                 },
//                                 icon: const Icon(
//                                   Icons.star_rounded,
//                                   color: Colors.red,
//                                   size: 50,
//                                 ),
//                               ),
//                               IconButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     rating = 4;
//                                   });
//                                 },
//                                 icon: const Icon(
//                                   Icons.star_rounded,
//                                   color: Colors.red,
//                                   size: 50,
//                                 ),
//                               ),
//                               IconButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     rating = 5;
//                                   });
//                                 },
//                                 icon: const Icon(
//                                   Icons.star_rounded,
//                                   color: Colors.grey,
//                                   size: 50,
//                                 ),
//                               ),
//                             ],
//                           )
//                         : Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               IconButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     rating = 1;
//                                   });
//                                 },
//                                 icon: const Icon(
//                                   Icons.star_rounded,
//                                   color: Colors.red,
//                                   size: 50,
//                                 ),
//                               ),
//                               IconButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     rating = 2;
//                                   });
//                                 },
//                                 icon: const Icon(
//                                   Icons.star_rounded,
//                                   color: Colors.red,
//                                   size: 50,
//                                 ),
//                               ),
//                               IconButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     rating = 3;
//                                   });
//                                 },
//                                 icon: const Icon(
//                                   Icons.star_rounded,
//                                   color: Colors.red,
//                                   size: 50,
//                                 ),
//                               ),
//                               IconButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     rating = 4;
//                                   });
//                                 },
//                                 icon: const Icon(
//                                   Icons.star_rounded,
//                                   color: Colors.red,
//                                   size: 50,
//                                 ),
//                               ),
//                               IconButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     rating = 5;
//                                   });
//                                 },
//                                 icon: const Icon(
//                                   Icons.star_rounded,
//                                   color: Colors.red,
//                                   size: 50,
//                                 ),
//                               ),
//                             ],
//                           );
//   }
// }
