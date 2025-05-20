import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentos_app/componant/component.dart';
import 'package:mentos_app/layout/social_app/cubit/cubit.dart';
import 'package:mentos_app/layout/social_app/cubit/states.dart';
import 'package:mentos_app/layout/social_app/social_app.dart';
import 'package:mentos_app/shared/local/cach_helper.dart';

class SocialRegisterScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  SocialRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {
        if (state is SocialCreateUserSuccessStates) {
          CachHelper.saveData(key: 'uid', value: state.uid).then((value) {
            navigatePushAndRemove(widget: SocialAppLayout(), context);
          });
        }
      },
      builder: (context, state) {
        final cubit = SocialAppCubit.get(context);
        return SafeArea(
          child: Scaffold(
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
                            txt(
                              txt: 'REGISTER',
                              size: 35,
                              weight: FontWeight.bold,
                            ),
                            txt(
                              txt:
                                  'Register Now To Communication With Your Friends',
                              size: 14,
                              weight: FontWeight.normal,
                            ),
                            SizedBox(height: 15),
                            defaultFormField(
                              controller: _nameController,
                              hintText: 'Name',
                              radius: 15,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Field must not be empty';
                                }
                                return null;
                              },
                              type: TextInputType.name,
                              prefixIcon: Icons.person,
                            ),
                            SizedBox(height: 15),
                            defaultFormField(
                              controller: _phoneController,
                              hintText: 'Phone',
                              radius: 15,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Field must not be empty';
                                }
                                return null;
                              },
                              type: TextInputType.phone,
                              prefixIcon: Icons.phone,
                            ),
                            SizedBox(height: 15),
                            defaultFormField(
                              controller: _emailController,
                              hintText: 'Email Address',
                              radius: 15,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Field must not be empty';
                                }
                                return null;
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
                                }
                                return null;
                              },
                              type: TextInputType.visiblePassword,
                              prefixIcon: Icons.lock_open_outlined,
                              suffixIcon: cubit.suffix,
                              suffixPressed: () {
                                cubit.changePasswordVisibility();
                              },
                            ),
                            SizedBox(height: 15),
                            defaultFormField(
                              isPassword: cubit.isPassword,
                              controller: _confirmPasswordController,
                              hintText: 'Confirm Password',
                              radius: 15,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Field must not be empty';
                                } else if (value != _passwordController.text) {
                                  return 'Password does not match';
                                }
                                return null;
                              },
                              type: TextInputType.visiblePassword,
                              prefixIcon: Icons.lock_open_outlined,
                              suffixIcon: cubit.suffix,
                              suffixPressed: () {
                                cubit.changePasswordVisibility();
                              },
                            ),
                            SizedBox(height: 15),
                            ConditionalBuilder(
                              condition:
                                  state is! SocialAppRegisterLoadingStates,
                              builder:
                                  (context) => Container(
                                    height: 40,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadiusDirectional.circular(25),
                                    ),
                                    child: defaultButton(
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          cubit.userRegister(
                                            name: _nameController.text,
                                            phone: _phoneController.text,
                                            email: _emailController.text,
                                            password: _passwordController.text,
                                          );
                                        }
                                      },
                                      child: Text('REGISTER'),
                                    ),
                                  ),
                              fallback:
                                  (context) => Center(
                                    child: CircularProgressIndicator(),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
