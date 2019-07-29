// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'predictions.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HypergeometricInputs extends HypergeometricInputs {
  @override
  final int population;
  @override
  final int hits;
  @override
  final int sample;

  factory _$HypergeometricInputs(
          [void Function(HypergeometricInputsBuilder) updates]) =>
      (new HypergeometricInputsBuilder()..update(updates)).build();

  _$HypergeometricInputs._({this.population, this.hits, this.sample})
      : super._() {
    if (population == null) {
      throw new BuiltValueNullFieldError('HypergeometricInputs', 'population');
    }
    if (hits == null) {
      throw new BuiltValueNullFieldError('HypergeometricInputs', 'hits');
    }
    if (sample == null) {
      throw new BuiltValueNullFieldError('HypergeometricInputs', 'sample');
    }
  }

  @override
  HypergeometricInputs rebuild(
          void Function(HypergeometricInputsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HypergeometricInputsBuilder toBuilder() =>
      new HypergeometricInputsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HypergeometricInputs &&
        population == other.population &&
        hits == other.hits &&
        sample == other.sample;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, population.hashCode), hits.hashCode), sample.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('HypergeometricInputs')
          ..add('population', population)
          ..add('hits', hits)
          ..add('sample', sample))
        .toString();
  }
}

class HypergeometricInputsBuilder
    implements Builder<HypergeometricInputs, HypergeometricInputsBuilder> {
  _$HypergeometricInputs _$v;

  int _population;
  int get population => _$this._population;
  set population(int population) => _$this._population = population;

  int _hits;
  int get hits => _$this._hits;
  set hits(int hits) => _$this._hits = hits;

  int _sample;
  int get sample => _$this._sample;
  set sample(int sample) => _$this._sample = sample;

  HypergeometricInputsBuilder();

  HypergeometricInputsBuilder get _$this {
    if (_$v != null) {
      _population = _$v.population;
      _hits = _$v.hits;
      _sample = _$v.sample;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HypergeometricInputs other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$HypergeometricInputs;
  }

  @override
  void update(void Function(HypergeometricInputsBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$HypergeometricInputs build() {
    final _$result = _$v ??
        new _$HypergeometricInputs._(
            population: population, hits: hits, sample: sample);
    replace(_$result);
    return _$result;
  }
}

class _$BuggedInputs extends BuggedInputs {
  @override
  final int population;
  @override
  final int hits;
  @override
  final int mulligans;
  @override
  final int sample;
  @override
  final int position;

  factory _$BuggedInputs([void Function(BuggedInputsBuilder) updates]) =>
      (new BuggedInputsBuilder()..update(updates)).build();

  _$BuggedInputs._(
      {this.population, this.hits, this.mulligans, this.sample, this.position})
      : super._() {
    if (population == null) {
      throw new BuiltValueNullFieldError('BuggedInputs', 'population');
    }
    if (hits == null) {
      throw new BuiltValueNullFieldError('BuggedInputs', 'hits');
    }
    if (mulligans == null) {
      throw new BuiltValueNullFieldError('BuggedInputs', 'mulligans');
    }
    if (sample == null) {
      throw new BuiltValueNullFieldError('BuggedInputs', 'sample');
    }
    if (position == null) {
      throw new BuiltValueNullFieldError('BuggedInputs', 'position');
    }
  }

  @override
  BuggedInputs rebuild(void Function(BuggedInputsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BuggedInputsBuilder toBuilder() => new BuggedInputsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BuggedInputs &&
        population == other.population &&
        hits == other.hits &&
        mulligans == other.mulligans &&
        sample == other.sample &&
        position == other.position;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, population.hashCode), hits.hashCode),
                mulligans.hashCode),
            sample.hashCode),
        position.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BuggedInputs')
          ..add('population', population)
          ..add('hits', hits)
          ..add('mulligans', mulligans)
          ..add('sample', sample)
          ..add('position', position))
        .toString();
  }
}

class BuggedInputsBuilder
    implements Builder<BuggedInputs, BuggedInputsBuilder> {
  _$BuggedInputs _$v;

  int _population;
  int get population => _$this._population;
  set population(int population) => _$this._population = population;

  int _hits;
  int get hits => _$this._hits;
  set hits(int hits) => _$this._hits = hits;

  int _mulligans;
  int get mulligans => _$this._mulligans;
  set mulligans(int mulligans) => _$this._mulligans = mulligans;

  int _sample;
  int get sample => _$this._sample;
  set sample(int sample) => _$this._sample = sample;

  int _position;
  int get position => _$this._position;
  set position(int position) => _$this._position = position;

  BuggedInputsBuilder();

  BuggedInputsBuilder get _$this {
    if (_$v != null) {
      _population = _$v.population;
      _hits = _$v.hits;
      _mulligans = _$v.mulligans;
      _sample = _$v.sample;
      _position = _$v.position;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BuggedInputs other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BuggedInputs;
  }

  @override
  void update(void Function(BuggedInputsBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BuggedInputs build() {
    final _$result = _$v ??
        new _$BuggedInputs._(
            population: population,
            hits: hits,
            mulligans: mulligans,
            sample: sample,
            position: position);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
