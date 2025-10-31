import 'package:clothiva_project/common/widgets/appbar/appbar.dart';
import 'package:clothiva_project/features/shop/screens/product_reviews/widgets/rating_progress_indicator.dart';
import 'package:clothiva_project/features/shop/screens/product_reviews/widgets/user_review_card.dart';
import 'package:clothiva_project/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/products/rating/rating_indicator.dart';

class ProductReviewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        title: Text('Reviews & Ratings'),
        showActions: false,
        showSkipButton: false,
        showBackArrow: true,
      ),
      bottomSheet: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Rating and Reviews are verified and are from people who use the same type of device that you use",
              ),
              SizedBox(height: CSizes.spaceBtItems),

              /// Overall Product Ratings
              COverallProductRating(),
              CRatingIndicator(rating: 3.5),
              Text("12,61", style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: CSizes.spaceBtItems),

              /// User Reviews List
              UserReviewCard(),
              UserReviewCard(),
              UserReviewCard(),
              UserReviewCard(),
              UserReviewCard(),
              UserReviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}
