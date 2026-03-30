import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_ui/src/presentation/ui_kit.dart';
import 'package:auth/auth.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authControllerProvider);
    final controller = ref.read(authControllerProvider.notifier);

    final session = state.session;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: AppColors.primary,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await controller.logout();
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),

        children: [
          /// Greeting
          Text(
            'Welcome 👋',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.amberAccent,
            ),
          ),

          const SizedBox(height: AppSpacing.sm),

          Text(
            'Here is your system overview',
            style: TextStyle(color: AppColors.textPrimary),
          ),

          const SizedBox(height: AppSpacing.lg),

          /// Session Info Card
          _Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Session Info',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: AppSpacing.sm),
                _infoRow('Account ID', session?.accountId ?? '-'),
                _infoRow('Context', session?.context.type.name ?? '-'),
                _infoRow('Expires At', session?.expiresAt.toString() ?? '-'),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          /// Stats
          Row(
            children: [
              Expanded(
                child: _StatCard(title: 'Projects', value: '12'),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _StatCard(title: 'Users', value: '248'),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.md),

          Row(
            children: [
              Expanded(
                child: _StatCard(title: 'Revenue', value: '\$1.2k'),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _StatCard(title: 'Growth', value: '+12%'),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          /// Fake list content (scrollable)
          const Text(
            'Recent Activity',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: AppSpacing.md),

          ...List.generate(10, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: _Card(
                child: Row(
                  children: [
                    const Icon(Icons.notifications_none),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        'Activity item #$index',
                        style: TextStyle(color: AppColors.textPrimary),
                      ),
                    ),
                    Text(
                      'Now',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          Text(value, style: TextStyle(color: AppColors.textPrimary)),
        ],
      ),
    );
  }
}

/// Reusable Card
class _Card extends StatelessWidget {
  final Widget child;

  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.all(AppBorder.radiusMd),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

/// Stat Card
class _StatCard extends StatelessWidget {
  final String title;
  final String value;

  const _StatCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
