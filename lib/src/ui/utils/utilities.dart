int createUniqueId() => DateTime.now().millisecondsSinceEpoch.remainder(100000);
