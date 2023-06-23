import 'dart:io';

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart';
import 'package:gallery_saver/gallery_saver.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  TextEditingController confirmPasswordController =
      TextEditingController(text: "");
  TextEditingController addressController = TextEditingController(text: "");
  bool isObscureText = true;
  bool isObscureTextConfirm = true;
  String? pathToImage;
  XFile? photo;

  validationAndSend(context) {
    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Campos obrigatórios devem ser preenchidos")));
    } else if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Senhas devem coincidir")));
    } else if (!(EmailValidator.validate(emailController.text))) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Email inválido")));
    } else {
      // FAZER REQUISIÇÃO
      // SALVAR USER NA BOX
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 111, 0, 255),
        title: const Text(
          "Cadastro",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                  onTap: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          height: 200,
                          child: ListView(
                            children: [
                              ListTile(
                                onTap: () async {
                                  final ImagePicker picker = ImagePicker();
                                  photo = await picker.pickImage(
                                      source: ImageSource.camera);
                                  if (photo != null) {
                                    String path = (await path_provider
                                            .getApplicationDocumentsDirectory())
                                        .path;
                                    String name = basename(photo!.path);
                                    await photo!.saveTo("$path/$name");
                                    pathToImage = "$path/$name";
                                    await GallerySaver.saveImage(photo!.path);
                                    Navigator.pop(context);
                                    setState(() {});
                                  }
                                },
                                visualDensity:
                                    const VisualDensity(vertical: -3),
                                title: const Text("Tirar foto"),
                              ),
                              const Divider(),
                              ListTile(
                                onTap: () async {
                                  final ImagePicker picker = ImagePicker();
                                  photo = await picker.pickImage(
                                      source: ImageSource.gallery);
                                  Navigator.pop(context);
                                  setState(() {});
                                },
                                visualDensity:
                                    const VisualDensity(vertical: -3),
                                title: const Text("Escolher imagem da galeria"),
                              ),
                              Row(
                                children: [
                                  Expanded(flex: 2, child: Container()),
                                  Expanded(
                                    child: ElevatedButton(
                                      style: const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Color.fromARGB(
                                                      255, 102, 0, 204))),
                                      child: const Text(
                                        'Cancelar',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: SizedBox(
                    height: 80,
                    width: 80,
                    child: photo != null
                        ? Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: FileImage(File(photo!.path)),
                                  fit: BoxFit.fill),
                            ),
                          )
                        : const CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: Icon(Icons.add_a_photo_outlined),
                          ),
                    //Image.file(File(photo!.path))
                  )),
              const SizedBox(
                height: 30,
              ),
              const Row(
                children: [
                  Text("Nome de usuário"),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "*",
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  )
                ],
              ),
              TextField(
                controller: usernameController,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  contentPadding: EdgeInsets.only(top: 15),
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 102, 0, 204))),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 102, 0, 204))),
                  hintText: "Digite seu nome de usuário",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Row(
                children: [
                  Text("Email"),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "*",
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  )
                ],
              ),
              TextField(
                controller: emailController,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  contentPadding: EdgeInsets.only(top: 15),
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 102, 0, 204))),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 102, 0, 204))),
                  hintText: "Digite seu melhor email",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Row(
                children: [
                  Text("Senha"),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "*",
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  )
                ],
              ),
              TextField(
                controller: passwordController,
                obscureText: isObscureText,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  contentPadding: const EdgeInsets.only(top: 15),
                  enabledBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 102, 0, 204))),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 102, 0, 204))),
                  hintText: "Digite sua senha",
                  hintStyle: const TextStyle(color: Colors.grey),
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        isObscureText = !isObscureText;
                      });
                    },
                    child: Icon(
                      isObscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Row(
                children: [
                  Text("Confirmação de senha"),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "*",
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  )
                ],
              ),
              TextField(
                controller: confirmPasswordController,
                obscureText: isObscureTextConfirm,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  contentPadding: const EdgeInsets.only(top: 15),
                  enabledBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 102, 0, 204))),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 102, 0, 204))),
                  hintText: "Digite novamente sua senha",
                  hintStyle: const TextStyle(color: Colors.grey),
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        isObscureTextConfirm = !isObscureTextConfirm;
                      });
                    },
                    child: Icon(
                      isObscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text("Endereço"),
              TextField(
                controller: addressController,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.home),
                  contentPadding: EdgeInsets.only(top: 15),
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 102, 0, 204))),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 102, 0, 204))),
                  hintText: "Digite sua rua e número",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      validationAndSend(context);
                    },
                    child: const Text("Finalizar"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
