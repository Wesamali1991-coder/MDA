import 'dart:io';
import 'package:flutter/material.dart';

enum Strategy { ict, smc, breakoutTrap, sk, fib, wave, timeCycle, sb, classicIndicators }

String strategyName(Strategy s) {
  switch (s) {
    case Strategy.ict: return 'ICT';
    case Strategy.smc: return 'SMC';
    case Strategy.breakoutTrap: return 'Breakout Trap';
    case Strategy.sk: return 'SK Strategy';
    case Strategy.fib: return 'FIB (Fibonacci)';
    case Strategy.wave: return 'Wave Theory';
    case Strategy.timeCycle: return 'Time Cycle';
    case Strategy.sb: return 'SB';
    case Strategy.classicIndicators: return 'Classic + Indicators';
  }
}

class AnalysisModel extends ChangeNotifier {
  Strategy strategy = Strategy.ict;
  String resultText = '';

  void setStrategy(Strategy s) { strategy = s; notifyListeners(); }

  Future<void> analyzeChart(File imageFile) async {
    await Future.delayed(const Duration(milliseconds: 600));
    resultText = _mockAnalyze(strategy);
    notifyListeners();
  }

  String _mockAnalyze(Strategy s) {
    switch (s) {
      case Strategy.ict:
        return 'ICT: OB/FVG + BOS/CHOCH/MSS → ادخل بعد إعادة الاختبار، الأهداف سيولة قمم/قيعان.';
      case Strategy.smc:
        return 'SMC: هيكلة + مناطق ذكية + تجنب السيولة الواضحة.';
      case Strategy.breakoutTrap:
        return 'Breakout Trap: راقب الكسر الكاذب ثم دخول معاكس.';
      case Strategy.sk:
        return 'SK: فلتر زخم + ATR وتلاقٍ؛ إدارة مخاطر صارمة.';
      case Strategy.fib:
        return 'FIB: 38.2/61.8 للتصحيح + 1.272/1.618 للأهداف.';
      case Strategy.wave:
        return 'Wave: عدّ أمواج مبسط لتقدير الاتجاه.';
      case Strategy.timeCycle:
        return 'Time Cycle: دورات زمنية لنقاط الانعكاس.';
      case Strategy.sb:
        return 'SB: سيولة + عرض/طلب + SL دقيق.';
      case Strategy.classicIndicators:
        return 'Indicators: EMA(9/21), RSI, Stoch, ATR — توصية مختصرة.';
    }
  }
}
