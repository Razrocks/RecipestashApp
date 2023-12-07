// Preferences class representing user preferences for the Recipe app
class Preferences {
  // Attributes for storing RGB color values, dark mode preference, and notification preference
  int? r, g, b, darkMode, notifications;

  // Constructor for creating Preferences objects with optional parameters
  Preferences({this.r, this.g, this.b, this.darkMode, this.notifications});

  // Constructor to create Preferences object from a map of key-value pairs
  Preferences.fromMap(Map<String, dynamic> map) {
    // Assign values from the map to corresponding attributes
    r = map['r'];
    g = map['g'];
    b = map['b'];
    darkMode = map['darkMode'];
    notifications = map['notifications'];
  }

  // Method to convert Preferences object to a map of key-value pairs
  Map<String, dynamic> toMap() {
    return {
      'r': r,
      'g': g,
      'b': b,
      'darkMode': darkMode,
      'notifications': notifications,
    };
  }

  // Override toString method to provide a string representation of Preferences object
  @override
  String toString() {
    return 'Preferences{r: $r, g: $g, b: $b, darkMode: $darkMode, notifications: $notifications}';
  }
}
