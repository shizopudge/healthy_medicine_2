import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:healthy_medicine_2/core/failure.dart';
import 'package:healthy_medicine_2/core/firebase_constants.dart';
import 'package:healthy_medicine_2/core/providers/firebase_providers.dart';
import 'package:healthy_medicine_2/core/type_defs.dart';
import 'package:healthy_medicine_2/core/models/review_model.dart';

final reviewsRepositoryProvider = Provider((ref) {
  return ReviewsRepository(firestore: ref.watch(firestoreProvider));
});

class ReviewsRepository {
  final FirebaseFirestore _firestore;
  ReviewsRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _doctors =>
      _firestore.collection(FirebaseConstants.doctorsCollection);

  final String reviews = FirebaseConstants.reviewsCollection;

  FutureVoid createReview(
    ReviewModel review,
    String doctorId,
    String uid,
    int rating,
  ) async {
    try {
      _doctors.doc(doctorId).update({
        'comments': FieldValue.arrayUnion([uid]),
      });

      return right(_doctors
          .doc(doctorId)
          .collection(reviews)
          .doc(uid)
          .set(review.toMap()));
    } on FirebaseException catch (e) {
      return left(Failure(e.message!));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  void editRating(String doctorId, List<dynamic> rating) async {
    _doctors.doc(doctorId).update({
      'rating': rating,
    });
  }

  // void minusRating(String doctorId, List<dynamic> rating) async {
  //   _doctors.doc(doctorId).update({
  //     'rating': rating,
  //   });
  // }

  Stream<List<ReviewModel>> getDoctorsReviews(String doctorId) {
    return _doctors
        .doc(doctorId)
        .collection(reviews)
        .orderBy(
          'createdAt',
          descending: true,
        )
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => ReviewModel.fromMap(
                  e.data(),
                ),
              )
              .toList(),
        );
  }

  Stream<ReviewModel> getReviewByUserId(String uid, String doctorId) {
    return _doctors.doc(doctorId).collection(reviews).doc(uid).snapshots().map(
        (event) => ReviewModel.fromMap(event.data() as Map<String, dynamic>));
  }
}
