import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/image/circular_image.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/personalization/controllers/user_controller.dart';
import 'package:ecommerce/features/personalization/screens/profile/wigets/change_name.dart';
import 'package:ecommerce/features/personalization/screens/profile/wigets/profile_meru.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Scaffold(
      appBar: const TAppbar(
        showBackArrow: true,
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(children: [
            // PROFILE PICTURE
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Obx(() {
                    final networkImage = controller.user.value.profilePicture;
                    final image =
                        networkImage.isNotEmpty ? networkImage : TImages.user;
                    return TCircularImage(
                        image: image,
                        width: 80,
                        height: 80,
                        isNetworkImage: networkImage.isNotEmpty);
                  }),
                  TextButton(
                      onPressed: () => controller.uploadUserProfilePicture(),
                      child: const Text('Change Profile Picture'))
                ],
              ),
            ),

            // DETAILS
            const SizedBox(height: TSizes.spaceBtwSections / 2),
            const Divider(),
            const SizedBox(height: TSizes.spaceBtwItems),
            const TSectionHeading(
              title: "Profile Information",
              showActionButton: false,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            TProfileMenu(
              title: "Name",
              value: controller.user.value.fullName,
              onPressed: () => Get.to(() => const ChangeName()),
            ),

            TProfileMenu(
              title: "Username",
              value: controller.user.value.userName,
              onPressed: () {},
            ),

            const SizedBox(height: TSizes.spaceBtwItems),
            const Divider(),
            const SizedBox(height: TSizes.spaceBtwItems),

            TProfileMenu(
              title: "User ID",
              value: controller.user.value.id,
              icon: Iconsax.copy,
              onPressed: () {},
            ),
            TProfileMenu(
              title: "E-mail",
              value: controller.user.value.email,
              onPressed: () {},
            ),
            TProfileMenu(
              title: "Phone number",
              value: controller.user.value.phoneNumber,
              onPressed: () {},
            ),
            TProfileMenu(
              title: "Gender",
              value: "Male",
              onPressed: () {},
            ),
            TProfileMenu(
              title: "Date of Birth",
              value: "20/04/2000",
              onPressed: () {},
            ),

            const Divider(),
            const SizedBox(height: TSizes.spaceBtwItems),

            Center(
              child: TextButton(
                  onPressed: () => controller.deleteAccountWarningPopup(),
                  child: const Text(
                    'Close Account',
                    style: TextStyle(color: Colors.red),
                  )),
            )
          ]),
        ),
      ),
    );
  }
}
