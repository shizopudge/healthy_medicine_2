import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/auth/auth_controller.dart';
import 'package:healthy_medicine_2/core/utils.dart';
import 'package:healthy_medicine_2/models/review_model.dart';
import 'package:healthy_medicine_2/reviews/reviews_repository.dart';
import 'package:routemaster/routemaster.dart';
import 'package:uuid/uuid.dart';

class MyParameter extends Equatable {
  const MyParameter({
    required this.uid,
    required this.doctorId,
  });

  final String uid;
  final String doctorId;

  @override
  List<Object> get props => [uid, doctorId];
}

final getReviewByUserIdProvider = StreamProvider.autoDispose
    .family<ReviewModel, MyParameter>((ref, myParameter) {
  final reviewController = ref.watch(reviewsControllerProvider.notifier);
  return reviewController.getReviewByUserId(
      myParameter.uid, myParameter.doctorId);
});

final reviewsControllerProvider =
    StateNotifierProvider<ReviewsController, bool>((ref) {
  final reviewsRepository = ref.watch(reviewsRepositoryProvider);
  return ReviewsController(
    reviewsRepository: reviewsRepository,
    ref: ref,
  );
});

final getDoctorsReviewsProvider = StreamProvider.family((ref, String doctorId) {
  final reviewController = ref.watch(reviewsControllerProvider.notifier);
  return reviewController.getDoctorsReviews(doctorId);
});

class ReviewsController extends StateNotifier<bool> {
  final ReviewsRepository _reviewsRepository;
  final Ref _ref;
  ReviewsController({
    required ReviewsRepository reviewsRepository,
    required Ref ref,
  })  : _reviewsRepository = reviewsRepository,
        _ref = ref,
        super(false);

  void createReview(BuildContext context, String doctorId, String reviewText,
      int rating) async {
    state = true;
    final user = _ref.read(userProvider)!;
    String reviewId = const Uuid().v1();
    ReviewModel review = ReviewModel(
      userAvatar: user.avatar,
      createdAt: DateTime.now(),
      doctorId: doctorId,
      userFirstName: user.firstName,
      userGender: user.gender,
      id: reviewId,
      userLastName: user.lastName,
      userPatronymic: user.patronymic,
      reviewText: reviewText,
      uid: user.uid,
      rating: rating,
    );
    final res = await _reviewsRepository.createReview(
      review,
      doctorId,
      user.uid,
      rating,
    );
    state = false;
    res.fold((l) => showSnackBar(context, l.message), (r) {
      showSnackBar(context, 'Вы оставили отзыв!');
      Routemaster.of(context).pop();
    });
  }

  void editRating(String doctorId, List<dynamic> rating) async {
    _reviewsRepository.editRating(doctorId, rating);
  }

  // void minusRating(String doctorId, List<dynamic> rating) async {
  //   _reviewsRepository.minusRating(doctorId, rating);
  // }

  Stream<List<ReviewModel>> getDoctorsReviews(String doctorId) {
    return _reviewsRepository.getDoctorsReviews(doctorId);
  }

  Stream<ReviewModel> getReviewByUserId(String uid, String doctorId) {
    return _reviewsRepository.getReviewByUserId(uid, doctorId);
  }
}
