import 'package:flutter/material.dart';

void main() {
  runApp(const KhedematApp());
}

class KhedematApp extends StatelessWidget {
  const KhedematApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تطبيق خدمات',
      debugShowCheckedModeBanner: false,
      // ضبط الاتجاه من اليمين إلى اليسار للغة العربية
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFF6F8FA),
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/wallet': (context) => const WalletScreen(),
      },
    );
  }
}

// ==========================================
// 1. شاشة تسجيل الدخول (LoginScreen)
// ==========================================
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String selectedWilaya = 'ورقلة';

  final List<String> wilayas = [
    'ورقلة', 'الجزائر', 'وهران', 'قسنطينة', 'عنابة', 'أدرار', 'بشار'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Center(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.teal.shade50,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.handshake_outlined,
                          size: 60,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'مرحباً بك في تطبيق خدمات',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'منصتك لقضاء الحوائج وجني المال بسهولة',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                const Text('الاسم الكامل', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person_outline),
                    hintText: 'أدخل اسمك الكريم',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 16),

                const Text('رقم الهاتف', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    prefixIcon: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      child: Text(
                        '+213 ',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.teal),
                      ),
                    ),
                    hintText: '661 00 00 00',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 16),

                const Text('الولاية الحالية', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: selectedWilaya,
                  items: wilayas.map((w) => DropdownMenuItem(value: w, child: Text(w))).toList(),
                  onChanged: (val) => setState(() => selectedWilaya = val!),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.location_city_outlined),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      if (_phoneController.text.isNotEmpty && _nameController.text.isNotEmpty) {
                        Navigator.pushReplacementNamed(context, '/home');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('يرجى ملء كافة البيانات لتأكيد الحساب')),
                        );
                      }
                    },
                    child: const Text('دخول إلى المنصة', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 2. الشاشة الرئيسية (HomeScreen)
// ==========================================
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> services = [
    {
      'title': 'توصيل وثيقة إدارية عاجلة',
      'category': 'توصيل',
      'location': 'حي النصر - ورقلة',
      'price': '800 دج',
      'time': 'منذ 10 دقائق',
      'icon': Icons.local_shipping_outlined,
      'hasAudio': true,
    },
    {
      'title': 'إصلاح حنفية وتسريب مياه',
      'category': 'خدمات منزلية',
      'location': 'وسط المدينة - ورقلة',
      'price': '1500 دج',
      'time': 'منذ 25 دقيقة',
      'icon': Icons.build_outlined,
      'hasAudio': false,
    },
    {
      'title': 'تنسيق وطباعة ملف PDF إداري',
      'category': 'كتابة وخدمات',
      'location': 'حي المجاهدين - ورقلة',
      'price': '1000 دج',
      'time': 'منذ ساعة',
      'icon': Icons.description_outlined,
      'hasAudio': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('تطبيق خدمات', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          // زر المحفظة
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/wallet'),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Icon(Icons.account_balance_wallet, color: Colors.amber, size: 18),
                  SizedBox(width: 4),
                  Text('1,500 دج', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            color: Colors.teal,
            child: const Row(
              children: [
                Icon(Icons.location_on, color: Colors.white),
                SizedBox(width: 6),
                Text('المنطقة الحالية: ', style: TextStyle(color: Colors.white70)),
                Text('ورقلة', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: services.length,
              itemBuilder: (context, index) {
                final item = services[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(backgroundColor: Colors.teal.shade50, child: Icon(item['icon'], color: Colors.teal)),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  Text(item['category'], style: const TextStyle(color: Colors.grey, fontSize: 12)),
                                ],
                              ),
                            ),
                            Text(item['price'], style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16)),
                          ],
                        ),
                        const Divider(height: 20),
                        Row(
                          children: [
                            const Icon(Icons.near_me, size: 14, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(item['location'], style: const TextStyle(color: Colors.grey, fontSize: 12)),
                            const Spacer(),
                            if (item['hasAudio']) const Icon(Icons.mic, color: Colors.orange, size: 18),
                            const SizedBox(width: 8),
                            Text(item['time'], style: const TextStyle(color: Colors.grey, fontSize: 11)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('تم قبول المهمة! جاري الاتصال بصاحب الطلب...')),
                              );
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                            child: const Text('قبول المهمة والتواصل', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.amber[800],
        onPressed: () async {
          final newService = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddServiceScreen()),
          );
          if (newService != null) {
            setState(() {
              services.insert(0, newService);
            });
          }
        },
        icon: const Icon(Icons.add, color: Colors.white, size: 28),
        label: const Text('أطلب خدمة جديدة', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }
}

// ==========================================
// 3. شاشة إضافة خدمة جديدة (AddServiceScreen)
// ==========================================
class AddServiceScreen extends StatefulWidget {
  const AddServiceScreen({super.key});

  @override
  State<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  String selectedCategory = 'توصيل';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إضافة طلب خدمة جديد')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'ماذا تحتاج؟ (مثال: نقل وثيقة، إصلاح قفل)', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              items: ['توصيل', 'خدمات منزلية', 'كتابة ووثائق', 'أخرى']
                  .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                  .toList(),
              onChanged: (val) => setState(() => selectedCategory = val!),
              decoration: const InputDecoration(labelText: 'الفئة', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'المبلغ المعروض (دج)', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.mic, color: Colors.white),
              label: const Text('تسجيل شرح صوتي (اختياري)', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                onPressed: () {
                  if (_titleController.text.isNotEmpty) {
                    Navigator.pop(context, {
                      'title': _titleController.text,
                      'category': selectedCategory,
                      'location': 'ورقلة',
                      'price': '${_priceController.text} دج',
                      'time': 'الآن',
                      'icon': Icons.miscellaneous_services,
                      'hasAudio': false,
                    });
                  }
                },
                child: const Text('نشر الطلب فوراً', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 4. شاشة المحفظة وسحب الأموال (WalletScreen)
// ==========================================
class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  double balance = 1500.0;
  final TextEditingController _ripController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المحفظة والأرباح', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.teal, Color(0xFF00796B)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('رصيد المحفظة الحالي', style: TextStyle(color: Colors.white70, fontSize: 14)),
                  const SizedBox(height: 8),
                  Text(
                    '${balance.toStringAsFixed(0)} دج',
                    style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    children: [
                      Icon(Icons.check_circle_outline, color: Colors.amber, size: 18),
                      SizedBox(width: 6),
                      Text('جاهز للسحب عبر BaridiMob', style: TextStyle(color: Colors.amber, fontSize: 12, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const Text('العمليات المتاحة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber[800],
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () => _showWithdrawDialog(context),
                    icon: const Icon(Icons.download_rounded, color: Colors.white),
                    label: const Text('سحب إلى CCP', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Colors.teal, width: 2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('شحن الرصيد عبر البطاقة الذهبية / BaridiMob قيد التفعيل')),
                      );
                    },
                    icon: const Icon(Icons.add_card, color: Colors.teal),
                    label: const Text('شحن الرصيد', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            const Text('سجل المعاملات', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            _buildTransactionItem(title: 'عمولة مهمة: توصيل وثيقة', date: 'اليوم، 14:30', amount: '+ 800 دج', isIncome: true),
            _buildTransactionItem(title: 'اقتطاع عمولة التطبيق (10%)', date: 'اليوم، 14:30', amount: '- 80 دج', isIncome: false),
            _buildTransactionItem(title: 'سحب أرباح إلى BaridiMob', date: 'أمس، 10:15', amount: '- 1000 دج', isIncome: false),
          ],
        ),
      ),
    );
  }

  void _showWithdrawDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            top: 20,
            left: 20,
            right: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('سحب الأرباح عبر BaridiMob', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal)),
              const SizedBox(height: 16),
              TextField(
                controller: _ripController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'رقم الحساب البريدي RIP (00799999...)', border: OutlineInputBorder(), prefixIcon: Icon(Icons.credit_card)),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'المبلغ المراد سحبه (دج)', border: OutlineInputBorder(), prefixIcon: Icon(Icons.attach_money)),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                  onPressed: () {
                    if (_ripController.text.isNotEmpty && _amountController.text.isNotEmpty) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('تم ارسال طلب السحب بنجاح! سيصلك المبلغ عبر BaridiMob')),
                      );
                    }
                  },
                  child: const Text('تأكيد طلب السحب', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTransactionItem({required String title, required String date, required String amount, required bool isIncome}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isIncome ? Colors.green.shade50 : Colors.red.shade50,
          child: Icon(isIncome ? Icons.arrow_downward : Icons.arrow_upward, color: isIncome ? Colors.green : Colors.red),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        subtitle: Text(date, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        trailing: Text(amount, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: isIncome ? Colors.green : Colors.red)),
      ),
    );
  }
}
