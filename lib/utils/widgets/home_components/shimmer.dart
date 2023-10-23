import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,

            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) => Container(
                height: 100.0,
                color: Colors.black,
                // Placeholder widget to show shimmer effect
              ),
              separatorBuilder: (context, index) => SizedBox(width: 10.w),
              itemCount: 4, // Number of shimmer placeholders
            ),
          ),
        ),
      ],
    );
  }
}
