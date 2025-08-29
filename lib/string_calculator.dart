class NegativeNumbersException implements Exception {
  final List<int> negatives;
  NegativeNumbersException(this.negatives);

  @override
  String toString() =>
      'Negative numbers not allowed: ${negatives.join(",")}';
}

class StringCalculator {
  int add(String numbers) {
    if (numbers.isEmpty) return 0;

    String delimiterPattern = r'[,\n]'; 
    String payload = numbers;

    if (numbers.startsWith('//')) {
      final newlineIndex = numbers.indexOf('\n');
      if (newlineIndex == -1) {
        payload = numbers;
      } else {
        final delimiterDeclaration = numbers.substring(2, newlineIndex);
        payload = numbers.substring(newlineIndex + 1);

        if (delimiterDeclaration.startsWith('[') && delimiterDeclaration.endsWith(']')) {
          final regex = RegExp(r'\[([^\]]+)\]');
          final matches = regex.allMatches(delimiterDeclaration).map((m) => RegExp.escape(m.group(1)!)).toList();
          if (matches.isNotEmpty) {
            delimiterPattern = '(?:${matches.join('|')})';
          } else {
            delimiterPattern = RegExp.escape(delimiterDeclaration);
          }
        } else {
          delimiterPattern = RegExp.escape(delimiterDeclaration);
        }
      }
    }

    List<String> tokens;
    if (numbers.startsWith('//')) {
      final combinedPattern = '(?:$delimiterPattern|,|\\n)';
      tokens = payload.split(RegExp(combinedPattern));
    } else {
      tokens = payload.split(RegExp(r',|\n'));
    }

    final nums = <int>[];
    for (final t in tokens) {
      if (t.trim().isEmpty) continue;
      final n = int.tryParse(t.trim());
      if (n == null) {
        throw FormatException('Invalid number: "$t"');
      }
      nums.add(n);
    }

    final negatives = nums.where((n) => n < 0).toList();
    if (negatives.isNotEmpty) {
      throw NegativeNumbersException(negatives);
    }

    final sum = nums.fold<int>(0, (prev, el) => prev + el);
    return sum;
  }
}
