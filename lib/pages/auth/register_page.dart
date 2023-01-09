part of '../pages.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final AuthController _auth = AuthController.to;

  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 38),
        children: [
          const SizedBox(height: 60),
          const FlutterLogo(size: 173),
          const SizedBox(height: 40),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Username',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    TextFormField(
                      controller: _auth.nameController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        filled: true,
                        fillColor: Constants.kBackgroundColor,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Username can\'t be empty';
                        }
                        return null;
                      },
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                ),
                const SizedBox(height: 17),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    TextFormField(
                      controller: _auth.emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        filled: true,
                        fillColor: Constants.kBackgroundColor,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email can\'t be empty';
                        } else if (!value.isEmail) {
                          return 'Please input a valid email format';
                        }
                        return null;
                      },
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                ),
                const SizedBox(height: 17),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Password',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    TextFormField(
                      controller: _auth.passwordController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        filled: true,
                        fillColor: Constants.kBackgroundColor,
                        suffixIcon: IconButton(
                          icon: _passwordVisible
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                          iconSize: 24,
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                      obscureText: !_passwordVisible,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password can\'t be empty';
                        }
                        return null;
                      },
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Obx(() {
                      return _auth.valMsg.value.isNotEmpty
                          ? Column(
                              children: [
                                const SizedBox(height: 8),
                                Obx(() {
                                  return Text(
                                    _auth.valMsg.value,
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        ?.copyWith(
                                          color: Colors.red,
                                          fontSize: 12,
                                        ),
                                  );
                                }),
                              ],
                            )
                          : Container();
                    }),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: Constants.kDefaultPadding + 8),
          OutlinedButton(
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
              _auth.register();
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                  vertical: Constants.kDefaultPadding + 4),
              backgroundColor: Constants.kPrimaryColor,
            ),
            child: const Text(
              'Register',
              style: TextStyle(
                fontSize: 18,
                color: Constants.kBackgroundColor,
              ),
            ),
          ),
          const SizedBox(height: Constants.kDefaultPadding + 5),
          OutlinedButton(
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
              _auth.clearFieldController();
              Get.offAndToNamed('/login');
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: Constants.kDefaultPadding + 4,
              ),
              side: const BorderSide(color: Colors.black, width: 1),
            ),
            child: const Text(
              'Login',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
