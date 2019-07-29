import 'dart:collection';
import 'dart:math';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'predictions.g.dart';

abstract class HypergeometricInputs
    implements Built<HypergeometricInputs, HypergeometricInputsBuilder> {
  int get population;
  int get hits;
  int get misses => population - hits;
  int get sample;

  HypergeometricInputs._();
  factory HypergeometricInputs(
          [void Function(HypergeometricInputsBuilder) updates]) =
      _$HypergeometricInputs;
}

var _hypergeometricCache = HashMap<HypergeometricInputs, List<double>>();

List<double> hypergeometric(HypergeometricInputs inputs) {
  return _hypergeometricCache[inputs] ??= _hypergeometric(inputs);
}

List<double> _hypergeometric(HypergeometricInputs inputs) {
  int maxHits = min(inputs.hits, inputs.sample);
  var combinations = List<int>(maxHits + 1);

  int hitsInSample = 0;
  int missesInSample = inputs.sample;
  int hitsNotInSample = inputs.hits;
  int missesNotInSample = inputs.misses - missesInSample;
  int hitCombos = 1;
  int missCombos = _combinations(inputs.misses, inputs.sample);
  int totalCombos = missCombos;
  combinations[0] = missCombos;

  while (hitsInSample < maxHits) {
    hitCombos = (hitCombos * hitsNotInSample-- / ++hitsInSample) as int;
    missCombos = (missCombos * missesInSample-- / ++missesNotInSample) as int;
    totalCombos += combinations[hitsInSample] = hitCombos * missCombos;
  }

  return [...combinations.map((c) => c / totalCombos)];
}

int _combinations(int n, int k) {
  int combinations = 1;
  for (int i = 1; i <= k; i++, n--) {
    combinations = (combinations * n / i) as int;
  }
  return combinations;
}

abstract class BuggedInputs
    implements Built<BuggedInputs, BuggedInputsBuilder> {
  int get population;
  int get hits;
  int get mulligans;
  int get sample;
  int get position;

  BuggedInputs._();
  factory BuggedInputs([void Function(BuggedInputsBuilder) updates]) =
      _$BuggedInputs;
}

List<double> bugged(BuggedInputs inputs) {
  return _buggedCache[inputs];
}

final _buggedCache = BuiltMap<BuggedInputs, List<double>>((bugged) => bugged
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 0)] = [
    0.82502650,
    0.17497350,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 1)] = [
    0.81848620,
    0.18151380,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 2)] = [
    0.81214950,
    0.18785050,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 3)] = [
    0.80604820,
    0.19395180,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 4)] = [
    0.80015490,
    0.19984510,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 5)] = [
    0.79437710,
    0.20562290,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 6)] = [
    0.78835240,
    0.21164760,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 7)] = [
    0.78304100,
    0.21695900,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 8)] = [
    0.78650410,
    0.21349590,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 9)] = [
    0.79024730,
    0.20975270,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 10)] = [
    0.79366420,
    0.20633580,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 11)] = [
    0.79706960,
    0.20293040,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 12)] = [
    0.80047870,
    0.19952130,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 13)] = [
    0.80369910,
    0.19630090,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 14)] = [
    0.80670470,
    0.19329530,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 15)] = [
    0.80983790,
    0.19016210,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 16)] = [
    0.81283440,
    0.18716560,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 17)] = [
    0.81563610,
    0.18436390,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 18)] = [
    0.81858060,
    0.18141940,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 19)] = [
    0.82140240,
    0.17859760,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 20)] = [
    0.82401480,
    0.17598520,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 21)] = [
    0.82665310,
    0.17334690,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 22)] = [
    0.82935680,
    0.17064320,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 23)] = [
    0.83194610,
    0.16805390,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 24)] = [
    0.83407770,
    0.16592230,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 25)] = [
    0.83663450,
    0.16336550,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 26)] = [
    0.83896130,
    0.16103870,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 27)] = [
    0.84104870,
    0.15895130,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 28)] = [
    0.84354870,
    0.15645130,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 29)] = [
    0.84561930,
    0.15438070,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 30)] = [
    0.84761020,
    0.15238980,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 31)] = [
    0.84955070,
    0.15044930,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 32)] = [
    0.85180900,
    0.14819100,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 33)] = [
    0.85371090,
    0.14628910,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 34)] = [
    0.85558290,
    0.14441710,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 35)] = [
    0.85741780,
    0.14258220,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 36)] = [
    0.85928740,
    0.14071260,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 37)] = [
    0.86098650,
    0.13901350,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 38)] = [
    0.86278630,
    0.13721370,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 39)] = [
    0.86424560,
    0.13575440,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 0)] = [
    0.84999300,
    0.15000700,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 1)] = [
    0.85020600,
    0.14979400,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 2)] = [
    0.85024090,
    0.14975910,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 3)] = [
    0.85022810,
    0.14977190,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 4)] = [
    0.85010440,
    0.14989560,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 5)] = [
    0.84992260,
    0.15007740,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 6)] = [
    0.84967740,
    0.15032260,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 7)] = [
    0.84953480,
    0.15046520,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 8)] = [
    0.84919130,
    0.15080870,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 9)] = [
    0.84902060,
    0.15097940,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 10)] = [
    0.84888620,
    0.15111380,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 11)] = [
    0.84864490,
    0.15135510,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 12)] = [
    0.84861920,
    0.15138080,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 13)] = [
    0.84850060,
    0.15149940,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 14)] = [
    0.84854780,
    0.15145220,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 15)] = [
    0.84861960,
    0.15138040,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 16)] = [
    0.84870210,
    0.15129790,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 17)] = [
    0.84865750,
    0.15134250,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 18)] = [
    0.84880830,
    0.15119170,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 19)] = [
    0.84888200,
    0.15111800,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 20)] = [
    0.84885660,
    0.15114340,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 21)] = [
    0.84898550,
    0.15101450,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 22)] = [
    0.84920140,
    0.15079860,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 23)] = [
    0.84944580,
    0.15055420,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 24)] = [
    0.84936710,
    0.15063290,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 25)] = [
    0.84946370,
    0.15053630,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 26)] = [
    0.84982810,
    0.15017190,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 27)] = [
    0.85014840,
    0.14985160,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 28)] = [
    0.85041790,
    0.14958210,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 29)] = [
    0.85052510,
    0.14947490,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 30)] = [
    0.85090480,
    0.14909520,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 31)] = [
    0.85089080,
    0.14910920,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 32)] = [
    0.85130820,
    0.14869180,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 33)] = [
    0.85169480,
    0.14830520,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 34)] = [
    0.85181250,
    0.14818750,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 35)] = [
    0.85213680,
    0.14786320,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 36)] = [
    0.85235890,
    0.14764110,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 37)] = [
    0.85269380,
    0.14730620,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 38)] = [
    0.85304820,
    0.14695180,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 39)] = [
    0.85309830,
    0.14690170,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 0)] = [
    0.82510360,
    0.17489640,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 1)] = [
    0.82523310,
    0.17476690,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 2)] = [
    0.82511230,
    0.17488770,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 3)] = [
    0.82535540,
    0.17464460,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 4)] = [
    0.82503630,
    0.17496370,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 5)] = [
    0.82504550,
    0.17495450,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 6)] = [
    0.82454280,
    0.17545720,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 7)] = [
    0.82443630,
    0.17556370,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 8)] = [
    0.82418770,
    0.17581230,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 9)] = [
    0.82409180,
    0.17590820,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 10)] = [
    0.82384930,
    0.17615070,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 11)] = [
    0.82363510,
    0.17636490,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 12)] = [
    0.82343510,
    0.17656490,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 13)] = [
    0.82348080,
    0.17651920,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 14)] = [
    0.82347100,
    0.17652900,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 15)] = [
    0.82318390,
    0.17681610,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 16)] = [
    0.82333280,
    0.17666720,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 17)] = [
    0.82330890,
    0.17669110,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 18)] = [
    0.82341670,
    0.17658330,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 19)] = [
    0.82362330,
    0.17637670,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 20)] = [
    0.82367280,
    0.17632720,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 21)] = [
    0.82389160,
    0.17610840,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 22)] = [
    0.82377640,
    0.17622360,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 23)] = [
    0.82416970,
    0.17583030,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 24)] = [
    0.82444640,
    0.17555360,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 25)] = [
    0.82464640,
    0.17535360,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 26)] = [
    0.82462820,
    0.17537180,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 27)] = [
    0.82490600,
    0.17509400,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 28)] = [
    0.82525690,
    0.17474310,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 29)] = [
    0.82531060,
    0.17468940,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 30)] = [
    0.82596120,
    0.17403880,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 31)] = [
    0.82618340,
    0.17381660,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 32)] = [
    0.82641230,
    0.17358770,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 33)] = [
    0.82666740,
    0.17333260,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 34)] = [
    0.82688270,
    0.17311730,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 35)] = [
    0.82731240,
    0.17268760,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 36)] = [
    0.82769050,
    0.17230950,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 37)] = [
    0.82830740,
    0.17169260,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 38)] = [
    0.82841580,
    0.17158420,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 39)] = [
    0.82860790,
    0.17139210,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 0)] = [
    0.67158060,
    0.30029820,
    0.02812120,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 1)] = [
    0.66107590,
    0.30876360,
    0.03016050,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 2)] = [
    0.65068830,
    0.31704080,
    0.03227090,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 3)] = [
    0.64095780,
    0.32451550,
    0.03452670,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 4)] = [
    0.63125340,
    0.33190300,
    0.03684360,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 5)] = [
    0.62187220,
    0.33898290,
    0.03914490,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 6)] = [
    0.61246470,
    0.34668150,
    0.04085380,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 7)] = [
    0.61075680,
    0.34828260,
    0.04096060,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 8)] = [
    0.61625610,
    0.34414640,
    0.03959750,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 9)] = [
    0.62225280,
    0.33949710,
    0.03825010,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 10)] = [
    0.62807570,
    0.33510850,
    0.03681580,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 11)] = [
    0.63317030,
    0.33107040,
    0.03575930,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 12)] = [
    0.63875530,
    0.32664880,
    0.03459590,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 13)] = [
    0.64382300,
    0.32274570,
    0.03343130,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 14)] = [
    0.64927990,
    0.31833710,
    0.03238300,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 15)] = [
    0.65391360,
    0.31480190,
    0.03128450,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 16)] = [
    0.65927600,
    0.31047650,
    0.03024750,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 17)] = [
    0.66358850,
    0.30694560,
    0.02946590,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 18)] = [
    0.66850640,
    0.30302330,
    0.02847030,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 19)] = [
    0.67328450,
    0.29911980,
    0.02759570,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 20)] = [
    0.67764240,
    0.29570320,
    0.02665440,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 21)] = [
    0.68212320,
    0.29189940,
    0.02597740,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 22)] = [
    0.68650240,
    0.28835560,
    0.02514200,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 23)] = [
    0.69040090,
    0.28511950,
    0.02447960,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 24)] = [
    0.69469970,
    0.28155990,
    0.02374040,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 25)] = [
    0.69848860,
    0.27852880,
    0.02298260,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 26)] = [
    0.70271050,
    0.27498090,
    0.02230860,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 27)] = [
    0.70655930,
    0.27179030,
    0.02165040,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 28)] = [
    0.71028570,
    0.26858540,
    0.02112890,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 29)] = [
    0.71371180,
    0.26570880,
    0.02057940,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 30)] = [
    0.71753470,
    0.26247980,
    0.01998550,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 31)] = [
    0.72085600,
    0.25967470,
    0.01946930,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 32)] = [
    0.72453470,
    0.25653500,
    0.01893030,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 33)] = [
    0.72771680,
    0.25384260,
    0.01844060,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 34)] = [
    0.73083180,
    0.25112230,
    0.01804590,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 35)] = [
    0.73432990,
    0.24816510,
    0.01750500,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 36)] = [
    0.73717110,
    0.24580550,
    0.01702340,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 37)] = [
    0.74047310,
    0.24293930,
    0.01658760,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 38)] = [
    0.74314550,
    0.24064070,
    0.01621380,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 0)] = [
    0.71939390,
    0.26141340,
    0.01919270,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 1)] = [
    0.71932960,
    0.26143260,
    0.01923780,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 2)] = [
    0.71931990,
    0.26153550,
    0.01914460,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 3)] = [
    0.71934710,
    0.26141720,
    0.01923570,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 4)] = [
    0.71889030,
    0.26189910,
    0.01921060,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 5)] = [
    0.71884820,
    0.26177760,
    0.01937420,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 6)] = [
    0.71844030,
    0.26215670,
    0.01940300,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 7)] = [
    0.71796280,
    0.26259060,
    0.01944660,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 8)] = [
    0.71756470,
    0.26302850,
    0.01940680,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 9)] = [
    0.71737650,
    0.26313790,
    0.01948560,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 10)] = [
    0.71680170,
    0.26365150,
    0.01954680,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 11)] = [
    0.71697670,
    0.26342490,
    0.01959840,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 12)] = [
    0.71702380,
    0.26336230,
    0.01961390,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 13)] = [
    0.71685670,
    0.26355490,
    0.01958840,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 14)] = [
    0.71660260,
    0.26376130,
    0.01963610,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 15)] = [
    0.71693040,
    0.26348760,
    0.01958200,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 16)] = [
    0.71661990,
    0.26378100,
    0.01959910,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 17)] = [
    0.71671550,
    0.26370580,
    0.01957870,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 18)] = [
    0.71737430,
    0.26301440,
    0.01961130,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 19)] = [
    0.71705840,
    0.26343640,
    0.01950520,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 20)] = [
    0.71723990,
    0.26319620,
    0.01956390,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 21)] = [
    0.71766620,
    0.26295600,
    0.01937780,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 22)] = [
    0.71770920,
    0.26282360,
    0.01946720,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 23)] = [
    0.71776160,
    0.26276720,
    0.01947120,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 24)] = [
    0.71812840,
    0.26259950,
    0.01927210,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 25)] = [
    0.71887660,
    0.26184760,
    0.01927580,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 26)] = [
    0.71939740,
    0.26139460,
    0.01920800,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 27)] = [
    0.71942910,
    0.26141100,
    0.01915990,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 28)] = [
    0.71987470,
    0.26101350,
    0.01911180,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 29)] = [
    0.72034600,
    0.26060890,
    0.01904510,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 30)] = [
    0.72090060,
    0.26014590,
    0.01895350,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 31)] = [
    0.72117040,
    0.25989120,
    0.01893840,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 32)] = [
    0.72145520,
    0.25960710,
    0.01893770,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 33)] = [
    0.72193150,
    0.25920230,
    0.01886620,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 34)] = [
    0.72279520,
    0.25851690,
    0.01868790,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 35)] = [
    0.72300660,
    0.25836660,
    0.01862680,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 36)] = [
    0.72377040,
    0.25774110,
    0.01848850,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 37)] = [
    0.72417720,
    0.25732690,
    0.01849590,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 38)] = [
    0.72495340,
    0.25666380,
    0.01838280,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 0)] = [
    0.67704400,
    0.29604520,
    0.02691080,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 1)] = [
    0.67702350,
    0.29608320,
    0.02689330,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 2)] = [
    0.67742040,
    0.29572380,
    0.02685580,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 3)] = [
    0.67696460,
    0.29615860,
    0.02687680,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 4)] = [
    0.67715670,
    0.29588950,
    0.02695380,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 5)] = [
    0.67682100,
    0.29635230,
    0.02682670,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 6)] = [
    0.67627690,
    0.29671660,
    0.02700650,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 7)] = [
    0.67565570,
    0.29721030,
    0.02713400,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 8)] = [
    0.67537270,
    0.29741440,
    0.02721290,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 9)] = [
    0.67522620,
    0.29756900,
    0.02720480,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 10)] = [
    0.67485860,
    0.29782120,
    0.02732020,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 11)] = [
    0.67484810,
    0.29774390,
    0.02740800,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 12)] = [
    0.67464910,
    0.29801200,
    0.02733890,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 13)] = [
    0.67454370,
    0.29803010,
    0.02742620,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 14)] = [
    0.67439950,
    0.29818410,
    0.02741640,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 15)] = [
    0.67439690,
    0.29814780,
    0.02745530,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 16)] = [
    0.67444220,
    0.29818810,
    0.02736970,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 17)] = [
    0.67433330,
    0.29825290,
    0.02741380,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 18)] = [
    0.67442210,
    0.29816910,
    0.02740880,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 19)] = [
    0.67482000,
    0.29777120,
    0.02740880,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 20)] = [
    0.67469910,
    0.29792050,
    0.02738040,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 21)] = [
    0.67499360,
    0.29772030,
    0.02728610,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 22)] = [
    0.67523500,
    0.29751290,
    0.02725210,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 23)] = [
    0.67578780,
    0.29713650,
    0.02707570,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 24)] = [
    0.67582610,
    0.29696550,
    0.02720840,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 25)] = [
    0.67634150,
    0.29665050,
    0.02700800,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 26)] = [
    0.67678600,
    0.29624770,
    0.02696630,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 27)] = [
    0.67708510,
    0.29598600,
    0.02692890,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 28)] = [
    0.67739320,
    0.29577230,
    0.02683450,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 29)] = [
    0.67822130,
    0.29511420,
    0.02666450,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 30)] = [
    0.67850690,
    0.29487620,
    0.02661690,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 31)] = [
    0.67914750,
    0.29431240,
    0.02654010,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 32)] = [
    0.67941000,
    0.29413890,
    0.02645110,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 33)] = [
    0.67997620,
    0.29369210,
    0.02633170,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 34)] = [
    0.68064480,
    0.29316890,
    0.02618630,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 35)] = [
    0.68111380,
    0.29273790,
    0.02614830,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 36)] = [
    0.68129180,
    0.29269820,
    0.02601000,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 37)] = [
    0.68214490,
    0.29186680,
    0.02598830,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 38)] = [
    0.68307470,
    0.29115430,
    0.02577100,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 0)] = [
    0.53888530,
    0.38203420,
    0.07507760,
    0.00400290,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 1)] = [
    0.52592310,
    0.38923430,
    0.08033040,
    0.00451220,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 2)] = [
    0.51358690,
    0.39614320,
    0.08526850,
    0.00500140,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 3)] = [
    0.50195470,
    0.40235720,
    0.09014780,
    0.00554030,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 4)] = [
    0.49061030,
    0.40788390,
    0.09538950,
    0.00611630,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 5)] = [
    0.47883140,
    0.41444150,
    0.10013950,
    0.00658760,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 6)] = [
    0.47358400,
    0.41764100,
    0.10206580,
    0.00670920,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 7)] = [
    0.47409240,
    0.41825260,
    0.10115260,
    0.00650240,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 8)] = [
    0.48111860,
    0.41450010,
    0.09815320,
    0.00622810,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 9)] = [
    0.48784490,
    0.41117060,
    0.09512480,
    0.00585970,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 10)] = [
    0.49468260,
    0.40746010,
    0.09223030,
    0.00562700,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 11)] = [
    0.50098000,
    0.40425960,
    0.08947370,
    0.00528670,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 12)] = [
    0.50801300,
    0.40008230,
    0.08685810,
    0.00504660,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 13)] = [
    0.51399010,
    0.39700950,
    0.08424320,
    0.00475720,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 14)] = [
    0.52043610,
    0.39318190,
    0.08181540,
    0.00456660,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 15)] = [
    0.52647530,
    0.38972100,
    0.07947080,
    0.00433290,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 16)] = [
    0.53257650,
    0.38615110,
    0.07713800,
    0.00413440,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 17)] = [
    0.53861380,
    0.38243760,
    0.07499570,
    0.00395290,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 18)] = [
    0.54462970,
    0.37881780,
    0.07281560,
    0.00373690,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 19)] = [
    0.55031120,
    0.37536880,
    0.07074690,
    0.00357310,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 20)] = [
    0.55537410,
    0.37234250,
    0.06889480,
    0.00338860,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 21)] = [
    0.56104140,
    0.36877820,
    0.06692190,
    0.00325850,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 22)] = [
    0.56666310,
    0.36507450,
    0.06513220,
    0.00313020,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 23)] = [
    0.57227010,
    0.36152810,
    0.06324450,
    0.00295730,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 24)] = [
    0.57725600,
    0.35838330,
    0.06153610,
    0.00282460,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 25)] = [
    0.58228160,
    0.35509190,
    0.05991250,
    0.00271400,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 26)] = [
    0.58725610,
    0.35177270,
    0.05836080,
    0.00261040,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 27)] = [
    0.59185200,
    0.34872020,
    0.05695190,
    0.00247590,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 28)] = [
    0.59658090,
    0.34563210,
    0.05540050,
    0.00238650,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 29)] = [
    0.60174260,
    0.34194490,
    0.05398960,
    0.00232290,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 30)] = [
    0.60615000,
    0.33913820,
    0.05251370,
    0.00219810,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 31)] = [
    0.61048630,
    0.33612150,
    0.05130540,
    0.00208680,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 32)] = [
    0.61516310,
    0.33303790,
    0.04976980,
    0.00202920,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 33)] = [
    0.61905750,
    0.33025750,
    0.04873160,
    0.00195340,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 34)] = [
    0.62376340,
    0.32687380,
    0.04748430,
    0.00187850,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 35)] = [
    0.62752980,
    0.32415850,
    0.04651450,
    0.00179720,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 36)] = [
    0.63158520,
    0.32132200,
    0.04536200,
    0.00173080,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 37)] = [
    0.63542900,
    0.31868780,
    0.04421720,
    0.00166600,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 0)] = [
    0.60593190,
    0.34054020,
    0.05150570,
    0.00202220,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 1)] = [
    0.60614630,
    0.34024800,
    0.05154310,
    0.00206260,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 2)] = [
    0.60561150,
    0.34067340,
    0.05169630,
    0.00201880,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 3)] = [
    0.60539550,
    0.34099090,
    0.05160530,
    0.00200830,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 4)] = [
    0.60555090,
    0.34069910,
    0.05169820,
    0.00205180,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 5)] = [
    0.60473150,
    0.34128100,
    0.05194900,
    0.00203850,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 6)] = [
    0.60458170,
    0.34144280,
    0.05192510,
    0.00205040,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 7)] = [
    0.60399840,
    0.34173720,
    0.05220500,
    0.00205940,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 8)] = [
    0.60355190,
    0.34212960,
    0.05225390,
    0.00206460,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 9)] = [
    0.60315480,
    0.34239160,
    0.05238870,
    0.00206490,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 10)] = [
    0.60303410,
    0.34242180,
    0.05246800,
    0.00207610,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 11)] = [
    0.60279250,
    0.34264260,
    0.05248770,
    0.00207720,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 12)] = [
    0.60271370,
    0.34261180,
    0.05257140,
    0.00210310,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 13)] = [
    0.60237020,
    0.34308350,
    0.05247180,
    0.00207450,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 14)] = [
    0.60236750,
    0.34292680,
    0.05261950,
    0.00208620,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 15)] = [
    0.60259760,
    0.34280210,
    0.05249380,
    0.00210650,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 16)] = [
    0.60238500,
    0.34296040,
    0.05258500,
    0.00206960,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 17)] = [
    0.60280900,
    0.34251770,
    0.05258250,
    0.00209080,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 18)] = [
    0.60291190,
    0.34255910,
    0.05246220,
    0.00206680,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 19)] = [
    0.60305440,
    0.34239110,
    0.05248260,
    0.00207190,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 20)] = [
    0.60366920,
    0.34199220,
    0.05226570,
    0.00207290,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 21)] = [
    0.60356550,
    0.34220550,
    0.05217240,
    0.00205660,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 22)] = [
    0.60429480,
    0.34164740,
    0.05199150,
    0.00206630,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 23)] = [
    0.60435620,
    0.34162150,
    0.05196470,
    0.00205760,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 24)] = [
    0.60486170,
    0.34128840,
    0.05181620,
    0.00203370,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 25)] = [
    0.60521690,
    0.34102920,
    0.05171860,
    0.00203530,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 26)] = [
    0.60574040,
    0.34071350,
    0.05152120,
    0.00202490,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 27)] = [
    0.60626010,
    0.34024110,
    0.05146940,
    0.00202940,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 28)] = [
    0.60671580,
    0.33994740,
    0.05132840,
    0.00200840,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 29)] = [
    0.60754180,
    0.33940540,
    0.05103880,
    0.00201400,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 30)] = [
    0.60784400,
    0.33919580,
    0.05096730,
    0.00199290,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 31)] = [
    0.60857320,
    0.33864470,
    0.05082230,
    0.00195980,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 32)] = [
    0.60928370,
    0.33822780,
    0.05052730,
    0.00196120,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 33)] = [
    0.61001560,
    0.33761950,
    0.05040580,
    0.00195910,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 34)] = [
    0.61041900,
    0.33742030,
    0.05022100,
    0.00193970,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 35)] = [
    0.61136290,
    0.33676360,
    0.04995120,
    0.00192230,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 36)] = [
    0.61196300,
    0.33631610,
    0.04982160,
    0.00189930,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 37)] = [
    0.61245350,
    0.33590860,
    0.04973550,
    0.00190240,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 0)] = [
    0.55245920,
    0.37376710,
    0.07025960,
    0.00351410,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 1)] = [
    0.55235850,
    0.37405080,
    0.07004750,
    0.00354320,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 2)] = [
    0.55255770,
    0.37374590,
    0.07016230,
    0.00353410,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 3)] = [
    0.55229440,
    0.37405330,
    0.07010390,
    0.00354840,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 4)] = [
    0.55190160,
    0.37427850,
    0.07028510,
    0.00353480,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 5)] = [
    0.55159370,
    0.37446570,
    0.07040130,
    0.00353930,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 6)] = [
    0.55091680,
    0.37489550,
    0.07062520,
    0.00356250,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 7)] = [
    0.55063020,
    0.37510100,
    0.07067220,
    0.00359660,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 8)] = [
    0.55027520,
    0.37537210,
    0.07073090,
    0.00362180,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 9)] = [
    0.54966440,
    0.37570400,
    0.07103370,
    0.00359790,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 10)] = [
    0.54942480,
    0.37586750,
    0.07108390,
    0.00362380,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 11)] = [
    0.54921110,
    0.37615430,
    0.07102370,
    0.00361090,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 12)] = [
    0.54921340,
    0.37574810,
    0.07138950,
    0.00364900,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 13)] = [
    0.54871000,
    0.37617210,
    0.07148820,
    0.00362970,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 14)] = [
    0.54896940,
    0.37605420,
    0.07133440,
    0.00364200,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 15)] = [
    0.54855870,
    0.37630180,
    0.07149260,
    0.00364690,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 16)] = [
    0.54894860,
    0.37608490,
    0.07130820,
    0.00365830,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 17)] = [
    0.54922510,
    0.37584640,
    0.07125430,
    0.00367420,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 18)] = [
    0.54941120,
    0.37575310,
    0.07120830,
    0.00362740,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 19)] = [
    0.54950520,
    0.37564740,
    0.07123180,
    0.00361560,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 20)] = [
    0.54975740,
    0.37561000,
    0.07099950,
    0.00363310,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 21)] = [
    0.55028730,
    0.37531020,
    0.07078960,
    0.00361290,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 22)] = [
    0.55050630,
    0.37519090,
    0.07068560,
    0.00361720,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 23)] = [
    0.55069010,
    0.37489390,
    0.07082050,
    0.00359550,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 24)] = [
    0.55113410,
    0.37475690,
    0.07055780,
    0.00355120,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 25)] = [
    0.55163200,
    0.37448100,
    0.07032400,
    0.00356300,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 26)] = [
    0.55208570,
    0.37418000,
    0.07020880,
    0.00352550,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 27)] = [
    0.55282250,
    0.37377290,
    0.06985770,
    0.00354690,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 28)] = [
    0.55312010,
    0.37349900,
    0.06987350,
    0.00350740,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 29)] = [
    0.55372080,
    0.37324150,
    0.06954440,
    0.00349330,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 30)] = [
    0.55468560,
    0.37270130,
    0.06911240,
    0.00350070,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 31)] = [
    0.55493630,
    0.37234120,
    0.06925130,
    0.00347120,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 32)] = [
    0.55594060,
    0.37167490,
    0.06897820,
    0.00340630,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 33)] = [
    0.55646130,
    0.37147780,
    0.06864330,
    0.00341760,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 34)] = [
    0.55703250,
    0.37110450,
    0.06844920,
    0.00341380,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 35)] = [
    0.55771930,
    0.37064670,
    0.06821500,
    0.00341900,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 36)] = [
    0.55847630,
    0.37027340,
    0.06791650,
    0.00333380,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 37)] = [
    0.55916190,
    0.36985570,
    0.06766600,
    0.00331640,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 0)] = [
    0.42608160,
    0.42547490,
    0.13298380,
    0.01496630,
    0.00049340,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 1)] = [
    0.41257780,
    0.42978620,
    0.14040670,
    0.01663830,
    0.00059100,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 2)] = [
    0.39948180,
    0.43349920,
    0.14802530,
    0.01830210,
    0.00069160,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 3)] = [
    0.38709120,
    0.43654490,
    0.15543680,
    0.02015430,
    0.00077280,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 4)] = [
    0.37434390,
    0.44051180,
    0.16248990,
    0.02180270,
    0.00085170,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 5)] = [
    0.36662290,
    0.44285270,
    0.16704210,
    0.02258410,
    0.00089820,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 6)] = [
    0.36450480,
    0.44397530,
    0.16792550,
    0.02269930,
    0.00089510,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 7)] = [
    0.36628820,
    0.44452860,
    0.16616830,
    0.02216290,
    0.00085200,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 8)] = [
    0.37358210,
    0.44286350,
    0.16182160,
    0.02094380,
    0.00078900,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 9)] = [
    0.38123870,
    0.44076560,
    0.15732370,
    0.01995800,
    0.00071400,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 10)] = [
    0.38835760,
    0.43872480,
    0.15316690,
    0.01906350,
    0.00068720,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 11)] = [
    0.39522740,
    0.43683840,
    0.14914730,
    0.01815590,
    0.00063100,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 12)] = [
    0.40248870,
    0.43434780,
    0.14524310,
    0.01733650,
    0.00058390,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 13)] = [
    0.40919080,
    0.43231550,
    0.14139170,
    0.01654870,
    0.00055330,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 14)] = [
    0.41605860,
    0.43018020,
    0.13757640,
    0.01565210,
    0.00053270,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 15)] = [
    0.42265930,
    0.42781320,
    0.13395610,
    0.01508250,
    0.00048890,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 16)] = [
    0.42949160,
    0.42522460,
    0.13056820,
    0.01425510,
    0.00046050,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 17)] = [
    0.43580150,
    0.42289440,
    0.12715310,
    0.01373290,
    0.00041810,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 18)] = [
    0.44196350,
    0.42046600,
    0.12400450,
    0.01316770,
    0.00039830,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 19)] = [
    0.44865000,
    0.41771080,
    0.12077140,
    0.01248560,
    0.00038220,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 20)] = [
    0.45460640,
    0.41538130,
    0.11769320,
    0.01197070,
    0.00034840,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 21)] = [
    0.46062850,
    0.41270770,
    0.11489550,
    0.01143760,
    0.00033070,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 22)] = [
    0.46670160,
    0.40992610,
    0.11208290,
    0.01097870,
    0.00031070,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 23)] = [
    0.47293440,
    0.40731510,
    0.10895870,
    0.01050330,
    0.00028850,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 24)] = [
    0.47828160,
    0.40502440,
    0.10634330,
    0.01007200,
    0.00027870,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 25)] = [
    0.48417920,
    0.40200270,
    0.10393990,
    0.00962140,
    0.00025680,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 26)] = [
    0.48962430,
    0.39943100,
    0.10146760,
    0.00923300,
    0.00024410,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 27)] = [
    0.49515340,
    0.39683190,
    0.09898700,
    0.00879230,
    0.00023540,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 28)] = [
    0.50101300,
    0.39368660,
    0.09666070,
    0.00842260,
    0.00021710,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 29)] = [
    0.50588840,
    0.39156230,
    0.09422420,
    0.00811690,
    0.00020820,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 30)] = [
    0.51085930,
    0.38892140,
    0.09222410,
    0.00779750,
    0.00019770,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 31)] = [
    0.51631510,
    0.38595650,
    0.09004030,
    0.00750130,
    0.00018680,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 32)] = [
    0.52142450,
    0.38331450,
    0.08784790,
    0.00724470,
    0.00016840,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 33)] = [
    0.52609400,
    0.38076700,
    0.08601450,
    0.00696620,
    0.00015830,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 34)] = [
    0.53120110,
    0.37800900,
    0.08390940,
    0.00672400,
    0.00015650,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 35)] = [
    0.53540790,
    0.37586800,
    0.08211190,
    0.00646090,
    0.00015130,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 36)] = [
    0.53999220,
    0.37327050,
    0.08040940,
    0.00618780,
    0.00014010,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 0)] = [
    0.50762080,
    0.39287450,
    0.09196890,
    0.00737690,
    0.00015890,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 1)] = [
    0.50771860,
    0.39275160,
    0.09198050,
    0.00738720,
    0.00016210,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 2)] = [
    0.50728850,
    0.39308410,
    0.09199450,
    0.00747070,
    0.00016220,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 3)] = [
    0.50697100,
    0.39318930,
    0.09219340,
    0.00748470,
    0.00016160,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 4)] = [
    0.50671120,
    0.39337670,
    0.09226080,
    0.00748570,
    0.00016560,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 5)] = [
    0.50628000,
    0.39330880,
    0.09275200,
    0.00749350,
    0.00016570,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 6)] = [
    0.50594130,
    0.39359120,
    0.09279040,
    0.00751260,
    0.00016450,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 7)] = [
    0.50536230,
    0.39389890,
    0.09300740,
    0.00756990,
    0.00016150,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 8)] = [
    0.50458960,
    0.39442830,
    0.09325010,
    0.00756090,
    0.00017110,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 9)] = [
    0.50438930,
    0.39442660,
    0.09338710,
    0.00762820,
    0.00016880,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 10)] = [
    0.50412000,
    0.39459950,
    0.09351370,
    0.00759500,
    0.00017180,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 11)] = [
    0.50380840,
    0.39470760,
    0.09367940,
    0.00762950,
    0.00017510,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 12)] = [
    0.50366140,
    0.39483840,
    0.09371660,
    0.00761460,
    0.00016900,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 13)] = [
    0.50382710,
    0.39463400,
    0.09371860,
    0.00765160,
    0.00016870,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 14)] = [
    0.50385630,
    0.39477770,
    0.09354860,
    0.00764900,
    0.00016840,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 15)] = [
    0.50371540,
    0.39481940,
    0.09365100,
    0.00764420,
    0.00017000,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 16)] = [
    0.50403080,
    0.39463200,
    0.09355480,
    0.00760770,
    0.00017470,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 17)] = [
    0.50413380,
    0.39460190,
    0.09345960,
    0.00763950,
    0.00016520,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 18)] = [
    0.50416990,
    0.39455700,
    0.09345330,
    0.00764670,
    0.00017310,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 19)] = [
    0.50478980,
    0.39423200,
    0.09326480,
    0.00755260,
    0.00016080,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 20)] = [
    0.50523260,
    0.39400030,
    0.09308420,
    0.00750870,
    0.00017420,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 21)] = [
    0.50526450,
    0.39424510,
    0.09276850,
    0.00754510,
    0.00017680,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 22)] = [
    0.50602910,
    0.39355400,
    0.09270500,
    0.00753970,
    0.00017220,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 23)] = [
    0.50634370,
    0.39340550,
    0.09259680,
    0.00748960,
    0.00016440,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 24)] = [
    0.50676680,
    0.39320930,
    0.09241230,
    0.00744770,
    0.00016390,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 25)] = [
    0.50749280,
    0.39283640,
    0.09199210,
    0.00751270,
    0.00016600,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 26)] = [
    0.50805790,
    0.39244800,
    0.09189090,
    0.00743760,
    0.00016560,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 27)] = [
    0.50846130,
    0.39228670,
    0.09169590,
    0.00739300,
    0.00016310,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 28)] = [
    0.50923140,
    0.39170670,
    0.09155580,
    0.00734510,
    0.00016100,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 29)] = [
    0.51004810,
    0.39139520,
    0.09108470,
    0.00731230,
    0.00015970,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 30)] = [
    0.51020000,
    0.39141530,
    0.09094620,
    0.00727820,
    0.00016030,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 31)] = [
    0.51110750,
    0.39091230,
    0.09062010,
    0.00720590,
    0.00015420,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 32)] = [
    0.51192070,
    0.39049470,
    0.09028420,
    0.00713830,
    0.00016210,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 33)] = [
    0.51267510,
    0.39013650,
    0.08987630,
    0.00715230,
    0.00015980,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 34)] = [
    0.51333690,
    0.38985780,
    0.08958130,
    0.00707140,
    0.00015260,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 35)] = [
    0.51409190,
    0.38941350,
    0.08924850,
    0.00708990,
    0.00015620,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 36)] = [
    0.51483860,
    0.38900670,
    0.08896530,
    0.00703500,
    0.00015440,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 0)] = [
    0.44810420,
    0.41753230,
    0.12136090,
    0.01262270,
    0.00037990,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 1)] = [
    0.44823870,
    0.41764120,
    0.12121240,
    0.01251580,
    0.00039190,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 2)] = [
    0.44807540,
    0.41768340,
    0.12127900,
    0.01258290,
    0.00037930,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 3)] = [
    0.44776240,
    0.41790430,
    0.12136580,
    0.01259530,
    0.00037220,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 4)] = [
    0.44750110,
    0.41784960,
    0.12155740,
    0.01271710,
    0.00037480,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 5)] = [
    0.44656390,
    0.41861070,
    0.12167200,
    0.01276240,
    0.00039100,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 6)] = [
    0.44633190,
    0.41844670,
    0.12206390,
    0.01277040,
    0.00038710,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 7)] = [
    0.44570090,
    0.41863620,
    0.12241820,
    0.01285420,
    0.00039050,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 8)] = [
    0.44531710,
    0.41878980,
    0.12261660,
    0.01288120,
    0.00039530,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 9)] = [
    0.44472390,
    0.41917720,
    0.12279680,
    0.01289930,
    0.00040280,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 10)] = [
    0.44481130,
    0.41891080,
    0.12298740,
    0.01289710,
    0.00039340,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 11)] = [
    0.44419900,
    0.41944960,
    0.12299840,
    0.01295340,
    0.00039960,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 12)] = [
    0.44430300,
    0.41900280,
    0.12333210,
    0.01297500,
    0.00038710,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 13)] = [
    0.44394020,
    0.41943750,
    0.12324370,
    0.01298640,
    0.00039220,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 14)] = [
    0.44378990,
    0.41967740,
    0.12315980,
    0.01297970,
    0.00039320,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 15)] = [
    0.44401510,
    0.41931970,
    0.12327920,
    0.01298470,
    0.00040130,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 16)] = [
    0.44400360,
    0.41937330,
    0.12317350,
    0.01304570,
    0.00040390,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 17)] = [
    0.44439630,
    0.41916990,
    0.12311910,
    0.01291300,
    0.00040170,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 18)] = [
    0.44465890,
    0.41879750,
    0.12322220,
    0.01291220,
    0.00040920,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 19)] = [
    0.44515240,
    0.41908740,
    0.12245170,
    0.01291940,
    0.00038910,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 20)] = [
    0.44519230,
    0.41886890,
    0.12259130,
    0.01295210,
    0.00039540,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 21)] = [
    0.44574370,
    0.41863300,
    0.12234510,
    0.01288170,
    0.00039650,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 22)] = [
    0.44574710,
    0.41885430,
    0.12221320,
    0.01279380,
    0.00039160,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 23)] = [
    0.44617250,
    0.41863670,
    0.12206610,
    0.01273990,
    0.00038480,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 24)] = [
    0.44684240,
    0.41828360,
    0.12178790,
    0.01270940,
    0.00037670,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 25)] = [
    0.44764480,
    0.41794460,
    0.12140660,
    0.01261560,
    0.00038840,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 26)] = [
    0.44839720,
    0.41753850,
    0.12100250,
    0.01266810,
    0.00039370,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 27)] = [
    0.44871360,
    0.41756550,
    0.12077240,
    0.01255650,
    0.00039200,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 28)] = [
    0.44948420,
    0.41704400,
    0.12057520,
    0.01251410,
    0.00038250,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 29)] = [
    0.45004140,
    0.41695780,
    0.12017290,
    0.01246880,
    0.00035910,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 30)] = [
    0.45075450,
    0.41674340,
    0.11977900,
    0.01234630,
    0.00037680,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 31)] = [
    0.45140980,
    0.41626360,
    0.11963300,
    0.01232650,
    0.00036710,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 32)] = [
    0.45214830,
    0.41600640,
    0.11921850,
    0.01225510,
    0.00037170,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 33)] = [
    0.45267330,
    0.41597570,
    0.11879040,
    0.01219040,
    0.00037020,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 34)] = [
    0.45354670,
    0.41557580,
    0.11843130,
    0.01209070,
    0.00035550,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 35)] = [
    0.45452270,
    0.41521950,
    0.11782770,
    0.01208660,
    0.00034350,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 36)] = [
    0.45528720,
    0.41486240,
    0.11748330,
    0.01201460,
    0.00035250,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 0
    ..sample = 7
    ..position = 0)] = [
    0.01268150,
    0.08994360,
    0.24205600,
    0.32274120,
    0.22915350,
    0.08645340,
    0.01587920,
    0.00109160
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 0
    ..sample = 7
    ..position = 1)] = [
    0.01223270,
    0.08759720,
    0.23960600,
    0.32331330,
    0.23196580,
    0.08800310,
    0.01616640,
    0.00111550
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 0
    ..sample = 7
    ..position = 2)] = [
    0.01195860,
    0.08672070,
    0.23859440,
    0.32421350,
    0.23296700,
    0.08824730,
    0.01619700,
    0.00110150
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 0
    ..sample = 7
    ..position = 3)] = [
    0.01193490,
    0.08658780,
    0.23949370,
    0.32464420,
    0.23284670,
    0.08755010,
    0.01587130,
    0.00107130
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 0
    ..sample = 7
    ..position = 4)] = [
    0.01204190,
    0.08786360,
    0.24188710,
    0.32548270,
    0.23058580,
    0.08584230,
    0.01528730,
    0.00100930
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 0
    ..sample = 7
    ..position = 5)] = [
    0.01249180,
    0.09015220,
    0.24527040,
    0.32642220,
    0.22731850,
    0.08294830,
    0.01446100,
    0.00093560
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 0
    ..sample = 7
    ..position = 6)] = [
    0.01315750,
    0.09360490,
    0.25085130,
    0.32645890,
    0.22238010,
    0.07922260,
    0.01348460,
    0.00084010
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 0
    ..sample = 7
    ..position = 7)] = [
    0.01404330,
    0.09837130,
    0.25734820,
    0.32619640,
    0.21617570,
    0.07472410,
    0.01238680,
    0.00075420
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 0
    ..sample = 7
    ..position = 8)] = [
    0.01563370,
    0.10489190,
    0.26462830,
    0.32454850,
    0.20854740,
    0.06990270,
    0.01118810,
    0.00065940
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 0
    ..sample = 7
    ..position = 9)] = [
    0.01722930,
    0.11138780,
    0.27189510,
    0.32272460,
    0.20072260,
    0.06527670,
    0.01018820,
    0.00057570
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 0
    ..sample = 7
    ..position = 10)] = [
    0.01889650,
    0.11806000,
    0.27848740,
    0.32051100,
    0.19326060,
    0.06098680,
    0.00928320,
    0.00051450
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 0
    ..sample = 7
    ..position = 11)] = [
    0.02072090,
    0.12503630,
    0.28479470,
    0.31738520,
    0.18602060,
    0.05712150,
    0.00845630,
    0.00046450
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 0
    ..sample = 7
    ..position = 12)] = [
    0.02238780,
    0.13157850,
    0.29116620,
    0.31450780,
    0.17908630,
    0.05322310,
    0.00764060,
    0.00040970
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 0
    ..sample = 7
    ..position = 13)] = [
    0.02434090,
    0.13821250,
    0.29671350,
    0.31135800,
    0.17223480,
    0.04980710,
    0.00697660,
    0.00035660
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 0
    ..sample = 7
    ..position = 14)] = [
    0.02645750,
    0.14497700,
    0.30183810,
    0.30781620,
    0.16548510,
    0.04671760,
    0.00637560,
    0.00033290
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 0
    ..sample = 7
    ..position = 15)] = [
    0.02837400,
    0.15167840,
    0.30656480,
    0.30429090,
    0.15921890,
    0.04379300,
    0.00579230,
    0.00028770
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 0
    ..sample = 7
    ..position = 16)] = [
    0.03070210,
    0.15838270,
    0.31123510,
    0.30041450,
    0.15283380,
    0.04088930,
    0.00529510,
    0.00024740
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 0
    ..sample = 7
    ..position = 17)] = [
    0.03281460,
    0.16497590,
    0.31552310,
    0.29623600,
    0.14699770,
    0.03838320,
    0.00484800,
    0.00022150
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 0
    ..sample = 7
    ..position = 18)] = [
    0.03500360,
    0.17151270,
    0.31964920,
    0.29204860,
    0.14125840,
    0.03591420,
    0.00441750,
    0.00019580
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 0
    ..sample = 7
    ..position = 19)] = [
    0.03745470,
    0.17816830,
    0.32313750,
    0.28785040,
    0.13563080,
    0.03353980,
    0.00403890,
    0.00017960
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 0
    ..sample = 7
    ..position = 20)] = [
    0.03983970,
    0.18472600,
    0.32630760,
    0.28350060,
    0.13022340,
    0.03152770,
    0.00371260,
    0.00016240
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 0
    ..sample = 7
    ..position = 21)] = [
    0.04233280,
    0.19142080,
    0.32901540,
    0.27893100,
    0.12507140,
    0.02969930,
    0.00338510,
    0.00014420
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 0
    ..sample = 7
    ..position = 22)] = [
    0.04470090,
    0.19762080,
    0.33200010,
    0.27451960,
    0.12021890,
    0.02768510,
    0.00312380,
    0.00013080
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 0
    ..sample = 7
    ..position = 23)] = [
    0.04738570,
    0.20390850,
    0.33423720,
    0.26987740,
    0.11561990,
    0.02602420,
    0.00283290,
    0.00011420
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 0
    ..sample = 7
    ..position = 24)] = [
    0.05023150,
    0.21038970,
    0.33581770,
    0.26531330,
    0.11101410,
    0.02449680,
    0.00263220,
    0.00010470
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 0
    ..sample = 7
    ..position = 25)] = [
    0.05275170,
    0.21637890,
    0.33812210,
    0.26062330,
    0.10659870,
    0.02302630,
    0.00240840,
    0.00009060
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 6
    ..position = 0)] = [
    0.04533340,
    0.20576810,
    0.34527230,
    0.27415590,
    0.10816280,
    0.01995860,
    0.00134890
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 6
    ..position = 1)] = [
    0.04524730,
    0.20536280,
    0.34527080,
    0.27441210,
    0.10835980,
    0.01999260,
    0.00135460
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 6
    ..position = 2)] = [
    0.04526500,
    0.20515260,
    0.34503340,
    0.27451480,
    0.10860370,
    0.02007880,
    0.00135170
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 6
    ..position = 3)] = [
    0.04504050,
    0.20500540,
    0.34488590,
    0.27481450,
    0.10873110,
    0.02016240,
    0.00136020
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 6
    ..position = 4)] = [
    0.04496210,
    0.20446770,
    0.34514570,
    0.27483280,
    0.10898300,
    0.02025550,
    0.00135320
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 6
    ..position = 5)] = [
    0.04479960,
    0.20397160,
    0.34483010,
    0.27561890,
    0.10911300,
    0.02029100,
    0.00137580
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 6
    ..position = 6)] = [
    0.04458030,
    0.20406780,
    0.34473900,
    0.27558040,
    0.10932390,
    0.02033990,
    0.00136870
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 6
    ..position = 7)] = [
    0.04463150,
    0.20409750,
    0.34463120,
    0.27541420,
    0.10941630,
    0.02040900,
    0.00140030
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 6
    ..position = 8)] = [
    0.04453630,
    0.20370950,
    0.34481460,
    0.27563980,
    0.10952910,
    0.02040620,
    0.00136450
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 6
    ..position = 9)] = [
    0.04464020,
    0.20372020,
    0.34476440,
    0.27564450,
    0.10947380,
    0.02037460,
    0.00138230
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 6
    ..position = 10)] = [
    0.04469670,
    0.20413010,
    0.34459670,
    0.27547470,
    0.10940080,
    0.02030810,
    0.00139290
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 6
    ..position = 11)] = [
    0.04463010,
    0.20419330,
    0.34484230,
    0.27556500,
    0.10913920,
    0.02024900,
    0.00138110
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 6
    ..position = 12)] = [
    0.04482210,
    0.20425620,
    0.34484020,
    0.27535540,
    0.10903660,
    0.02030890,
    0.00138060
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 6
    ..position = 13)] = [
    0.04488830,
    0.20458490,
    0.34508480,
    0.27499030,
    0.10886150,
    0.02022340,
    0.00136680
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 6
    ..position = 14)] = [
    0.04508260,
    0.20491670,
    0.34491180,
    0.27481370,
    0.10884280,
    0.02007310,
    0.00135930
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 6
    ..position = 15)] = [
    0.04520380,
    0.20532590,
    0.34519560,
    0.27468400,
    0.10825700,
    0.01998020,
    0.00135350
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 6
    ..position = 16)] = [
    0.04538040,
    0.20596330,
    0.34517140,
    0.27425240,
    0.10795170,
    0.01993830,
    0.00134250
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 6
    ..position = 17)] = [
    0.04564490,
    0.20630940,
    0.34551790,
    0.27358380,
    0.10776480,
    0.01983520,
    0.00134400
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 6
    ..position = 18)] = [
    0.04572700,
    0.20712160,
    0.34562670,
    0.27335490,
    0.10719200,
    0.01966690,
    0.00131090
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 6
    ..position = 19)] = [
    0.04608480,
    0.20739150,
    0.34585050,
    0.27296420,
    0.10680060,
    0.01961490,
    0.00129350
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 6
    ..position = 20)] = [
    0.04628270,
    0.20830140,
    0.34620520,
    0.27206860,
    0.10638630,
    0.01944670,
    0.00130910
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 6
    ..position = 21)] = [
    0.04661560,
    0.20856460,
    0.34649650,
    0.27188200,
    0.10583840,
    0.01931600,
    0.00128690
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 6
    ..position = 22)] = [
    0.04687950,
    0.20971010,
    0.34673560,
    0.27098060,
    0.10529920,
    0.01912900,
    0.00126600
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 6
    ..position = 23)] = [
    0.04733030,
    0.21044530,
    0.34655480,
    0.27055100,
    0.10480360,
    0.01906310,
    0.00125190
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 6
    ..position = 24)] = [
    0.04752000,
    0.21122350,
    0.34713500,
    0.26977150,
    0.10424650,
    0.01886770,
    0.00123580
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 6
    ..position = 25)] = [
    0.04780080,
    0.21181000,
    0.34764640,
    0.26911780,
    0.10376000,
    0.01862680,
    0.00123820
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 7
    ..position = 0)] = [
    0.02542900,
    0.14079550,
    0.29807990,
    0.30936470,
    0.16995270,
    0.04916610,
    0.00685740,
    0.00035470
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 7
    ..position = 1)] = [
    0.02527570,
    0.14053450,
    0.29786470,
    0.30961180,
    0.17020120,
    0.04927430,
    0.00688900,
    0.00034880
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 7
    ..position = 2)] = [
    0.02513680,
    0.14042730,
    0.29728770,
    0.30983410,
    0.17062980,
    0.04939300,
    0.00692420,
    0.00036710
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 7
    ..position = 3)] = [
    0.02515440,
    0.13982450,
    0.29737580,
    0.31001770,
    0.17072380,
    0.04958200,
    0.00695960,
    0.00036220
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 7
    ..position = 4)] = [
    0.02502970,
    0.13995400,
    0.29695150,
    0.31007860,
    0.17098590,
    0.04963490,
    0.00699880,
    0.00036660
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 7
    ..position = 5)] = [
    0.02498230,
    0.13956460,
    0.29700630,
    0.31015720,
    0.17123780,
    0.04972050,
    0.00696710,
    0.00036420
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 7
    ..position = 6)] = [
    0.02491620,
    0.13939510,
    0.29674920,
    0.31018570,
    0.17152900,
    0.04987820,
    0.00698340,
    0.00036320
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 7
    ..position = 7)] = [
    0.02486810,
    0.13926440,
    0.29665400,
    0.31042860,
    0.17152670,
    0.04987090,
    0.00703620,
    0.00035110
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 7
    ..position = 8)] = [
    0.02479850,
    0.13940740,
    0.29666240,
    0.31021540,
    0.17153970,
    0.04995370,
    0.00705200,
    0.00037090
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 7
    ..position = 9)] = [
    0.02478410,
    0.13935260,
    0.29623650,
    0.31031660,
    0.17183350,
    0.05003750,
    0.00706560,
    0.00037360
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 7
    ..position = 10)] = [
    0.02482610,
    0.13938910,
    0.29638740,
    0.31042440,
    0.17162760,
    0.04994690,
    0.00702710,
    0.00037140
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 7
    ..position = 11)] = [
    0.02485370,
    0.13935400,
    0.29663240,
    0.31023260,
    0.17166470,
    0.04986550,
    0.00702640,
    0.00037070
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 7
    ..position = 12)] = [
    0.02482810,
    0.13941850,
    0.29678410,
    0.31010890,
    0.17152390,
    0.04994960,
    0.00701330,
    0.00037360
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 7
    ..position = 13)] = [
    0.02512030,
    0.13965500,
    0.29708570,
    0.31003830,
    0.17101760,
    0.04972660,
    0.00699040,
    0.00036610
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 7
    ..position = 14)] = [
    0.02505290,
    0.13990770,
    0.29744630,
    0.30988690,
    0.17084690,
    0.04956730,
    0.00693090,
    0.00036110
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 7
    ..position = 15)] = [
    0.02516330,
    0.14051570,
    0.29770890,
    0.30971850,
    0.17034170,
    0.04927740,
    0.00692780,
    0.00034670
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 7
    ..position = 16)] = [
    0.02533320,
    0.14059390,
    0.29763110,
    0.30986390,
    0.17004780,
    0.04925340,
    0.00691160,
    0.00036510
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 7
    ..position = 17)] = [
    0.02532620,
    0.14132730,
    0.29841480,
    0.30919470,
    0.16959090,
    0.04893640,
    0.00686100,
    0.00034870
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 7
    ..position = 18)] = [
    0.02551170,
    0.14159710,
    0.29833550,
    0.30943400,
    0.16918270,
    0.04880100,
    0.00678520,
    0.00035280
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 7
    ..position = 19)] = [
    0.02577520,
    0.14226890,
    0.29893640,
    0.30872450,
    0.16874180,
    0.04848980,
    0.00670690,
    0.00035650
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 7
    ..position = 20)] = [
    0.02585460,
    0.14276330,
    0.29940780,
    0.30859040,
    0.16825780,
    0.04809240,
    0.00668610,
    0.00034760
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 7
    ..position = 21)] = [
    0.02601880,
    0.14331370,
    0.30006530,
    0.30818160,
    0.16753750,
    0.04792840,
    0.00660650,
    0.00034820
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 7
    ..position = 22)] = [
    0.02625270,
    0.14425950,
    0.30037190,
    0.30788030,
    0.16677250,
    0.04760860,
    0.00652100,
    0.00033350
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 7
    ..position = 23)] = [
    0.02647440,
    0.14482660,
    0.30074400,
    0.30760020,
    0.16615550,
    0.04734690,
    0.00652540,
    0.00032700
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 7
    ..position = 24)] = [
    0.02667500,
    0.14537970,
    0.30146190,
    0.30731900,
    0.16553090,
    0.04688450,
    0.00640560,
    0.00034340
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 15
    ..mulligans = 1
    ..sample = 7
    ..position = 25)] = [
    0.02688620,
    0.14630210,
    0.30203870,
    0.30665530,
    0.16489780,
    0.04653030,
    0.00636490,
    0.00032470
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 0
    ..sample = 7
    ..position = 0)] = [
    0.00859590,
    0.06874620,
    0.21031010,
    0.31852570,
    0.25733340,
    0.11116140,
    0.02345930,
    0.00186800
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 0
    ..sample = 7
    ..position = 1)] = [
    0.00827050,
    0.06733160,
    0.20842050,
    0.31844360,
    0.25956790,
    0.11230080,
    0.02374970,
    0.00191540
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 0
    ..sample = 7
    ..position = 2)] = [
    0.00815450,
    0.06656510,
    0.20762480,
    0.31931490,
    0.26035820,
    0.11234360,
    0.02377570,
    0.00186320
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 0
    ..sample = 7
    ..position = 3)] = [
    0.00815350,
    0.06685300,
    0.20871320,
    0.31993280,
    0.25996370,
    0.11133230,
    0.02324650,
    0.00180500
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 0
    ..sample = 7
    ..position = 4)] = [
    0.00830070,
    0.06821020,
    0.21134930,
    0.32126410,
    0.25788990,
    0.10894580,
    0.02233230,
    0.00170770
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 0
    ..sample = 7
    ..position = 5)] = [
    0.00863010,
    0.07028840,
    0.21555780,
    0.32293280,
    0.25437350,
    0.10549550,
    0.02116090,
    0.00156100
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 0
    ..sample = 7
    ..position = 6)] = [
    0.00920980,
    0.07348870,
    0.22094450,
    0.32449870,
    0.24982160,
    0.10093680,
    0.01967690,
    0.00142300
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 0
    ..sample = 7
    ..position = 7)] = [
    0.01001600,
    0.07782970,
    0.22814690,
    0.32538280,
    0.24372800,
    0.09563600,
    0.01801650,
    0.00124410
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 0
    ..sample = 7
    ..position = 8)] = [
    0.01107900,
    0.08375020,
    0.23662600,
    0.32587960,
    0.23568750,
    0.08945630,
    0.01640330,
    0.00111810
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 0
    ..sample = 7
    ..position = 9)] = [
    0.01238900,
    0.08981850,
    0.24471310,
    0.32523940,
    0.22811840,
    0.08376550,
    0.01496540,
    0.00099070
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 0
    ..sample = 7
    ..position = 10)] = [
    0.01368950,
    0.09564310,
    0.25212560,
    0.32479000,
    0.22052340,
    0.07874940,
    0.01361800,
    0.00086100
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 0
    ..sample = 7
    ..position = 11)] = [
    0.01511610,
    0.10204720,
    0.25922650,
    0.32378520,
    0.21298280,
    0.07369650,
    0.01238130,
    0.00076440
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 0
    ..sample = 7
    ..position = 12)] = [
    0.01653830,
    0.10808240,
    0.26670980,
    0.32207500,
    0.20562090,
    0.06905840,
    0.01124220,
    0.00067300
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 0
    ..sample = 7
    ..position = 13)] = [
    0.01823000,
    0.11460540,
    0.27326330,
    0.32001670,
    0.19828510,
    0.06465830,
    0.01032990,
    0.00061130
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 0
    ..sample = 7
    ..position = 14)] = [
    0.01979200,
    0.12074980,
    0.27954800,
    0.31798020,
    0.19148610,
    0.06052670,
    0.00936630,
    0.00055090
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 0
    ..sample = 7
    ..position = 15)] = [
    0.02146080,
    0.12719090,
    0.28579700,
    0.31524810,
    0.18433660,
    0.05690030,
    0.00857750,
    0.00048880
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 0
    ..sample = 7
    ..position = 16)] = [
    0.02327780,
    0.13355100,
    0.29132350,
    0.31244710,
    0.17762920,
    0.05350980,
    0.00782950,
    0.00043210
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 0
    ..sample = 7
    ..position = 17)] = [
    0.02517470,
    0.13988020,
    0.29633630,
    0.30953910,
    0.17143150,
    0.05010790,
    0.00715810,
    0.00037220
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 0
    ..sample = 7
    ..position = 18)] = [
    0.02705810,
    0.14637850,
    0.30143010,
    0.30623520,
    0.16502130,
    0.04697370,
    0.00656460,
    0.00033850
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 0
    ..sample = 7
    ..position = 19)] = [
    0.02903200,
    0.15287710,
    0.30580420,
    0.30252350,
    0.15917770,
    0.04429580,
    0.00598690,
    0.00030280
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 0
    ..sample = 7
    ..position = 20)] = [
    0.03101990,
    0.15914530,
    0.31025950,
    0.29898890,
    0.15332780,
    0.04149040,
    0.00549520,
    0.00027300
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 0
    ..sample = 7
    ..position = 21)] = [
    0.03318210,
    0.16522760,
    0.31443250,
    0.29523360,
    0.14754790,
    0.03907690,
    0.00505440,
    0.00024500
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 0
    ..sample = 7
    ..position = 22)] = [
    0.03549750,
    0.17158860,
    0.31796700,
    0.29140700,
    0.14203210,
    0.03664330,
    0.00464150,
    0.00022300
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 0
    ..sample = 7
    ..position = 23)] = [
    0.03756970,
    0.17794170,
    0.32151000,
    0.28706840,
    0.13687120,
    0.03455840,
    0.00427920,
    0.00020140
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 0
    ..sample = 7
    ..position = 24)] = [
    0.03980270,
    0.18393320,
    0.32499360,
    0.28304910,
    0.13162590,
    0.03249560,
    0.00392490,
    0.00017500
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 6
    ..position = 0)] = [
    0.03436370,
    0.17489380,
    0.33112980,
    0.29675350,
    0.13279780,
    0.02792070,
    0.00214070
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 6
    ..position = 1)] = [
    0.03419770,
    0.17499860,
    0.33094860,
    0.29689650,
    0.13282890,
    0.02794940,
    0.00218030
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 6
    ..position = 2)] = [
    0.03425220,
    0.17460370,
    0.33076650,
    0.29735830,
    0.13288090,
    0.02797720,
    0.00216120
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 6
    ..position = 3)] = [
    0.03402980,
    0.17407110,
    0.33050900,
    0.29762210,
    0.13347340,
    0.02813330,
    0.00216130
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 6
    ..position = 4)] = [
    0.03392380,
    0.17407310,
    0.33054700,
    0.29747910,
    0.13344990,
    0.02833880,
    0.00218830
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 6
    ..position = 5)] = [
    0.03393820,
    0.17385410,
    0.33017440,
    0.29769980,
    0.13374060,
    0.02838520,
    0.00220770
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 6
    ..position = 6)] = [
    0.03391180,
    0.17362480,
    0.33003520,
    0.29779390,
    0.13409440,
    0.02832750,
    0.00221240
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 6
    ..position = 7)] = [
    0.03379390,
    0.17340830,
    0.33033540,
    0.29782070,
    0.13411580,
    0.02835840,
    0.00216750
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 6
    ..position = 8)] = [
    0.03379650,
    0.17351360,
    0.33007130,
    0.29796300,
    0.13398280,
    0.02849670,
    0.00217610
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 6
    ..position = 9)] = [
    0.03376220,
    0.17357900,
    0.33036340,
    0.29774650,
    0.13397330,
    0.02839270,
    0.00218290
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 6
    ..position = 10)] = [
    0.03381470,
    0.17349370,
    0.32993900,
    0.29814980,
    0.13407640,
    0.02833600,
    0.00219040
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 6
    ..position = 11)] = [
    0.03400160,
    0.17385990,
    0.33055790,
    0.29744160,
    0.13370230,
    0.02823440,
    0.00220230
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 6
    ..position = 12)] = [
    0.03405320,
    0.17412190,
    0.33056070,
    0.29740650,
    0.13358380,
    0.02809440,
    0.00217950
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 6
    ..position = 13)] = [
    0.03412850,
    0.17453340,
    0.33060950,
    0.29722550,
    0.13312920,
    0.02821420,
    0.00215970
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 6
    ..position = 14)] = [
    0.03419810,
    0.17469460,
    0.33087470,
    0.29713550,
    0.13291490,
    0.02801050,
    0.00217170
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 6
    ..position = 15)] = [
    0.03452530,
    0.17499230,
    0.33115460,
    0.29693840,
    0.13230230,
    0.02792990,
    0.00215720
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 6
    ..position = 16)] = [
    0.03450270,
    0.17554000,
    0.33171410,
    0.29638520,
    0.13197850,
    0.02774260,
    0.00213690
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 6
    ..position = 17)] = [
    0.03472060,
    0.17619760,
    0.33180280,
    0.29584710,
    0.13167990,
    0.02764410,
    0.00210790
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 6
    ..position = 18)] = [
    0.03494290,
    0.17676140,
    0.33224310,
    0.29538450,
    0.13117810,
    0.02736800,
    0.00212200
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 6
    ..position = 19)] = [
    0.03510390,
    0.17734580,
    0.33227230,
    0.29537650,
    0.13056000,
    0.02725490,
    0.00208660
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 6
    ..position = 20)] = [
    0.03533720,
    0.17798110,
    0.33256340,
    0.29478630,
    0.13009830,
    0.02717280,
    0.00206090
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 6
    ..position = 21)] = [
    0.03557290,
    0.17865410,
    0.33333370,
    0.29403030,
    0.12949300,
    0.02688420,
    0.00203180
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 6
    ..position = 22)] = [
    0.03582020,
    0.17952850,
    0.33355910,
    0.29371990,
    0.12878150,
    0.02658200,
    0.00200880
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 6
    ..position = 23)] = [
    0.03612910,
    0.18022880,
    0.33366590,
    0.29316320,
    0.12834870,
    0.02646640,
    0.00199790
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 6
    ..position = 24)] = [
    0.03635440,
    0.18105340,
    0.33432930,
    0.29246250,
    0.12756680,
    0.02626990,
    0.00196370
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 7
    ..position = 0)] = [
    0.01820280,
    0.11405530,
    0.27199180,
    0.31940940,
    0.19934410,
    0.06574910,
    0.01060800,
    0.00063950
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 7
    ..position = 1)] = [
    0.01812270,
    0.11372420,
    0.27182820,
    0.31937540,
    0.19976240,
    0.06587710,
    0.01065480,
    0.00065520
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 7
    ..position = 2)] = [
    0.01805760,
    0.11352030,
    0.27119880,
    0.31983320,
    0.20004290,
    0.06599970,
    0.01071480,
    0.00063270
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 7
    ..position = 3)] = [
    0.01797140,
    0.11341060,
    0.27127110,
    0.32010720,
    0.19972580,
    0.06617480,
    0.01068280,
    0.00065630
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 7
    ..position = 4)] = [
    0.01793190,
    0.11288550,
    0.27099580,
    0.32002470,
    0.20044170,
    0.06627630,
    0.01079930,
    0.00064480
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 7
    ..position = 5)] = [
    0.01793990,
    0.11277160,
    0.27087130,
    0.31972050,
    0.20068600,
    0.06660390,
    0.01076130,
    0.00064550
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 7
    ..position = 6)] = [
    0.01790970,
    0.11280410,
    0.27039000,
    0.31986080,
    0.20068620,
    0.06689550,
    0.01080360,
    0.00065010
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 7
    ..position = 7)] = [
    0.01784540,
    0.11268740,
    0.27034230,
    0.32003990,
    0.20087390,
    0.06678190,
    0.01078300,
    0.00064620
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 7
    ..position = 8)] = [
    0.01784490,
    0.11248140,
    0.27050500,
    0.31999930,
    0.20090100,
    0.06681760,
    0.01080630,
    0.00064450
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 7
    ..position = 9)] = [
    0.01782640,
    0.11248060,
    0.27061020,
    0.31999960,
    0.20087620,
    0.06668480,
    0.01084210,
    0.00068010
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 7
    ..position = 10)] = [
    0.01780670,
    0.11252330,
    0.27043350,
    0.32023780,
    0.20084900,
    0.06673790,
    0.01076480,
    0.00064700
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 7
    ..position = 11)] = [
    0.01785150,
    0.11288570,
    0.27063770,
    0.31972350,
    0.20077750,
    0.06664200,
    0.01081030,
    0.00067180
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 7
    ..position = 12)] = [
    0.01794000,
    0.11291240,
    0.27063040,
    0.31991260,
    0.20068230,
    0.06650320,
    0.01076960,
    0.00064950
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 7
    ..position = 13)] = [
    0.01794920,
    0.11303310,
    0.27107070,
    0.31989490,
    0.20035910,
    0.06633760,
    0.01069800,
    0.00065740
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 7
    ..position = 14)] = [
    0.01799710,
    0.11360210,
    0.27116650,
    0.31977700,
    0.20006360,
    0.06611730,
    0.01064500,
    0.00063140
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 7
    ..position = 15)] = [
    0.01813600,
    0.11374210,
    0.27192890,
    0.31961250,
    0.19955060,
    0.06578430,
    0.01061660,
    0.00062900
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 7
    ..position = 16)] = [
    0.01823700,
    0.11395860,
    0.27219460,
    0.31954560,
    0.19914290,
    0.06578150,
    0.01051480,
    0.00062500
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 7
    ..position = 17)] = [
    0.01841820,
    0.11457310,
    0.27282920,
    0.31926900,
    0.19860020,
    0.06519550,
    0.01047660,
    0.00063820
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 7
    ..position = 18)] = [
    0.01839420,
    0.11506210,
    0.27321000,
    0.31942920,
    0.19806640,
    0.06485760,
    0.01036410,
    0.00061640
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 7
    ..position = 19)] = [
    0.01859930,
    0.11553130,
    0.27363640,
    0.31927640,
    0.19743230,
    0.06463350,
    0.01028410,
    0.00060670
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 7
    ..position = 20)] = [
    0.01879000,
    0.11613940,
    0.27413650,
    0.31887450,
    0.19706900,
    0.06416050,
    0.01021690,
    0.00061320
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 7
    ..position = 21)] = [
    0.01884150,
    0.11683620,
    0.27461810,
    0.31891300,
    0.19615780,
    0.06394770,
    0.01008750,
    0.00059820
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 7
    ..position = 22)] = [
    0.01904460,
    0.11730630,
    0.27561740,
    0.31855120,
    0.19536600,
    0.06350310,
    0.01002160,
    0.00058980
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 7
    ..position = 23)] = [
    0.01920360,
    0.11795680,
    0.27614190,
    0.31851130,
    0.19451920,
    0.06314830,
    0.00993890,
    0.00058000
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 16
    ..mulligans = 1
    ..sample = 7
    ..position = 24)] = [
    0.01938050,
    0.11858550,
    0.27686220,
    0.31799130,
    0.19402840,
    0.06273200,
    0.00985090,
    0.00056920
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 0
    ..sample = 7
    ..position = 0)] = [
    0.00580350,
    0.05180880,
    0.17887670,
    0.30669320,
    0.28202940,
    0.13816850,
    0.03352100,
    0.00309890
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 0
    ..sample = 7
    ..position = 1)] = [
    0.00556220,
    0.05078290,
    0.17734940,
    0.30686800,
    0.28336610,
    0.13928880,
    0.03369460,
    0.00308800
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 0
    ..sample = 7
    ..position = 2)] = [
    0.00548070,
    0.05046980,
    0.17719270,
    0.30770030,
    0.28352160,
    0.13916780,
    0.03343840,
    0.00302870
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 0
    ..sample = 7
    ..position = 3)] = [
    0.00546730,
    0.05074390,
    0.17847750,
    0.30883230,
    0.28329560,
    0.13760920,
    0.03266700,
    0.00290720
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 0
    ..sample = 7
    ..position = 4)] = [
    0.00566510,
    0.05199770,
    0.18164200,
    0.31088080,
    0.28124480,
    0.13444160,
    0.03136650,
    0.00276150
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 0
    ..sample = 7
    ..position = 5)] = [
    0.00596170,
    0.05405520,
    0.18586300,
    0.31325630,
    0.27832500,
    0.13032360,
    0.02971040,
    0.00250480
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 0
    ..sample = 7
    ..position = 6)] = [
    0.00634610,
    0.05702130,
    0.19170060,
    0.31611130,
    0.27394750,
    0.12493210,
    0.02764860,
    0.00229250
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 0
    ..sample = 7
    ..position = 7)] = [
    0.00695790,
    0.06080500,
    0.19945370,
    0.31875490,
    0.26798190,
    0.11868360,
    0.02534860,
    0.00201440
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 0
    ..sample = 7
    ..position = 8)] = [
    0.00787370,
    0.06593230,
    0.20810990,
    0.32092360,
    0.26059380,
    0.11162130,
    0.02313490,
    0.00181050
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 0
    ..sample = 7
    ..position = 9)] = [
    0.00886290,
    0.07128410,
    0.21668670,
    0.32237840,
    0.25329090,
    0.10489630,
    0.02101460,
    0.00158610
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 0
    ..sample = 7
    ..position = 10)] = [
    0.00991200,
    0.07666920,
    0.22520810,
    0.32345330,
    0.24572540,
    0.09840900,
    0.01920840,
    0.00141460
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 0
    ..sample = 7
    ..position = 11)] = [
    0.01099060,
    0.08229390,
    0.23292970,
    0.32398390,
    0.23851440,
    0.09254500,
    0.01750510,
    0.00123740
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 0
    ..sample = 7
    ..position = 12)] = [
    0.01216680,
    0.08794310,
    0.24074120,
    0.32390350,
    0.23095500,
    0.08710700,
    0.01608530,
    0.00109810
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 0
    ..sample = 7
    ..position = 13)] = [
    0.01344560,
    0.09379230,
    0.24840290,
    0.32335200,
    0.22361550,
    0.08181220,
    0.01459610,
    0.00098340
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 0
    ..sample = 7
    ..position = 14)] = [
    0.01474040,
    0.09958010,
    0.25546080,
    0.32265760,
    0.21648910,
    0.07689080,
    0.01331540,
    0.00086580
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 0
    ..sample = 7
    ..position = 15)] = [
    0.01618590,
    0.10536530,
    0.26219520,
    0.32150510,
    0.20948610,
    0.07227640,
    0.01220100,
    0.00078500
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 0
    ..sample = 7
    ..position = 16)] = [
    0.01756090,
    0.11139310,
    0.26883860,
    0.31993710,
    0.20256470,
    0.06792480,
    0.01108860,
    0.00069220
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 0
    ..sample = 7
    ..position = 17)] = [
    0.01920550,
    0.11773440,
    0.27489140,
    0.31771740,
    0.19578620,
    0.06386350,
    0.01020070,
    0.00060090
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 0
    ..sample = 7
    ..position = 18)] = [
    0.02071990,
    0.12364230,
    0.28102890,
    0.31564500,
    0.18895940,
    0.06010260,
    0.00937080,
    0.00053110
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 0
    ..sample = 7
    ..position = 19)] = [
    0.02232800,
    0.12952420,
    0.28653890,
    0.31345580,
    0.18244780,
    0.05666640,
    0.00855150,
    0.00048740
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 0
    ..sample = 7
    ..position = 20)] = [
    0.02407910,
    0.13559000,
    0.29187490,
    0.31044820,
    0.17628460,
    0.05336230,
    0.00791850,
    0.00044240
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 0
    ..sample = 7
    ..position = 21)] = [
    0.02589330,
    0.14174710,
    0.29672280,
    0.30763210,
    0.17022830,
    0.05015080,
    0.00723000,
    0.00039560
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 0
    ..sample = 7
    ..position = 22)] = [
    0.02780750,
    0.14763560,
    0.30154700,
    0.30436910,
    0.16432790,
    0.04725620,
    0.00668460,
    0.00037210
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 0
    ..sample = 7
    ..position = 23)] = [
    0.02958490,
    0.15373830,
    0.30579340,
    0.30145480,
    0.15847980,
    0.04448690,
    0.00614380,
    0.00031810
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 6
    ..position = 0)] = [
    0.02566480,
    0.14672300,
    0.31205100,
    0.31509470,
    0.15910610,
    0.03802340,
    0.00333700
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 6
    ..position = 1)] = [
    0.02563640,
    0.14678200,
    0.31199080,
    0.31525230,
    0.15900490,
    0.03798600,
    0.00334760
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 6
    ..position = 2)] = [
    0.02549560,
    0.14642430,
    0.31140820,
    0.31553590,
    0.15960420,
    0.03819710,
    0.00333470
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 6
    ..position = 3)] = [
    0.02549810,
    0.14610090,
    0.31142140,
    0.31557910,
    0.15973550,
    0.03826580,
    0.00339920
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 6
    ..position = 4)] = [
    0.02544610,
    0.14598850,
    0.31162930,
    0.31529220,
    0.16003440,
    0.03820810,
    0.00340140
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 6
    ..position = 5)] = [
    0.02536520,
    0.14590980,
    0.31096070,
    0.31566140,
    0.16029640,
    0.03842240,
    0.00338410
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 6
    ..position = 6)] = [
    0.02527810,
    0.14528630,
    0.31098620,
    0.31602560,
    0.16052830,
    0.03850500,
    0.00339050
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 6
    ..position = 7)] = [
    0.02530260,
    0.14551560,
    0.31111350,
    0.31563920,
    0.16051950,
    0.03854510,
    0.00336450
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 6
    ..position = 8)] = [
    0.02528750,
    0.14547610,
    0.31115390,
    0.31580480,
    0.16027740,
    0.03859730,
    0.00340300
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 6
    ..position = 9)] = [
    0.02536110,
    0.14560540,
    0.31109560,
    0.31587600,
    0.16024710,
    0.03844680,
    0.00336800
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 6
    ..position = 10)] = [
    0.02538790,
    0.14560610,
    0.31129930,
    0.31575630,
    0.16022270,
    0.03835650,
    0.00337120
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 6
    ..position = 11)] = [
    0.02545190,
    0.14593340,
    0.31133960,
    0.31565900,
    0.15996580,
    0.03830070,
    0.00334960
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 6
    ..position = 12)] = [
    0.02545070,
    0.14621580,
    0.31176150,
    0.31552690,
    0.15945200,
    0.03822300,
    0.00337010
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 6
    ..position = 13)] = [
    0.02559980,
    0.14662770,
    0.31188210,
    0.31502530,
    0.15940450,
    0.03810000,
    0.00336060
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 6
    ..position = 14)] = [
    0.02565370,
    0.14703380,
    0.31225120,
    0.31483350,
    0.15906710,
    0.03782030,
    0.00334040
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 6
    ..position = 15)] = [
    0.02584920,
    0.14739550,
    0.31214820,
    0.31494290,
    0.15859950,
    0.03774750,
    0.00331720
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 6
    ..position = 16)] = [
    0.02592240,
    0.14796030,
    0.31307160,
    0.31425420,
    0.15803720,
    0.03747520,
    0.00327910
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 6
    ..position = 17)] = [
    0.02603970,
    0.14828120,
    0.31316690,
    0.31433890,
    0.15763290,
    0.03728330,
    0.00325710
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 6
    ..position = 18)] = [
    0.02624640,
    0.14908620,
    0.31376930,
    0.31371720,
    0.15683070,
    0.03712570,
    0.00322450
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 6
    ..position = 19)] = [
    0.02646130,
    0.14962700,
    0.31402830,
    0.31331170,
    0.15645550,
    0.03691630,
    0.00319990
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 6
    ..position = 20)] = [
    0.02667760,
    0.15013530,
    0.31477640,
    0.31303620,
    0.15567200,
    0.03653490,
    0.00316760
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 6
    ..position = 21)] = [
    0.02688260,
    0.15105180,
    0.31508180,
    0.31264610,
    0.15485170,
    0.03635570,
    0.00313030
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 6
    ..position = 22)] = [
    0.02714780,
    0.15187760,
    0.31573180,
    0.31201460,
    0.15406650,
    0.03604880,
    0.00311290
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 6
    ..position = 23)] = [
    0.02735600,
    0.15254740,
    0.31614410,
    0.31154100,
    0.15365150,
    0.03571460,
    0.00304540
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 7
    ..position = 0)] = [
    0.01283090,
    0.09045030,
    0.24356130,
    0.32316520,
    0.22796060,
    0.08529820,
    0.01564780,
    0.00108570
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 7
    ..position = 1)] = [
    0.01278250,
    0.09032720,
    0.24311470,
    0.32296120,
    0.22832130,
    0.08564590,
    0.01576910,
    0.00107810
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 7
    ..position = 2)] = [
    0.01274070,
    0.09012090,
    0.24296900,
    0.32290200,
    0.22838950,
    0.08601040,
    0.01577660,
    0.00109090
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 7
    ..position = 3)] = [
    0.01266880,
    0.08995560,
    0.24258600,
    0.32322410,
    0.22870700,
    0.08590490,
    0.01585610,
    0.00109750
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 7
    ..position = 4)] = [
    0.01264230,
    0.08981610,
    0.24254880,
    0.32276260,
    0.22904190,
    0.08624340,
    0.01584700,
    0.00109790
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 7
    ..position = 5)] = [
    0.01267710,
    0.08961070,
    0.24237370,
    0.32271370,
    0.22932930,
    0.08622560,
    0.01594920,
    0.00112070
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 7
    ..position = 6)] = [
    0.01257820,
    0.08959600,
    0.24225860,
    0.32278780,
    0.22939210,
    0.08636560,
    0.01591230,
    0.00110940
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 7
    ..position = 7)] = [
    0.01261940,
    0.08937450,
    0.24176760,
    0.32303600,
    0.22948750,
    0.08662320,
    0.01598420,
    0.00110760
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 7
    ..position = 8)] = [
    0.01259690,
    0.08950170,
    0.24198950,
    0.32291940,
    0.22945810,
    0.08653250,
    0.01591310,
    0.00108880
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 7
    ..position = 9)] = [
    0.01263020,
    0.08929840,
    0.24223510,
    0.32286390,
    0.22923610,
    0.08663380,
    0.01599600,
    0.00110650
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 7
    ..position = 10)] = [
    0.01260630,
    0.08958870,
    0.24202020,
    0.32284600,
    0.22950870,
    0.08637910,
    0.01593180,
    0.00111920
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 7
    ..position = 11)] = [
    0.01265860,
    0.08948820,
    0.24227600,
    0.32312330,
    0.22920840,
    0.08630030,
    0.01585270,
    0.00109250
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 7
    ..position = 12)] = [
    0.01270840,
    0.08990060,
    0.24250260,
    0.32322220,
    0.22878790,
    0.08597760,
    0.01581840,
    0.00108230
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 7
    ..position = 13)] = [
    0.01275900,
    0.08987800,
    0.24259700,
    0.32317640,
    0.22884960,
    0.08587500,
    0.01578260,
    0.00108240
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 7
    ..position = 14)] = [
    0.01276670,
    0.09015980,
    0.24332310,
    0.32305690,
    0.22842580,
    0.08549830,
    0.01569120,
    0.00107820
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 7
    ..position = 15)] = [
    0.01282180,
    0.09068880,
    0.24358900,
    0.32295280,
    0.22797810,
    0.08525860,
    0.01564780,
    0.00106310
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 7
    ..position = 16)] = [
    0.01292490,
    0.09104240,
    0.24412200,
    0.32285680,
    0.22739240,
    0.08508880,
    0.01551290,
    0.00105980
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 7
    ..position = 17)] = [
    0.01298330,
    0.09151880,
    0.24439070,
    0.32318100,
    0.22679520,
    0.08463560,
    0.01543030,
    0.00106510
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 7
    ..position = 18)] = [
    0.01306410,
    0.09189380,
    0.24540680,
    0.32316350,
    0.22605140,
    0.08405380,
    0.01531400,
    0.00105260
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 7
    ..position = 19)] = [
    0.01326290,
    0.09232190,
    0.24595910,
    0.32289170,
    0.22557670,
    0.08382640,
    0.01510860,
    0.00105270
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 7
    ..position = 20)] = [
    0.01329510,
    0.09270130,
    0.24649560,
    0.32301450,
    0.22523330,
    0.08314980,
    0.01506710,
    0.00104330
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 7
    ..position = 21)] = [
    0.01338990,
    0.09347870,
    0.24719940,
    0.32265630,
    0.22455490,
    0.08279160,
    0.01489430,
    0.00103490
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 7
    ..position = 22)] = [
    0.01356820,
    0.09401290,
    0.24818820,
    0.32260580,
    0.22374390,
    0.08214040,
    0.01474550,
    0.00099510
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 17
    ..mulligans = 1
    ..sample = 7
    ..position = 23)] = [
    0.01366970,
    0.09444850,
    0.24873870,
    0.32286930,
    0.22294470,
    0.08172960,
    0.01460050,
    0.00099900
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 0
    ..sample = 7
    ..position = 0)] = [
    0.00376500,
    0.03816640,
    0.14958420,
    0.28991010,
    0.30064320,
    0.16722070,
    0.04591610,
    0.00479430
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 0
    ..sample = 7
    ..position = 1)] = [
    0.00362380,
    0.03760760,
    0.14804930,
    0.28958270,
    0.30206590,
    0.16803270,
    0.04623230,
    0.00480570
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 0
    ..sample = 7
    ..position = 2)] = [
    0.00359860,
    0.03758590,
    0.14850370,
    0.29035220,
    0.30244600,
    0.16728440,
    0.04555010,
    0.00467910
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 0
    ..sample = 7
    ..position = 3)] = [
    0.00362960,
    0.03797560,
    0.15021780,
    0.29203750,
    0.30196430,
    0.16521410,
    0.04446720,
    0.00449390
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 0
    ..sample = 7
    ..position = 4)] = [
    0.00378190,
    0.03907320,
    0.15322310,
    0.29503550,
    0.30020270,
    0.16192090,
    0.04255450,
    0.00420820
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 0
    ..sample = 7
    ..position = 5)] = [
    0.00398850,
    0.04087120,
    0.15764670,
    0.29815230,
    0.29805640,
    0.15701700,
    0.04039270,
    0.00387520
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 0
    ..sample = 7
    ..position = 6)] = [
    0.00430800,
    0.04334580,
    0.16384120,
    0.30212150,
    0.29453060,
    0.15077990,
    0.03757850,
    0.00349450
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 0
    ..sample = 7
    ..position = 7)] = [
    0.00479860,
    0.04660970,
    0.17130320,
    0.30677050,
    0.28920920,
    0.14346720,
    0.03469520,
    0.00314640
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 0
    ..sample = 7
    ..position = 8)] = [
    0.00546660,
    0.05120610,
    0.18046210,
    0.31063420,
    0.28253870,
    0.13526170,
    0.03168150,
    0.00274910
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 0
    ..sample = 7
    ..position = 9)] = [
    0.00619350,
    0.05573340,
    0.18936150,
    0.31423840,
    0.27536260,
    0.12772250,
    0.02893170,
    0.00245640
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 0
    ..sample = 7
    ..position = 10)] = [
    0.00698070,
    0.06072080,
    0.19780430,
    0.31689090,
    0.26857950,
    0.12043810,
    0.02642840,
    0.00215730
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 0
    ..sample = 7
    ..position = 11)] = [
    0.00785690,
    0.06566720,
    0.20652870,
    0.31880630,
    0.26151470,
    0.11356740,
    0.02410480,
    0.00195400
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 0
    ..sample = 7
    ..position = 12)] = [
    0.00884870,
    0.07065430,
    0.21445580,
    0.32093200,
    0.25449610,
    0.10684550,
    0.02206520,
    0.00170240
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 0
    ..sample = 7
    ..position = 13)] = [
    0.00983420,
    0.07578640,
    0.22285830,
    0.32180340,
    0.24740890,
    0.10068650,
    0.02009600,
    0.00152630
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 0
    ..sample = 7
    ..position = 14)] = [
    0.01090290,
    0.08118330,
    0.23042430,
    0.32270410,
    0.24007280,
    0.09498340,
    0.01838460,
    0.00134460
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 0
    ..sample = 7
    ..position = 15)] = [
    0.01196630,
    0.08669960,
    0.23790510,
    0.32282470,
    0.23307520,
    0.08949530,
    0.01682910,
    0.00120470
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 0
    ..sample = 7
    ..position = 16)] = [
    0.01311190,
    0.09228330,
    0.24507540,
    0.32249200,
    0.22600990,
    0.08444750,
    0.01550960,
    0.00107040
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 0
    ..sample = 7
    ..position = 17)] = [
    0.01443880,
    0.09771600,
    0.25188550,
    0.32188810,
    0.21923250,
    0.07964320,
    0.01424420,
    0.00095170
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 0
    ..sample = 7
    ..position = 18)] = [
    0.01567280,
    0.10325640,
    0.25866230,
    0.32101420,
    0.21255290,
    0.07494840,
    0.01303840,
    0.00085460
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 0
    ..sample = 7
    ..position = 19)] = [
    0.01705220,
    0.10891880,
    0.26500970,
    0.31964760,
    0.20585540,
    0.07081820,
    0.01193660,
    0.00076150
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 0
    ..sample = 7
    ..position = 20)] = [
    0.01861370,
    0.11475900,
    0.27139300,
    0.31786060,
    0.19926310,
    0.06644830,
    0.01095540,
    0.00070690
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 0
    ..sample = 7
    ..position = 21)] = [
    0.02006170,
    0.12051700,
    0.27729890,
    0.31584120,
    0.19278510,
    0.06280480,
    0.01007910,
    0.00061220
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 0
    ..sample = 7
    ..position = 22)] = [
    0.02155460,
    0.12618540,
    0.28259060,
    0.31386950,
    0.18657630,
    0.05938500,
    0.00929190,
    0.00054670
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 6
    ..position = 0)] = [
    0.01896490,
    0.12122210,
    0.28927360,
    0.32850230,
    0.18671980,
    0.05029090,
    0.00502640
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 6
    ..position = 1)] = [
    0.01889480,
    0.12107780,
    0.28931540,
    0.32848850,
    0.18685100,
    0.05034070,
    0.00503180
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 6
    ..position = 2)] = [
    0.01886450,
    0.12091120,
    0.28893130,
    0.32846620,
    0.18723300,
    0.05058520,
    0.00500860
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 6
    ..position = 3)] = [
    0.01870460,
    0.12068920,
    0.28893700,
    0.32867290,
    0.18726910,
    0.05066420,
    0.00506300
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 6
    ..position = 4)] = [
    0.01865540,
    0.12043740,
    0.28866240,
    0.32869090,
    0.18767110,
    0.05076180,
    0.00512100
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 6
    ..position = 5)] = [
    0.01867730,
    0.12059720,
    0.28834090,
    0.32875820,
    0.18772470,
    0.05081330,
    0.00508840
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 6
    ..position = 6)] = [
    0.01863980,
    0.12025700,
    0.28868950,
    0.32883470,
    0.18759860,
    0.05087100,
    0.00510940
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 6
    ..position = 7)] = [
    0.01859080,
    0.12014920,
    0.28839980,
    0.32889190,
    0.18791010,
    0.05096160,
    0.00509660
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 6
    ..position = 8)] = [
    0.01871850,
    0.12029190,
    0.28844160,
    0.32890660,
    0.18774110,
    0.05080570,
    0.00509460
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 6
    ..position = 9)] = [
    0.01868240,
    0.12041450,
    0.28868660,
    0.32871050,
    0.18752670,
    0.05091440,
    0.00506490
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 6
    ..position = 10)] = [
    0.01868120,
    0.12044550,
    0.28889260,
    0.32895940,
    0.18729690,
    0.05067310,
    0.00505130
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 6
    ..position = 11)] = [
    0.01874600,
    0.12100810,
    0.28880840,
    0.32876510,
    0.18717060,
    0.05045380,
    0.00504800
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 6
    ..position = 12)] = [
    0.01883130,
    0.12104590,
    0.28935400,
    0.32844190,
    0.18696140,
    0.05038090,
    0.00498460
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 6
    ..position = 13)] = [
    0.01889490,
    0.12133530,
    0.28939920,
    0.32825580,
    0.18675970,
    0.05033180,
    0.00502330
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 6
    ..position = 14)] = [
    0.01908140,
    0.12195060,
    0.28978190,
    0.32792370,
    0.18620890,
    0.05008160,
    0.00497190
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 6
    ..position = 15)] = [
    0.01903500,
    0.12216790,
    0.29040410,
    0.32813530,
    0.18547870,
    0.04980500,
    0.00497400
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 6
    ..position = 16)] = [
    0.01922650,
    0.12278130,
    0.29066830,
    0.32784280,
    0.18498610,
    0.04958090,
    0.00491410
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 6
    ..position = 17)] = [
    0.01936880,
    0.12313140,
    0.29150360,
    0.32748950,
    0.18442130,
    0.04925270,
    0.00483270
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 6
    ..position = 18)] = [
    0.01951790,
    0.12394260,
    0.29162280,
    0.32730960,
    0.18390640,
    0.04888480,
    0.00481590
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 6
    ..position = 19)] = [
    0.01976280,
    0.12438900,
    0.29260180,
    0.32683170,
    0.18299220,
    0.04861980,
    0.00480270
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 6
    ..position = 20)] = [
    0.01983030,
    0.12492350,
    0.29308550,
    0.32678320,
    0.18232890,
    0.04834810,
    0.00470050
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 6
    ..position = 21)] = [
    0.02000200,
    0.12567020,
    0.29385110,
    0.32626150,
    0.18179670,
    0.04778450,
    0.00463400
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 6
    ..position = 22)] = [
    0.02018540,
    0.12653890,
    0.29449930,
    0.32590930,
    0.18067080,
    0.04759200,
    0.00460430
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 7
    ..position = 0)] = [
    0.00883920,
    0.07072540,
    0.21372040,
    0.31959920,
    0.25480690,
    0.10810070,
    0.02246060,
    0.00174760
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 7
    ..position = 1)] = [
    0.00889100,
    0.07044390,
    0.21362780,
    0.31931380,
    0.25507400,
    0.10826280,
    0.02259150,
    0.00179520
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 7
    ..position = 2)] = [
    0.00883050,
    0.07033510,
    0.21321330,
    0.31967810,
    0.25498860,
    0.10851090,
    0.02265160,
    0.00179190
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 7
    ..position = 3)] = [
    0.00881240,
    0.06996930,
    0.21305520,
    0.31946480,
    0.25553560,
    0.10860680,
    0.02274510,
    0.00181080
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 7
    ..position = 4)] = [
    0.00878220,
    0.06996890,
    0.21301290,
    0.31936190,
    0.25560300,
    0.10881810,
    0.02264300,
    0.00181000
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 7
    ..position = 5)] = [
    0.00873070,
    0.06984530,
    0.21262880,
    0.31941920,
    0.25583850,
    0.10894050,
    0.02280080,
    0.00179620
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 7
    ..position = 6)] = [
    0.00872780,
    0.06966690,
    0.21238540,
    0.31940390,
    0.25599040,
    0.10917080,
    0.02284610,
    0.00180870
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 7
    ..position = 7)] = [
    0.00870570,
    0.06975380,
    0.21265550,
    0.31920520,
    0.25600610,
    0.10906510,
    0.02282300,
    0.00178560
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 7
    ..position = 8)] = [
    0.00868700,
    0.06977850,
    0.21239250,
    0.31962040,
    0.25575180,
    0.10905480,
    0.02292010,
    0.00179490
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 7
    ..position = 9)] = [
    0.00874810,
    0.06976320,
    0.21232520,
    0.31971670,
    0.25585220,
    0.10897200,
    0.02281460,
    0.00180800
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 7
    ..position = 10)] = [
    0.00870880,
    0.06990830,
    0.21253880,
    0.31948050,
    0.25596900,
    0.10881130,
    0.02278080,
    0.00180250
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 7
    ..position = 11)] = [
    0.00878860,
    0.06995330,
    0.21300110,
    0.31959940,
    0.25545130,
    0.10866890,
    0.02273810,
    0.00179930
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 7
    ..position = 12)] = [
    0.00881620,
    0.07023780,
    0.21310470,
    0.31983810,
    0.25505030,
    0.10846920,
    0.02270100,
    0.00178270
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 7
    ..position = 13)] = [
    0.00884430,
    0.07048010,
    0.21328520,
    0.31989570,
    0.25500480,
    0.10814630,
    0.02256650,
    0.00177710
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 7
    ..position = 14)] = [
    0.00888790,
    0.07076750,
    0.21396990,
    0.31995350,
    0.25457490,
    0.10770090,
    0.02239460,
    0.00175080
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 7
    ..position = 15)] = [
    0.00892800,
    0.07095250,
    0.21445710,
    0.32000510,
    0.25430720,
    0.10739050,
    0.02222850,
    0.00173110
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 7
    ..position = 16)] = [
    0.00901840,
    0.07145770,
    0.21485170,
    0.32011580,
    0.25369140,
    0.10697120,
    0.02217140,
    0.00172240
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 7
    ..position = 17)] = [
    0.00915770,
    0.07175640,
    0.21583990,
    0.31996470,
    0.25310240,
    0.10652400,
    0.02194650,
    0.00170840
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 7
    ..position = 18)] = [
    0.00918070,
    0.07204370,
    0.21630130,
    0.32030150,
    0.25247850,
    0.10613830,
    0.02184500,
    0.00171100
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 7
    ..position = 19)] = [
    0.00925170,
    0.07271740,
    0.21689050,
    0.32037830,
    0.25182410,
    0.10548100,
    0.02178240,
    0.00167460
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 7
    ..position = 20)] = [
    0.00932640,
    0.07306920,
    0.21755540,
    0.32063270,
    0.25126700,
    0.10495540,
    0.02152700,
    0.00166690
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 7
    ..position = 21)] = [
    0.00945880,
    0.07364660,
    0.21857640,
    0.32051190,
    0.25074400,
    0.10414810,
    0.02125480,
    0.00165940
  ]
  ..[BuggedInputs((b) => b
    ..population = 40
    ..hits = 18
    ..mulligans = 1
    ..sample = 7
    ..position = 22)] = [
    0.00956000,
    0.07410240,
    0.21963590,
    0.32083610,
    0.24952600,
    0.10365350,
    0.02105160,
    0.00163450
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 0)] = [
    0.88318490,
    0.11681510,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 1)] = [
    0.87849300,
    0.12150700,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 2)] = [
    0.87364860,
    0.12635140,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 3)] = [
    0.86877230,
    0.13122770,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 4)] = [
    0.86426860,
    0.13573140,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 5)] = [
    0.85969640,
    0.14030360,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 6)] = [
    0.85514390,
    0.14485610,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 7)] = [
    0.85062530,
    0.14937470,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 8)] = [
    0.85238440,
    0.14761560,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 9)] = [
    0.85426020,
    0.14573980,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 10)] = [
    0.85575690,
    0.14424310,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 11)] = [
    0.85744300,
    0.14255700,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 12)] = [
    0.85923920,
    0.14076080,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 13)] = [
    0.86068190,
    0.13931810,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 14)] = [
    0.86208550,
    0.13791450,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 15)] = [
    0.86372870,
    0.13627130,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 16)] = [
    0.86549100,
    0.13450900,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 17)] = [
    0.86667210,
    0.13332790,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 18)] = [
    0.86818900,
    0.13181100,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 19)] = [
    0.86963300,
    0.13036700,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 20)] = [
    0.87105850,
    0.12894150,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 21)] = [
    0.87254160,
    0.12745840,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 22)] = [
    0.87378170,
    0.12621830,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 23)] = [
    0.87509790,
    0.12490210,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 24)] = [
    0.87650600,
    0.12349400,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 25)] = [
    0.87782700,
    0.12217300,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 26)] = [
    0.87920810,
    0.12079190,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 27)] = [
    0.88032580,
    0.11967420,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 28)] = [
    0.88148270,
    0.11851730,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 29)] = [
    0.88275900,
    0.11724100,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 30)] = [
    0.88395080,
    0.11604920,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 31)] = [
    0.88507050,
    0.11492950,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 32)] = [
    0.88617970,
    0.11382030,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 33)] = [
    0.88745600,
    0.11254400,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 34)] = [
    0.88849370,
    0.11150630,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 35)] = [
    0.88956960,
    0.11043040,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 36)] = [
    0.89088140,
    0.10911860,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 37)] = [
    0.89174980,
    0.10825020,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 38)] = [
    0.89290930,
    0.10709070,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 39)] = [
    0.89386350,
    0.10613650,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 40)] = [
    0.89473560,
    0.10526440,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 41)] = [
    0.89592520,
    0.10407480,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 42)] = [
    0.89697380,
    0.10302620,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 43)] = [
    0.89768160,
    0.10231840,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 44)] = [
    0.89876570,
    0.10123430,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 45)] = [
    0.89975790,
    0.10024210,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 46)] = [
    0.90048640,
    0.09951360,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 47)] = [
    0.90160500,
    0.09839500,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 48)] = [
    0.90263510,
    0.09736490,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 49)] = [
    0.90315700,
    0.09684300,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 50)] = [
    0.90413350,
    0.09586650,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 51)] = [
    0.90496310,
    0.09503690,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 52)] = [
    0.90578960,
    0.09421040,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 53)] = [
    0.90661220,
    0.09338780,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 54)] = [
    0.90747100,
    0.09252900,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 55)] = [
    0.90808100,
    0.09191900,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 56)] = [
    0.90892480,
    0.09107520,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 57)] = [
    0.90959640,
    0.09040360,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 58)] = [
    0.91038370,
    0.08961630,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 0
    ..sample = 7
    ..position = 59)] = [
    0.91128250,
    0.08871750,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 0)] = [
    0.90002510,
    0.09997490,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 1)] = [
    0.89993190,
    0.10006810,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 2)] = [
    0.89999980,
    0.10000020,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 3)] = [
    0.90017210,
    0.09982790,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 4)] = [
    0.90016850,
    0.09983150,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 5)] = [
    0.89982920,
    0.10017080,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 6)] = [
    0.89975470,
    0.10024530,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 7)] = [
    0.89981160,
    0.10018840,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 8)] = [
    0.89969300,
    0.10030700,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 9)] = [
    0.89933430,
    0.10066570,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 10)] = [
    0.89941440,
    0.10058560,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 11)] = [
    0.89918510,
    0.10081490,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 12)] = [
    0.89914700,
    0.10085300,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 13)] = [
    0.89899450,
    0.10100550,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 14)] = [
    0.89903420,
    0.10096580,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 15)] = [
    0.89911980,
    0.10088020,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 16)] = [
    0.89888800,
    0.10111200,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 17)] = [
    0.89910630,
    0.10089370,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 18)] = [
    0.89898080,
    0.10101920,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 19)] = [
    0.89891580,
    0.10108420,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 20)] = [
    0.89875760,
    0.10124240,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 21)] = [
    0.89884340,
    0.10115660,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 22)] = [
    0.89897400,
    0.10102600,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 23)] = [
    0.89886700,
    0.10113300,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 24)] = [
    0.89905690,
    0.10094310,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 25)] = [
    0.89897720,
    0.10102280,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 26)] = [
    0.89901700,
    0.10098300,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 27)] = [
    0.89907230,
    0.10092770,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 28)] = [
    0.89916240,
    0.10083760,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 29)] = [
    0.89927920,
    0.10072080,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 30)] = [
    0.89916850,
    0.10083150,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 31)] = [
    0.89925600,
    0.10074400,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 32)] = [
    0.89937150,
    0.10062850,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 33)] = [
    0.89937980,
    0.10062020,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 34)] = [
    0.89963260,
    0.10036740,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 35)] = [
    0.89963120,
    0.10036880,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 36)] = [
    0.89970500,
    0.10029500,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 37)] = [
    0.89971670,
    0.10028330,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 38)] = [
    0.89972900,
    0.10027100,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 39)] = [
    0.89994930,
    0.10005070,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 40)] = [
    0.90022210,
    0.09977790,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 41)] = [
    0.90018130,
    0.09981870,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 42)] = [
    0.90013760,
    0.09986240,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 43)] = [
    0.90041840,
    0.09958160,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 44)] = [
    0.90052330,
    0.09947670,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 45)] = [
    0.90059000,
    0.09941000,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 46)] = [
    0.90068190,
    0.09931810,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 47)] = [
    0.90091720,
    0.09908280,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 48)] = [
    0.90090690,
    0.09909310,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 49)] = [
    0.90121020,
    0.09878980,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 50)] = [
    0.90116460,
    0.09883540,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 51)] = [
    0.90143370,
    0.09856630,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 52)] = [
    0.90152910,
    0.09847090,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 53)] = [
    0.90188500,
    0.09811500,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 54)] = [
    0.90174150,
    0.09825850,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 55)] = [
    0.90197720,
    0.09802280,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 56)] = [
    0.90223990,
    0.09776010,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 57)] = [
    0.90223320,
    0.09776680,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 58)] = [
    0.90238300,
    0.09761700,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 6
    ..position = 59)] = [
    0.90259970,
    0.09740030,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 0)] = [
    0.88336290,
    0.11663710,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 1)] = [
    0.88342900,
    0.11657100,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 2)] = [
    0.88314010,
    0.11685990,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 3)] = [
    0.88350710,
    0.11649290,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 4)] = [
    0.88331990,
    0.11668010,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 5)] = [
    0.88315110,
    0.11684890,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 6)] = [
    0.88304480,
    0.11695520,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 7)] = [
    0.88303290,
    0.11696710,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 8)] = [
    0.88290120,
    0.11709880,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 9)] = [
    0.88266470,
    0.11733530,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 10)] = [
    0.88272600,
    0.11727400,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 11)] = [
    0.88269150,
    0.11730850,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 12)] = [
    0.88256530,
    0.11743470,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 13)] = [
    0.88241170,
    0.11758830,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 14)] = [
    0.88224500,
    0.11775500,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 15)] = [
    0.88225510,
    0.11774490,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 16)] = [
    0.88217610,
    0.11782390,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 17)] = [
    0.88219510,
    0.11780490,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 18)] = [
    0.88223200,
    0.11776800,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 19)] = [
    0.88210890,
    0.11789110,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 20)] = [
    0.88231000,
    0.11769000,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 21)] = [
    0.88207810,
    0.11792190,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 22)] = [
    0.88205460,
    0.11794540,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 23)] = [
    0.88225540,
    0.11774460,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 24)] = [
    0.88201160,
    0.11798840,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 25)] = [
    0.88217860,
    0.11782140,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 26)] = [
    0.88235000,
    0.11765000,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 27)] = [
    0.88216440,
    0.11783560,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 28)] = [
    0.88240050,
    0.11759950,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 29)] = [
    0.88223800,
    0.11776200,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 30)] = [
    0.88253640,
    0.11746360,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 31)] = [
    0.88253140,
    0.11746860,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 32)] = [
    0.88255750,
    0.11744250,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 33)] = [
    0.88254050,
    0.11745950,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 34)] = [
    0.88269870,
    0.11730130,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 35)] = [
    0.88288150,
    0.11711850,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 36)] = [
    0.88294690,
    0.11705310,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 37)] = [
    0.88301590,
    0.11698410,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 38)] = [
    0.88314880,
    0.11685120,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 39)] = [
    0.88317850,
    0.11682150,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 40)] = [
    0.88338240,
    0.11661760,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 41)] = [
    0.88376610,
    0.11623390,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 42)] = [
    0.88356270,
    0.11643730,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 43)] = [
    0.88374810,
    0.11625190,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 44)] = [
    0.88378840,
    0.11621160,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 45)] = [
    0.88400950,
    0.11599050,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 46)] = [
    0.88412040,
    0.11587960,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 47)] = [
    0.88456730,
    0.11543270,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 48)] = [
    0.88449120,
    0.11550880,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 49)] = [
    0.88462290,
    0.11537710,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 50)] = [
    0.88496030,
    0.11503970,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 51)] = [
    0.88490940,
    0.11509060,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 52)] = [
    0.88501940,
    0.11498060,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 53)] = [
    0.88515280,
    0.11484720,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 54)] = [
    0.88550840,
    0.11449160,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 55)] = [
    0.88556860,
    0.11443140,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 56)] = [
    0.88557900,
    0.11442100,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 57)] = [
    0.88587650,
    0.11412350,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 58)] = [
    0.88608630,
    0.11391370,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 1
    ..mulligans = 1
    ..sample = 7
    ..position = 59)] = [
    0.88605560,
    0.11394440,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 0)] = [
    0.77422160,
    0.21339990,
    0.01237850,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 1)] = [
    0.76572790,
    0.22080420,
    0.01346790,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 2)] = [
    0.75707900,
    0.22834460,
    0.01457640,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 3)] = [
    0.74869420,
    0.23553080,
    0.01577500,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 4)] = [
    0.74056340,
    0.24250400,
    0.01693260,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 5)] = [
    0.73312170,
    0.24883080,
    0.01804750,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 6)] = [
    0.72493830,
    0.25594720,
    0.01911450,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 7)] = [
    0.72236640,
    0.25833950,
    0.01929410,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 8)] = [
    0.72559050,
    0.25563410,
    0.01877540,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 9)] = [
    0.72837490,
    0.25323210,
    0.01839300,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 10)] = [
    0.73123390,
    0.25068560,
    0.01808050,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 11)] = [
    0.73402100,
    0.24850390,
    0.01747510,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 12)] = [
    0.73703050,
    0.24581610,
    0.01715340,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 13)] = [
    0.73960230,
    0.24360640,
    0.01679130,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 14)] = [
    0.74243970,
    0.24113470,
    0.01642560,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 15)] = [
    0.74514220,
    0.23880540,
    0.01605240,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 16)] = [
    0.74770310,
    0.23662370,
    0.01567320,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 17)] = [
    0.75024420,
    0.23444940,
    0.01530640,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 18)] = [
    0.75270760,
    0.23227280,
    0.01501960,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 19)] = [
    0.75531960,
    0.22997500,
    0.01470540,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 20)] = [
    0.75807800,
    0.22755400,
    0.01436800,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 21)] = [
    0.76034850,
    0.22551440,
    0.01413710,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 22)] = [
    0.76281380,
    0.22346620,
    0.01372000,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 23)] = [
    0.76503440,
    0.22156440,
    0.01340120,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 24)] = [
    0.76755750,
    0.21926100,
    0.01318150,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 25)] = [
    0.76984920,
    0.21719340,
    0.01295740,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 26)] = [
    0.77198120,
    0.21540940,
    0.01260940,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 27)] = [
    0.77437460,
    0.21327190,
    0.01235350,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 28)] = [
    0.77645350,
    0.21143180,
    0.01211470,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 29)] = [
    0.77862680,
    0.20950090,
    0.01187230,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 30)] = [
    0.78109050,
    0.20735390,
    0.01155560,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 31)] = [
    0.78260950,
    0.20597520,
    0.01141530,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 32)] = [
    0.78506760,
    0.20386160,
    0.01107080,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 33)] = [
    0.78689170,
    0.20220930,
    0.01089900,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 34)] = [
    0.78891490,
    0.20038820,
    0.01069690,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 35)] = [
    0.79089360,
    0.19864390,
    0.01046250,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 36)] = [
    0.79271370,
    0.19698430,
    0.01030200,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 37)] = [
    0.79485660,
    0.19508360,
    0.01005980,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 38)] = [
    0.79682950,
    0.19322110,
    0.00994940,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 39)] = [
    0.79857830,
    0.19168710,
    0.00973460,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 40)] = [
    0.80046220,
    0.19005470,
    0.00948310,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 41)] = [
    0.80201730,
    0.18869110,
    0.00929160,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 42)] = [
    0.80368540,
    0.18710570,
    0.00920890,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 43)] = [
    0.80557080,
    0.18541890,
    0.00901030,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 44)] = [
    0.80739840,
    0.18378980,
    0.00881180,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 45)] = [
    0.80889280,
    0.18243260,
    0.00867460,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 46)] = [
    0.81063770,
    0.18085710,
    0.00850520,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 47)] = [
    0.81228390,
    0.17936340,
    0.00835270,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 48)] = [
    0.81369330,
    0.17809800,
    0.00820870,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 49)] = [
    0.81550250,
    0.17644350,
    0.00805400,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 50)] = [
    0.81712010,
    0.17493620,
    0.00794370,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 51)] = [
    0.81813530,
    0.17409790,
    0.00776680,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 52)] = [
    0.81987230,
    0.17246690,
    0.00766080,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 53)] = [
    0.82154270,
    0.17094840,
    0.00750890,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 54)] = [
    0.82295940,
    0.16971110,
    0.00732950,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 55)] = [
    0.82448860,
    0.16826280,
    0.00724860,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 56)] = [
    0.82572230,
    0.16713920,
    0.00713850,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 57)] = [
    0.82704970,
    0.16595830,
    0.00699200,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 0
    ..sample = 7
    ..position = 58)] = [
    0.82846360,
    0.16464240,
    0.00689400,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 0)] = [
    0.80847960,
    0.18306260,
    0.00845780,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 1)] = [
    0.80852780,
    0.18301060,
    0.00846160,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 2)] = [
    0.80864390,
    0.18289990,
    0.00845620,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 3)] = [
    0.80831700,
    0.18317520,
    0.00850780,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 4)] = [
    0.80841810,
    0.18315480,
    0.00842710,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 5)] = [
    0.80837770,
    0.18313770,
    0.00848460,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 6)] = [
    0.80806610,
    0.18343970,
    0.00849420,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 7)] = [
    0.80758000,
    0.18391310,
    0.00850690,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 8)] = [
    0.80773910,
    0.18369860,
    0.00856230,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 9)] = [
    0.80737980,
    0.18400800,
    0.00861220,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 10)] = [
    0.80722910,
    0.18417010,
    0.00860080,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 11)] = [
    0.80700790,
    0.18433600,
    0.00865610,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 12)] = [
    0.80717720,
    0.18415700,
    0.00866580,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 13)] = [
    0.80687170,
    0.18445150,
    0.00867680,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 14)] = [
    0.80688150,
    0.18445700,
    0.00866150,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 15)] = [
    0.80671990,
    0.18461860,
    0.00866150,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 16)] = [
    0.80645020,
    0.18487920,
    0.00867060,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 17)] = [
    0.80642920,
    0.18488240,
    0.00868840,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 18)] = [
    0.80646560,
    0.18489280,
    0.00864160,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 19)] = [
    0.80657250,
    0.18474760,
    0.00867990,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 20)] = [
    0.80669250,
    0.18465940,
    0.00864810,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 21)] = [
    0.80634880,
    0.18495640,
    0.00869480,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 22)] = [
    0.80650830,
    0.18483520,
    0.00865650,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 23)] = [
    0.80637600,
    0.18491890,
    0.00870510,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 24)] = [
    0.80649830,
    0.18484140,
    0.00866030,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 25)] = [
    0.80662930,
    0.18468970,
    0.00868100,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 26)] = [
    0.80677770,
    0.18456800,
    0.00865430,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 27)] = [
    0.80700940,
    0.18436060,
    0.00863000,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 28)] = [
    0.80692000,
    0.18448000,
    0.00860000,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 29)] = [
    0.80696210,
    0.18441380,
    0.00862410,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 30)] = [
    0.80692940,
    0.18447030,
    0.00860030,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 31)] = [
    0.80716380,
    0.18428910,
    0.00854710,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 32)] = [
    0.80741230,
    0.18399910,
    0.00858860,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 33)] = [
    0.80756730,
    0.18385970,
    0.00857300,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 34)] = [
    0.80764470,
    0.18381300,
    0.00854230,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 35)] = [
    0.80777820,
    0.18373030,
    0.00849150,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 36)] = [
    0.80801360,
    0.18346580,
    0.00852060,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 37)] = [
    0.80800870,
    0.18350630,
    0.00848500,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 38)] = [
    0.80841170,
    0.18311820,
    0.00847010,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 39)] = [
    0.80844150,
    0.18308320,
    0.00847530,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 40)] = [
    0.80842640,
    0.18307500,
    0.00849860,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 41)] = [
    0.80907810,
    0.18246920,
    0.00845270,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 42)] = [
    0.80899220,
    0.18257910,
    0.00842870,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 43)] = [
    0.80915470,
    0.18247480,
    0.00837050,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 44)] = [
    0.80955040,
    0.18202950,
    0.00842010,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 45)] = [
    0.80969800,
    0.18192310,
    0.00837890,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 46)] = [
    0.80971060,
    0.18193580,
    0.00835360,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 47)] = [
    0.81011570,
    0.18159130,
    0.00829300,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 48)] = [
    0.81051940,
    0.18118630,
    0.00829430,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 49)] = [
    0.81082960,
    0.18091780,
    0.00825260,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 50)] = [
    0.81092650,
    0.18084000,
    0.00823350,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 51)] = [
    0.81116630,
    0.18060270,
    0.00823100,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 52)] = [
    0.81176600,
    0.18003460,
    0.00819940,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 53)] = [
    0.81184540,
    0.17997660,
    0.00817800,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 54)] = [
    0.81200480,
    0.17986820,
    0.00812700,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 55)] = [
    0.81220930,
    0.17969040,
    0.00810030,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 56)] = [
    0.81249080,
    0.17940460,
    0.00810460,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 57)] = [
    0.81257660,
    0.17932460,
    0.00809880,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 6
    ..position = 58)] = [
    0.81291060,
    0.17901520,
    0.00807420,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 0)] = [
    0.77875970,
    0.20940960,
    0.01183070,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 1)] = [
    0.77858550,
    0.20959330,
    0.01182120,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 2)] = [
    0.77846810,
    0.20966600,
    0.01186590,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 3)] = [
    0.77848290,
    0.20965150,
    0.01186560,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 4)] = [
    0.77838020,
    0.20975230,
    0.01186750,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 5)] = [
    0.77847860,
    0.20964760,
    0.01187380,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 6)] = [
    0.77800590,
    0.21003840,
    0.01195570,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 7)] = [
    0.77783180,
    0.21021640,
    0.01195180,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 8)] = [
    0.77759870,
    0.21041430,
    0.01198700,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 9)] = [
    0.77763500,
    0.21044930,
    0.01191570,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 10)] = [
    0.77730950,
    0.21070130,
    0.01198920,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 11)] = [
    0.77683100,
    0.21110460,
    0.01206440,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 12)] = [
    0.77706490,
    0.21084710,
    0.01208800,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 13)] = [
    0.77684150,
    0.21107030,
    0.01208820,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 14)] = [
    0.77657640,
    0.21138560,
    0.01203800,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 15)] = [
    0.77649880,
    0.21141350,
    0.01208770,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 16)] = [
    0.77656730,
    0.21133630,
    0.01209640,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 17)] = [
    0.77645390,
    0.21144310,
    0.01210300,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 18)] = [
    0.77622050,
    0.21166540,
    0.01211410,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 19)] = [
    0.77646310,
    0.21145080,
    0.01208610,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 20)] = [
    0.77638800,
    0.21150480,
    0.01210720,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 21)] = [
    0.77608860,
    0.21170980,
    0.01220160,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 22)] = [
    0.77644230,
    0.21147480,
    0.01208290,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 23)] = [
    0.77633440,
    0.21153490,
    0.01213070,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 24)] = [
    0.77668530,
    0.21122680,
    0.01208790,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 25)] = [
    0.77668320,
    0.21120700,
    0.01210980,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 26)] = [
    0.77658620,
    0.21126430,
    0.01214950,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 27)] = [
    0.77676250,
    0.21115290,
    0.01208460,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 28)] = [
    0.77666280,
    0.21123780,
    0.01209940,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 29)] = [
    0.77692920,
    0.21102860,
    0.01204220,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 30)] = [
    0.77700290,
    0.21095540,
    0.01204170,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 31)] = [
    0.77709210,
    0.21086540,
    0.01204250,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 32)] = [
    0.77721830,
    0.21078070,
    0.01200100,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 33)] = [
    0.77758530,
    0.21040350,
    0.01201120,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 34)] = [
    0.77755510,
    0.21046880,
    0.01197610,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 35)] = [
    0.77786010,
    0.21017520,
    0.01196470,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 36)] = [
    0.77799480,
    0.21008810,
    0.01191710,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 37)] = [
    0.77811540,
    0.21001300,
    0.01187160,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 38)] = [
    0.77847480,
    0.20969670,
    0.01182850,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 39)] = [
    0.77849020,
    0.20966580,
    0.01184400,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 40)] = [
    0.77865010,
    0.20951130,
    0.01183860,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 41)] = [
    0.77896510,
    0.20916390,
    0.01187100,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 42)] = [
    0.77919130,
    0.20905090,
    0.01175780,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 43)] = [
    0.77942760,
    0.20877110,
    0.01180130,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 44)] = [
    0.77980850,
    0.20847960,
    0.01171190,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 45)] = [
    0.78006300,
    0.20821100,
    0.01172600,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 46)] = [
    0.78001260,
    0.20826880,
    0.01171860,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 47)] = [
    0.78037840,
    0.20803040,
    0.01159120,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 48)] = [
    0.78058280,
    0.20783650,
    0.01158070,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 49)] = [
    0.78113390,
    0.20729130,
    0.01157480,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 50)] = [
    0.78131850,
    0.20713440,
    0.01154710,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 51)] = [
    0.78136860,
    0.20712330,
    0.01150810,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 52)] = [
    0.78163090,
    0.20684140,
    0.01152770,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 53)] = [
    0.78200910,
    0.20653310,
    0.01145780,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 54)] = [
    0.78214590,
    0.20641640,
    0.01143770,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 55)] = [
    0.78264730,
    0.20599380,
    0.01135890,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 56)] = [
    0.78279500,
    0.20583480,
    0.01137020,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 57)] = [
    0.78328970,
    0.20533470,
    0.01137560,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 2
    ..mulligans = 1
    ..sample = 7
    ..position = 58)] = [
    0.78363460,
    0.20511490,
    0.01125050,
    0,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 0)] = [
    0.67291370,
    0.29060930,
    0.03530770,
    0.00116930,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 1)] = [
    0.66151650,
    0.29904960,
    0.03809600,
    0.00133790,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 2)] = [
    0.65047940,
    0.30710580,
    0.04091680,
    0.00149800,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 3)] = [
    0.63998600,
    0.31441650,
    0.04390880,
    0.00168870,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 4)] = [
    0.62967120,
    0.32164260,
    0.04677950,
    0.00190670,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 5)] = [
    0.61930010,
    0.32910100,
    0.04952740,
    0.00207150,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 6)] = [
    0.61351700,
    0.33351170,
    0.05086670,
    0.00210460,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 7)] = [
    0.61234800,
    0.33456340,
    0.05098240,
    0.00210620,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 8)] = [
    0.61663930,
    0.33151290,
    0.04982870,
    0.00201910,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 9)] = [
    0.61991170,
    0.32951500,
    0.04864010,
    0.00193320,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 10)] = [
    0.62374960,
    0.32671470,
    0.04765470,
    0.00188100,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 11)] = [
    0.62752980,
    0.32396280,
    0.04668120,
    0.00182620,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 12)] = [
    0.63124540,
    0.32132990,
    0.04566860,
    0.00175610,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 13)] = [
    0.63446300,
    0.31910690,
    0.04473630,
    0.00169380,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 14)] = [
    0.63820070,
    0.31645870,
    0.04370350,
    0.00163710,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 15)] = [
    0.64187080,
    0.31382910,
    0.04272500,
    0.00157510,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 16)] = [
    0.64545860,
    0.31117950,
    0.04182500,
    0.00153690,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 17)] = [
    0.64862900,
    0.30880310,
    0.04107670,
    0.00149120,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 18)] = [
    0.65222660,
    0.30614470,
    0.04018540,
    0.00144330,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 19)] = [
    0.65527510,
    0.30398120,
    0.03937580,
    0.00136790,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 20)] = [
    0.65872480,
    0.30144070,
    0.03850020,
    0.00133430,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 21)] = [
    0.66203120,
    0.29891790,
    0.03773710,
    0.00131380,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 22)] = [
    0.66476790,
    0.29689200,
    0.03710190,
    0.00123820,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 23)] = [
    0.66821770,
    0.29434310,
    0.03622350,
    0.00121570,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 24)] = [
    0.67122120,
    0.29206330,
    0.03554200,
    0.00117350,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 25)] = [
    0.67463940,
    0.28942240,
    0.03480430,
    0.00113390,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 26)] = [
    0.67740210,
    0.28739430,
    0.03410030,
    0.00110330,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 27)] = [
    0.68018880,
    0.28520130,
    0.03352590,
    0.00108400,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 28)] = [
    0.68324140,
    0.28288770,
    0.03282530,
    0.00104560,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 29)] = [
    0.68593660,
    0.28079900,
    0.03225910,
    0.00100530,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 30)] = [
    0.68883220,
    0.27861830,
    0.03157170,
    0.00097780,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 31)] = [
    0.69189470,
    0.27627030,
    0.03090010,
    0.00093490,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 32)] = [
    0.69470440,
    0.27407210,
    0.03033550,
    0.00088800,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 33)] = [
    0.69735630,
    0.27201510,
    0.02974830,
    0.00088030,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 34)] = [
    0.69991500,
    0.27006510,
    0.02916860,
    0.00085130,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 35)] = [
    0.70266910,
    0.26787780,
    0.02862090,
    0.00083220,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 36)] = [
    0.70508290,
    0.26598630,
    0.02813510,
    0.00079570,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 37)] = [
    0.70764090,
    0.26393420,
    0.02762880,
    0.00079610,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 38)] = [
    0.71024320,
    0.26185860,
    0.02713980,
    0.00075840,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 39)] = [
    0.71233630,
    0.26035090,
    0.02658660,
    0.00072620,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 40)] = [
    0.71516730,
    0.25805090,
    0.02607360,
    0.00070820,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 41)] = [
    0.71763870,
    0.25602160,
    0.02564150,
    0.00069820,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 42)] = [
    0.71988690,
    0.25424830,
    0.02520160,
    0.00066320,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 43)] = [
    0.72245860,
    0.25219080,
    0.02468710,
    0.00066350,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 44)] = [
    0.72442290,
    0.25062900,
    0.02431800,
    0.00063010,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 45)] = [
    0.72701610,
    0.24852720,
    0.02383670,
    0.00062000,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 46)] = [
    0.72909890,
    0.24692550,
    0.02337920,
    0.00059640,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 47)] = [
    0.73138170,
    0.24500430,
    0.02301420,
    0.00059980,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 48)] = [
    0.73365140,
    0.24311100,
    0.02266440,
    0.00057320,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 49)] = [
    0.73573800,
    0.24151070,
    0.02219600,
    0.00055530,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 50)] = [
    0.73773180,
    0.23987740,
    0.02186020,
    0.00053060,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 51)] = [
    0.73997880,
    0.23801520,
    0.02147810,
    0.00052790,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 52)] = [
    0.74194740,
    0.23639810,
    0.02113060,
    0.00052390,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 53)] = [
    0.74388670,
    0.23480270,
    0.02080630,
    0.00050430,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 54)] = [
    0.74581320,
    0.23313700,
    0.02055140,
    0.00049840,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 55)] = [
    0.74778500,
    0.23157020,
    0.02016090,
    0.00048390,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 56)] = [
    0.75001250,
    0.22980690,
    0.01970650,
    0.00047410,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 0
    ..sample = 7
    ..position = 57)] = [
    0.75177520,
    0.22835380,
    0.01942480,
    0.00044620,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 0)] = [
    0.72519950,
    0.25065000,
    0.02357230,
    0.00057820,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 1)] = [
    0.72492370,
    0.25085210,
    0.02365340,
    0.00057080,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 2)] = [
    0.72486190,
    0.25093980,
    0.02362430,
    0.00057400,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 3)] = [
    0.72464750,
    0.25105350,
    0.02371720,
    0.00058180,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 4)] = [
    0.72455990,
    0.25112870,
    0.02373890,
    0.00057250,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 5)] = [
    0.72434600,
    0.25123010,
    0.02383010,
    0.00059380,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 6)] = [
    0.72416660,
    0.25147900,
    0.02375710,
    0.00059730,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 7)] = [
    0.72383260,
    0.25173990,
    0.02383400,
    0.00059350,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 8)] = [
    0.72344300,
    0.25197170,
    0.02397690,
    0.00060840,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 9)] = [
    0.72309450,
    0.25232120,
    0.02398340,
    0.00060090,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 10)] = [
    0.72292980,
    0.25243470,
    0.02403220,
    0.00060330,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 11)] = [
    0.72290400,
    0.25243200,
    0.02405840,
    0.00060560,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 12)] = [
    0.72264150,
    0.25266690,
    0.02409190,
    0.00059970,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 13)] = [
    0.72261270,
    0.25271460,
    0.02407210,
    0.00060060,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 14)] = [
    0.72240170,
    0.25292420,
    0.02406710,
    0.00060700,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 15)] = [
    0.72246140,
    0.25288130,
    0.02405720,
    0.00060010,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 16)] = [
    0.72209190,
    0.25308830,
    0.02421050,
    0.00060930,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 17)] = [
    0.72209550,
    0.25311310,
    0.02417070,
    0.00062070,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 18)] = [
    0.72208570,
    0.25312030,
    0.02419330,
    0.00060070,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 19)] = [
    0.72209900,
    0.25310370,
    0.02419190,
    0.00060540,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 20)] = [
    0.72234820,
    0.25294430,
    0.02409640,
    0.00061110,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 21)] = [
    0.72234960,
    0.25299810,
    0.02404620,
    0.00060610,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 22)] = [
    0.72209980,
    0.25307980,
    0.02421540,
    0.00060500,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 23)] = [
    0.72241780,
    0.25280340,
    0.02416340,
    0.00061540,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 24)] = [
    0.72208660,
    0.25304820,
    0.02426410,
    0.00060110,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 25)] = [
    0.72271080,
    0.25262350,
    0.02405770,
    0.00060800,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 26)] = [
    0.72240410,
    0.25290050,
    0.02408670,
    0.00060870,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 27)] = [
    0.72264930,
    0.25266320,
    0.02409920,
    0.00058830,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 28)] = [
    0.72263510,
    0.25264630,
    0.02411010,
    0.00060850,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 29)] = [
    0.72252650,
    0.25288400,
    0.02399130,
    0.00059820,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 30)] = [
    0.72318310,
    0.25227080,
    0.02393930,
    0.00060680,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 31)] = [
    0.72329480,
    0.25222920,
    0.02388940,
    0.00058660,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 32)] = [
    0.72330820,
    0.25216360,
    0.02393190,
    0.00059630,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 33)] = [
    0.72367540,
    0.25181320,
    0.02391600,
    0.00059540,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 34)] = [
    0.72380060,
    0.25174400,
    0.02386090,
    0.00059450,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 35)] = [
    0.72394390,
    0.25164590,
    0.02381300,
    0.00059720,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 36)] = [
    0.72429530,
    0.25128440,
    0.02384000,
    0.00058030,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 37)] = [
    0.72467700,
    0.25103390,
    0.02369330,
    0.00059580,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 38)] = [
    0.72477420,
    0.25098430,
    0.02367210,
    0.00056940,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 39)] = [
    0.72498840,
    0.25079690,
    0.02363640,
    0.00057830,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 40)] = [
    0.72535640,
    0.25043840,
    0.02362560,
    0.00057960,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 41)] = [
    0.72563190,
    0.25022240,
    0.02356610,
    0.00057960,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 42)] = [
    0.72567170,
    0.25025270,
    0.02349620,
    0.00057940,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 43)] = [
    0.72621560,
    0.24990160,
    0.02331310,
    0.00056970,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 44)] = [
    0.72640770,
    0.24971360,
    0.02330950,
    0.00056920,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 45)] = [
    0.72683680,
    0.24925640,
    0.02334160,
    0.00056520,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 46)] = [
    0.72702300,
    0.24919100,
    0.02322640,
    0.00055960,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 47)] = [
    0.72710970,
    0.24910510,
    0.02321990,
    0.00056530,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 48)] = [
    0.72766750,
    0.24850050,
    0.02326200,
    0.00057000,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 49)] = [
    0.72817310,
    0.24808350,
    0.02319150,
    0.00055190,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 50)] = [
    0.72833920,
    0.24807430,
    0.02302120,
    0.00056530,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 51)] = [
    0.72835180,
    0.24813660,
    0.02295530,
    0.00055630,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 52)] = [
    0.72925460,
    0.24733870,
    0.02286240,
    0.00054430,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 53)] = [
    0.72945410,
    0.24725770,
    0.02275870,
    0.00052950,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 54)] = [
    0.72971880,
    0.24696620,
    0.02275450,
    0.00056050,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 55)] = [
    0.73023940,
    0.24655600,
    0.02265800,
    0.00054660,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 56)] = [
    0.73032850,
    0.24646210,
    0.02266810,
    0.00054130,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 6
    ..position = 57)] = [
    0.73068780,
    0.24623260,
    0.02253260,
    0.00054700,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 0)] = [
    0.68460080,
    0.28197320,
    0.03240490,
    0.00102110,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 1)] = [
    0.68445700,
    0.28202010,
    0.03250660,
    0.00101630,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 2)] = [
    0.68482980,
    0.28162420,
    0.03253340,
    0.00101260,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 3)] = [
    0.68450640,
    0.28184580,
    0.03261420,
    0.00103360,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 4)] = [
    0.68426990,
    0.28217860,
    0.03254190,
    0.00100960,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 5)] = [
    0.68422630,
    0.28221410,
    0.03254530,
    0.00101430,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 6)] = [
    0.68379590,
    0.28249190,
    0.03267600,
    0.00103620,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 7)] = [
    0.68366670,
    0.28255950,
    0.03272920,
    0.00104460,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 8)] = [
    0.68344060,
    0.28280420,
    0.03272770,
    0.00102750,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 9)] = [
    0.68315240,
    0.28293680,
    0.03286360,
    0.00104720,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 10)] = [
    0.68284010,
    0.28314530,
    0.03296460,
    0.00105000,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 11)] = [
    0.68256350,
    0.28341410,
    0.03297860,
    0.00104380,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 12)] = [
    0.68208720,
    0.28379690,
    0.03305710,
    0.00105880,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 13)] = [
    0.68217430,
    0.28372660,
    0.03304340,
    0.00105570,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 14)] = [
    0.68218130,
    0.28365420,
    0.03310500,
    0.00105950,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 15)] = [
    0.68177500,
    0.28407480,
    0.03310960,
    0.00104060,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 16)] = [
    0.68195290,
    0.28380060,
    0.03318700,
    0.00105950,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 17)] = [
    0.68165190,
    0.28411960,
    0.03318510,
    0.00104340,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 18)] = [
    0.68178380,
    0.28396940,
    0.03316730,
    0.00107950,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 19)] = [
    0.68174740,
    0.28395650,
    0.03323520,
    0.00106090,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 20)] = [
    0.68162070,
    0.28410360,
    0.03322400,
    0.00105170,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 21)] = [
    0.68171230,
    0.28403280,
    0.03320140,
    0.00105350,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 22)] = [
    0.68181010,
    0.28404170,
    0.03310290,
    0.00104530,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 23)] = [
    0.68198610,
    0.28383820,
    0.03312710,
    0.00104860,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 24)] = [
    0.68170350,
    0.28415540,
    0.03307750,
    0.00106360,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 25)] = [
    0.68172480,
    0.28402320,
    0.03320230,
    0.00104970,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 26)] = [
    0.68208100,
    0.28374220,
    0.03309820,
    0.00107860,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 27)] = [
    0.68217470,
    0.28365180,
    0.03312650,
    0.00104700,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 28)] = [
    0.68221880,
    0.28377310,
    0.03296820,
    0.00103990,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 29)] = [
    0.68241580,
    0.28357840,
    0.03293900,
    0.00106680,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 30)] = [
    0.68262410,
    0.28332250,
    0.03299960,
    0.00105380,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 31)] = [
    0.68287750,
    0.28319640,
    0.03286880,
    0.00105730,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 32)] = [
    0.68301380,
    0.28308330,
    0.03286490,
    0.00103800,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 33)] = [
    0.68310980,
    0.28298220,
    0.03286920,
    0.00103880,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 34)] = [
    0.68305940,
    0.28309940,
    0.03280900,
    0.00103220,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 35)] = [
    0.68372470,
    0.28258050,
    0.03267460,
    0.00102020,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 36)] = [
    0.68397050,
    0.28229920,
    0.03270300,
    0.00102730,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 37)] = [
    0.68401080,
    0.28237910,
    0.03259250,
    0.00101760,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 38)] = [
    0.68458050,
    0.28182680,
    0.03257590,
    0.00101680,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 39)] = [
    0.68467800,
    0.28179480,
    0.03250390,
    0.00102330,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 40)] = [
    0.68485520,
    0.28177690,
    0.03235020,
    0.00101770,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 41)] = [
    0.68533680,
    0.28128730,
    0.03235570,
    0.00102020,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 42)] = [
    0.68562500,
    0.28100860,
    0.03235660,
    0.00100980,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 43)] = [
    0.68587070,
    0.28087380,
    0.03224900,
    0.00100650,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 44)] = [
    0.68627440,
    0.28057010,
    0.03213330,
    0.00102220,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 45)] = [
    0.68666180,
    0.28016830,
    0.03217770,
    0.00099220,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 46)] = [
    0.68653200,
    0.28040040,
    0.03206550,
    0.00100210,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 47)] = [
    0.68707260,
    0.27995890,
    0.03197660,
    0.00099190,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 48)] = [
    0.68765070,
    0.27956580,
    0.03181010,
    0.00097340,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 49)] = [
    0.68821110,
    0.27907210,
    0.03175300,
    0.00096380,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 50)] = [
    0.68837290,
    0.27894400,
    0.03168370,
    0.00099940,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 51)] = [
    0.68875100,
    0.27870030,
    0.03158920,
    0.00095950,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 52)] = [
    0.68917220,
    0.27833830,
    0.03152570,
    0.00096380,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 53)] = [
    0.68944960,
    0.27813080,
    0.03145880,
    0.00096080,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 54)] = [
    0.68987760,
    0.27776310,
    0.03140580,
    0.00095350,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 55)] = [
    0.69030490,
    0.27743260,
    0.03127920,
    0.00098330,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 56)] = [
    0.69061330,
    0.27718890,
    0.03123960,
    0.00095820,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 3
    ..mulligans = 1
    ..sample = 7
    ..position = 57)] = [
    0.69098900,
    0.27692980,
    0.03112340,
    0.00095780,
    0,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 0)] = [
    0.58010730,
    0.34864950,
    0.06653700,
    0.00461360,
    0.00009260,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 1)] = [
    0.56748060,
    0.35592260,
    0.07129810,
    0.00518290,
    0.00011580,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 2)] = [
    0.55438970,
    0.36371780,
    0.07591800,
    0.00583810,
    0.00013640,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 3)] = [
    0.54235100,
    0.37012510,
    0.08085360,
    0.00651320,
    0.00015710,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 4)] = [
    0.53004390,
    0.37699210,
    0.08564080,
    0.00714290,
    0.00018030,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 5)] = [
    0.52177190,
    0.38219890,
    0.08835960,
    0.00748280,
    0.00018680,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 6)] = [
    0.51821730,
    0.38418400,
    0.08978590,
    0.00761850,
    0.00019430,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 7)] = [
    0.51828790,
    0.38485010,
    0.08916180,
    0.00750960,
    0.00019060,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 8)] = [
    0.52271630,
    0.38221160,
    0.08766130,
    0.00723370,
    0.00017710,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 9)] = [
    0.52691460,
    0.38008280,
    0.08587630,
    0.00695090,
    0.00017540,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 10)] = [
    0.53131370,
    0.37763740,
    0.08411450,
    0.00677720,
    0.00015720,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 11)] = [
    0.53547670,
    0.37528480,
    0.08253310,
    0.00655550,
    0.00014990,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 12)] = [
    0.53966160,
    0.37302680,
    0.08081970,
    0.00635340,
    0.00013850,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 13)] = [
    0.54397510,
    0.37059350,
    0.07916670,
    0.00612240,
    0.00014230,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 14)] = [
    0.54793510,
    0.36840770,
    0.07759310,
    0.00593110,
    0.00013300,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 15)] = [
    0.55219670,
    0.36587530,
    0.07606780,
    0.00573640,
    0.00012380,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 16)] = [
    0.55593610,
    0.36370000,
    0.07469960,
    0.00554320,
    0.00012110,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 17)] = [
    0.55976690,
    0.36157100,
    0.07321350,
    0.00533470,
    0.00011390,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 18)] = [
    0.56371740,
    0.35929590,
    0.07169090,
    0.00518850,
    0.00010730,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 19)] = [
    0.56771040,
    0.35680300,
    0.07037710,
    0.00500310,
    0.00010640,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 20)] = [
    0.57179880,
    0.35428890,
    0.06897990,
    0.00483040,
    0.00010200,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 21)] = [
    0.57521700,
    0.35230190,
    0.06767110,
    0.00471590,
    0.00009410,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 22)] = [
    0.57908060,
    0.35002030,
    0.06620610,
    0.00460690,
    0.00008610,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 23)] = [
    0.58280960,
    0.34774260,
    0.06494160,
    0.00441590,
    0.00009030,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 24)] = [
    0.58669970,
    0.34502500,
    0.06387060,
    0.00432210,
    0.00008260,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 25)] = [
    0.59018180,
    0.34291870,
    0.06264940,
    0.00417040,
    0.00007970,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 26)] = [
    0.59353380,
    0.34084810,
    0.06148770,
    0.00405380,
    0.00007660,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 27)] = [
    0.59712870,
    0.33836290,
    0.06051330,
    0.00392000,
    0.00007510,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 28)] = [
    0.60045180,
    0.33633420,
    0.05936980,
    0.00377030,
    0.00007390,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 29)] = [
    0.60416150,
    0.33390740,
    0.05819070,
    0.00367220,
    0.00006820,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 30)] = [
    0.60719380,
    0.33198830,
    0.05716880,
    0.00358570,
    0.00006340,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 31)] = [
    0.61065200,
    0.32986160,
    0.05598700,
    0.00343920,
    0.00006020,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 32)] = [
    0.61394780,
    0.32768630,
    0.05497390,
    0.00332920,
    0.00006280,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 33)] = [
    0.61716970,
    0.32540570,
    0.05410320,
    0.00326330,
    0.00005810,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 34)] = [
    0.62022150,
    0.32345550,
    0.05310540,
    0.00316190,
    0.00005570,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 35)] = [
    0.62351190,
    0.32118210,
    0.05218030,
    0.00306830,
    0.00005740,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 36)] = [
    0.62641470,
    0.31917810,
    0.05136730,
    0.00299260,
    0.00004730,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 37)] = [
    0.62952170,
    0.31718240,
    0.05031580,
    0.00292790,
    0.00005220,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 38)] = [
    0.63276960,
    0.31479760,
    0.04957680,
    0.00280950,
    0.00004650,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 39)] = [
    0.63566470,
    0.31294040,
    0.04859350,
    0.00275460,
    0.00004680,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 40)] = [
    0.63860570,
    0.31096570,
    0.04771530,
    0.00266790,
    0.00004540,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 41)] = [
    0.64183910,
    0.30859840,
    0.04691530,
    0.00260520,
    0.00004200,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 42)] = [
    0.64456610,
    0.30685360,
    0.04601490,
    0.00252390,
    0.00004150,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 43)] = [
    0.64737730,
    0.30483900,
    0.04531920,
    0.00242540,
    0.00003910,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 44)] = [
    0.65012900,
    0.30302680,
    0.04443980,
    0.00236880,
    0.00003560,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 45)] = [
    0.65246190,
    0.30132440,
    0.04386710,
    0.00230630,
    0.00004030,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 46)] = [
    0.65541780,
    0.29921600,
    0.04307430,
    0.00225540,
    0.00003650,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 47)] = [
    0.65811040,
    0.29736170,
    0.04229360,
    0.00220050,
    0.00003380,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 48)] = [
    0.66067580,
    0.29544230,
    0.04171750,
    0.00212950,
    0.00003490,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 49)] = [
    0.66334620,
    0.29357610,
    0.04095980,
    0.00208640,
    0.00003150,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 50)] = [
    0.66581240,
    0.29176640,
    0.04038470,
    0.00200430,
    0.00003220,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 51)] = [
    0.66831330,
    0.29003410,
    0.03966320,
    0.00195840,
    0.00003100,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 52)] = [
    0.67089490,
    0.28802010,
    0.03914080,
    0.00191540,
    0.00002880,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 53)] = [
    0.67316080,
    0.28657390,
    0.03838050,
    0.00185780,
    0.00002700,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 54)] = [
    0.67565580,
    0.28468320,
    0.03780830,
    0.00182460,
    0.00002810,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 55)] = [
    0.67831850,
    0.28262920,
    0.03723770,
    0.00178970,
    0.00002490,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 0
    ..sample = 7
    ..position = 56)] = [
    0.68033460,
    0.28127560,
    0.03663590,
    0.00172790,
    0.00002600,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 0)] = [
    0.64859010,
    0.30516860,
    0.04399230,
    0.00222130,
    0.00002770,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 1)] = [
    0.64870440,
    0.30524240,
    0.04380150,
    0.00222390,
    0.00002780,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 2)] = [
    0.64850590,
    0.30515760,
    0.04408530,
    0.00221840,
    0.00003280,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 3)] = [
    0.64857260,
    0.30502920,
    0.04414030,
    0.00222580,
    0.00003210,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 4)] = [
    0.64810620,
    0.30558680,
    0.04406660,
    0.00221390,
    0.00002650,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 5)] = [
    0.64768860,
    0.30587250,
    0.04419580,
    0.00221160,
    0.00003150,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 6)] = [
    0.64745610,
    0.30587410,
    0.04438780,
    0.00225310,
    0.00002890,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 7)] = [
    0.64697050,
    0.30621200,
    0.04453620,
    0.00224870,
    0.00003260,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 8)] = [
    0.64673090,
    0.30636300,
    0.04460150,
    0.00227400,
    0.00003060,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 9)] = [
    0.64642040,
    0.30672410,
    0.04456830,
    0.00225580,
    0.00003140,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 10)] = [
    0.64633410,
    0.30667000,
    0.04470970,
    0.00225420,
    0.00003200,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 11)] = [
    0.64581080,
    0.30716990,
    0.04472500,
    0.00226110,
    0.00003320,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 12)] = [
    0.64588300,
    0.30694940,
    0.04484700,
    0.00228560,
    0.00003500,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 13)] = [
    0.64552950,
    0.30724020,
    0.04492890,
    0.00227050,
    0.00003090,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 14)] = [
    0.64541340,
    0.30739560,
    0.04486530,
    0.00229320,
    0.00003250,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 15)] = [
    0.64546670,
    0.30730160,
    0.04491140,
    0.00228980,
    0.00003050,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 16)] = [
    0.64509210,
    0.30777040,
    0.04481690,
    0.00228730,
    0.00003330,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 17)] = [
    0.64549990,
    0.30730070,
    0.04488390,
    0.00228110,
    0.00003440,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 18)] = [
    0.64559570,
    0.30727580,
    0.04479640,
    0.00230090,
    0.00003120,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 19)] = [
    0.64530610,
    0.30753740,
    0.04480930,
    0.00231480,
    0.00003240,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 20)] = [
    0.64559700,
    0.30718230,
    0.04490880,
    0.00228110,
    0.00003080,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 21)] = [
    0.64528130,
    0.30746950,
    0.04495660,
    0.00226180,
    0.00003080,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 22)] = [
    0.64553720,
    0.30717470,
    0.04493880,
    0.00231780,
    0.00003150,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 23)] = [
    0.64562590,
    0.30732090,
    0.04474540,
    0.00227440,
    0.00003340,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 24)] = [
    0.64549330,
    0.30731150,
    0.04487660,
    0.00228350,
    0.00003510,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 25)] = [
    0.64564990,
    0.30721130,
    0.04485670,
    0.00225260,
    0.00002950,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 26)] = [
    0.64607890,
    0.30692170,
    0.04468820,
    0.00227880,
    0.00003240,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 27)] = [
    0.64578170,
    0.30708450,
    0.04482160,
    0.00228140,
    0.00003080,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 28)] = [
    0.64616590,
    0.30682320,
    0.04472770,
    0.00224900,
    0.00003420,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 29)] = [
    0.64636400,
    0.30664960,
    0.04470060,
    0.00225530,
    0.00003050,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 30)] = [
    0.64657890,
    0.30652800,
    0.04458280,
    0.00227650,
    0.00003380,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 31)] = [
    0.64674400,
    0.30649720,
    0.04446760,
    0.00225820,
    0.00003300,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 32)] = [
    0.64691300,
    0.30632320,
    0.04447450,
    0.00225990,
    0.00002940,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 33)] = [
    0.64737520,
    0.30602690,
    0.04434070,
    0.00222460,
    0.00003260,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 34)] = [
    0.64745480,
    0.30597260,
    0.04432660,
    0.00221070,
    0.00003530,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 35)] = [
    0.64753280,
    0.30590000,
    0.04428970,
    0.00224760,
    0.00002990,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 36)] = [
    0.64815280,
    0.30529640,
    0.04428720,
    0.00223040,
    0.00003320,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 37)] = [
    0.64846950,
    0.30530610,
    0.04398340,
    0.00221270,
    0.00002830,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 38)] = [
    0.64852610,
    0.30519180,
    0.04404050,
    0.00221030,
    0.00003130,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 39)] = [
    0.64880430,
    0.30493850,
    0.04401020,
    0.00221690,
    0.00003010,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 40)] = [
    0.64920600,
    0.30463430,
    0.04391360,
    0.00221530,
    0.00003080,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 41)] = [
    0.64956320,
    0.30444950,
    0.04377620,
    0.00218080,
    0.00003030,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 42)] = [
    0.64980130,
    0.30434930,
    0.04364890,
    0.00216820,
    0.00003230,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 43)] = [
    0.65034310,
    0.30389660,
    0.04355960,
    0.00217010,
    0.00003060,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 44)] = [
    0.65077250,
    0.30357540,
    0.04344920,
    0.00217020,
    0.00003270,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 45)] = [
    0.65091040,
    0.30356110,
    0.04332940,
    0.00216830,
    0.00003080,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 46)] = [
    0.65114120,
    0.30342560,
    0.04326220,
    0.00214160,
    0.00002940,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 47)] = [
    0.65175780,
    0.30291980,
    0.04314580,
    0.00214650,
    0.00003010,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 48)] = [
    0.65219900,
    0.30270420,
    0.04293200,
    0.00213620,
    0.00002860,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 49)] = [
    0.65251240,
    0.30237590,
    0.04297430,
    0.00211280,
    0.00002460,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 50)] = [
    0.65286080,
    0.30223580,
    0.04277780,
    0.00209520,
    0.00003040,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 51)] = [
    0.65340200,
    0.30183540,
    0.04260590,
    0.00212610,
    0.00003060,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 52)] = [
    0.65369930,
    0.30159620,
    0.04257960,
    0.00210250,
    0.00002240,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 53)] = [
    0.65461960,
    0.30096850,
    0.04228350,
    0.00210160,
    0.00002680,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 54)] = [
    0.65467300,
    0.30087190,
    0.04233660,
    0.00208930,
    0.00002920,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 55)] = [
    0.65500470,
    0.30080690,
    0.04210390,
    0.00205650,
    0.00002800,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 6
    ..position = 56)] = [
    0.65568090,
    0.30013890,
    0.04208640,
    0.00206320,
    0.00003060,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 0)] = [
    0.60095860,
    0.33586870,
    0.05933840,
    0.00376710,
    0.00006720,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 1)] = [
    0.60070960,
    0.33611260,
    0.05930610,
    0.00380050,
    0.00007120,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 2)] = [
    0.60068570,
    0.33618340,
    0.05924670,
    0.00381050,
    0.00007370,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 3)] = [
    0.60066090,
    0.33614020,
    0.05933910,
    0.00378900,
    0.00007080,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 4)] = [
    0.60037330,
    0.33626710,
    0.05944110,
    0.00384630,
    0.00007220,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 5)] = [
    0.59997210,
    0.33663280,
    0.05949900,
    0.00382250,
    0.00007360,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 6)] = [
    0.59970510,
    0.33669490,
    0.05967670,
    0.00384700,
    0.00007630,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 7)] = [
    0.59931090,
    0.33701260,
    0.05974410,
    0.00385380,
    0.00007860,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 8)] = [
    0.59895570,
    0.33736150,
    0.05971460,
    0.00389540,
    0.00007280,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 9)] = [
    0.59870950,
    0.33744250,
    0.05992460,
    0.00385250,
    0.00007090,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 10)] = [
    0.59834690,
    0.33749180,
    0.06019000,
    0.00389970,
    0.00007160,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 11)] = [
    0.59788610,
    0.33792980,
    0.06022940,
    0.00387940,
    0.00007530,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 12)] = [
    0.59747000,
    0.33818940,
    0.06038110,
    0.00388290,
    0.00007660,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 13)] = [
    0.59772090,
    0.33801130,
    0.06029840,
    0.00389690,
    0.00007250,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 14)] = [
    0.59728650,
    0.33848720,
    0.06025120,
    0.00390260,
    0.00007250,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 15)] = [
    0.59719740,
    0.33836500,
    0.06047010,
    0.00389170,
    0.00007580,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 16)] = [
    0.59735850,
    0.33825930,
    0.06041180,
    0.00389650,
    0.00007390,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 17)] = [
    0.59720860,
    0.33834730,
    0.06044110,
    0.00393070,
    0.00007230,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 18)] = [
    0.59700820,
    0.33854000,
    0.06045100,
    0.00392930,
    0.00007150,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 19)] = [
    0.59709650,
    0.33839750,
    0.06051410,
    0.00391800,
    0.00007390,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 20)] = [
    0.59699390,
    0.33848900,
    0.06053240,
    0.00391090,
    0.00007380,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 21)] = [
    0.59698240,
    0.33864920,
    0.06039230,
    0.00390060,
    0.00007550,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 22)] = [
    0.59707330,
    0.33849980,
    0.06041920,
    0.00393020,
    0.00007750,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 23)] = [
    0.59731980,
    0.33831870,
    0.06035810,
    0.00392820,
    0.00007520,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 24)] = [
    0.59721990,
    0.33824090,
    0.06052520,
    0.00394000,
    0.00007400,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 25)] = [
    0.59725370,
    0.33832160,
    0.06043600,
    0.00391510,
    0.00007360,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 26)] = [
    0.59798310,
    0.33779810,
    0.06022540,
    0.00391950,
    0.00007390,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 27)] = [
    0.59790190,
    0.33789200,
    0.06022290,
    0.00390850,
    0.00007470,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 28)] = [
    0.59815890,
    0.33765760,
    0.06022940,
    0.00388120,
    0.00007290,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 29)] = [
    0.59790790,
    0.33798840,
    0.06015940,
    0.00387340,
    0.00007090,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 30)] = [
    0.59792220,
    0.33804940,
    0.06007400,
    0.00388300,
    0.00007140,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 31)] = [
    0.59844290,
    0.33764770,
    0.05996330,
    0.00387620,
    0.00006990,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 32)] = [
    0.59851460,
    0.33743760,
    0.06008820,
    0.00388610,
    0.00007350,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 33)] = [
    0.59900200,
    0.33723670,
    0.05981940,
    0.00386970,
    0.00007220,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 34)] = [
    0.59911070,
    0.33732800,
    0.05966150,
    0.00382350,
    0.00007630,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 35)] = [
    0.59952930,
    0.33685960,
    0.05968840,
    0.00384940,
    0.00007330,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 36)] = [
    0.59970550,
    0.33673630,
    0.05966000,
    0.00382620,
    0.00007200,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 37)] = [
    0.60003910,
    0.33661250,
    0.05946760,
    0.00380700,
    0.00007380,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 38)] = [
    0.60023960,
    0.33647040,
    0.05938370,
    0.00383280,
    0.00007350,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 39)] = [
    0.60060750,
    0.33611860,
    0.05940790,
    0.00379380,
    0.00007220,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 40)] = [
    0.60130910,
    0.33581640,
    0.05901430,
    0.00379650,
    0.00006370,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 41)] = [
    0.60152830,
    0.33558670,
    0.05905250,
    0.00376490,
    0.00006760,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 42)] = [
    0.60190700,
    0.33543020,
    0.05883320,
    0.00375650,
    0.00007310,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 43)] = [
    0.60213270,
    0.33528620,
    0.05876970,
    0.00374190,
    0.00006950,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 44)] = [
    0.60246650,
    0.33498290,
    0.05872740,
    0.00375320,
    0.00007000,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 45)] = [
    0.60304400,
    0.33465410,
    0.05851040,
    0.00371810,
    0.00007340,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 46)] = [
    0.60346310,
    0.33429010,
    0.05847720,
    0.00370130,
    0.00006830,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 47)] = [
    0.60391630,
    0.33400610,
    0.05833960,
    0.00367270,
    0.00006530,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 48)] = [
    0.60437250,
    0.33374870,
    0.05813840,
    0.00367030,
    0.00007010,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 49)] = [
    0.60493140,
    0.33346020,
    0.05790520,
    0.00363840,
    0.00006480,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 50)] = [
    0.60507020,
    0.33328500,
    0.05790600,
    0.00367020,
    0.00006860,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 51)] = [
    0.60591320,
    0.33278740,
    0.05762430,
    0.00361310,
    0.00006200,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 52)] = [
    0.60591510,
    0.33290120,
    0.05749940,
    0.00361340,
    0.00007090,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 53)] = [
    0.60652630,
    0.33234520,
    0.05744980,
    0.00361130,
    0.00006740,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 54)] = [
    0.60698900,
    0.33212030,
    0.05724380,
    0.00358070,
    0.00006620,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 55)] = [
    0.60745930,
    0.33187660,
    0.05699770,
    0.00359670,
    0.00006970,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 4
    ..mulligans = 1
    ..sample = 7
    ..position = 56)] = [
    0.60806720,
    0.33132580,
    0.05698850,
    0.00355440,
    0.00006410,
    0,
    0,
    0
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 0
    ..sample = 7
    ..position = 0)] = [
    0.01526130,
    0.09624900,
    0.24122120,
    0.31217650,
    0.22508780,
    0.08997650,
    0.01854530,
    0.00148240
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 0
    ..sample = 7
    ..position = 1)] = [
    0.01492100,
    0.09493120,
    0.23998850,
    0.31279870,
    0.22631650,
    0.09078140,
    0.01873450,
    0.00152820
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 0
    ..sample = 7
    ..position = 2)] = [
    0.01469510,
    0.09394140,
    0.23940530,
    0.31342980,
    0.22725890,
    0.09109330,
    0.01863860,
    0.00153760
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 0
    ..sample = 7
    ..position = 3)] = [
    0.01474430,
    0.09417090,
    0.23993720,
    0.31359560,
    0.22714140,
    0.09052180,
    0.01839200,
    0.00149680
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 0
    ..sample = 7
    ..position = 4)] = [
    0.01482940,
    0.09514580,
    0.24159160,
    0.31433370,
    0.22557950,
    0.08914810,
    0.01795280,
    0.00141910
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 0
    ..sample = 7
    ..position = 5)] = [
    0.01514230,
    0.09672650,
    0.24420830,
    0.31462670,
    0.22343870,
    0.08726130,
    0.01723110,
    0.00136510
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 0
    ..sample = 7
    ..position = 6)] = [
    0.01563140,
    0.09919990,
    0.24734400,
    0.31485380,
    0.22056140,
    0.08459800,
    0.01654810,
    0.00126340
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 0
    ..sample = 7
    ..position = 7)] = [
    0.01638340,
    0.10236330,
    0.25161290,
    0.31478560,
    0.21657220,
    0.08156180,
    0.01555970,
    0.00116110
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 0
    ..sample = 7
    ..position = 8)] = [
    0.01750710,
    0.10661130,
    0.25668310,
    0.31410140,
    0.21133560,
    0.07806100,
    0.01463920,
    0.00106130
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 0
    ..sample = 7
    ..position = 9)] = [
    0.01862990,
    0.11105490,
    0.26095560,
    0.31323870,
    0.20666170,
    0.07477540,
    0.01370410,
    0.00097970
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 0
    ..sample = 7
    ..position = 10)] = [
    0.01974420,
    0.11542320,
    0.26600250,
    0.31182570,
    0.20168240,
    0.07155290,
    0.01285860,
    0.00091050
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 0
    ..sample = 7
    ..position = 11)] = [
    0.02099360,
    0.11995340,
    0.26996060,
    0.31074380,
    0.19690710,
    0.06846250,
    0.01216050,
    0.00081850
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 0
    ..sample = 7
    ..position = 12)] = [
    0.02226130,
    0.12436530,
    0.27446500,
    0.30934130,
    0.19198700,
    0.06546740,
    0.01134280,
    0.00076990
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 0
    ..sample = 7
    ..position = 13)] = [
    0.02355100,
    0.12894310,
    0.27849380,
    0.30761810,
    0.18718310,
    0.06274860,
    0.01075030,
    0.00071200
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 0
    ..sample = 7
    ..position = 14)] = [
    0.02488480,
    0.13326650,
    0.28242510,
    0.30594210,
    0.18263550,
    0.06016130,
    0.01003460,
    0.00065010
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 0
    ..sample = 7
    ..position = 15)] = [
    0.02624330,
    0.13777320,
    0.28616020,
    0.30408480,
    0.17811980,
    0.05755300,
    0.00945880,
    0.00060690
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 0
    ..sample = 7
    ..position = 16)] = [
    0.02762080,
    0.14205220,
    0.28977930,
    0.30212310,
    0.17390580,
    0.05504510,
    0.00890370,
    0.00057000
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 0
    ..sample = 7
    ..position = 17)] = [
    0.02904060,
    0.14667020,
    0.29329630,
    0.29994930,
    0.16941710,
    0.05270750,
    0.00840520,
    0.00051380
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 0
    ..sample = 7
    ..position = 18)] = [
    0.03062950,
    0.15114420,
    0.29659010,
    0.29785410,
    0.16501390,
    0.05045240,
    0.00784580,
    0.00047000
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 0
    ..sample = 7
    ..position = 19)] = [
    0.03207450,
    0.15580450,
    0.29950760,
    0.29552050,
    0.16094000,
    0.04828340,
    0.00742990,
    0.00043960
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 0
    ..sample = 7
    ..position = 20)] = [
    0.03347920,
    0.16023320,
    0.30249790,
    0.29333830,
    0.15674810,
    0.04628490,
    0.00700450,
    0.00041390
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 0
    ..sample = 7
    ..position = 21)] = [
    0.03522320,
    0.16475840,
    0.30571870,
    0.29036950,
    0.15275270,
    0.04425860,
    0.00654390,
    0.00037500
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 0
    ..sample = 7
    ..position = 22)] = [
    0.03680310,
    0.16921120,
    0.30816850,
    0.28805500,
    0.14874200,
    0.04247440,
    0.00619220,
    0.00035360
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 0
    ..sample = 7
    ..position = 23)] = [
    0.03842350,
    0.17379650,
    0.31053980,
    0.28548860,
    0.14486830,
    0.04074220,
    0.00580400,
    0.00033710
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 0
    ..sample = 7
    ..position = 24)] = [
    0.04014580,
    0.17782120,
    0.31325820,
    0.28283100,
    0.14120790,
    0.03895780,
    0.00547070,
    0.00030740
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 0
    ..sample = 7
    ..position = 25)] = [
    0.04193740,
    0.18238430,
    0.31548780,
    0.27994490,
    0.13752930,
    0.03727680,
    0.00515260,
    0.00028690
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 0
    ..sample = 7
    ..position = 26)] = [
    0.04362260,
    0.18682570,
    0.31749790,
    0.27710770,
    0.13395750,
    0.03581520,
    0.00490990,
    0.00026350
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 0
    ..sample = 7
    ..position = 27)] = [
    0.04539130,
    0.19111180,
    0.31971230,
    0.27418570,
    0.13043510,
    0.03430470,
    0.00462500,
    0.00023410
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 0
    ..sample = 7
    ..position = 28)] = [
    0.04712590,
    0.19537260,
    0.32137340,
    0.27155830,
    0.12708000,
    0.03290940,
    0.00436260,
    0.00021780
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 0
    ..sample = 7
    ..position = 29)] = [
    0.04897050,
    0.19991000,
    0.32284460,
    0.26872610,
    0.12373870,
    0.03149600,
    0.00410460,
    0.00020950
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 0
    ..sample = 7
    ..position = 30)] = [
    0.05083700,
    0.20398860,
    0.32452770,
    0.26568520,
    0.12063830,
    0.03024100,
    0.00388440,
    0.00019780
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 0
    ..sample = 7
    ..position = 31)] = [
    0.05268060,
    0.20797810,
    0.32603810,
    0.26286750,
    0.11751280,
    0.02904870,
    0.00368100,
    0.00019320
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 0
    ..sample = 7
    ..position = 32)] = [
    0.05467330,
    0.21230260,
    0.32737740,
    0.25998780,
    0.11426890,
    0.02778800,
    0.00342880,
    0.00017320
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 0
    ..sample = 7
    ..position = 33)] = [
    0.05651640,
    0.21618520,
    0.32862080,
    0.25705770,
    0.11134070,
    0.02685130,
    0.00326940,
    0.00015850
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 0
    ..sample = 7
    ..position = 34)] = [
    0.05841200,
    0.22036510,
    0.32989160,
    0.25395340,
    0.10847060,
    0.02566350,
    0.00309560,
    0.00014820
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 0
    ..sample = 7
    ..position = 35)] = [
    0.06045740,
    0.22432150,
    0.33080600,
    0.25107220,
    0.10564200,
    0.02461320,
    0.00294900,
    0.00013870
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 0
    ..sample = 7
    ..position = 36)] = [
    0.06241730,
    0.22832820,
    0.33176080,
    0.24785000,
    0.10305690,
    0.02370450,
    0.00275300,
    0.00012930
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 0
    ..sample = 7
    ..position = 37)] = [
    0.06445910,
    0.23198440,
    0.33257740,
    0.24510850,
    0.10033050,
    0.02280240,
    0.00261480,
    0.00012290
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 0
    ..sample = 7
    ..position = 38)] = [
    0.06641980,
    0.23596120,
    0.33337500,
    0.24205590,
    0.09777050,
    0.02181900,
    0.00248760,
    0.00011100
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 6
    ..position = 0)] = [
    0.05402850,
    0.21762910,
    0.34028470,
    0.26147190,
    0.10445480,
    0.02058350,
    0.00154750
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 6
    ..position = 1)] = [
    0.05377270,
    0.21785310,
    0.33969890,
    0.26164200,
    0.10484780,
    0.02062430,
    0.00156120
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 6
    ..position = 2)] = [
    0.05371030,
    0.21758850,
    0.33968850,
    0.26195660,
    0.10484060,
    0.02065710,
    0.00155840
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 6
    ..position = 3)] = [
    0.05368790,
    0.21735520,
    0.33971380,
    0.26214870,
    0.10489310,
    0.02065320,
    0.00154810
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 6
    ..position = 4)] = [
    0.05352620,
    0.21717580,
    0.33927730,
    0.26254880,
    0.10513720,
    0.02075140,
    0.00158330
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 6
    ..position = 5)] = [
    0.05347830,
    0.21664830,
    0.33989840,
    0.26228890,
    0.10523840,
    0.02085650,
    0.00159120
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 6
    ..position = 6)] = [
    0.05342200,
    0.21643270,
    0.33954300,
    0.26244420,
    0.10570410,
    0.02087520,
    0.00157880
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 6
    ..position = 7)] = [
    0.05322430,
    0.21665310,
    0.33968980,
    0.26257470,
    0.10545870,
    0.02080160,
    0.00159780
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 6
    ..position = 8)] = [
    0.05317010,
    0.21643470,
    0.33923970,
    0.26303030,
    0.10570380,
    0.02083720,
    0.00158420
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 6
    ..position = 9)] = [
    0.05320680,
    0.21640210,
    0.33940990,
    0.26283290,
    0.10564510,
    0.02093400,
    0.00156920
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 6
    ..position = 10)] = [
    0.05327270,
    0.21644110,
    0.33930420,
    0.26277070,
    0.10572070,
    0.02091290,
    0.00157770
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 6
    ..position = 11)] = [
    0.05330100,
    0.21640040,
    0.33939820,
    0.26289530,
    0.10558010,
    0.02083210,
    0.00159290
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 6
    ..position = 12)] = [
    0.05321560,
    0.21654370,
    0.33943590,
    0.26278190,
    0.10554890,
    0.02089800,
    0.00157600
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 6
    ..position = 13)] = [
    0.05325210,
    0.21639190,
    0.33962070,
    0.26266650,
    0.10557180,
    0.02092200,
    0.00157500
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 6
    ..position = 14)] = [
    0.05339280,
    0.21648630,
    0.33940110,
    0.26260890,
    0.10565710,
    0.02085580,
    0.00159800
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 6
    ..position = 15)] = [
    0.05333720,
    0.21647650,
    0.33963070,
    0.26268280,
    0.10540730,
    0.02090690,
    0.00155860
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 6
    ..position = 16)] = [
    0.05347420,
    0.21687510,
    0.33957150,
    0.26236170,
    0.10540060,
    0.02075370,
    0.00156320
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 6
    ..position = 17)] = [
    0.05354060,
    0.21704900,
    0.33964440,
    0.26226070,
    0.10524590,
    0.02068390,
    0.00157550
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 6
    ..position = 18)] = [
    0.05354610,
    0.21707900,
    0.33978520,
    0.26211400,
    0.10520850,
    0.02070190,
    0.00156530
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 6
    ..position = 19)] = [
    0.05375210,
    0.21741460,
    0.33989360,
    0.26188920,
    0.10487150,
    0.02062900,
    0.00155000
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 6
    ..position = 20)] = [
    0.05381130,
    0.21771580,
    0.34005060,
    0.26151950,
    0.10480130,
    0.02054580,
    0.00155570
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 6
    ..position = 21)] = [
    0.05389560,
    0.21794220,
    0.33988850,
    0.26171130,
    0.10443160,
    0.02057970,
    0.00155110
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 6
    ..position = 22)] = [
    0.05407850,
    0.21815280,
    0.34012800,
    0.26132800,
    0.10428900,
    0.02048430,
    0.00153940
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 6
    ..position = 23)] = [
    0.05429000,
    0.21861490,
    0.34007500,
    0.26091230,
    0.10420570,
    0.02036300,
    0.00153910
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 6
    ..position = 24)] = [
    0.05437990,
    0.21903870,
    0.33984590,
    0.26090240,
    0.10401480,
    0.02031120,
    0.00150710
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 6
    ..position = 25)] = [
    0.05457130,
    0.21925410,
    0.34015900,
    0.26053470,
    0.10368670,
    0.02026530,
    0.00152890
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 6
    ..position = 26)] = [
    0.05477790,
    0.21970820,
    0.34020690,
    0.26029580,
    0.10324570,
    0.02026320,
    0.00150230
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 6
    ..position = 27)] = [
    0.05497390,
    0.22003380,
    0.34039080,
    0.25999580,
    0.10298140,
    0.02010430,
    0.00152000
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 6
    ..position = 28)] = [
    0.05512270,
    0.22056200,
    0.34072480,
    0.25939900,
    0.10268470,
    0.01999920,
    0.00150760
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 6
    ..position = 29)] = [
    0.05538670,
    0.22095920,
    0.34053590,
    0.25922170,
    0.10251620,
    0.01988540,
    0.00149490
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 6
    ..position = 30)] = [
    0.05553240,
    0.22145380,
    0.34057910,
    0.25893500,
    0.10218290,
    0.01982110,
    0.00149570
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 6
    ..position = 31)] = [
    0.05580930,
    0.22205280,
    0.34085880,
    0.25842880,
    0.10176410,
    0.01962170,
    0.00146450
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 6
    ..position = 32)] = [
    0.05597470,
    0.22248770,
    0.34110510,
    0.25799050,
    0.10141870,
    0.01955920,
    0.00146410
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 6
    ..position = 33)] = [
    0.05614250,
    0.22281460,
    0.34115060,
    0.25784920,
    0.10115930,
    0.01943720,
    0.00144660
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 6
    ..position = 34)] = [
    0.05649020,
    0.22328420,
    0.34125770,
    0.25731530,
    0.10080750,
    0.01942110,
    0.00142400
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 6
    ..position = 35)] = [
    0.05672100,
    0.22400900,
    0.34141700,
    0.25698190,
    0.10028300,
    0.01919500,
    0.00139310
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 6
    ..position = 36)] = [
    0.05709690,
    0.22452160,
    0.34146470,
    0.25649310,
    0.09989700,
    0.01913400,
    0.00139270
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 6
    ..position = 37)] = [
    0.05718810,
    0.22514550,
    0.34164220,
    0.25588150,
    0.09960050,
    0.01911430,
    0.00142790
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 6
    ..position = 38)] = [
    0.05747310,
    0.22578490,
    0.34174720,
    0.25547680,
    0.09919000,
    0.01892900,
    0.00139900
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 7
    ..position = 0)] = [
    0.03198000,
    0.15492480,
    0.29883370,
    0.29509590,
    0.16196410,
    0.04910680,
    0.00763520,
    0.00045950
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 7
    ..position = 1)] = [
    0.03187070,
    0.15486660,
    0.29856700,
    0.29551580,
    0.16210730,
    0.04902810,
    0.00759080,
    0.00045370
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 7
    ..position = 2)] = [
    0.03180660,
    0.15446250,
    0.29857580,
    0.29551600,
    0.16239110,
    0.04916690,
    0.00761110,
    0.00047000
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 7
    ..position = 3)] = [
    0.03165900,
    0.15452040,
    0.29811180,
    0.29589820,
    0.16226090,
    0.04940560,
    0.00767160,
    0.00047250
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 7
    ..position = 4)] = [
    0.03158390,
    0.15431570,
    0.29751790,
    0.29606340,
    0.16301210,
    0.04936200,
    0.00767170,
    0.00047330
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 7
    ..position = 5)] = [
    0.03156970,
    0.15397840,
    0.29772260,
    0.29616390,
    0.16271450,
    0.04965790,
    0.00772300,
    0.00047000
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 7
    ..position = 6)] = [
    0.03157970,
    0.15378960,
    0.29790290,
    0.29604980,
    0.16292940,
    0.04953140,
    0.00774670,
    0.00047050
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 7
    ..position = 7)] = [
    0.03147330,
    0.15383050,
    0.29783780,
    0.29580940,
    0.16312860,
    0.04968190,
    0.00777120,
    0.00046730
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 7
    ..position = 8)] = [
    0.03143010,
    0.15355590,
    0.29756970,
    0.29640400,
    0.16314610,
    0.04971870,
    0.00770440,
    0.00047110
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 7
    ..position = 9)] = [
    0.03133650,
    0.15362790,
    0.29751710,
    0.29628440,
    0.16315400,
    0.04984380,
    0.00776370,
    0.00047260
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 7
    ..position = 10)] = [
    0.03130470,
    0.15355180,
    0.29732720,
    0.29628830,
    0.16348500,
    0.04982520,
    0.00774530,
    0.00047250
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 7
    ..position = 11)] = [
    0.03140420,
    0.15347070,
    0.29761790,
    0.29605720,
    0.16332020,
    0.04989560,
    0.00775600,
    0.00047820
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 7
    ..position = 12)] = [
    0.03137320,
    0.15334350,
    0.29733290,
    0.29649220,
    0.16340080,
    0.04979150,
    0.00778840,
    0.00047750
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 7
    ..position = 13)] = [
    0.03133620,
    0.15357850,
    0.29761510,
    0.29616960,
    0.16330770,
    0.04974680,
    0.00777220,
    0.00047390
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 7
    ..position = 14)] = [
    0.03146990,
    0.15326580,
    0.29788790,
    0.29618270,
    0.16321830,
    0.04976030,
    0.00774100,
    0.00047410
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 7
    ..position = 15)] = [
    0.03148530,
    0.15381880,
    0.29775440,
    0.29605070,
    0.16312740,
    0.04960540,
    0.00768650,
    0.00047150
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 7
    ..position = 16)] = [
    0.03148980,
    0.15370060,
    0.29765240,
    0.29638970,
    0.16287870,
    0.04969850,
    0.00770950,
    0.00048080
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 7
    ..position = 17)] = [
    0.03145710,
    0.15393650,
    0.29795840,
    0.29596610,
    0.16286380,
    0.04965630,
    0.00769580,
    0.00046600
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 7
    ..position = 18)] = [
    0.03159050,
    0.15400950,
    0.29795900,
    0.29601610,
    0.16282950,
    0.04947500,
    0.00766200,
    0.00045840
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 7
    ..position = 19)] = [
    0.03155730,
    0.15436430,
    0.29807680,
    0.29586140,
    0.16262340,
    0.04935340,
    0.00769950,
    0.00046390
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 7
    ..position = 20)] = [
    0.03178690,
    0.15458790,
    0.29837310,
    0.29577920,
    0.16224630,
    0.04915610,
    0.00760800,
    0.00046250
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 7
    ..position = 21)] = [
    0.03177130,
    0.15467050,
    0.29860640,
    0.29559590,
    0.16210610,
    0.04919890,
    0.00758960,
    0.00046130
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 7
    ..position = 22)] = [
    0.03192840,
    0.15531590,
    0.29842940,
    0.29545130,
    0.16169480,
    0.04912310,
    0.00760220,
    0.00045490
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 7
    ..position = 23)] = [
    0.03212410,
    0.15532760,
    0.29860940,
    0.29526910,
    0.16173680,
    0.04889090,
    0.00758200,
    0.00046010
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 7
    ..position = 24)] = [
    0.03220880,
    0.15562400,
    0.29892300,
    0.29523910,
    0.16127900,
    0.04872090,
    0.00753880,
    0.00046640
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 7
    ..position = 25)] = [
    0.03219940,
    0.15599490,
    0.29921510,
    0.29509190,
    0.16107200,
    0.04847180,
    0.00750090,
    0.00045400
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 7
    ..position = 26)] = [
    0.03238850,
    0.15659320,
    0.29970830,
    0.29453120,
    0.16054340,
    0.04837380,
    0.00740500,
    0.00045660
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 7
    ..position = 27)] = [
    0.03253120,
    0.15669700,
    0.30009290,
    0.29445060,
    0.16009370,
    0.04830200,
    0.00738680,
    0.00044580
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 7
    ..position = 28)] = [
    0.03269420,
    0.15688720,
    0.30007240,
    0.29454060,
    0.15994010,
    0.04804680,
    0.00736490,
    0.00045380
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 7
    ..position = 29)] = [
    0.03280700,
    0.15759600,
    0.30042380,
    0.29412090,
    0.15945350,
    0.04785650,
    0.00731020,
    0.00043210
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 7
    ..position = 30)] = [
    0.03296550,
    0.15786710,
    0.30073650,
    0.29398380,
    0.15899000,
    0.04771100,
    0.00730840,
    0.00043770
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 7
    ..position = 31)] = [
    0.03306160,
    0.15852550,
    0.30092360,
    0.29375790,
    0.15866080,
    0.04737200,
    0.00725620,
    0.00044240
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 7
    ..position = 32)] = [
    0.03324650,
    0.15887120,
    0.30160670,
    0.29325880,
    0.15821640,
    0.04717810,
    0.00719460,
    0.00042770
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 7
    ..position = 33)] = [
    0.03338310,
    0.15917380,
    0.30155250,
    0.29347270,
    0.15783250,
    0.04701210,
    0.00714760,
    0.00042570
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 7
    ..position = 34)] = [
    0.03359740,
    0.15992270,
    0.30178500,
    0.29314330,
    0.15726050,
    0.04683740,
    0.00703150,
    0.00042220
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 7
    ..position = 35)] = [
    0.03371170,
    0.16014840,
    0.30231550,
    0.29267790,
    0.15694700,
    0.04673160,
    0.00704400,
    0.00042390
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 7
    ..position = 36)] = [
    0.03397640,
    0.16058330,
    0.30247510,
    0.29256410,
    0.15677280,
    0.04620080,
    0.00701390,
    0.00041360
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 7
    ..position = 37)] = [
    0.03399530,
    0.16146030,
    0.30306730,
    0.29212740,
    0.15599730,
    0.04596630,
    0.00697740,
    0.00040870
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 22
    ..mulligans = 1
    ..sample = 7
    ..position = 38)] = [
    0.03414930,
    0.16213720,
    0.30335860,
    0.29174980,
    0.15542360,
    0.04586470,
    0.00690760,
    0.00040920
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 0
    ..sample = 7
    ..position = 0)] = [
    0.01192740,
    0.08169290,
    0.22132890,
    0.31075330,
    0.24291180,
    0.10563600,
    0.02366580,
    0.00208390
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 0
    ..sample = 7
    ..position = 1)] = [
    0.01165770,
    0.08034670,
    0.22045500,
    0.31086730,
    0.24430950,
    0.10640690,
    0.02386280,
    0.00209410
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 0
    ..sample = 7
    ..position = 2)] = [
    0.01156110,
    0.07996850,
    0.22002770,
    0.31135360,
    0.24465680,
    0.10662120,
    0.02375490,
    0.00205620
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 0
    ..sample = 7
    ..position = 3)] = [
    0.01152490,
    0.08001300,
    0.22077980,
    0.31207110,
    0.24427230,
    0.10583830,
    0.02346950,
    0.00203110
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 0
    ..sample = 7
    ..position = 4)] = [
    0.01164570,
    0.08099710,
    0.22244880,
    0.31282070,
    0.24305390,
    0.10420560,
    0.02289550,
    0.00193270
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 0
    ..sample = 7
    ..position = 5)] = [
    0.01203390,
    0.08253960,
    0.22508080,
    0.31352390,
    0.24097840,
    0.10198950,
    0.02200100,
    0.00185290
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 0
    ..sample = 7
    ..position = 6)] = [
    0.01240160,
    0.08495890,
    0.22867500,
    0.31416960,
    0.23816830,
    0.09889490,
    0.02102700,
    0.00170470
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 0
    ..sample = 7
    ..position = 7)] = [
    0.01303190,
    0.08790410,
    0.23309190,
    0.31517490,
    0.23384430,
    0.09551370,
    0.01983100,
    0.00160820
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 0
    ..sample = 7
    ..position = 8)] = [
    0.01395550,
    0.09201080,
    0.23852000,
    0.31460600,
    0.22924090,
    0.09163830,
    0.01857100,
    0.00145750
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 0
    ..sample = 7
    ..position = 9)] = [
    0.01494870,
    0.09618880,
    0.24337700,
    0.31485040,
    0.22400860,
    0.08782000,
    0.01746650,
    0.00134000
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 0
    ..sample = 7
    ..position = 10)] = [
    0.01597050,
    0.10042500,
    0.24846870,
    0.31408210,
    0.21914970,
    0.08422670,
    0.01641270,
    0.00126460
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 0
    ..sample = 7
    ..position = 11)] = [
    0.01696400,
    0.10466050,
    0.25328680,
    0.31365240,
    0.21412400,
    0.08075220,
    0.01541260,
    0.00114750
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 0
    ..sample = 7
    ..position = 12)] = [
    0.01800710,
    0.10894790,
    0.25789630,
    0.31291690,
    0.20947360,
    0.07718100,
    0.01449960,
    0.00107760
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 0
    ..sample = 7
    ..position = 13)] = [
    0.01919190,
    0.11305830,
    0.26232070,
    0.31206620,
    0.20473040,
    0.07394810,
    0.01368280,
    0.00100160
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 0
    ..sample = 7
    ..position = 14)] = [
    0.02039450,
    0.11732570,
    0.26686610,
    0.31061610,
    0.20018370,
    0.07093040,
    0.01277550,
    0.00090800
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 0
    ..sample = 7
    ..position = 15)] = [
    0.02161820,
    0.12168450,
    0.27119020,
    0.30946090,
    0.19520610,
    0.06793520,
    0.01206130,
    0.00084360
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 0
    ..sample = 7
    ..position = 16)] = [
    0.02282540,
    0.12590640,
    0.27517940,
    0.30822460,
    0.19056480,
    0.06517410,
    0.01136280,
    0.00076250
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 0
    ..sample = 7
    ..position = 17)] = [
    0.02410850,
    0.13053450,
    0.27919550,
    0.30644700,
    0.18585820,
    0.06249570,
    0.01063310,
    0.00072750
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 0
    ..sample = 7
    ..position = 18)] = [
    0.02546440,
    0.13465590,
    0.28263520,
    0.30499270,
    0.18160840,
    0.05989190,
    0.01008560,
    0.00066590
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 0
    ..sample = 7
    ..position = 19)] = [
    0.02667240,
    0.13903950,
    0.28624710,
    0.30304110,
    0.17742950,
    0.05745800,
    0.00949490,
    0.00061750
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 0
    ..sample = 7
    ..position = 20)] = [
    0.02817380,
    0.14329060,
    0.28998730,
    0.30115310,
    0.17291530,
    0.05496740,
    0.00893390,
    0.00057860
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 0
    ..sample = 7
    ..position = 21)] = [
    0.02944700,
    0.14779720,
    0.29311030,
    0.29909500,
    0.16890250,
    0.05273220,
    0.00839190,
    0.00052390
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 0
    ..sample = 7
    ..position = 22)] = [
    0.03089890,
    0.15214390,
    0.29661670,
    0.29673730,
    0.16472090,
    0.05042260,
    0.00796440,
    0.00049530
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 0
    ..sample = 7
    ..position = 23)] = [
    0.03241960,
    0.15641150,
    0.29957350,
    0.29451530,
    0.16067820,
    0.04849800,
    0.00745520,
    0.00044870
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 0
    ..sample = 7
    ..position = 24)] = [
    0.03392410,
    0.16072920,
    0.30237880,
    0.29238200,
    0.15673850,
    0.04636590,
    0.00706440,
    0.00041710
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 0
    ..sample = 7
    ..position = 25)] = [
    0.03541690,
    0.16497190,
    0.30511000,
    0.29014420,
    0.15270820,
    0.04462980,
    0.00662230,
    0.00039670
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 0
    ..sample = 7
    ..position = 26)] = [
    0.03702430,
    0.16932410,
    0.30740180,
    0.28755090,
    0.14926160,
    0.04279340,
    0.00628360,
    0.00036030
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 0
    ..sample = 7
    ..position = 27)] = [
    0.03876140,
    0.17353770,
    0.31036460,
    0.28501640,
    0.14515180,
    0.04090120,
    0.00592040,
    0.00034650
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 0
    ..sample = 7
    ..position = 28)] = [
    0.04028140,
    0.17797080,
    0.31271590,
    0.28232120,
    0.14140860,
    0.03940630,
    0.00559300,
    0.00030280
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 0
    ..sample = 7
    ..position = 29)] = [
    0.04194230,
    0.18207990,
    0.31494550,
    0.27949580,
    0.13819180,
    0.03775430,
    0.00530360,
    0.00028680
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 0
    ..sample = 7
    ..position = 30)] = [
    0.04367570,
    0.18626500,
    0.31658110,
    0.27721870,
    0.13473150,
    0.03626260,
    0.00498970,
    0.00027570
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 0
    ..sample = 7
    ..position = 31)] = [
    0.04538280,
    0.19033650,
    0.31859040,
    0.27464080,
    0.13122690,
    0.03481070,
    0.00475010,
    0.00026180
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 0
    ..sample = 7
    ..position = 32)] = [
    0.04716400,
    0.19444480,
    0.32045500,
    0.27164940,
    0.12812470,
    0.03345240,
    0.00447240,
    0.00023730
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 0
    ..sample = 7
    ..position = 33)] = [
    0.04884460,
    0.19887390,
    0.32245280,
    0.26850740,
    0.12486600,
    0.03200540,
    0.00423440,
    0.00021550
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 0
    ..sample = 7
    ..position = 34)] = [
    0.05062740,
    0.20283310,
    0.32360630,
    0.26638830,
    0.12159190,
    0.03074120,
    0.00400470,
    0.00020710
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 0
    ..sample = 7
    ..position = 35)] = [
    0.05237770,
    0.20686320,
    0.32519740,
    0.26341460,
    0.11855620,
    0.02962420,
    0.00378110,
    0.00018560
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 0
    ..sample = 7
    ..position = 36)] = [
    0.05428940,
    0.21080760,
    0.32642400,
    0.26064120,
    0.11571340,
    0.02836870,
    0.00357500,
    0.00018070
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 0
    ..sample = 7
    ..position = 37)] = [
    0.05603360,
    0.21488030,
    0.32772710,
    0.25774750,
    0.11265670,
    0.02739210,
    0.00340290,
    0.00015980
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 6
    ..position = 0)] = [
    0.04530490,
    0.19736550,
    0.33266670,
    0.27694540,
    0.11995690,
    0.02567100,
    0.00208960
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 6
    ..position = 1)] = [
    0.04519550,
    0.19730720,
    0.33269180,
    0.27692580,
    0.12011010,
    0.02567970,
    0.00208990
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 6
    ..position = 2)] = [
    0.04510570,
    0.19707730,
    0.33267590,
    0.27707340,
    0.12019890,
    0.02575380,
    0.00211500
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 6
    ..position = 3)] = [
    0.04523370,
    0.19684110,
    0.33257740,
    0.27728360,
    0.12026370,
    0.02568920,
    0.00211130
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 6
    ..position = 4)] = [
    0.04500410,
    0.19674620,
    0.33235630,
    0.27747640,
    0.12049200,
    0.02579160,
    0.00213340
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 6
    ..position = 5)] = [
    0.04486380,
    0.19655660,
    0.33235370,
    0.27766570,
    0.12054110,
    0.02589670,
    0.00212240
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 6
    ..position = 6)] = [
    0.04483080,
    0.19623730,
    0.33238670,
    0.27778560,
    0.12076640,
    0.02585380,
    0.00213940
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 6
    ..position = 7)] = [
    0.04475330,
    0.19648230,
    0.33202000,
    0.27772960,
    0.12096070,
    0.02591360,
    0.00214050
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 6
    ..position = 8)] = [
    0.04475220,
    0.19615090,
    0.33227530,
    0.27755840,
    0.12106500,
    0.02607630,
    0.00212190
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 6
    ..position = 9)] = [
    0.04475500,
    0.19598140,
    0.33196520,
    0.27809940,
    0.12104390,
    0.02601310,
    0.00214200
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 6
    ..position = 10)] = [
    0.04471030,
    0.19629590,
    0.33193720,
    0.27791110,
    0.12098380,
    0.02602370,
    0.00213800
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 6
    ..position = 11)] = [
    0.04468310,
    0.19583750,
    0.33228180,
    0.27813050,
    0.12101310,
    0.02593220,
    0.00212180
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 6
    ..position = 12)] = [
    0.04481020,
    0.19594660,
    0.33193760,
    0.27834060,
    0.12086010,
    0.02595300,
    0.00215190
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 6
    ..position = 13)] = [
    0.04479700,
    0.19600330,
    0.33219080,
    0.27797410,
    0.12094590,
    0.02593790,
    0.00215100
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 6
    ..position = 14)] = [
    0.04484820,
    0.19637350,
    0.33214720,
    0.27769850,
    0.12084270,
    0.02596740,
    0.00212250
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 6
    ..position = 15)] = [
    0.04497440,
    0.19645560,
    0.33238150,
    0.27734860,
    0.12078740,
    0.02590450,
    0.00214800
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 6
    ..position = 16)] = [
    0.04497640,
    0.19661000,
    0.33211260,
    0.27785800,
    0.12049280,
    0.02583030,
    0.00211990
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 6
    ..position = 17)] = [
    0.04492440,
    0.19683800,
    0.33227860,
    0.27741390,
    0.12068340,
    0.02574850,
    0.00211320
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 6
    ..position = 18)] = [
    0.04505350,
    0.19722370,
    0.33251870,
    0.27718540,
    0.12011220,
    0.02579160,
    0.00211490
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 6
    ..position = 19)] = [
    0.04525720,
    0.19733590,
    0.33249940,
    0.27710360,
    0.12005090,
    0.02562000,
    0.00213300
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 6
    ..position = 20)] = [
    0.04533110,
    0.19757430,
    0.33260980,
    0.27679070,
    0.11998900,
    0.02561720,
    0.00208790
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 6
    ..position = 21)] = [
    0.04535130,
    0.19794970,
    0.33271300,
    0.27653400,
    0.11988140,
    0.02548430,
    0.00208630
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 6
    ..position = 22)] = [
    0.04551730,
    0.19825470,
    0.33274290,
    0.27649460,
    0.11944740,
    0.02545340,
    0.00208970
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 6
    ..position = 23)] = [
    0.04572140,
    0.19844860,
    0.33298700,
    0.27616280,
    0.11934010,
    0.02526560,
    0.00207450
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 6
    ..position = 24)] = [
    0.04581840,
    0.19888550,
    0.33327450,
    0.27599190,
    0.11867980,
    0.02528070,
    0.00206920
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 6
    ..position = 25)] = [
    0.04596960,
    0.19906340,
    0.33316950,
    0.27566380,
    0.11887800,
    0.02520610,
    0.00204960
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 6
    ..position = 26)] = [
    0.04625230,
    0.19954200,
    0.33328370,
    0.27532400,
    0.11838400,
    0.02515640,
    0.00205760
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 6
    ..position = 27)] = [
    0.04639630,
    0.20011890,
    0.33358220,
    0.27518770,
    0.11780090,
    0.02488510,
    0.00202890
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 6
    ..position = 28)] = [
    0.04641410,
    0.20025410,
    0.33410780,
    0.27468450,
    0.11769800,
    0.02481920,
    0.00202230
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 6
    ..position = 29)] = [
    0.04668830,
    0.20116360,
    0.33381910,
    0.27432350,
    0.11736120,
    0.02465110,
    0.00199320
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 6
    ..position = 30)] = [
    0.04692870,
    0.20140620,
    0.33428290,
    0.27396950,
    0.11685230,
    0.02457740,
    0.00198300
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 6
    ..position = 31)] = [
    0.04709810,
    0.20188360,
    0.33441710,
    0.27351250,
    0.11661700,
    0.02450410,
    0.00196760
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 6
    ..position = 32)] = [
    0.04747360,
    0.20256210,
    0.33438140,
    0.27319940,
    0.11610710,
    0.02433140,
    0.00194500
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 6
    ..position = 33)] = [
    0.04759550,
    0.20274430,
    0.33466740,
    0.27287470,
    0.11599990,
    0.02418260,
    0.00193560
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 6
    ..position = 34)] = [
    0.04774820,
    0.20340450,
    0.33497350,
    0.27268840,
    0.11524870,
    0.02404060,
    0.00189610
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 6
    ..position = 35)] = [
    0.04818100,
    0.20408500,
    0.33516660,
    0.27185940,
    0.11483860,
    0.02396450,
    0.00190490
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 6
    ..position = 36)] = [
    0.04832740,
    0.20468440,
    0.33497460,
    0.27169870,
    0.11455780,
    0.02385290,
    0.00190420
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 6
    ..position = 37)] = [
    0.04848100,
    0.20531020,
    0.33561730,
    0.27117060,
    0.11397950,
    0.02355560,
    0.00188580
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 7
    ..position = 0)] = [
    0.02606030,
    0.13592610,
    0.28391690,
    0.30371070,
    0.18033890,
    0.05936750,
    0.01001100,
    0.00066860
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 7
    ..position = 1)] = [
    0.02588750,
    0.13606230,
    0.28340920,
    0.30398550,
    0.18054340,
    0.05940040,
    0.01004600,
    0.00066570
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 7
    ..position = 2)] = [
    0.02586180,
    0.13572360,
    0.28328420,
    0.30403800,
    0.18080260,
    0.05955470,
    0.01007420,
    0.00066090
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 7
    ..position = 3)] = [
    0.02582570,
    0.13566180,
    0.28302220,
    0.30408180,
    0.18099870,
    0.05967090,
    0.01007230,
    0.00066660
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 7
    ..position = 4)] = [
    0.02563770,
    0.13544900,
    0.28321480,
    0.30367460,
    0.18129600,
    0.05990070,
    0.01014590,
    0.00068130
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 7
    ..position = 5)] = [
    0.02570130,
    0.13525950,
    0.28286500,
    0.30413800,
    0.18151620,
    0.05970190,
    0.01015680,
    0.00066130
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 7
    ..position = 6)] = [
    0.02558120,
    0.13513070,
    0.28262230,
    0.30431400,
    0.18153210,
    0.06002440,
    0.01011460,
    0.00068070
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 7
    ..position = 7)] = [
    0.02557050,
    0.13496710,
    0.28247830,
    0.30442170,
    0.18166020,
    0.06007650,
    0.01015080,
    0.00067490
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 7
    ..position = 8)] = [
    0.02557170,
    0.13487390,
    0.28228260,
    0.30439110,
    0.18172150,
    0.06024550,
    0.01023140,
    0.00068230
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 7
    ..position = 9)] = [
    0.02552920,
    0.13477090,
    0.28267820,
    0.30434400,
    0.18165120,
    0.06017780,
    0.01016910,
    0.00067960
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 7
    ..position = 10)] = [
    0.02555870,
    0.13492660,
    0.28246450,
    0.30417480,
    0.18179910,
    0.06019120,
    0.01020330,
    0.00068180
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 7
    ..position = 11)] = [
    0.02552410,
    0.13465860,
    0.28238570,
    0.30457320,
    0.18174460,
    0.06022050,
    0.01021410,
    0.00067920
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 7
    ..position = 12)] = [
    0.02547440,
    0.13479850,
    0.28229000,
    0.30449440,
    0.18188580,
    0.06018660,
    0.01018980,
    0.00068050
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 7
    ..position = 13)] = [
    0.02556430,
    0.13478380,
    0.28225140,
    0.30430800,
    0.18191410,
    0.06027380,
    0.01023930,
    0.00066530
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 7
    ..position = 14)] = [
    0.02560250,
    0.13497590,
    0.28241980,
    0.30434790,
    0.18154480,
    0.06028920,
    0.01015030,
    0.00066960
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 7
    ..position = 15)] = [
    0.02560820,
    0.13502200,
    0.28260820,
    0.30417700,
    0.18152800,
    0.06019200,
    0.01019410,
    0.00067050
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 7
    ..position = 16)] = [
    0.02569460,
    0.13499780,
    0.28278820,
    0.30420680,
    0.18149310,
    0.05995490,
    0.01017950,
    0.00068510
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 7
    ..position = 17)] = [
    0.02576500,
    0.13524170,
    0.28303200,
    0.30420330,
    0.18127510,
    0.05973880,
    0.01007740,
    0.00066670
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 7
    ..position = 18)] = [
    0.02568700,
    0.13556550,
    0.28303740,
    0.30384940,
    0.18137650,
    0.05975840,
    0.01006880,
    0.00065700
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 7
    ..position = 19)] = [
    0.02581760,
    0.13580620,
    0.28301460,
    0.30387370,
    0.18104200,
    0.05972990,
    0.01005190,
    0.00066410
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 7
    ..position = 20)] = [
    0.02593570,
    0.13616540,
    0.28331460,
    0.30389900,
    0.18060960,
    0.05935020,
    0.01006400,
    0.00066150
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 7
    ..position = 21)] = [
    0.02588560,
    0.13612690,
    0.28373160,
    0.30387490,
    0.18047730,
    0.05928030,
    0.00996660,
    0.00065680
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 7
    ..position = 22)] = [
    0.02602470,
    0.13653160,
    0.28392520,
    0.30353380,
    0.18020110,
    0.05917280,
    0.00996090,
    0.00064990
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 7
    ..position = 23)] = [
    0.02617870,
    0.13668810,
    0.28394220,
    0.30338190,
    0.18014910,
    0.05909630,
    0.00989910,
    0.00066460
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 7
    ..position = 24)] = [
    0.02621920,
    0.13715720,
    0.28453400,
    0.30335260,
    0.17945740,
    0.05877510,
    0.00984870,
    0.00065580
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 7
    ..position = 25)] = [
    0.02623210,
    0.13739410,
    0.28484510,
    0.30337070,
    0.17923650,
    0.05846200,
    0.00982110,
    0.00063840
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 7
    ..position = 26)] = [
    0.02647260,
    0.13780860,
    0.28503200,
    0.30295280,
    0.17896390,
    0.05835880,
    0.00976820,
    0.00064310
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 7
    ..position = 27)] = [
    0.02660770,
    0.13808780,
    0.28542130,
    0.30290410,
    0.17854500,
    0.05804690,
    0.00975140,
    0.00063580
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 7
    ..position = 28)] = [
    0.02671480,
    0.13851280,
    0.28559640,
    0.30297300,
    0.17788700,
    0.05799270,
    0.00968430,
    0.00063900
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 7
    ..position = 29)] = [
    0.02687220,
    0.13893760,
    0.28581690,
    0.30289480,
    0.17762150,
    0.05761760,
    0.00962230,
    0.00061710
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 7
    ..position = 30)] = [
    0.02696600,
    0.13939470,
    0.28637000,
    0.30249060,
    0.17698690,
    0.05764070,
    0.00953930,
    0.00061180
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 7
    ..position = 31)] = [
    0.02709690,
    0.13981610,
    0.28657970,
    0.30214570,
    0.17691150,
    0.05732350,
    0.00951490,
    0.00061170
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 7
    ..position = 32)] = [
    0.02720790,
    0.14025940,
    0.28713550,
    0.30215750,
    0.17632870,
    0.05688930,
    0.00940620,
    0.00061550
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 7
    ..position = 33)] = [
    0.02736870,
    0.14081100,
    0.28728330,
    0.30202340,
    0.17592660,
    0.05661860,
    0.00936310,
    0.00060530
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 7
    ..position = 34)] = [
    0.02756620,
    0.14113630,
    0.28769230,
    0.30179370,
    0.17551690,
    0.05640180,
    0.00930130,
    0.00059150
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 7
    ..position = 35)] = [
    0.02767720,
    0.14175160,
    0.28802080,
    0.30131440,
    0.17519090,
    0.05617980,
    0.00925630,
    0.00060900
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 7
    ..position = 36)] = [
    0.02794350,
    0.14230470,
    0.28860430,
    0.30106030,
    0.17424150,
    0.05607180,
    0.00917340,
    0.00060050
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 23
    ..mulligans = 1
    ..sample = 7
    ..position = 37)] = [
    0.02791390,
    0.14275680,
    0.28903970,
    0.30108990,
    0.17379900,
    0.05572500,
    0.00908450,
    0.00059120
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 0
    ..sample = 7
    ..position = 0)] = [
    0.00929070,
    0.06861110,
    0.20171740,
    0.30629310,
    0.25903900,
    0.12238550,
    0.02979110,
    0.00287210
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 0
    ..sample = 7
    ..position = 1)] = [
    0.00909500,
    0.06775750,
    0.20078100,
    0.30608150,
    0.26024000,
    0.12317470,
    0.02999300,
    0.00287730
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 0
    ..sample = 7
    ..position = 2)] = [
    0.00904620,
    0.06747370,
    0.20031650,
    0.30677410,
    0.26055090,
    0.12320740,
    0.02980080,
    0.00283040
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 0
    ..sample = 7
    ..position = 3)] = [
    0.00899940,
    0.06763950,
    0.20147440,
    0.30740420,
    0.26039240,
    0.12209710,
    0.02922250,
    0.00277050
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 0
    ..sample = 7
    ..position = 4)] = [
    0.00919550,
    0.06864820,
    0.20298900,
    0.30822710,
    0.25927420,
    0.12043900,
    0.02856290,
    0.00266410
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 0
    ..sample = 7
    ..position = 5)] = [
    0.00936570,
    0.07009980,
    0.20602410,
    0.30993450,
    0.25695550,
    0.11761830,
    0.02748380,
    0.00251830
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 0
    ..sample = 7
    ..position = 6)] = [
    0.00983140,
    0.07224360,
    0.20980010,
    0.31092060,
    0.25426930,
    0.11439490,
    0.02619860,
    0.00234150
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 0
    ..sample = 7
    ..position = 7)] = [
    0.01036770,
    0.07504980,
    0.21436640,
    0.31245850,
    0.25043300,
    0.11045820,
    0.02469080,
    0.00217560
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 0
    ..sample = 7
    ..position = 8)] = [
    0.01114610,
    0.07896350,
    0.21997840,
    0.31304900,
    0.24554050,
    0.10605740,
    0.02326540,
    0.00199970
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 0
    ..sample = 7
    ..position = 9)] = [
    0.01194610,
    0.08285550,
    0.22548210,
    0.31370250,
    0.24050150,
    0.10167300,
    0.02198930,
    0.00185000
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 0
    ..sample = 7
    ..position = 10)] = [
    0.01290520,
    0.08650960,
    0.23064780,
    0.31423340,
    0.23572040,
    0.09766470,
    0.02061410,
    0.00170480
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 0
    ..sample = 7
    ..position = 11)] = [
    0.01371210,
    0.09052690,
    0.23607740,
    0.31413690,
    0.23088030,
    0.09375840,
    0.01932360,
    0.00158440
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 0
    ..sample = 7
    ..position = 12)] = [
    0.01463030,
    0.09456850,
    0.24112660,
    0.31411220,
    0.22602730,
    0.08985580,
    0.01822310,
    0.00145620
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 0
    ..sample = 7
    ..position = 13)] = [
    0.01559430,
    0.09857330,
    0.24605850,
    0.31353780,
    0.22147030,
    0.08630800,
    0.01710450,
    0.00135330
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 0
    ..sample = 7
    ..position = 14)] = [
    0.01669230,
    0.10272460,
    0.25065440,
    0.31313490,
    0.21660320,
    0.08279490,
    0.01613860,
    0.00125710
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 0
    ..sample = 7
    ..position = 15)] = [
    0.01772750,
    0.10678610,
    0.25518990,
    0.31263830,
    0.21189700,
    0.07942870,
    0.01518890,
    0.00114360
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 0
    ..sample = 7
    ..position = 16)] = [
    0.01880290,
    0.11122300,
    0.25966260,
    0.31169480,
    0.20713760,
    0.07617180,
    0.01424840,
    0.00105890
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 0
    ..sample = 7
    ..position = 17)] = [
    0.01985970,
    0.11512170,
    0.26421630,
    0.31087790,
    0.20257250,
    0.07285830,
    0.01351340,
    0.00098020
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 0
    ..sample = 7
    ..position = 18)] = [
    0.02105650,
    0.11934930,
    0.26800100,
    0.30959650,
    0.19820780,
    0.07016230,
    0.01270480,
    0.00092180
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 0
    ..sample = 7
    ..position = 19)] = [
    0.02223550,
    0.12352400,
    0.27224560,
    0.30821630,
    0.19350120,
    0.06745650,
    0.01198310,
    0.00083780
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 0
    ..sample = 7
    ..position = 20)] = [
    0.02337240,
    0.12767130,
    0.27607610,
    0.30696760,
    0.18917080,
    0.06474170,
    0.01123060,
    0.00076950
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 0
    ..sample = 7
    ..position = 21)] = [
    0.02472190,
    0.13193850,
    0.27979380,
    0.30545570,
    0.18482820,
    0.06194290,
    0.01060740,
    0.00071160
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 0
    ..sample = 7
    ..position = 22)] = [
    0.02598320,
    0.13615270,
    0.28350220,
    0.30385000,
    0.18032690,
    0.05945360,
    0.01006130,
    0.00067010
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 0
    ..sample = 7
    ..position = 23)] = [
    0.02722280,
    0.14040060,
    0.28708500,
    0.30175900,
    0.17652290,
    0.05696520,
    0.00941780,
    0.00062670
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 0
    ..sample = 7
    ..position = 24)] = [
    0.02862740,
    0.14449570,
    0.29019650,
    0.30025070,
    0.17206750,
    0.05483350,
    0.00894780,
    0.00058090
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 0
    ..sample = 7
    ..position = 25)] = [
    0.02994540,
    0.14882520,
    0.29362830,
    0.29794140,
    0.16804410,
    0.05263820,
    0.00843390,
    0.00054350
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 0
    ..sample = 7
    ..position = 26)] = [
    0.03146360,
    0.15297420,
    0.29666880,
    0.29587870,
    0.16403970,
    0.05048440,
    0.00799310,
    0.00049750
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 0
    ..sample = 7
    ..position = 27)] = [
    0.03284300,
    0.15715020,
    0.29938030,
    0.29395010,
    0.16023480,
    0.04848870,
    0.00748930,
    0.00046360
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 0
    ..sample = 7
    ..position = 28)] = [
    0.03441250,
    0.16141090,
    0.30194570,
    0.29175090,
    0.15642970,
    0.04653300,
    0.00708760,
    0.00042970
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 0
    ..sample = 7
    ..position = 29)] = [
    0.03572280,
    0.16574490,
    0.30475680,
    0.28924530,
    0.15267940,
    0.04475480,
    0.00669740,
    0.00039860
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 0
    ..sample = 7
    ..position = 30)] = [
    0.03735420,
    0.16981890,
    0.30711750,
    0.28713690,
    0.14888190,
    0.04295030,
    0.00635850,
    0.00038180
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 0
    ..sample = 7
    ..position = 31)] = [
    0.03895630,
    0.17396730,
    0.30987850,
    0.28432390,
    0.14534100,
    0.04117840,
    0.00600730,
    0.00034730
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 0
    ..sample = 7
    ..position = 32)] = [
    0.04038060,
    0.17812360,
    0.31196800,
    0.28212440,
    0.14175980,
    0.03966520,
    0.00566680,
    0.00031160
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 0
    ..sample = 7
    ..position = 33)] = [
    0.04202680,
    0.18233750,
    0.31386660,
    0.27957360,
    0.13837770,
    0.03812060,
    0.00539190,
    0.00030530
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 0
    ..sample = 7
    ..position = 34)] = [
    0.04361720,
    0.18615600,
    0.31608190,
    0.27720710,
    0.13497110,
    0.03661290,
    0.00507970,
    0.00027410
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 0
    ..sample = 7
    ..position = 35)] = [
    0.04531310,
    0.19008670,
    0.31808000,
    0.27457340,
    0.13171290,
    0.03515020,
    0.00481840,
    0.00026530
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 0
    ..sample = 7
    ..position = 36)] = [
    0.04699800,
    0.19440230,
    0.31946250,
    0.27170810,
    0.12876160,
    0.03384360,
    0.00458210,
    0.00024180
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 6
    ..position = 0)] = [
    0.03789560,
    0.17799400,
    0.32317280,
    0.29049520,
    0.13608020,
    0.03158100,
    0.00278120
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 6
    ..position = 1)] = [
    0.03772480,
    0.17777650,
    0.32311170,
    0.29052180,
    0.13637850,
    0.03164570,
    0.00284100
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 6
    ..position = 2)] = [
    0.03766710,
    0.17760920,
    0.32309700,
    0.29067090,
    0.13649990,
    0.03162910,
    0.00282680
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 6
    ..position = 3)] = [
    0.03756380,
    0.17736800,
    0.32302650,
    0.29097880,
    0.13658430,
    0.03168020,
    0.00279840
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 6
    ..position = 4)] = [
    0.03771330,
    0.17704180,
    0.32290380,
    0.29104770,
    0.13671640,
    0.03173820,
    0.00283880
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 6
    ..position = 5)] = [
    0.03751490,
    0.17714820,
    0.32268060,
    0.29117770,
    0.13694480,
    0.03170120,
    0.00283260
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 6
    ..position = 6)] = [
    0.03752030,
    0.17669600,
    0.32270420,
    0.29126160,
    0.13710470,
    0.03184920,
    0.00286400
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 6
    ..position = 7)] = [
    0.03740760,
    0.17685100,
    0.32234630,
    0.29128940,
    0.13723410,
    0.03199720,
    0.00287440
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 6
    ..position = 8)] = [
    0.03752030,
    0.17649570,
    0.32247030,
    0.29156460,
    0.13724820,
    0.03184530,
    0.00285560
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 6
    ..position = 9)] = [
    0.03741350,
    0.17682240,
    0.32276880,
    0.29089240,
    0.13738830,
    0.03188010,
    0.00283450
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 6
    ..position = 10)] = [
    0.03747600,
    0.17660690,
    0.32251040,
    0.29141490,
    0.13726730,
    0.03190140,
    0.00282310
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 6
    ..position = 11)] = [
    0.03735750,
    0.17663840,
    0.32250410,
    0.29147270,
    0.13727100,
    0.03191040,
    0.00284590
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 6
    ..position = 12)] = [
    0.03743170,
    0.17667820,
    0.32276890,
    0.29131850,
    0.13721960,
    0.03169300,
    0.00289010
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 6
    ..position = 13)] = [
    0.03743450,
    0.17659460,
    0.32295960,
    0.29121670,
    0.13711960,
    0.03182580,
    0.00284920
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 6
    ..position = 14)] = [
    0.03750490,
    0.17682200,
    0.32285870,
    0.29109710,
    0.13713120,
    0.03173010,
    0.00285600
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 6
    ..position = 15)] = [
    0.03758450,
    0.17690630,
    0.32281980,
    0.29099080,
    0.13699150,
    0.03186850,
    0.00283860
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 6
    ..position = 16)] = [
    0.03754510,
    0.17730530,
    0.32280200,
    0.29112000,
    0.13669840,
    0.03167310,
    0.00285610
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 6
    ..position = 17)] = [
    0.03766360,
    0.17754140,
    0.32328600,
    0.29063140,
    0.13653660,
    0.03152080,
    0.00282020
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 6
    ..position = 18)] = [
    0.03775040,
    0.17771070,
    0.32313350,
    0.29056580,
    0.13645340,
    0.03158500,
    0.00280120
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 6
    ..position = 19)] = [
    0.03790050,
    0.17782250,
    0.32332960,
    0.29078730,
    0.13596070,
    0.03138140,
    0.00281800
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 6
    ..position = 20)] = [
    0.03798410,
    0.17816660,
    0.32347140,
    0.29031850,
    0.13593560,
    0.03134590,
    0.00277790
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 6
    ..position = 21)] = [
    0.03808890,
    0.17825830,
    0.32365800,
    0.29015500,
    0.13579230,
    0.03129850,
    0.00274900
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 6
    ..position = 22)] = [
    0.03820270,
    0.17863750,
    0.32396740,
    0.28973610,
    0.13554590,
    0.03115560,
    0.00275480
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 6
    ..position = 23)] = [
    0.03842240,
    0.17937310,
    0.32394770,
    0.28942430,
    0.13500750,
    0.03107610,
    0.00274890
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 6
    ..position = 24)] = [
    0.03846830,
    0.17972240,
    0.32423300,
    0.28936970,
    0.13454570,
    0.03091490,
    0.00274600
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 6
    ..position = 25)] = [
    0.03862600,
    0.17992240,
    0.32418490,
    0.28909840,
    0.13447770,
    0.03095720,
    0.00273340
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 6
    ..position = 26)] = [
    0.03873990,
    0.18035450,
    0.32463450,
    0.28891590,
    0.13405910,
    0.03060640,
    0.00268970
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 6
    ..position = 27)] = [
    0.03893940,
    0.18063800,
    0.32481810,
    0.28876190,
    0.13360430,
    0.03057020,
    0.00266810
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 6
    ..position = 28)] = [
    0.03904270,
    0.18114820,
    0.32503540,
    0.28820440,
    0.13343200,
    0.03046720,
    0.00267010
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 6
    ..position = 29)] = [
    0.03924860,
    0.18177670,
    0.32518060,
    0.28794960,
    0.13292180,
    0.03027960,
    0.00264310
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 6
    ..position = 30)] = [
    0.03940320,
    0.18197920,
    0.32530530,
    0.28786840,
    0.13261580,
    0.03016950,
    0.00265860
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 6
    ..position = 31)] = [
    0.03951600,
    0.18271510,
    0.32591180,
    0.28720690,
    0.13207280,
    0.02998520,
    0.00259220
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 6
    ..position = 32)] = [
    0.03986030,
    0.18308530,
    0.32594440,
    0.28704600,
    0.13166910,
    0.02978440,
    0.00261050
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 6
    ..position = 33)] = [
    0.04006260,
    0.18363500,
    0.32619700,
    0.28672330,
    0.13116430,
    0.02961400,
    0.00260380
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 6
    ..position = 34)] = [
    0.04020840,
    0.18413960,
    0.32652450,
    0.28614910,
    0.13090150,
    0.02950600,
    0.00257090
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 6
    ..position = 35)] = [
    0.04043610,
    0.18483700,
    0.32690490,
    0.28555440,
    0.13035180,
    0.02936000,
    0.00255580
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 6
    ..position = 36)] = [
    0.04062450,
    0.18543510,
    0.32708760,
    0.28521550,
    0.12999090,
    0.02915190,
    0.00249450
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 7
    ..position = 0)] = [
    0.02094010,
    0.11888980,
    0.26712060,
    0.30913810,
    0.19904850,
    0.07093860,
    0.01299030,
    0.00093400
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 7
    ..position = 1)] = [
    0.02100820,
    0.11879620,
    0.26686490,
    0.30930820,
    0.19904100,
    0.07094370,
    0.01309340,
    0.00094440
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 7
    ..position = 2)] = [
    0.02091110,
    0.11824540,
    0.26687080,
    0.30935700,
    0.19941390,
    0.07121670,
    0.01304290,
    0.00094220
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 7
    ..position = 3)] = [
    0.02089350,
    0.11824060,
    0.26646500,
    0.30939360,
    0.19956900,
    0.07138580,
    0.01310890,
    0.00094360
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 7
    ..position = 4)] = [
    0.02079260,
    0.11807130,
    0.26634380,
    0.30960900,
    0.19960730,
    0.07152330,
    0.01311140,
    0.00094130
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 7
    ..position = 5)] = [
    0.02080410,
    0.11805760,
    0.26625870,
    0.30949060,
    0.19977420,
    0.07158020,
    0.01307880,
    0.00095580
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 7
    ..position = 6)] = [
    0.02066130,
    0.11797640,
    0.26599780,
    0.30981560,
    0.19977600,
    0.07168080,
    0.01314440,
    0.00094770
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 7
    ..position = 7)] = [
    0.02072230,
    0.11759760,
    0.26610550,
    0.30952090,
    0.20012970,
    0.07175540,
    0.01321440,
    0.00095420
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 7
    ..position = 8)] = [
    0.02065040,
    0.11750260,
    0.26606860,
    0.30969040,
    0.20022670,
    0.07170740,
    0.01320000,
    0.00095390
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 7
    ..position = 9)] = [
    0.02059590,
    0.11770090,
    0.26606920,
    0.30949260,
    0.20017440,
    0.07180000,
    0.01322160,
    0.00094540
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 7
    ..position = 10)] = [
    0.02058210,
    0.11773510,
    0.26582850,
    0.30966540,
    0.20021290,
    0.07184930,
    0.01317820,
    0.00094850
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 7
    ..position = 11)] = [
    0.02061970,
    0.11776180,
    0.26587640,
    0.30946800,
    0.20032470,
    0.07170970,
    0.01328340,
    0.00095630
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 7
    ..position = 12)] = [
    0.02075800,
    0.11766090,
    0.26596730,
    0.30931320,
    0.20038170,
    0.07178560,
    0.01317930,
    0.00095400
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 7
    ..position = 13)] = [
    0.02061400,
    0.11767010,
    0.26612000,
    0.30946170,
    0.20024430,
    0.07172090,
    0.01321120,
    0.00095780
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 7
    ..position = 14)] = [
    0.02072940,
    0.11789260,
    0.26597170,
    0.30953480,
    0.20009410,
    0.07163930,
    0.01317330,
    0.00096480
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 7
    ..position = 15)] = [
    0.02074830,
    0.11787810,
    0.26661030,
    0.30925720,
    0.19987170,
    0.07149060,
    0.01319170,
    0.00095210
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 7
    ..position = 16)] = [
    0.02077470,
    0.11793870,
    0.26649280,
    0.30942390,
    0.19973680,
    0.07153140,
    0.01315480,
    0.00094690
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 7
    ..position = 17)] = [
    0.02088180,
    0.11828210,
    0.26639470,
    0.30961440,
    0.19940100,
    0.07140630,
    0.01306750,
    0.00095220
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 7
    ..position = 18)] = [
    0.02090930,
    0.11824400,
    0.26653550,
    0.30956720,
    0.19941010,
    0.07132300,
    0.01305580,
    0.00095510
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 7
    ..position = 19)] = [
    0.02089360,
    0.11861070,
    0.26691230,
    0.30924030,
    0.19919110,
    0.07117290,
    0.01303110,
    0.00094800
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 7
    ..position = 20)] = [
    0.02107000,
    0.11890500,
    0.26699420,
    0.30943700,
    0.19881860,
    0.07089820,
    0.01295570,
    0.00092130
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 7
    ..position = 21)] = [
    0.02110580,
    0.11889270,
    0.26747120,
    0.30923260,
    0.19872100,
    0.07072980,
    0.01292240,
    0.00092450
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 7
    ..position = 22)] = [
    0.02114580,
    0.11938710,
    0.26766730,
    0.30908650,
    0.19828080,
    0.07060180,
    0.01287420,
    0.00095650
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 7
    ..position = 23)] = [
    0.02121440,
    0.11972550,
    0.26770480,
    0.30906150,
    0.19824230,
    0.07035180,
    0.01277160,
    0.00092810
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 7
    ..position = 24)] = [
    0.02121130,
    0.11986030,
    0.26843380,
    0.30888880,
    0.19777950,
    0.07014790,
    0.01276470,
    0.00091370
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 7
    ..position = 25)] = [
    0.02139270,
    0.12029020,
    0.26870390,
    0.30881330,
    0.19725130,
    0.06993380,
    0.01271340,
    0.00090140
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 7
    ..position = 26)] = [
    0.02143060,
    0.12078080,
    0.26846350,
    0.30879070,
    0.19720670,
    0.06982060,
    0.01260520,
    0.00090190
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 7
    ..position = 27)] = [
    0.02155480,
    0.12094140,
    0.26919760,
    0.30890750,
    0.19649220,
    0.06949980,
    0.01250420,
    0.00090250
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 7
    ..position = 28)] = [
    0.02167580,
    0.12146540,
    0.26972520,
    0.30867610,
    0.19610040,
    0.06899220,
    0.01247920,
    0.00088570
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 7
    ..position = 29)] = [
    0.02176170,
    0.12188160,
    0.27023580,
    0.30827310,
    0.19559670,
    0.06891180,
    0.01245110,
    0.00088820
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 7
    ..position = 30)] = [
    0.02189730,
    0.12213330,
    0.27062880,
    0.30836250,
    0.19520030,
    0.06859120,
    0.01231660,
    0.00087000
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 7
    ..position = 31)] = [
    0.02207310,
    0.12244680,
    0.27077100,
    0.30855390,
    0.19487620,
    0.06818020,
    0.01223520,
    0.00086360
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 7
    ..position = 32)] = [
    0.02217630,
    0.12296300,
    0.27120410,
    0.30822150,
    0.19443670,
    0.06795260,
    0.01219170,
    0.00085410
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 7
    ..position = 33)] = [
    0.02234760,
    0.12338750,
    0.27176800,
    0.30831550,
    0.19357810,
    0.06764910,
    0.01210840,
    0.00084580
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 7
    ..position = 34)] = [
    0.02238430,
    0.12386950,
    0.27203670,
    0.30806520,
    0.19347120,
    0.06732180,
    0.01199980,
    0.00085150
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 7
    ..position = 35)] = [
    0.02257730,
    0.12445470,
    0.27253030,
    0.30783940,
    0.19295690,
    0.06685680,
    0.01193840,
    0.00084620
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 24
    ..mulligans = 1
    ..sample = 7
    ..position = 36)] = [
    0.02271850,
    0.12502740,
    0.27293090,
    0.30761070,
    0.19227930,
    0.06672190,
    0.01189200,
    0.00081930
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 0
    ..sample = 7
    ..position = 0)] = [
    0.00724630,
    0.05741830,
    0.18214180,
    0.29879200,
    0.27383930,
    0.13981170,
    0.03686780,
    0.00388280
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 0
    ..sample = 7
    ..position = 1)] = [
    0.00707720,
    0.05687940,
    0.18144720,
    0.29875470,
    0.27449090,
    0.14053290,
    0.03696430,
    0.00385340
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 0
    ..sample = 7
    ..position = 2)] = [
    0.00698780,
    0.05659580,
    0.18129340,
    0.29934490,
    0.27487880,
    0.14033740,
    0.03679060,
    0.00377130
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 0
    ..sample = 7
    ..position = 3)] = [
    0.00705740,
    0.05679990,
    0.18203470,
    0.30034940,
    0.27464970,
    0.13911220,
    0.03625000,
    0.00374670
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 0
    ..sample = 7
    ..position = 4)] = [
    0.00715680,
    0.05773090,
    0.18405130,
    0.30184880,
    0.27338950,
    0.13707980,
    0.03517480,
    0.00356810
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 0
    ..sample = 7
    ..position = 5)] = [
    0.00737360,
    0.05912090,
    0.18712860,
    0.30342620,
    0.27138630,
    0.13432380,
    0.03386240,
    0.00337820
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 0
    ..sample = 7
    ..position = 6)] = [
    0.00775360,
    0.06108360,
    0.19102820,
    0.30508130,
    0.26895510,
    0.13058390,
    0.03239830,
    0.00311600
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 0
    ..sample = 7
    ..position = 7)] = [
    0.00819320,
    0.06364030,
    0.19581890,
    0.30703580,
    0.26539160,
    0.12629270,
    0.03070730,
    0.00292020
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 0
    ..sample = 7
    ..position = 8)] = [
    0.00882640,
    0.06727660,
    0.20151560,
    0.30886610,
    0.26074940,
    0.12126180,
    0.02882600,
    0.00267810
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 0
    ..sample = 7
    ..position = 9)] = [
    0.00950770,
    0.07088870,
    0.20738600,
    0.31002230,
    0.25606550,
    0.11644520,
    0.02720170,
    0.00248290
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 0
    ..sample = 7
    ..position = 10)] = [
    0.01031220,
    0.07452600,
    0.21283840,
    0.31097710,
    0.25158620,
    0.11201090,
    0.02545510,
    0.00229410
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 0
    ..sample = 7
    ..position = 11)] = [
    0.01102910,
    0.07822300,
    0.21814260,
    0.31201390,
    0.24669890,
    0.10782000,
    0.02399780,
    0.00207470
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 0
    ..sample = 7
    ..position = 12)] = [
    0.01184330,
    0.08191900,
    0.22336080,
    0.31270810,
    0.24203660,
    0.10359160,
    0.02260970,
    0.00193090
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 0
    ..sample = 7
    ..position = 13)] = [
    0.01264020,
    0.08546730,
    0.22888340,
    0.31311610,
    0.23732850,
    0.09942940,
    0.02134510,
    0.00179000
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 0
    ..sample = 7
    ..position = 14)] = [
    0.01355500,
    0.08952670,
    0.23378150,
    0.31368070,
    0.23217300,
    0.09560320,
    0.02003990,
    0.00164000
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 0
    ..sample = 7
    ..position = 15)] = [
    0.01445310,
    0.09345640,
    0.23874510,
    0.31347000,
    0.22786740,
    0.09160310,
    0.01888460,
    0.00152030
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 0
    ..sample = 7
    ..position = 16)] = [
    0.01540800,
    0.09743210,
    0.24364000,
    0.31313510,
    0.22313520,
    0.08803860,
    0.01780640,
    0.00140460
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 0
    ..sample = 7
    ..position = 17)] = [
    0.01638250,
    0.10136020,
    0.24824090,
    0.31299010,
    0.21857680,
    0.08442460,
    0.01671700,
    0.00130790
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 0
    ..sample = 7
    ..position = 18)] = [
    0.01736610,
    0.10525800,
    0.25298270,
    0.31199280,
    0.21402300,
    0.08130240,
    0.01584670,
    0.00122830
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 0
    ..sample = 7
    ..position = 19)] = [
    0.01837020,
    0.10909720,
    0.25722660,
    0.31174550,
    0.20965130,
    0.07794300,
    0.01483770,
    0.00112850
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 0
    ..sample = 7
    ..position = 20)] = [
    0.01943050,
    0.11336630,
    0.26159510,
    0.31061610,
    0.20498110,
    0.07486960,
    0.01408750,
    0.00105380
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 0
    ..sample = 7
    ..position = 21)] = [
    0.02061310,
    0.11724030,
    0.26571690,
    0.30984850,
    0.20024110,
    0.07207970,
    0.01328540,
    0.00097500
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 0
    ..sample = 7
    ..position = 22)] = [
    0.02175360,
    0.12138950,
    0.26987530,
    0.30824100,
    0.19612620,
    0.06919500,
    0.01252750,
    0.00089190
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 0
    ..sample = 7
    ..position = 23)] = [
    0.02289010,
    0.12536150,
    0.27370020,
    0.30726670,
    0.19168200,
    0.06638700,
    0.01188690,
    0.00082560
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 0
    ..sample = 7
    ..position = 24)] = [
    0.02401300,
    0.12951820,
    0.27747030,
    0.30582940,
    0.18743360,
    0.06382620,
    0.01114890,
    0.00076040
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 0
    ..sample = 7
    ..position = 25)] = [
    0.02535280,
    0.13357940,
    0.28089920,
    0.30430040,
    0.18303180,
    0.06152450,
    0.01059880,
    0.00071310
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 0
    ..sample = 7
    ..position = 26)] = [
    0.02651440,
    0.13772860,
    0.28435540,
    0.30287670,
    0.17907680,
    0.05883230,
    0.00994710,
    0.00066870
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 0
    ..sample = 7
    ..position = 27)] = [
    0.02798330,
    0.14175420,
    0.28784130,
    0.30072720,
    0.17506790,
    0.05665840,
    0.00933700,
    0.00063070
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 0
    ..sample = 7
    ..position = 28)] = [
    0.02914690,
    0.14594830,
    0.29093860,
    0.29914720,
    0.17102130,
    0.05436690,
    0.00886390,
    0.00056690
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 0
    ..sample = 7
    ..position = 29)] = [
    0.03043690,
    0.14989120,
    0.29406790,
    0.29711780,
    0.16719650,
    0.05226410,
    0.00847790,
    0.00054770
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 0
    ..sample = 7
    ..position = 30)] = [
    0.03179050,
    0.15400900,
    0.29682550,
    0.29550750,
    0.16325200,
    0.05018430,
    0.00793850,
    0.00049270
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 0
    ..sample = 7
    ..position = 31)] = [
    0.03324940,
    0.15824780,
    0.29951980,
    0.29308120,
    0.15962450,
    0.04823140,
    0.00756530,
    0.00048060
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 0
    ..sample = 7
    ..position = 32)] = [
    0.03474710,
    0.16200980,
    0.30247240,
    0.29093360,
    0.15571210,
    0.04655240,
    0.00713770,
    0.00043490
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 0
    ..sample = 7
    ..position = 33)] = [
    0.03614210,
    0.16628570,
    0.30484710,
    0.28855340,
    0.15233550,
    0.04468620,
    0.00675280,
    0.00039720
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 0
    ..sample = 7
    ..position = 34)] = [
    0.03767630,
    0.17040470,
    0.30725410,
    0.28628020,
    0.14872620,
    0.04282920,
    0.00644250,
    0.00038680
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 0
    ..sample = 7
    ..position = 35)] = [
    0.03912300,
    0.17409590,
    0.30961610,
    0.28418400,
    0.14522200,
    0.04134680,
    0.00605220,
    0.00036000
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 6
    ..position = 0)] = [
    0.03150400,
    0.15929870,
    0.31178460,
    0.30236340,
    0.15313260,
    0.03823070,
    0.00368600
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 6
    ..position = 1)] = [
    0.03142420,
    0.15926470,
    0.31186750,
    0.30250900,
    0.15302770,
    0.03821840,
    0.00368850
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 6
    ..position = 2)] = [
    0.03132520,
    0.15894060,
    0.31152080,
    0.30257700,
    0.15343090,
    0.03848660,
    0.00371890
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 6
    ..position = 3)] = [
    0.03142920,
    0.15858960,
    0.31154470,
    0.30258620,
    0.15367820,
    0.03847990,
    0.00369220
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 6
    ..position = 4)] = [
    0.03122170,
    0.15843660,
    0.31151060,
    0.30291440,
    0.15366660,
    0.03850490,
    0.00374520
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 6
    ..position = 5)] = [
    0.03127420,
    0.15831000,
    0.31131050,
    0.30304330,
    0.15368760,
    0.03863870,
    0.00373570
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 6
    ..position = 6)] = [
    0.03119680,
    0.15838690,
    0.31108760,
    0.30302540,
    0.15397350,
    0.03860740,
    0.00372240
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 6
    ..position = 7)] = [
    0.03103060,
    0.15791680,
    0.31146910,
    0.30334860,
    0.15385660,
    0.03864810,
    0.00373020
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 6
    ..position = 8)] = [
    0.03106200,
    0.15833420,
    0.31103620,
    0.30305790,
    0.15402710,
    0.03875030,
    0.00373230
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 6
    ..position = 9)] = [
    0.03112010,
    0.15808200,
    0.31106630,
    0.30311860,
    0.15425340,
    0.03858910,
    0.00377050
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 6
    ..position = 10)] = [
    0.03115100,
    0.15817610,
    0.31106450,
    0.30304550,
    0.15411270,
    0.03872390,
    0.00372630
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 6
    ..position = 11)] = [
    0.03103780,
    0.15803720,
    0.31109110,
    0.30313250,
    0.15425370,
    0.03870820,
    0.00373950
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 6
    ..position = 12)] = [
    0.03105350,
    0.15837180,
    0.31123680,
    0.30303890,
    0.15387340,
    0.03869540,
    0.00373020
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 6
    ..position = 13)] = [
    0.03113540,
    0.15830290,
    0.31129480,
    0.30278680,
    0.15406390,
    0.03871450,
    0.00370170
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 6
    ..position = 14)] = [
    0.03115320,
    0.15840640,
    0.31160340,
    0.30288770,
    0.15373030,
    0.03851660,
    0.00370240
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 6
    ..position = 15)] = [
    0.03122990,
    0.15876850,
    0.31134600,
    0.30274580,
    0.15354900,
    0.03862940,
    0.00373140
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 6
    ..position = 16)] = [
    0.03124690,
    0.15874840,
    0.31135750,
    0.30300210,
    0.15352090,
    0.03841190,
    0.00371230
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 6
    ..position = 17)] = [
    0.03141240,
    0.15917840,
    0.31178890,
    0.30236230,
    0.15318910,
    0.03837820,
    0.00369070
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 6
    ..position = 18)] = [
    0.03153000,
    0.15935250,
    0.31173170,
    0.30246120,
    0.15298670,
    0.03823800,
    0.00369990
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 6
    ..position = 19)] = [
    0.03153470,
    0.15939160,
    0.31187310,
    0.30257140,
    0.15280670,
    0.03816540,
    0.00365710
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 6
    ..position = 20)] = [
    0.03164130,
    0.15978190,
    0.31232110,
    0.30197570,
    0.15258990,
    0.03800260,
    0.00368750
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 6
    ..position = 21)] = [
    0.03186300,
    0.16007700,
    0.31262440,
    0.30186410,
    0.15206010,
    0.03785810,
    0.00365330
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 6
    ..position = 22)] = [
    0.03184140,
    0.16041000,
    0.31278540,
    0.30164370,
    0.15185280,
    0.03782260,
    0.00364410
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 6
    ..position = 23)] = [
    0.03194520,
    0.16079750,
    0.31308870,
    0.30138910,
    0.15146220,
    0.03770030,
    0.00361700
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 6
    ..position = 24)] = [
    0.03211910,
    0.16124350,
    0.31267680,
    0.30154480,
    0.15127720,
    0.03758450,
    0.00355410
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 6
    ..position = 25)] = [
    0.03232040,
    0.16155990,
    0.31327190,
    0.30108190,
    0.15081320,
    0.03740000,
    0.00355270
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 6
    ..position = 26)] = [
    0.03230990,
    0.16197160,
    0.31369730,
    0.30055520,
    0.15063360,
    0.03726460,
    0.00356780
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 6
    ..position = 27)] = [
    0.03259930,
    0.16200600,
    0.31390860,
    0.30080390,
    0.15009300,
    0.03706610,
    0.00352310
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 6
    ..position = 28)] = [
    0.03267820,
    0.16278460,
    0.31417750,
    0.30015940,
    0.14976610,
    0.03694500,
    0.00348920
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 6
    ..position = 29)] = [
    0.03284900,
    0.16327290,
    0.31462350,
    0.29992700,
    0.14908830,
    0.03676920,
    0.00347010
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 6
    ..position = 30)] = [
    0.03298320,
    0.16382870,
    0.31472400,
    0.29968260,
    0.14873720,
    0.03657730,
    0.00346700
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 6
    ..position = 31)] = [
    0.03312650,
    0.16422710,
    0.31542970,
    0.29917660,
    0.14822940,
    0.03640240,
    0.00340830
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 6
    ..position = 32)] = [
    0.03329550,
    0.16489150,
    0.31586000,
    0.29875780,
    0.14767210,
    0.03613040,
    0.00339270
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 6
    ..position = 33)] = [
    0.03344400,
    0.16540060,
    0.31576370,
    0.29871060,
    0.14737060,
    0.03594350,
    0.00336700
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 6
    ..position = 34)] = [
    0.03367180,
    0.16609290,
    0.31604500,
    0.29812110,
    0.14694190,
    0.03579170,
    0.00333560
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 6
    ..position = 35)] = [
    0.03379990,
    0.16640540,
    0.31653110,
    0.29794380,
    0.14642920,
    0.03558310,
    0.00330750
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 7
    ..position = 0)] = [
    0.01695170,
    0.10283730,
    0.24938800,
    0.31196770,
    0.21713030,
    0.08384200,
    0.01658500,
    0.00129800
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 7
    ..position = 1)] = [
    0.01686100,
    0.10258260,
    0.24929250,
    0.31210400,
    0.21732200,
    0.08380970,
    0.01672120,
    0.00130700
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 7
    ..position = 2)] = [
    0.01679070,
    0.10252590,
    0.24923100,
    0.31195310,
    0.21743320,
    0.08399330,
    0.01674810,
    0.00132470
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 7
    ..position = 3)] = [
    0.01686500,
    0.10250680,
    0.24915660,
    0.31203620,
    0.21717810,
    0.08415590,
    0.01678950,
    0.00131190
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 7
    ..position = 4)] = [
    0.01665850,
    0.10231790,
    0.24893800,
    0.31230300,
    0.21752650,
    0.08425520,
    0.01669360,
    0.00130730
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 7
    ..position = 5)] = [
    0.01661560,
    0.10208270,
    0.24875910,
    0.31232260,
    0.21771730,
    0.08437030,
    0.01680920,
    0.00132320
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 7
    ..position = 6)] = [
    0.01664400,
    0.10191260,
    0.24873490,
    0.31207260,
    0.21793330,
    0.08456690,
    0.01681390,
    0.00132180
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 7
    ..position = 7)] = [
    0.01657460,
    0.10190290,
    0.24861120,
    0.31200970,
    0.21809080,
    0.08461390,
    0.01686650,
    0.00133040
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 7
    ..position = 8)] = [
    0.01663380,
    0.10194150,
    0.24830820,
    0.31218150,
    0.21814610,
    0.08463210,
    0.01682190,
    0.00133490
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 7
    ..position = 9)] = [
    0.01659430,
    0.10191780,
    0.24865970,
    0.31201940,
    0.21785250,
    0.08473620,
    0.01688300,
    0.00133710
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 7
    ..position = 10)] = [
    0.01659370,
    0.10180690,
    0.24829850,
    0.31205570,
    0.21837390,
    0.08465840,
    0.01687300,
    0.00133990
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 7
    ..position = 11)] = [
    0.01667770,
    0.10176700,
    0.24822510,
    0.31201720,
    0.21839280,
    0.08474090,
    0.01684980,
    0.00132950
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 7
    ..position = 12)] = [
    0.01662950,
    0.10182000,
    0.24836080,
    0.31215710,
    0.21820680,
    0.08458450,
    0.01689990,
    0.00134140
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 7
    ..position = 13)] = [
    0.01670990,
    0.10194430,
    0.24862660,
    0.31196970,
    0.21797890,
    0.08462250,
    0.01682650,
    0.00132160
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 7
    ..position = 14)] = [
    0.01669070,
    0.10177660,
    0.24868160,
    0.31239790,
    0.21782200,
    0.08445250,
    0.01685210,
    0.00132660
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 7
    ..position = 15)] = [
    0.01673570,
    0.10228920,
    0.24884390,
    0.31218190,
    0.21766080,
    0.08415410,
    0.01681890,
    0.00131550
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 7
    ..position = 16)] = [
    0.01672330,
    0.10232780,
    0.24877130,
    0.31238920,
    0.21757120,
    0.08411190,
    0.01678850,
    0.00131680
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 7
    ..position = 17)] = [
    0.01680250,
    0.10244120,
    0.24912970,
    0.31219870,
    0.21741490,
    0.08406900,
    0.01663650,
    0.00130750
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 7
    ..position = 18)] = [
    0.01671500,
    0.10260830,
    0.24948020,
    0.31212060,
    0.21721480,
    0.08394950,
    0.01662370,
    0.00128790
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 7
    ..position = 19)] = [
    0.01689340,
    0.10297250,
    0.24958770,
    0.31199350,
    0.21688540,
    0.08374970,
    0.01663910,
    0.00127870
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 7
    ..position = 20)] = [
    0.01686650,
    0.10305190,
    0.24993320,
    0.31203940,
    0.21668230,
    0.08356200,
    0.01655410,
    0.00131060
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 7
    ..position = 21)] = [
    0.01697570,
    0.10338290,
    0.25017590,
    0.31196990,
    0.21635950,
    0.08332900,
    0.01651900,
    0.00128810
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 7
    ..position = 22)] = [
    0.01696690,
    0.10357890,
    0.25042960,
    0.31201020,
    0.21624600,
    0.08310840,
    0.01637530,
    0.00128470
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 7
    ..position = 23)] = [
    0.01705250,
    0.10388900,
    0.25080720,
    0.31205430,
    0.21574340,
    0.08291630,
    0.01627620,
    0.00126110
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 7
    ..position = 24)] = [
    0.01724280,
    0.10405060,
    0.25094160,
    0.31200450,
    0.21564200,
    0.08258900,
    0.01627180,
    0.00125770
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 7
    ..position = 25)] = [
    0.01725790,
    0.10440040,
    0.25136900,
    0.31187150,
    0.21524540,
    0.08237690,
    0.01622350,
    0.00125540
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 7
    ..position = 26)] = [
    0.01732320,
    0.10497530,
    0.25193020,
    0.31169220,
    0.21472870,
    0.08199250,
    0.01610490,
    0.00125300
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 7
    ..position = 27)] = [
    0.01748840,
    0.10523910,
    0.25229140,
    0.31183730,
    0.21406030,
    0.08179470,
    0.01605010,
    0.00123870
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 7
    ..position = 28)] = [
    0.01752560,
    0.10564400,
    0.25255530,
    0.31214590,
    0.21363110,
    0.08138040,
    0.01589790,
    0.00121980
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 7
    ..position = 29)] = [
    0.01765210,
    0.10580720,
    0.25295340,
    0.31191890,
    0.21349760,
    0.08110770,
    0.01585370,
    0.00120940
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 7
    ..position = 30)] = [
    0.01776110,
    0.10633200,
    0.25335690,
    0.31163800,
    0.21298880,
    0.08089410,
    0.01580330,
    0.00122580
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 7
    ..position = 31)] = [
    0.01782940,
    0.10674150,
    0.25403270,
    0.31180760,
    0.21222690,
    0.08046790,
    0.01566770,
    0.00122630
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 7
    ..position = 32)] = [
    0.01796570,
    0.10713140,
    0.25458070,
    0.31148240,
    0.21194860,
    0.08021750,
    0.01549040,
    0.00118330
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 7
    ..position = 33)] = [
    0.01810570,
    0.10760300,
    0.25510130,
    0.31127190,
    0.21157900,
    0.07969940,
    0.01544880,
    0.00119090
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 7
    ..position = 34)] = [
    0.01819360,
    0.10816030,
    0.25559170,
    0.31146350,
    0.21081340,
    0.07931990,
    0.01528120,
    0.00117640
  ]
  ..[BuggedInputs((b) => b
    ..population = 60
    ..hits = 25
    ..mulligans = 1
    ..sample = 7
    ..position = 35)] = [
    0.01835280,
    0.10849230,
    0.25606370,
    0.31134290,
    0.21037720,
    0.07897220,
    0.01524140,
    0.00115750
  ]
);
