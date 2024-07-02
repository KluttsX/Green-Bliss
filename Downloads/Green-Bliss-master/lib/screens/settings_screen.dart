import 'package:Bliss/screens/changepassword.dart';
import 'package:Bliss/screens/navigation.dart';
import 'package:Bliss/screens/settings_webview.dart';
import 'package:Bliss/widgets/settings_items.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:open_apps_settings/open_apps_settings.dart';
import 'package:open_apps_settings/settings_enum.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    String? userEmail = FirebaseAuth.instance.currentUser?.email;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Iconsax.arrow_left,
          ),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        elevation: 3,
        title: const Text(
          'Ajustes',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Cuenta",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(50),
                              ),
                            ),
                            child: const Icon(
                              Iconsax.user,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Gmail',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                FirebaseAuth.instance.currentUser != null
                                    ? userEmail!
                                    : "Usuario no registrado",
                                softWrap: true,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Opciones",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SettingItem(
                      title: "Notificaciónes",
                      icon: Iconsax.notification,
                      bgColor: const Color.fromARGB(255, 42, 166, 238),
                      iconColor: Colors.white,
                      onTap: () {
                        OpenAppsSettings.openAppsSettings(
                          settingsCode: SettingsCode.NOTIFICATION,
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    SettingItem(
                      title: "Política de privacidad",
                      icon: Iconsax.security,
                      bgColor: Colors.orange,
                      iconColor: Colors.white,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const SettingsWebView(
                              title: 'Política de privacidad',
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    SettingItem(
                      title: "Términos y condiciones",
                      icon: Iconsax.book,
                      bgColor: const Color.fromARGB(255, 37, 167, 104),
                      iconColor: Colors.white,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const SettingsWebView(
                              title: 'Términos y condiciones',
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    SettingItem(
                      title: "Permisos",
                      icon: Iconsax.lock,
                      bgColor: Colors.brown.shade600,
                      iconColor: Colors.white,
                      onTap: () {
                        OpenAppsSettings.openAppsSettings(
                          settingsCode: SettingsCode.APP_SETTINGS,
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    FirebaseAuth.instance.currentUser != null
                        ? SettingItem(
                            title: "Cambiar contraseña",
                            icon: Iconsax.password_check,
                            bgColor: Colors.deepPurple.shade400,
                            iconColor: Colors.white,
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const ChangePasswordPage(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    var begin = const Offset(0.0, 1.0);
                                    var end = Offset.zero;
                                    var curve = Curves.ease;

                                    var tween = Tween(begin: begin, end: end)
                                        .chain(CurveTween(curve: curve));

                                    return SlideTransition(
                                      position: animation.drive(tween),
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },
                          )
                        : const SizedBox(height: 0),
                    const SizedBox(height: 20),
                    FirebaseAuth.instance.currentUser != null
                        ? SettingItem(
                            title: "Borrar cuenta",
                            icon: Iconsax.profile_delete,
                            bgColor: Colors.red.shade400,
                            iconColor: Colors.white,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.white,
                                    icon: const Icon(
                                      Iconsax.trash,
                                      size: 35,
                                    ),
                                    title: const Text('Borrar cuenta'),
                                    content: const Text(
                                      'Eliminar cuenta. Esta accián es irreversible y todos tus datos asociados a la aplicacion serán perdidos. El proceso toma 24 horas.',
                                      textAlign: TextAlign.center,
                                    ),
                                    actions: [
                                      MaterialButton(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Cancelar'),
                                      ),
                                      MaterialButton(
                                        color: Colors.redAccent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        onPressed: () {
                                          FirebaseAuth.instance.currentUser
                                              ?.delete();
                                          FirebaseAuth.instance.signOut();
                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                      secondaryAnimation) =>
                                                  const NavigationPage(),
                                              transitionsBuilder: (context,
                                                  animation,
                                                  secondaryAnimation,
                                                  child) {
                                                var begin =
                                                    const Offset(0.0, 1.0);
                                                var end = Offset.zero;
                                                var curve = Curves.ease;

                                                var tween = Tween(
                                                        begin: begin, end: end)
                                                    .chain(CurveTween(
                                                        curve: curve));

                                                return SlideTransition(
                                                  position:
                                                      animation.drive(tween),
                                                  child: child,
                                                );
                                              },
                                            ),
                                          );
                                        },
                                        child: const Text('Aceptar'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          )
                        : const SizedBox(height: 0),
                  ],
                ),
              ),
            ),
          ),
          const Divider(),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: const Center(
              child: Text(
                'Version: 1.0.9',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
