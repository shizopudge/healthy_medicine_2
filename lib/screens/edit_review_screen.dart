import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:healthy_medicine_2/core/auth/auth_controller.dart';
import 'package:healthy_medicine_2/core/constants.dart';
import 'package:healthy_medicine_2/core/doctors/doctors_controller.dart';
import 'package:healthy_medicine_2/core/reviews/reviews_controller.dart';
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
    reviewController = TextEditingController(
        text: ref
            .read(getReviewByUserIdProvider(
                MyParameter(uid: uid, doctorId: widget.doctorId)))
            .value!
            .reviewText);
    rating = ref
        .read(getReviewByUserIdProvider(
            MyParameter(uid: uid, doctorId: widget.doctorId)))
        .value!
        .rating;
    userRating = ref
        .read(getReviewByUserIdProvider(
            MyParameter(uid: uid, doctorId: widget.doctorId)))
        .value!
        .rating;
    listRating =
        ref.read(getDoctorByIdProvider(widget.doctorId)).value!.rating.toList();
    comments = ref.read(getDoctorByIdProvider(widget.doctorId)).value!.comments;
  }

  late TextEditingController reviewController;
  late int rating;
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
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: rating != userRating || isReviewText
          ? ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Constants.primaryColor,
                minimumSize: const Size(250, 42),
              ),
              onPressed: () {
                listRating.remove(
                    listRating.firstWhere((element) => element == userRating));
                listRating.add(rating);
                editRating();
                createReview(context);
              },
              child: const Text(
                'Отправить отзыв',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            )
          : null,
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: () => Routemaster.of(context).pop(),
          borderRadius: BorderRadius.circular(21),
          child: const Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 24,
            color: Colors.indigo,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Text(
                    'Хотите изменить отзыв?',
                    style: AppTheme.headerTextStyle,
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
                      maxLength: 200,
                      controller: reviewController,
                      style: AppTheme.dedicatedWhiteTextStyle,
                      decoration: InputDecoration(
                        hintText: 'Ваш отзыв',
                        hintStyle: AppTheme.dedicatedWhiteTextStyle,
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
