String timestampToString(double timestamp) {
  var now = DateTime.now();
  var difference = now
      .difference(DateTime.fromMillisecondsSinceEpoch(timestamp.toInt() * 1000))
      .inSeconds;
  print("diff = $difference");
  if (difference < 60) {
    return 'Now';
  } else if (difference < 3600) {
    return '${difference ~/ 60}m';
  } else if (difference < 86400) {
    return '${difference ~/ 3600}h';
  } else {
    return '${difference ~/ 86400}d';
  }
}
