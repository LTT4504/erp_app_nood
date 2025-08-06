import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_manager/shared/shared.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: ColorConstants.highlightPrimary,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
      child: SafeArea(
        bottom: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 4)
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo_circle.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'good_morning'.tr,
                        style: const TextStyle(fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Icon(Icons.notifications, color: Colors.white, size: 26),
            const SizedBox(width: 12),
            ClipOval(
              child: Image.asset(
                'assets/images/avatar_default.png',
                width: 36,
                height: 36,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
