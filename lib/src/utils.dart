import 'dart:collection';

Map<String, String> _canonicalInstances = HashMap();

String canonicalize(String str) => _canonicalInstances[str] ??= str;
