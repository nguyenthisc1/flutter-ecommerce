import 'package:ecommerce/features/authentication/controllers/signup/signup_controller.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/text_strings.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:ecommerce/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TSignupForm extends StatelessWidget {
  const TSignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(SignupController());
    return Form(
        key: controller.signupFormKey,
        child: Column(
          children: [
            Row(
              children: [
                // FIRST NAME
                Expanded(
                    child: TextFormField(
                  controller: controller.fistName,
                  validator: (value) =>
                      TValidator.validateEmptyText('First name', value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: TTexts.firstName,
                      prefixIcon: Icon(Iconsax.user)),
                )),
                const SizedBox(width: TSizes.spaceBtwInputFields),

                // LAST NAME
                Expanded(
                    child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) =>
                      TValidator.validateEmptyText('Last name', value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: TTexts.lastName,
                      prefixIcon: Icon(Iconsax.user)),
                )),
              ],
            ),

            const SizedBox(height: TSizes.spaceBtwInputFields),

            // USER NAME
            TextFormField(
              controller: controller.userName,
              validator: (value) =>
                  TValidator.validateEmptyText('Username', value),
              expands: false,
              decoration: const InputDecoration(
                  labelText: TTexts.username,
                  prefixIcon: Icon(Iconsax.user_edit)),
            ),

            const SizedBox(height: TSizes.spaceBtwInputFields),

            // EMAIL
            TextFormField(
              controller: controller.email,
              validator: (value) => TValidator.validateEmail(value),
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: TTexts.email),
            ),

            const SizedBox(height: TSizes.spaceBtwInputFields),

            // PHONE
            TextFormField(
              controller: controller.phoneNumber,
              validator: (value) => TValidator.validatePhoneNumber(value),
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.call), labelText: TTexts.phoneNo),
            ),

            const SizedBox(height: TSizes.spaceBtwInputFields),

            // PASSWORD
            Obx(() => TextFormField(
                  controller: controller.password,
                  validator: (value) => TValidator.validatePassword(value),
                  obscureText: controller.hidePassword.value,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Iconsax.password_check),
                      suffixIcon: IconButton(
                          onPressed: () => controller.hidePassword.value =
                              !controller.hidePassword.value,
                          icon: Icon(controller.hidePassword.value
                              ? Iconsax.eye_slash
                              : Iconsax.eye)),
                      labelText: TTexts.password),
                )),

            const SizedBox(height: TSizes.spaceBtwSections),

            // TERM&CONDITIONS
            Row(
              children: [
                SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(value: true, onChanged: (value) {})),
                const SizedBox(width: TSizes.spaceBtwInputFields),
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: '${TTexts.iAgreeTo} ',
                      style: Theme.of(context).textTheme.bodySmall),
                  TextSpan(
                      text: '${TTexts.privacyPolicy} ',
                      style: Theme.of(context).textTheme.bodyMedium?.apply(
                          color: dark ? TColors.white : TColors.primary,
                          decoration: TextDecoration.underline,
                          decorationColor:
                              dark ? TColors.white : TColors.primary)),
                  TextSpan(
                      text: '${TTexts.and} ',
                      style: Theme.of(context).textTheme.bodySmall),
                  TextSpan(
                      text: '${TTexts.termsOfUse} ',
                      style: Theme.of(context).textTheme.bodyMedium?.apply(
                          color: dark ? TColors.white : TColors.primary,
                          decoration: TextDecoration.underline,
                          decorationColor:
                              dark ? TColors.white : TColors.primary)),
                ]))
              ],
            ),

            const SizedBox(height: TSizes.spaceBtwSections),

            // SIGN UP BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.signup(),
                  child: const Text(
                    TTexts.createAccount,
                    style: TextStyle(),
                  )),
            ),
          ],
        ));
  }
}
