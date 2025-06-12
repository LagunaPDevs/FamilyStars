// All String Constants defined here

class AppConstants {
  // name of the app
  static const String familyStars = 'FamilyStars';

  // Initial screens
  static const String start = "Comenzar";
  static const String welcome = '¡Bienvenido de nuevo!';
  static const String email = 'Email';
  static const String emailHint = 'Correo Electrónico';
  static const String password = 'Contraseña';
  static const String forgotPassword = '¿Olvidó su contraseña?';
  static const String signIn = 'Ingresar';
  static const String noAccount = '¿No tienes cuenta?';
  static const String signUp = '¡Regístrate!';
  static const String titleForgotPassword =
      'Introduce tu correo electrónico para que te enviemos una nueva contraseña';
  static const String resetPassword = 'Resetear contraseña';
  static const String softchanging = 'SoftChanging S.L.';
  static const String noData = 'No existe ningún dato actualmente';
  static const String resetPwd =
      'Se te ha enviado un email para restaurar la contraseña';

  // Registration
  static const String chooseSignUp = 'Elige método de registro';
  static const String signUpMail = 'Registrarse con correo electrónico';
  static const String signUpFacebook = 'Registrarse con cuenta de Facebook';
  static const String signUpGoogle = 'Registrase con cuenta de Google';
  static const String signUpTwitter = 'Registrarse con cuenta de Twitter';
  static const String yesAccount = '¿Ya tienes cuenta?';
  static const String verification = 'Verificación';
  static const String verificationText =
      'Introduce el código de verificación que hemos enviado a tu correo electrónico';
  static const String verificationNotReceiveCode =
      '¿No recibiste ningún código?';
  static const String verificationResendCode = 'REENVIAR CÓDIGO';
  static const String next = 'Siguiente';
  static const String previous = 'Atrás';
  static const String emailPassword = 'Introduzca email y contraseña';
  static const String nameSex = 'Miembro de la familia';
  static const String dob = 'Fecha de nacimiento';
  static const String invalidDob =
      'Para registrase hay que ser mayor de 18 años';
  static const String done = '¡Hecho!';
  static const String familiar = 'Familiar';
  static const String father = 'Padre';
  static const String mother = 'Madre';
  static const String ninio = 'Niño';
  static const String ninia = 'Niña';
  static const String other = 'Otro';
  static const String fullname = 'Nombre completo';
  static const String name = 'Nombre';
  static const String userCreated = 'Has creado un nuevo usuario';

  // Email address validation

  static const String emailAddressEmptyText =
      'Por favor introduzca su correo electrónico';
  static const String emailAddressValidText =
      'Por favor introduzca un correo electrónico válido';
  static const String emailAddressSingleAtTheRate =
      'Por favor compruebe el email introducido. Parece que olvidó el símbolo \'@\'.';
  static const String emailAddressMultipleAtTheRate =
      'Su correo tiene demasiados símbolos \'@\' para ser válido.';
  static const String emailAddressSingleDot =
      'Su email necesita al menos un punto final (.) para ser válido.';
  static const String emailAddressValidDomain =
      'Su email necesita un nombre de dominio válido.';
  static const String emailAddressInvalidCharacterInEmail =
      "Un caracter inválido se ha encontrado en el correo electrónico.";
  static const String emailAddressInValidEmail =
      'El email introducido no es válido.';
  static const String emailExists = 'El correo electrónico indicado ya existe';

  // Password validation

  static const String passwordEmptyText = 'Por favor introduzca contraseña.';
  static const String passwordValidText =
      'Por favor introduzca una contraseña válida.';

  // Full name validation

  static const String fullNameEmptyText =
      'Por favor introduzca su nombre completo.';
  static const String fullNameValidText =
      'Por favor introduzca un nombre completo válido.';
  static const String fullNameEnterLastNameText =
      'Por favor introduzca su apellido.';

  // Main screen
  static const String main = 'Principal';
  static const String eventList = 'Listado de eventos';
  static const String addTask = 'Añadir Tarea';
  static const String rewards = 'Recompensas';
  static const String stars = 'Estrellas';

  static const String calendar = 'Calendario de tareas';

  static const String experiences = 'Experiencias';
  static const String material = 'Material';
  static const String culture = 'Cultura';

  static const String selectCalendar =
      "Para cambiar el estado de los eventos, selecciona el Calendario de Tareas";

  // Drawer screen
  static const String menu = 'Menú';
  static const String editUser = 'Editar información personal';
  static const String createUser = 'Crear usuario';
  static const String changeUser = 'Cambiar usuario';
  static const String aboutUs = 'Sobre nosotros';
  static const String logOut = 'Salir de la app';
  static const String notPermitted =
      'La actividad seleccionada no está disponible para un tipo de usuario hijo';

  // Add task screen
  static const String selectTask = 'Selecciona tarea';
  static const String selectDate = 'Fecha';
  static const String changeDate = 'Seleccionar';
  static const String selectChild = 'Selecciona familiar';
  static const String category = 'Categoría';
  static const String assignTo = 'Asignar a';
  static const String taskCreated = '¡Asignaste una nueva tarea!';
  static const String incompleteFields =
      'Rellena todos los campos para asignar una tarea';
  static const String incomplete = 'Incompleta';
  static const String waiting = 'En espera';
  static const String completed = 'Completada';

  // Calendar screen
  static const String monthView = 'Vista Mes';
  static const String weekView = 'Vista Semana';
  static const String waitingParent =
      'La tarea está a la espera de ser revisada por un padre';
  static const String waitingChild =
      'La tarea está a la espera de ser completada por un niño';
  static const String completedTask = 'Tarea completada';
  static const String waitingTask = 'Tarea en espera';

  // Password screen
  static const String setPassword = 'Establecer contraseña';

  // Rewards screen
  static const String notStars =
      'Cantidad de estrellas insuficiente para reclamar este premio';

  // Dialog constants
  static const String deniedAccess = 'Acceso denegado';
  static const String ok = 'Aceptar';
  static const String cancel = 'Cancelar';

  // Error constants
  static const String errorCreateUserWithEmail = 'Error creando usuario con email';
  static const String errorRegisteringUser = 'Error registrando usuario';
  static const String errorUpdatingUser = 'Error actualizando datos de usuario';
  static const String unexpectedError = 'Error inexperado';

  // Categories constants
  static const String homeCategory = 'Hogar';
  static const String schoolCategory = 'Escolar';
  static const String groceryCategory = 'Compras';
}
