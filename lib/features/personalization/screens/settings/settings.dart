import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:ecommerce/common/widgets/list_tile/setting_menu_tile.dart';
import 'package:ecommerce/common/widgets/list_tile/user_profile_tile.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/personalization/screens/address/address.dart';
import 'package:ecommerce/features/personalization/screens/profile/profile.dart';
import 'package:ecommerce/features/shop/screens/checkout/checkout.dart';
import 'package:ecommerce/features/shop/screens/order/order.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          // HEADER
          TPrimaryHeaderContainer(
              child: Column(
            children: [
              // APPBAR
              TAppbar(
                  title: Text(
                'Account',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .apply(color: TColors.white),
              )),

              // USER PROFILE CARD
              TUserProfileTile(
                  onPressed: () => Get.to(() => const ProfileScreen())),

              const SizedBox(height: TSizes.spaceBtwSections),
            ],
          )),

          // BODY
          Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                // ACCOUNT SETTINGS
                const TSectionHeading(
                  title: 'Account Settings',
                  showActionButton: false,
                ),
                const SizedBox(height: TSizes.spaceBtwItems),

                TSettingMenuTile(
                  icon: Iconsax.safe_home,
                  title: "My Address",
                  subTitle: "Set shopping delivery address",
                  onTap: () => Get.to(() => const UserAddressScreen()),
                ),
                TSettingMenuTile(
                  icon: Iconsax.shopping_cart,
                  title: "My Cart",
                  subTitle: "Add, remove products and move to checkout",
                  onTap: () => Get.to(() => const CheckoutScreen()),
                ),
                TSettingMenuTile(
                  icon: Iconsax.bag_tick,
                  title: "My Orders",
                  subTitle: "In-progress and Completed Orders",
                  onTap: () => Get.to(() => const OrderScreen()),
                ),
                const TSettingMenuTile(
                  icon: Iconsax.bank,
                  title: "Bank Account",
                  subTitle: "Withdraw balance to registered bank account",
                ),
                const TSettingMenuTile(
                  icon: Iconsax.discount_shape,
                  title: "My Coupons",
                  subTitle: "List of all the discounted coupons",
                ),
                const TSettingMenuTile(
                  icon: Iconsax.notification,
                  title: "Notifications",
                  subTitle: "Set any kind of notification message",
                ),
                const TSettingMenuTile(
                  icon: Iconsax.security_card,
                  title: "Account privacy",
                  subTitle: "Manage data usage and connected accounts",
                ),

                // APP SETTINGS
                const SizedBox(height: TSizes.spaceBtwSections),
                const TSectionHeading(
                  title: "App settings",
                  showActionButton: false,
                ),
                const SizedBox(height: TSizes.spaceBtwItems),

                const TSettingMenuTile(
                    icon: Iconsax.document_upload,
                    title: 'Load Data',
                    subTitle: 'Upload data to your Cloud Firebase'),

                TSettingMenuTile(
                  icon: Iconsax.location,
                  title: 'Geolocation',
                  subTitle: 'Set recommendation based on location',
                  trailing: Switch(value: true, onChanged: (value) {}),
                ),

                TSettingMenuTile(
                    icon: Iconsax.security_user,
                    title: 'Safe Mode',
                    subTitle: 'Search result is safe for all ages',
                    trailing: Switch(value: false, onChanged: (value) {})),

                TSettingMenuTile(
                    icon: Iconsax.image,
                    title: 'HD Image Quality',
                    subTitle: 'Set image quality to be seen',
                    trailing: Switch(value: false, onChanged: (value) {})),

                // LOGOUT BUTTON
                const SizedBox(height: TSizes.spaceBtwSections),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Logout'),
                  ),
                ),

                const SizedBox(height: TSizes.spaceBtwSections * 2.5),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
