import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentos_app/layout/social_app/cubit/cubit.dart';
import 'package:mentos_app/layout/social_app/cubit/states.dart';

import 'componant/component.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {
        if (state is PaymentSuccess) {
          showToast(text: 'Payment successful!', states: ToastStates.SUCCESS);
        } else if (state is PaymentError) {
          showToast(text: '${state.error}', states: ToastStates.ERROR);
        }
      },
      builder: (context, state) {
        final cubit = SocialAppCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: ElevatedButton(
            onPressed: () {
              final paymentIntentSecret = 'get_from_backend_or_test';
              cubit.makePayment(paymentIntentClientSecret: paymentIntentSecret);
            },
            child:
                state is PaymentLoading
                    ? CircularProgressIndicator()
                    : Text('Pay Now'),
          ),
        );
      },
    );
  }
}
