import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  final double totalAmount;
  final VoidCallback onPaymentSuccess;

  const CheckoutScreen({
    super.key,
    required this.totalAmount,
    required this.onPaymentSuccess,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _cardNumberController = TextEditingController();
  final _nameController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();

  bool _isSuccess = false;

  final Color primaryColor = const Color(0xFF1E293B);
  final Color accentColor = const Color(0xFF4F46E5);

  void _processPayment() {
    if (_cardNumberController.text.trim().isEmpty ||
        _nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen kart bilgilerinizi eksiksiz doldurun.')),
      );
      return;
    }

    setState(() {
      _isSuccess = true;
    });

    widget.onPaymentSuccess();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: Text(
          _isSuccess ? 'Payment Successful' : 'Checkout & Payment',
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: _isSuccess
            ? null
            : IconButton(
                icon: Icon(Icons.arrow_back_ios_new, color: primaryColor, size: 18),
                onPressed: () => Navigator.pop(context),
              ),
        automaticallyImplyLeading: !_isSuccess,
      ),
      body: _isSuccess ? _buildSuccessView(context) : _buildPaymentForm(context),
    );
  }

  Widget _buildPaymentForm(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 180,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1E293B), Color(0xFF334155)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('DEMO CARD', style: TextStyle(color: Colors.white70, fontSize: 12, letterSpacing: 1.5)),
                    Icon(Icons.credit_card, color: Colors.white70),
                  ],
                ),
                Text(
                  _cardNumberController.text.isEmpty
                      ? '**** **** **** ****'
                      : _cardNumberController.text,
                  style: const TextStyle(color: Colors.white, fontSize: 19, letterSpacing: 2, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _nameController.text.isEmpty ? 'CARDHOLDER NAME' : _nameController.text.toUpperCase(),
                      style: const TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    const Text('12/28', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          Text('Cardholder Name', style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor)),
          const SizedBox(height: 6),
          _buildInputField(_nameController, 'e.g. Tolgahan Mestan', TextInputType.text, (val) => setState(() {})),
          const SizedBox(height: 16),

          Text('Card Number', style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor)),
          const SizedBox(height: 6),
          _buildInputField(_cardNumberController, '5555 4444 3333 2222', TextInputType.number, (val) => setState(() {})),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Expiry Date', style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor)),
                    const SizedBox(height: 6),
                    _buildInputField(_expiryController, 'MM/YY', TextInputType.datetime, null),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('CVV', style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor)),
                    const SizedBox(height: 6),
                    _buildInputField(_cvvController, '123', TextInputType.number, null),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: accentColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 0,
              ),
              onPressed: _processPayment,
              child: Text(
                'Pay \$${widget.totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessView(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFFDCFCE7),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.2),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: const Icon(Icons.check_circle_rounded, size: 72, color: Color(0xFF16A34A)),
            ),
            const SizedBox(height: 24),
            Text(
              '🎉 Siparişiniz Alındı! 🎊',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: primaryColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Ödemeniz başarıyla simüle edildi ve toplam \$${widget.totalAmount.toStringAsFixed(2)} tutarındaki siparişiniz onaylandı.',
              style: const TextStyle(fontSize: 14, color: Colors.grey, height: 1.5),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text('Alışverişe Devam Et', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(
    TextEditingController controller,
    String hint,
    TextInputType keyboardType,
    Function(String)? onChanged,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}