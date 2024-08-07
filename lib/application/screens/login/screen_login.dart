import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_admin_app/application/screens/home/screen_home.dart';
import 'package:super_admin_app/application/screens/login/bloc/bloc/login_bloc.dart';
import 'package:super_admin_app/application/utils/colors.dart';
import 'package:super_admin_app/application/utils/height_width.dart';
import 'package:super_admin_app/application/utils/routs.dart';
import 'package:super_admin_app/application/utils/snakbar_sowdiolag.dart';
import 'package:super_admin_app/application/utils/validation.dart';
import 'package:super_admin_app/application/widgets/login_signup_button.dart';
import 'package:super_admin_app/application/widgets/login_signup_text.dart';
import 'package:super_admin_app/application/widgets/login_text_formfield.dart';

class ScreenLogIn extends StatelessWidget {
  const ScreenLogIn({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController idController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder( 
        builder: (context, constraints) {
          bool isWideScreen = constraints.maxWidth > 600;
          
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isWideScreen ? 100 : 15,  
            ),
            child: SingleChildScrollView( 
              child: Form(
                key: formKey, 
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   const LoginSignUpHedingWidget(
                      title: 'Tenant Login',
                      text: 'Login to get started',
                    ),
                    isWideScreen? kHeight40 : kHeight20 ,
                    Text(
                      'Tenant ID',
                      style: TextStyle(
                        color: kClrGrey,
                        fontSize: isWideScreen ? 20 : 16, 
                      ),
                    ),
                    BuildTextFormField(
                      hintTxt: 'Enter your ID',
                      prfixIcon: Icons.email_outlined,
                      controller: idController,
                     validator: (value) =>Validatior.tenantIDValidate(value),
                    ),
                    isWideScreen? kHeight40 : kHeight20,
                    Text(
                      'Password',
                      style: TextStyle(
                        color: kClrGrey,
                        fontSize: isWideScreen ? 20 : 16,
                      ),
                    ),
                    BuildTextFormField(
                      obscureTxt: true,
                      hintTxt: 'Enter Password',
                      prfixIcon: Icons.lock_outlined,
                      controller: passwordController,
                      validator: (value) {
                        return Validatior.validatePassword(value);
                      },
                    ),
                    isWideScreen? kHeight80 :kHeight60 ,

                    BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginSucessState) {
                      kHideLoadingSnackbar(context); 
                      kNavigationPushReplacement(context, const ScreenHome());
                    }
                    if (state is LoginLoadingState) {
                      kLodingSnackbar(context); 
                    }
                    if (state is LoginErrorState) {
                      kSnakBar(context, "Email or password does not match", kClrRed);
                    }
                  },
                  builder: (context, state) {
                    return LoginSignUpButtonWidget(
                      text: 'Login',
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                           context.read<LoginBloc>().add(TenantLoginEvent(tenantID: idController.text, password: passwordController.text));
                        }
                      },
                    );
                  },
                ),
                  ],
                ),
              ),
            ),
          ); 
        },
      ),
    );
  }
}
