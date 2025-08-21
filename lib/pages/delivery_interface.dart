import 'package:flutter/material.dart';

// Replace with your actual page imports
import 'package:capstone_proj/category_page.dart';
import 'package:capstone_proj/pages/profile_page.dart';
import 'package:capstone_proj/pages/address_page.dart';
import 'package:capstone_proj/pages/logout_page.dart';

class DeliveryInterface extends StatefulWidget {
  const DeliveryInterface({super.key});

  @override
  State<DeliveryInterface> createState() => _DeliveryInterfaceState();
}

class _DeliveryInterfaceState extends State<DeliveryInterface> {
  int selectedTab = 0;

  Map<int, List<bool>> orderStatuses = {
    6969: [true, true, false, false],
    6968: [true, false, false, false],
  };

  final orders = [
    Order(
      number: 6969,
      address: 'calaca, camastilisan',
      items: '1× Ube Turon  •  3× Burger w/ Fries (BF)',
      time: '3:45 PM',
      phone: '0921‑456‑7890',
    ),
    Order(
      number: 6968,
      address: 'calaca, puting bato',
      items: '1× Ube Turon  •  3× Burger w/ Fries (BF)',
      time: '3:45 PM',
      phone: '0921‑456‑7890',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9B56B),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: const Color(0xFFD9B56B),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
          title: Image.asset('asset/logo.png', height: 40),
          centerTitle: true,
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(height: 1, color: Colors.black.withOpacity(.2)),
          ),
        ),
      ),
      endDrawer: _buildDrawer(context),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Text(
              selectedTab == 0 ? 'ORDER TO DELIVER' : 'ONGOING DELIVERIES',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                letterSpacing: .5,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: orders.length,
                separatorBuilder: (_, __) => const SizedBox(height: 20),
                itemBuilder: (context, index) {
                  return selectedTab == 0
                      ? OrderCard(
                          order: orders[index],
                          onStatusPressed: () => _showOrderStatusModal(
                            context,
                            orders[index].number,
                          ),
                        )
                      : OngoingOrderCard(order: orders[index]);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
              child: Row(
                children: [
                  Expanded(
                    child: _HomeButton(
                      label: 'ORDER TO DELIVER',
                      onPressed: () {
                        setState(() {
                          selectedTab = 0;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _HomeButton(
                      label: 'ONGOING DELIVERIES',
                      onPressed: () {
                        setState(() {
                          selectedTab = 1;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showOrderStatusModal(BuildContext context, int orderNumber) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: StatefulBuilder(
            builder: (context, setModalState) {
              orderStatuses.putIfAbsent(
                orderNumber,
                () => [false, false, false, false],
              );

              return Container(
                width: MediaQuery.of(context).size.width * 0.85,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const BoxDecoration(
                        color: Color(0xFF5C3B24),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Order Status',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 25,
                            top: 0,
                            bottom: 0,
                            child: Container(width: 2, color: Colors.black),
                          ),
                          Column(
                            children: [
                              _buildTimelineCheckboxItem(
                                context,
                                modalSetState: setModalState,
                                label: '10:20 AM Order Placed',
                                orderNumber: orderNumber,
                                index: 0,
                                isCurrent: false,
                              ),
                              _buildTimelineCheckboxItem(
                                context,
                                modalSetState: setModalState,
                                label: '10:20 AM Order is Being Prepared',
                                orderNumber: orderNumber,
                                index: 1,
                                isCurrent: true,
                              ),
                              _buildTimelineCheckboxItem(
                                context,
                                modalSetState: setModalState,
                                label:
                                    '10:40 AM Order Packed Rider is on the Way',
                                orderNumber: orderNumber,
                                index: 2,
                                isCurrent: false,
                              ),
                              _buildTimelineCheckboxItem(
                                context,
                                modalSetState: setModalState,
                                label: '10:45 AM Order Delivered',
                                orderNumber: orderNumber,
                                index: 3,
                                isCurrent: false,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5C3B24),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Update'),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildTimelineCheckboxItem(
    BuildContext context, {
    required StateSetter modalSetState,
    required String label,
    required int orderNumber,
    required int index,
    required bool isCurrent,
  }) {
    orderStatuses.putIfAbsent(orderNumber, () => [false, false, false, false]);

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            child: Checkbox(
              value: orderStatuses[orderNumber]![index],
              onChanged: (bool? value) {
                modalSetState(() {
                  orderStatuses[orderNumber]![index] = value ?? false;
                });
                setState(() {});
              },
              activeColor: const Color(0xFF5C3B24),
              checkColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isCurrent
                    ? Colors.blue.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.restaurant_menu),
              title: const Text("Menu"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const CategoryPage()),
                  (route) => false,
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfilePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text("Address"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const AddressPage()),
                );
              },
            ),
            const Spacer(),
            const Divider(thickness: 1),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout", style: TextStyle(color: Colors.red)),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Confirm Logout'),
                    content: const Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LogoutPage(),
                            ),
                          );
                        },
                        child: const Text('Logout'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.order,
    required this.onStatusPressed,
  });
  final Order order;
  final VoidCallback onStatusPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: const BoxDecoration(
              color: Color(0xFF5C3B24),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: const Center(
              child: Text(
                'ORDER TO DELIVER',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: .5,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(0xFFEFEFEF),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _InfoRow(
                  icon: Icons.assignment,
                  text: 'Order No. #${order.number}',
                ),
                _InfoRow(icon: Icons.location_on, text: order.address),
                _InfoRow(icon: Icons.list_alt, text: 'Items: ${order.items}'),
                _InfoRow(icon: Icons.schedule, text: 'Time: ${order.time}'),
                _InfoRow(icon: Icons.phone, text: 'Phone: ${order.phone}'),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.my_location),
                        label: const Text('Navigate'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF5C3B24),
                          side: const BorderSide(color: Color(0xFF5C3B24)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: onStatusPressed,
                        icon: const Icon(Icons.info_outline),
                        label: const Text('Status'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5C3B24),
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OngoingOrderCard extends StatelessWidget {
  const OngoingOrderCard({super.key, required this.order});
  final Order order;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: const BoxDecoration(
                color: Color(0xFF5C3B24),
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: const Center(
                child: Text(
                  'ONGOING DELIVERIES',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: .5,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color(0xFFEFEFEF),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(12),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _InfoRow(icon: Icons.person, text: 'Name: John Doe'),
                  _InfoRow(
                    icon: Icons.location_on,
                    text: 'Address: ${order.address}',
                  ),
                  _InfoRow(icon: Icons.list_alt, text: 'Items: ${order.items}'),
                  _InfoRow(icon: Icons.schedule, text: 'Time: ${order.time}'),
                  _InfoRow(icon: Icons.phone, text: 'Phone: ${order.phone}'),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order No. #${order.number}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5C3B24),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Marked as done'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Colors.black54),
          const SizedBox(width: 6),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}

class _HomeButton extends StatelessWidget {
  const _HomeButton({required this.label, required this.onPressed});
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFF7E8B6),
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: .5,
        ),
      ),
    );
  }
}

class Order {
  final int number;
  final String address;
  final String items;
  final String time;
  final String phone;

  Order({
    required this.number,
    required this.address,
    required this.items,
    required this.time,
    required this.phone,
  });
}
