import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// This class represents a provider that catch events in 'CreateTaskScreen'
// and notify about changes in it attributes

class CreateTaskScreenProvider extends ChangeNotifier {
  /// get the reference for use other providers
  Ref ref;

  CreateTaskScreenProvider(this.ref);

  /// text field for name
  TextEditingController nameController = TextEditingController();

  /// focus node for name
  FocusNode nameFocus = FocusNode();

  /// test for task name
  String nameText = '';
  void setName(String id) {
    nameText = id;
    notifyListeners();
  }

  bool emptyName = true;
  void isEmptyName() {
    if (nameText.length < 0) {
      emptyName = true;
    } else {
      emptyName = false;
    }
    notifyListeners();
  }

  /// text for task date
  String dateText = '';
  void setDateText(String date) {
    dateText = date;
    notifyListeners();
  }

  /// text for task category
  String categoryText = 'Hogar';

  /// text for child assigned
  String assignedText = '';
  String assignedName = '';
  void setAssigned(String id) {
    assignedText = id;
    notifyListeners();
  }

  void setAssignedName(String childName) {
    assignedName = childName;
    notifyListeners();
  }

  /// text for owner
  String ownerText = '';

  /// text for stars
  int stars = 0;
  String starsText = '0';
  
  void setZeroStars() {
    stars = 0;
    notifyListeners();
  }

  void setStarsText(String stars) {
    starsText = stars;
    notifyListeners();
  }

  void setStarsUp() {
    stars++;
    notifyListeners();
  }

  void setStarsDown() {
    if (stars > 0) {
      stars--;
    }
    notifyListeners();
  }

  /// set home category
  bool isHome = true;

  void setHome() {
    isHome = true;
    isSchool = false;
    isGrocery = false;
    categoryText = 'Hogar';
    notifyListeners();
  }

  /// set school category
  bool isSchool = false;

  void setSchool() {
    isHome = false;
    isSchool = true;
    isGrocery = false;
    categoryText = 'Escolar';
    notifyListeners();
  }

  /// set grocery category
  bool isGrocery = false;

  void setGrocery() {
    isHome = false;
    isSchool = false;
    isGrocery = true;
    categoryText = 'Compras';
    notifyListeners();
  }

  void cleanFields() {
    setAssignedName('');
    setName('');
    setAssigned('');
    setHome();
    setZeroStars();
    setStarsText('0');
    notifyListeners();
  }

  /// list of home tasks
  List<String> homeTasks = [
    'Ordenar habitación',
    'Limpiar habitación',
    'Recoger la mesa',
    'Lavar platos',
    'Ayudar a los abuelos'
  ];

  /// list of school tasks
  List<String> schoolTasks = [
    'Hacer deberes',
    'Estudiar',
    'Aprobar examen',
    'Notable en examen',
    'Sobresaliente en examen'
  ];

  /// list of grocery task
  List<String> groceryTasks = [
    'Comprar el pan',
    'Comprar fruta',
    'Comprar leche',
    'Ir de compras con abuelos'
  ];

  
}
