import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_text_styles.dart';
import '../controllers/scm_controller.dart';

class DataDetailView extends GetView<ScmController> {
  const DataDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFD7E3F0),
      child: Stack(
        children: [
          Positioned.fill(
            top: 40.h,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 50.h),
                    SizedBox(
                      width: 160.w,
                      height: 160.w,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 160.w,
                            height: 160.w,
                            child: CircularProgressIndicator(
                              value: 0.7,
                              strokeWidth: 12.w,
                              backgroundColor: Color(0xFFE3F2FD),
                              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                              strokeCap: StrokeCap.round,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '57.00',
                                style: TextStyle(
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF0F1E32),
                                ),
                              ),
                              Text(
                                'kWh/Sqft',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Color(0xFF757575),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 30.h),

                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: Color(0xFFF5F7FA),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 8.w,
                                height: 8.w,
                                decoration: BoxDecoration(
                                  color: Color(0xFFBDBDBD),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                'Today Data',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Color(0xFF757575),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: Color(0xFFF5F7FA),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 8.w,
                                height: 8.w,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                'Custom Date Data',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    // Date Pickers Row
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(color: Color(0xFFE0E0E0)),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    'From Date',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Color(0xFF757575),
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.calendar_today_outlined,
                                    size: 16.w,
                                    color: Color(0xFF757575),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(color: Color(0xFFE0E0E0)),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    'To Date',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Color(0xFF757575),
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.calendar_today_outlined,
                                    size: 16.w,
                                    color: Color(0xFF757575),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(
                              Icons.search,
                              size: 20.w,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Energy Chart Card 1
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: Color(0xFFE5E5E5), width: 1),
                      ),
                      child: Column(
                        children: [
                          // Header
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Energy Chart',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textColor1,
                                ),
                              ),
                              Text(
                                '20.05 kw',
                                style: TextStyle(
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF0F1E32),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 16.h),

                          // Data Cards
                          _buildDataCard('Data A', Color(0xFF2196F3), '2798.50 (29.53%)', '35689 ৳'),
                          SizedBox(height: 12.h),
                          _buildDataCard('Data B', Color(0xFF42C5F5), '72598.50 (35.39%)', '5259689 ৳'),
                          SizedBox(height: 12.h),
                          _buildDataCard('Data C', Color(0xFF9C27B0), '6598.36 (83.90%)', '5698756 ৳'),
                          SizedBox(height: 12.h),
                          _buildDataCard('Data D', Color(0xFFFF9800), '6598.26 (36.59%)', '356987 ৳'),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // Energy Chart Card 2
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: Color(0xFFE5E5E5), width: 1),
                      ),
                      child: Column(
                        children: [
                          // Header
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Energy Chart',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textColor1,
                                ),
                              ),
                              Text(
                                '5.53 kw',
                                style: TextStyle(
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF0F1E32),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 16.h),

                          // Data Cards
                          _buildDataCard('Data A', Color(0xFF2196F3), '2798.50 (29.53%)', '35689 ৳'),
                          SizedBox(height: 12.h),
                          _buildDataCard('Data B', Color(0xFF42C5F5), '72598.50 (35.39%)', '5259689 ৳'),
                          SizedBox(height: 12.h),
                          _buildDataCard('Data C', Color(0xFF9C27B0), '6598.36 (83.90%)', '5698756 ৳'),
                          SizedBox(height: 12.h),
                          _buildDataCard('Data D', Color(0xFFFF9800), '6598.26 (36.59%)', '356987 ৳'),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),

          // View Toggle Buttons - positioned on top center of curved card
          Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                height: 40.h,
                margin: EdgeInsets.symmetric(horizontal: 24.w),
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: AppColors.borderColor2,width: 1)
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 14.w,
                            height: 14.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.primary,  // Border color
                                width: 1,  // Border width
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(2.w),
                              child: Container(
                                width: 10.w,
                                height: 10.w,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Data View',
                            style: h2.copyWith(
                              fontSize: 16.sp,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 14.w,
                            height: 14.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.borderColor2,
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(2.w),
                              child: Container(
                                width: 10.w,
                                height: 10.w,
                                decoration: BoxDecoration(
                                  color: AppColors.borderColor2,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Revenue View',
                            style: h4.copyWith(
                              fontSize: 16.sp,
                              color: AppColors.textColor2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataCard(String label, Color color, String dataValue, String costValue) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Color(0xFFE5E5E5), width: 1),
      ),
      child: Row(
        children: [
          // Color indicator and label
          Row(
            children: [
              Container(
                width: 8.w,
                height: 8.w,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                width: 1,
                height: 40.h,
                color: Color(0xFFE0E0E0),
              ),
              SizedBox(width: 8.w),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textColor1,
                ),
              ),
            ],
          ),

          SizedBox(width: 16.w),

          // Data and Cost
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Data',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.textColor2,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      ':',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.textColor2,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      dataValue,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textColor1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Text(
                      'Cost',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.textColor2,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      ':',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.textColor2,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      costValue,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textColor1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}