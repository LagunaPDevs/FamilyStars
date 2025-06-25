String dateToDDMMYY(DateTime date) {
  final localDate = date.toLocal();
  return '${localDate.day}/${localDate.month}/${localDate.year}';
}
