export 'Combinator.dart';

class Combinator {
  Set<String> set = {};

  Set<String> combine(String prefix, String symbols) {
      set.add(prefix);
      for (var l in symbols.split('')) {
        combine(prefix + l, symbols.replaceFirst(l + '', ''));
      }

      return set;
    }
}
