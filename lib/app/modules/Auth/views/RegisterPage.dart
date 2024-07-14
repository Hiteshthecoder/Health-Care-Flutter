import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/shared/views/layouts/MasterLayout.dart';
import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';


import '../controllers/RegisterController.dart';

class RegisterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final RegisterController controller = Get.put(RegisterController());

    return MasterLayout(
      title: "",
      leading: GestureDetector(
          onTap: (){
            Get.toNamed("/login");
          },

          child: Icon(Icons.arrow_back)),
      backgroundColor: kcWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            color: Colors.transparent,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50),
                    Text("Having trouble signing in?",
                      style: TextStyl.body?.copyWith(color: kcBlack.withOpacity(0.7),fontWeight: FontWeight.bold),),
                    SizedBox(height: 5),
                    Text("Let us know the rouble you are facing and our team will reach out to get this resolved,",
                        style: TextStyl.bodySm!.copyWith(color: kcBlack.withOpacity(0.7))),
                  ],
                ),
                SizedBox(height: 50,),
                Form(
                  key: controller.formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      FormInput.text(
                        controller: controller.nameInput,
                        placeholder: "Full Name",
                        leading: Icon(Icons.person_outline),
                        validator: (value) => Validator("Full Name", value!).required().max(30).validate(),
                      ),
                      SizedBox(height: 25),
                      FormInput.number(
                        controller: controller.phoneInput,
                        placeholder: "Mobile Number",
                        leading: Icon(Icons.call_rounded),
                        validator: (value) => Validator("Mobile Number", value!).between(10, 12).required().validate(),
                      ),
                      SizedBox(height: 25),
                      FormInput.multiline(
                        controller: controller.messageInput,
                        placeholder: "Write your message here",
                      ),
                      SizedBox(height: 30),

                      Button.block(
                        key: UniqueKey(),
                        label: "Submit",
                        onTap: (btn) async {
                          btn.setBusy(true).setDisabled(true);
                           controller.submitRegistration();
                          btn.setBusy(false).setDisabled(false);
                        },
                      ),
                      SizedBox(height: 35),
                      GestureDetector(
                        onTap: () => Get.offNamed("/login"),
                        child: Text.rich(
                          TextSpan(
                            text: "Already have an account?",
                            style: TextStyl.button?.copyWith(color: kcBlack.withOpacity(0.5)),
                            children: [
                              TextSpan(
                                text: " Login",
                                style: TextStyl.button?.copyWith(color: Theme.of(context).primaryColor),
                              ),
                            ],
                          ),
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
    );
  }
}
