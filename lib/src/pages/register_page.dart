part of 'login_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});


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
                _Logo(title: 'Registro'),
                _LoginForm(
                  buttonText: 'Registrarse',
                  onPressed: () {
                    
                  },
                  fields: [
                    InputProperties(
                      icon: Icons.perm_identity,
                      hintText: 'Name',
                    ),
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
                  route: 'login',
                  title: '¿Ya tienes cuenta?', subTitle: 'Ingresa con tu cuenta ahora',
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