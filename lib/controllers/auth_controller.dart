part of 'controllers.dart';

class AuthController extends GetxController {
  final store = GetStorage();
  static AuthController to = Get.find();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  late Rx<User?> firebaseUser;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var token = ''.obs;
  var valMsg = ''.obs;

  @override
  void onInit() {
    ///Called immediately after the widget is allocated in memory. You
    ///might use this to initialize something for the controller.
    super.onInit();
    // token.value = await store.read('token') ?? '';

    firebaseUser = Rx<User?>(firebaseAuth.currentUser);

    firebaseUser.bindStream(firebaseAuth.userChanges());
  }

  void register() async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      firebaseUser = firebaseAuth.currentUser.obs;

      Get.offAllNamed('/home');
      clearFieldController();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        valMsg.value = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        valMsg.value = 'The account already exists for that email.';
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error on login',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }

  void login() async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      firebaseUser = firebaseAuth.currentUser.obs;

      Get.offAllNamed('/home');
      clearFieldController();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        valMsg.value = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        valMsg.value = 'Wrong password provided for that user.';
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error on login',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }

  void signout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAllNamed('/login');
    } on FirebaseAuthException catch (e) {
      e.printError();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error on login',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }

  void performGoogleSignIn() async {
    try {
      final googleSignInAccount = await GoogleSignIn().signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential userCredential =
            await firebaseAuth.signInWithCredential(credential);
        firebaseUser = userCredential.user.obs;
      }

      Get.offAllNamed('/home');
      clearFieldController();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        valMsg.value = 'Account exists with different credential';
      } else if (e.code == 'invalid-credential') {
        valMsg.value = 'Invalid Credential';
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error on googleLogin',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }

  // Sign out
  void clearFieldController() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();

    valMsg.value = '';
  }
}
