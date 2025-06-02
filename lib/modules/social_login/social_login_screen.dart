import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentos_app/componant/component.dart';
import 'package:mentos_app/componant/constant.dart';
import 'package:mentos_app/layout/social_app/cubit/cubit.dart';
import 'package:mentos_app/layout/social_app/social_layout.dart';
import 'package:mentos_app/modules/social_login/cubit/cubit.dart';
import 'package:mentos_app/modules/social_login/cubit/states.dart';
import 'package:mentos_app/modules/social_register/social_register_screen.dart';
import 'package:mentos_app/shared/local/cach_helper.dart';

class SocialLoginScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppLoginCubit, SocialAppLoginStates>(
      listener: (context, state) {
        if (state is SocialAppLoginErrorStates) {
          showToast(text: state.error, states: ToastStates.ERROR);
        } else if (state is SocialAppLoginSuccessStates) {
          CachHelper.saveData(key: 'uid', value: state.id).then((value) {
            id = state.id;
            BlocProvider.of<SocialAppCubit>(
              context,
              listen: false,
            ).getUsersData();
            navigatePushAndRemove(context, widget: SocialAppLayout());
          });
        }
      },
      builder: (context, state) {
        final cubit = SocialAppLoginCubit.get(context);
        return Scaffold(
          body: Container(
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image(
                  image: AssetImage('assets/images/background.jpg'),
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage('assets/images/mentos.png'),
                            fit: BoxFit.cover,
                            height: 250,
                          ),
                          txt(txt: 'LOGIN', size: 35, weight: FontWeight.bold),
                          txt(
                            txt: 'Login Now To Communication With Your Friends',
                            size: 14,
                            weight: FontWeight.normal,
                          ),
                          SizedBox(height: 15),
                          defaultFormField(
                            controller: _emailController,
                            hintText: 'Email Address',
                            radius: 15,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Field must not be empty';
                              } else {
                                return null;
                              }
                            },
                            type: TextInputType.emailAddress,
                            prefixIcon: Icons.email_outlined,
                          ),
                          SizedBox(height: 15),
                          defaultFormField(
                            isPassword: cubit.isPassword,
                            controller: _passwordController,
                            hintText: 'Password',
                            radius: 15,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Field must not be empty';
                              } else {
                                return null;
                              }
                            },
                            type: TextInputType.visiblePassword,
                            prefixIcon: Icons.lock_open_outlined,
                            suffixIcon: cubit.suffix,
                            suffixPressed: () {
                              cubit.changePasswordVisibility();
                            },
                          ),
                          SizedBox(height: 15),
                          SizedBox(
                            width: double.infinity,
                            child: ConditionalBuilder(
                              condition: state is! SocialAppLoginLoadingStates,
                              builder:
                                  (context) => defaultButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        cubit.userLogin(
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                        );
                                      }
                                    },
                                    btnColor: Colors.blue,
                                    child: Text('LOGIN'),
                                  ),
                              fallback:
                                  (context) => Center(
                                    child: CircularProgressIndicator(),
                                  ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              txt(txt: "Don't have any account"),
                              TextButton(
                                onPressed: () {
                                  navigatePush(
                                    context,
                                    widget: SocialRegisterScreen(),
                                  );
                                },
                                child: Text('REGISTER'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
