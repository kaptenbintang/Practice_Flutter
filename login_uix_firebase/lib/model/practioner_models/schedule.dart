enum Schedule {
  allowLikes(
    dayName: 'dasd',
    resultTime: 'dsadas',
  ),
  allowComments(
    dayName: 'dasd',
    resultTime: 'dasd',
  );

  final String dayName;
  final String resultTime;

  // firebase storage key
  // final String storageKey;

  const Schedule({
    required this.dayName,
    required this.resultTime,
    // required this.storageKey,
  });
}
