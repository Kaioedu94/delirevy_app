import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../components/my_text_field.dart';
import '../blocs/sign_up_bloc/sign_up_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final addressController = TextEditingController();

  // Usando controladores de texto mascarado para telefone e data de nascimento
  final phoneController = MaskedTextController(mask: '(00) 00000-0000');
  final dobController = MaskedTextController(mask: '00/00/0000');

  final _formKey = GlobalKey<FormState>();
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool obscurePassword = true;
  bool signUpRequired = false;

  bool containsUpperCase = false;
  bool containsLowerCase = false;
  bool containsNumber = false;
  bool containsSpecialChar = false;
  bool contains8Length = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          setState(() {
            signUpRequired = false;
          });
        } else if (state is SignUpProcess) {
          setState(() {
            signUpRequired = true;
          });
        } else if (state is SignUpFailure) {
          return;
        }
      },
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(CupertinoIcons.mail_solid),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return '*Preenchimento obrigatório';
                      } else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$').hasMatch(val)) {
                        return 'Por favor, digite um e-mail válido';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: MyTextField(
                    controller: passwordController,
                    hintText: 'Senha',
                    obscureText: obscurePassword,
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: const Icon(CupertinoIcons.lock_fill),
                    onChanged: (val) {
                      if (val!.contains(RegExp(r'[A-Z]'))) {
                        setState(() {
                          containsUpperCase = true;
                        });
                      } else {
                        setState(() {
                          containsUpperCase = false;
                        });
                      }
                      if (val.contains(RegExp(r'[a-z]'))) {
                        setState(() {
                          containsLowerCase = true;
                        });
                      } else {
                        setState(() {
                          containsLowerCase = false;
                        });
                      }
                      if (val.contains(RegExp(r'[0-9]'))) {
                        setState(() {
                          containsNumber = true;
                        });
                      } else {
                        setState(() {
                          containsNumber = false;
                        });
                      }
                      if (val.contains(RegExp(r'^(?=.*?[!@#$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^])'))) {
                        setState(() {
                          containsSpecialChar = true;
                        });
                      } else {
                        setState(() {
                          containsSpecialChar = false;
                        });
                      }
                      if (val.length >= 8) {
                        setState(() {
                          contains8Length = true;
                        });
                      } else {
                        setState(() {
                          contains8Length = false;
                        });
                      }
                      return null;
                    },
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                          if (obscurePassword) {
                            iconPassword = CupertinoIcons.eye_fill;
                          } else {
                            iconPassword = CupertinoIcons.eye_slash_fill;
                          }
                        });
                      },
                      icon: Icon(iconPassword),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return '*Preenchimento obrigatório';
                      } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$').hasMatch(val)) {
                        return 'Por favor, digite uma senha válida';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "⚈  1 Maiúscula",
                          style: TextStyle(
                            color: containsUpperCase
                                ? Colors.green
                                : Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          "⚈  1 minúscula",
                          style: TextStyle(
                            color: containsLowerCase
                                ? Colors.green
                                : Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          "⚈  1 número",
                          style: TextStyle(
                            color: containsNumber
                                ? Colors.green
                                : Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "⚈  1 caractere especial",
                          style: TextStyle(
                            color: containsSpecialChar
                                ? Colors.green
                                : Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          "⚈  8 caracteres mínimos",
                          style: TextStyle(
                            color: contains8Length
                                ? Colors.green
                                : Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: MyTextField(
                    controller: nameController,
                    hintText: 'Nome',
                    obscureText: false,
                    keyboardType: TextInputType.name,
                    prefixIcon: const Icon(CupertinoIcons.person_fill),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return '*Preenchimento obrigatório';
                      } else if (val.length > 30) {
                        return 'Nome muito Longo';
                      }
                      return
                      null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: MyTextField(
                    controller: phoneController,
                    hintText: 'Telefone',
                    obscureText: false,
                    keyboardType: TextInputType.phone,
                    prefixIcon: const Icon(CupertinoIcons.phone_fill),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return '*Preenchimento obrigatório';
                      } else if (!RegExp(r'^\(\d{2}\)\s?\d{4,5}-?\d{4}$').hasMatch(val)) {
                        return 'Por favor, digite um telefone válido';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: MyTextField(
                    controller: dobController,
                    hintText: 'Data de Nascimento (dd/mm/aaaa)',
                    obscureText: false,
                    keyboardType: TextInputType.datetime,
                    prefixIcon: const Icon(CupertinoIcons.calendar),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return '*Preenchimento obrigatório';
                      } else if (!RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(val)) {
                        return 'Por favor, digite uma data válida';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: MyTextField(
                    controller: addressController,
                    hintText: 'Endereço',
                    obscureText: false,
                    keyboardType: TextInputType.streetAddress,
                    prefixIcon: const Icon(CupertinoIcons.location_solid),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return '*Preenchimento obrigatório';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                !signUpRequired
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              MyUser myUser = MyUser.empty;
                              myUser.email = emailController.text;
                              myUser.name = nameController.text;
                              myUser.phone = phoneController.text;
                              myUser.dob = dobController.text;
                              myUser.address = addressController.text;

                              setState(() {
                                context.read<SignUpBloc>().add(
                                      SignUpRequired(
                                        myUser,
                                        passwordController.text,
                                      ),
                                    );
                              });
                            }
                          },
                          style: TextButton.styleFrom(
                            elevation: 3.0,
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(60),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                            child: Text(
                              'Cadastrar-se',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      )
                    : const CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
