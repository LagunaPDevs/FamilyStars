import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/models/user.dart';
import 'package:familystars_2/infrastructure/models/task.dart';
import 'package:familystars_2/infrastructure/services/shared_preference_services.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';

// This class represents a provider that catch events in 'CreateTaskScreen'
// and notify about changes in it attributes

class CreateTaskScreenProvider extends ChangeNotifier {
  /// get the reference for use other providers
  Ref ref;

  CreateTaskScreenProvider(this.ref);

  /// child list for current user
  List<UserModel> childList = [];

  /// is loading
  bool isLoading = false;

  /// text field for name
  TextEditingController nameController = TextEditingController();

  /// focus node for name
  FocusNode nameFocus = FocusNode();

  /// test for task name
  String nameText = '';

  bool emptyName = true;
  
  /// text for task date
  String dateText = DateTime.now().toLocal().toString();

  /// text for task category
  String categoryText = AppConstants.homeCategory;

  /// text for child assigned
  String assignedText = '';
  String assignedName = '';
  
  /// text for owner
  String ownerText = '';

  /// text for stars
  int stars = 0;
  String starsText = '0';

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
  
  void setName(String id) {
    nameText = id;
    notifyListeners();
  }

  void isEmptyName() {
    if (nameText.isEmpty) {
      emptyName = true;
    } else {
      emptyName = false;
    }
    notifyListeners();
  }

  void setDateText(DateTime date) {
    final pickedDate = date.toLocal();
    dateText = '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
    notifyListeners();
  }

  void setAssigned(String id) {
    assignedText = id;
    notifyListeners();
  }

  void setAssignedName(String childName) {
    assignedName = childName;
    notifyListeners();
  }


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

  void setIsLoading(bool loading) {
    isLoading = !loading;
    notifyListeners();
  }

  
  void setCategory(String category) {
    categoryText = category;
    notifyListeners();
  }

  void setChildList(List<UserModel> list) {
    childList = list;
    notifyListeners();
  }

  void cleanFields() {
    setAssignedName('');
    setName('');
    setAssigned('');
    setCategory(AppConstants.homeCategory);
    setZeroStars();
    setStarsText('0');
    notifyListeners();
  }


  Future<bool> addNewTaskToChild() async {
    final addNewTaskToChildRef = ref.watch(addNewTaskToChildUseCase);
    final currentUser = SharedPreferenceService().getUser();
    final Task task = Task(
      owner: currentUser,
      assigned: assignedText,
      assignedName: assignedName,
      name: nameText,
      category: categoryText,
      date: dateText,
      stars: starsText,
      state: "Incompleta"
    );
    setIsLoading(true);
    final result = await addNewTaskToChildRef.addNewTaskToChild(task);
    setIsLoading(false);
    if (result) {
      cleanFields();
    }
    return result;
  }

  Future<List<UserModel>> getChildList() async {
    final getParentChildrenRef = ref.watch(getParentUserChildrenUseCase);
    final result = await getParentChildrenRef.getParentUserChildren();
    return result;
  }
}
