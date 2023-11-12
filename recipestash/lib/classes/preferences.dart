class Preferences {
  int? r, g, b, darkMode, notifications;

  Preferences({this.r, this.g, this.b, this.darkMode, this.notifications});

  Preferences.fromMap(Map<String, dynamic> map) {
    r = map['r'];
    g = map['g'];
    b = map['b'];
    darkMode = map['darkMode'];
    notifications = map['notifications'];
  }

  Map<String, dynamic> toMap() {
    return {
      'r': r,
      'g': g,
      'b': b,
      'darkMode': darkMode,
      'notifications': notifications,
    };
  }

  // testing purposes only - remove later
  @override
  String toString() {
    return 'Preferences{r: $r, g: $g, b: $b, darkMode: $darkMode, notifications: $notifications}';
  }
}