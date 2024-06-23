import 'dart:developer';

import 'package:ecommerce_app/application/utility/app_colors.dart';
import 'package:ecommerce_app/presentation/state_holders/create_review_screen_controller.dart';
import 'package:ecommerce_app/presentation/state_holders/product_review_screen_controller.dart';
import 'package:ecommerce_app/presentation/ui/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class CreateReviewScreen extends StatefulWidget {
  final int productId;

  const CreateReviewScreen({super.key, required this.productId});

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  final TextEditingController _reviewTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  double _rating = 4.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(title: 'Create Review', elevation: 1),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "What is your rate?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Rating : ${_rating.toString()}",
                    style: const TextStyle(
                      fontSize: 15,
                      letterSpacing: .5,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  RatingBar.builder(
                    initialRating: 4.5,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: AppColors.startColor,
                    ),
                    onRatingUpdate: (rating) {
                      log(rating.toString());
                      _rating = rating;
                      setState(() {});
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    '''Please Share Your opinion
        about this product''',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _reviewTEController,
                    maxLines: 8,
                    decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      contentPadding: EdgeInsets.all(10),
                      hintText: 'Write Review',
                      labelText: 'Write Review',
                    ),
                    validator: (String? text) {
                      if (text?.isEmpty ?? true) {
                        return 'Please write your review';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: GetBuilder<CreateReviewScreenController>(
                        builder: (createReviewScreenController) {
                      if (createReviewScreenController.createReviewInProgress) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            createReviewScreenController
                                .createReview(_reviewTEController.text.trim(),
                                    widget.productId, _rating)
                                .then((result) {
                              if (result) {
                                Get.snackbar(
                                    'Success', 'Add review successful.',
                                    backgroundColor: AppColors.greenColor,
                                    borderRadius: 10,
                                    snackPosition: SnackPosition.BOTTOM);
                                Get.find<ProductReviewScreenController>()
                                    .getProductReviews(widget.productId);
                                Navigator.pop(context);
                              } else {
                                Get.snackbar(
                                    'Failed', 'Add review failed! Try again.',
                                    backgroundColor: AppColors.alertColor,
                                    borderRadius: 10,
                                    snackPosition: SnackPosition.BOTTOM);
                              }
                            });
                          }
                        },
                        child: const Text('Submit'),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
