import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/image/circular_image.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/personalization/screens/profile/wigets/profile_meru.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  const TCircularImage(
                    image: TImages.user,
                    width: 80,
                    height: 80,
                  ),
                  TextButton(
                      onPressed: () {},
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
              value: "Thi Nguyn",
              onPressed: () {},
            ),

            TProfileMenu(
              title: "Username",
              value: "Thi Nguyn",
              onPressed: () {},
            ),

            const SizedBox(height: TSizes.spaceBtwItems),
            const Divider(),
            const SizedBox(height: TSizes.spaceBtwItems),

            TProfileMenu(
              title: "User ID",
              value: "123456",
              icon: Iconsax.copy,
              onPressed: () {},
            ),
            TProfileMenu(
              title: "E-mail",
              value: "nguyenthisc1@gmail.com",
              onPressed: () {},
            ),
            TProfileMenu(
              title: "Phone number",
              value: "+841237860",
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
                  onPressed: () {},
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
