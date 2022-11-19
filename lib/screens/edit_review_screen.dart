import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/auth/auth_controller.dart';
import 'package:healthy_medicine_2/core/constants.dart';
import 'package:healthy_medicine_2/doctors/doctors_controller.dart';
import 'package:healthy_medicine_2/reviews/reviews_controller.dart';
import 'package:routemaster/routemaster.dart';

class EditReviewScreen extends ConsumerStatefulWidget {
  final String doctorId;
  const EditReviewScreen({
    super.key,
    required this.doctorId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddReviewScreenState();
}

class _AddReviewScreenState extends ConsumerState<EditReviewScreen> {
  late List<dynamic> listRating;
  late List<String> comments;
  late String uid;
  late int userRating;
  @override
  void initState() {
    super.initState();
    uid = ref.read(userProvider)!.uid;
    userRating = ref
        .read(getReviewByUserIdProvider(
            MyParameter(uid: uid, doctorId: widget.doctorId)))
        .value!
        .rating;
    listRating =
        ref.read(getDoctorByIdProvider(widget.doctorId)).value!.rating.toList();
    print(listRating);
    comments = ref.read(getDoctorByIdProvider(widget.doctorId)).value!.comments;
  }

  TextEditingController reviewController = TextEditingController();
  int rating = 0;
  bool isReviewText = false;
  void createReview(
    BuildContext context,
  ) {
    ref.read(reviewsControllerProvider.notifier).createReview(
          context,
          widget.doctorId,
          reviewController.text.trim(),
          rating,
        );
  }

  void editRating() {
    ref
        .read(reviewsControllerProvider.notifier)
        .editRating(widget.doctorId, listRating);
  }

  @override
  Widget build(BuildContext context) {
    // final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      backgroundColor: Constants.bg,
      appBar: AppBar(
        backgroundColor: Constants.bg,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Routemaster.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Constants.textColor,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: rating != 0 && isReviewText
          ? ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Constants.primaryColor,
                minimumSize: const Size(250, 42),
              ),
              onPressed: () {
                print(listRating);
                listRating.remove(
                    listRating.firstWhere((element) => element == userRating));
                print(listRating);
                listRating = listRating + [rating];
                print(listRating);
                editRating();
                createReview(context);
                //ЗАЩИТА ЧТОБЫ НЕЛЬЗЯ БЫЛО 1 ЧЕЛУ ДОБАВЛЯТЬ БЕСКОНЕЧНОСТЬ ОТЗЫВОВ
              },
              child: const Text(
                'Отправить отзыв',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            )
          : null,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 25),
                  child: Text(
                    'Хотите оставить отзыв?',
                    style: TextStyle(
                      color: Constants.textColor,
                      fontSize: 36,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(21),
                      color: Colors.grey.shade400,
                    ),
                    child: TextFormField(
                      maxLines: 15,
                      maxLength: 250,
                      controller: reviewController,
                      decoration: const InputDecoration(
                        hintText: 'Ваш отзыв',
                        hintStyle: TextStyle(fontSize: 20, color: Colors.white),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        setState(() {
                          isReviewText = true;
                        });
                      },
                    ),
                  ),
                ),
                rating == 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                rating = 1;
                              });
                            },
                            icon: const Icon(
                              Icons.star_rounded,
                              color: Colors.grey,
                              size: 50,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                rating = 2;
                              });
                            },
                            icon: const Icon(
                              Icons.star_rounded,
                              color: Colors.grey,
                              size: 50,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                rating = 3;
                              });
                            },
                            icon: const Icon(
                              Icons.star_rounded,
                              color: Colors.grey,
                              size: 50,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                rating = 4;
                              });
                            },
                            icon: const Icon(
                              Icons.star_rounded,
                              color: Colors.grey,
                              size: 50,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                rating = 5;
                              });
                            },
                            icon: const Icon(
                              Icons.star_rounded,
                              color: Colors.grey,
                              size: 50,
                            ),
                          ),
                        ],
                      )
                    : rating == 1
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    rating = 1;
                                  });
                                },
                                icon: const Icon(
                                  Icons.star_rounded,
                                  color: Colors.red,
                                  size: 50,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    rating = 2;
                                  });
                                },
                                icon: const Icon(
                                  Icons.star_rounded,
                                  color: Colors.grey,
                                  size: 50,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    rating = 3;
                                  });
                                },
                                icon: const Icon(
                                  Icons.star_rounded,
                                  color: Colors.grey,
                                  size: 50,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    rating = 4;
                                  });
                                },
                                icon: const Icon(
                                  Icons.star_rounded,
                                  color: Colors.grey,
                                  size: 50,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    rating = 5;
                                  });
                                },
                                icon: const Icon(
                                  Icons.star_rounded,
                                  color: Colors.grey,
                                  size: 50,
                                ),
                              ),
                            ],
                          )
                        : rating == 2
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        rating = 1;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.star_rounded,
                                      color: Colors.red,
                                      size: 50,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        rating = 2;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.star_rounded,
                                      color: Colors.red,
                                      size: 50,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        rating = 3;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.star_rounded,
                                      color: Colors.grey,
                                      size: 50,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        rating = 4;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.star_rounded,
                                      color: Colors.grey,
                                      size: 50,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        rating = 5;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.star_rounded,
                                      color: Colors.grey,
                                      size: 50,
                                    ),
                                  ),
                                ],
                              )
                            : rating == 3
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            rating = 1;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.star_rounded,
                                          color: Colors.red,
                                          size: 50,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            rating = 2;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.star_rounded,
                                          color: Colors.red,
                                          size: 50,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            rating = 3;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.star_rounded,
                                          color: Colors.red,
                                          size: 50,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            rating = 4;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.star_rounded,
                                          color: Colors.grey,
                                          size: 50,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            rating = 5;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.star_rounded,
                                          color: Colors.grey,
                                          size: 50,
                                        ),
                                      ),
                                    ],
                                  )
                                : rating == 4
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                rating = 1;
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.star_rounded,
                                              color: Colors.red,
                                              size: 50,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                rating = 2;
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.star_rounded,
                                              color: Colors.red,
                                              size: 50,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                rating = 3;
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.star_rounded,
                                              color: Colors.red,
                                              size: 50,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                rating = 4;
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.star_rounded,
                                              color: Colors.red,
                                              size: 50,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                rating = 5;
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.star_rounded,
                                              color: Colors.grey,
                                              size: 50,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                rating = 1;
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.star_rounded,
                                              color: Colors.red,
                                              size: 50,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                rating = 2;
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.star_rounded,
                                              color: Colors.red,
                                              size: 50,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                rating = 3;
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.star_rounded,
                                              color: Colors.red,
                                              size: 50,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                rating = 4;
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.star_rounded,
                                              color: Colors.red,
                                              size: 50,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                rating = 5;
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.star_rounded,
                                              color: Colors.red,
                                              size: 50,
                                            ),
                                          ),
                                        ],
                                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
