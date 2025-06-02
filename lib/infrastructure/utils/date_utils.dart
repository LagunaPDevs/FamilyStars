String dateToDDMMYY(DateTime date) {
  String onlyDate = date.toLocal().toString().split(' ')[0];
  List splittedDate = onlyDate.split('-');
  return '${splittedDate[2]}/${splittedDate[1]}/${splittedDate[0]}';
}
