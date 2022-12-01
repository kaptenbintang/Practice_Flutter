import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final eProvider = Provider.autoDispose<String>((ref) {
  return 'tai';
});

class ProfileRiverpodPage extends ConsumerWidget {
  const ProfileRiverpodPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String value = ref.watch(eProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('example'),
      ),
      body: Center(
        child: Text(value),
      ),
    );
  }
}
