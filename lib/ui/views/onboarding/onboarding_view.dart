import 'package:flutter/material.dart';
import 'package:kaykommerce/ui/widgets/kayko_button.dart';

import 'onboarding_view_model.dart';
import 'package:stacked/stacked.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OnboardingViewModel>.reactive(
      builder: (context, viewModel, child) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 35.0),
          child: Center(
            child: viewModel.isBusy
                ? CircularProgressIndicator()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      KaykoButton(
                        title: 'Continue',
                        onTap: viewModel.login,
                      ),
                    ],
                  ),
          ),
        ),
      ),
      viewModelBuilder: () => OnboardingViewModel(),
    );
  }
}
