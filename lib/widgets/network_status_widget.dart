import 'package:flutter/material.dart';
import '../services/network_service.dart';
import '../config.dart';

class NetworkStatusWidget extends StatefulWidget {
  const NetworkStatusWidget({super.key});

  @override
  State<NetworkStatusWidget> createState() => _NetworkStatusWidgetState();
}

class _NetworkStatusWidgetState extends State<NetworkStatusWidget> {
  Map<String, bool> _networkStatus = {};
  bool _isLoading = true;
  String? _currentBackendUrl;

  @override
  void initState() {
    super.initState();
    _checkNetworkStatus();
  }

  Future<void> _checkNetworkStatus() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final status = await NetworkService.getNetworkStatus();
      final currentUrl = await NetworkService.getBackendUrl();
      
      setState(() {
        _networkStatus = Map<String, bool>.from(status);
        _currentBackendUrl = currentUrl;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.wifi,
                  color: _isLoading ? Colors.grey : 
                         _currentBackendUrl != null ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 8),
                Text(
                  'Network Status',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                if (_isLoading)
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            if (_currentBackendUrl != null) ...[
              Text(
                'Connected to: $_currentBackendUrl',
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
            ],
            Text(
              'Available Backend URLs:',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 4),
            ...NetworkConfig.allPossibleUrls.map((url) {
              final isConnected = _networkStatus[url] ?? false;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: [
                    Icon(
                      isConnected ? Icons.check_circle : Icons.cancel,
                      color: isConnected ? Colors.green : Colors.red,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        url,
                        style: TextStyle(
                          color: isConnected ? Colors.green : Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            const SizedBox(height: 12),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _isLoading ? null : _checkNetworkStatus,
                  icon: const Icon(Icons.refresh, size: 16),
                  label: const Text('Refresh'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    NetworkService.clearCache();
                    _checkNetworkStatus();
                  },
                  icon: const Icon(Icons.clear, size: 16),
                  label: const Text('Clear Cache'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
