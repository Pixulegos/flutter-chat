import 'package:chat_app/src/widgets/custom_button.dart';
import 'package:chat_app/src/widgets/custom_input.dart';
import 'package:flutter/material.dart';

part 'register_page.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _Logo(title: 'Messenger'),
                _LoginForm(
                  buttonText: 'Ingresar',
                  onPressed: () {
                    
                  },
                  fields: [
                    InputProperties(
                      icon: Icons.mail_outline,
                      type: TextInputType.emailAddress,
                      hintText: 'Email',
                    ),
                    InputProperties(
                      type: TextInputType.visiblePassword, 
                      icon: Icons.lock_outline, 
                      hintText: 'Password',
                      obscure: true,
                    )
                  ],
                ),
                _Labels(
                  route: 'register',
                  title: '¿No tienes cuenta?', subTitle: 'Crea una ahora',
                ),
                Text('Términos y condiciones de unos', style: TextStyle(fontWeight: FontWeight.w200))
              ],
            ),
          ),
        ),
      )
   );
  }
}

class _Labels extends StatelessWidget {
  const _Labels({required this.route, required this.title, required this.subTitle});

  final String route, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Text(title, style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300)),
        GestureDetector(
          onTap: () => Navigator.pushReplacementNamed(context, route),
          child: Text(subTitle, style: TextStyle(color: Colors.blue[600], fontSize: 18, fontWeight: FontWeight.bold))
        )
      ],
    );
  }
}

class _LoginForm extends StatefulWidget {
  final String buttonText;
  final void Function()? onPressed;
  final List<InputProperties> fields;

  const _LoginForm({required this.buttonText, required this.onPressed, required this.fields});

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  List<CustomInput> fields = [];
  List<TextEditingController> controllers = [];

  @override
  void initState() {
    final list = widget.fields;
    controllers = List.generate(list.length, (index) => TextEditingController());

    fields = List.generate(list.length, (index) => 
      CustomInput(
        icon: list[index].icon, 
        hintText: list[index].hintText, 
        type: list[index].type,
        obscure: list[index].obscure,
        textController: controllers[index],
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric( horizontal: 50),
      child: Column(
        children: [
          ...fields,
          CustomButton(
            text: widget.buttonText,
            onPressed: widget.onPressed
          ),
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  final String title;

  const _Logo({required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 50),
        width: 200,
        child: Column(
          spacing: 20,
          children: [
            Image(image: AssetImage('assets/tag-logo.png')),
            Text(title, style: TextStyle(fontSize: 30),)
          ],
        ),
      ),
    );
  }
}

class InputProperties {
  final TextInputType type;
  final String hintText;
  final bool obscure;
  final IconData icon;

  const InputProperties({ 
    this.type = TextInputType.text, 
    required this.icon, 
    required this.hintText, 
    this.obscure = false,
  });
}